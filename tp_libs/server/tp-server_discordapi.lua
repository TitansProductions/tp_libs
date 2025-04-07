local FormattedToken = "Bot " .. Config.DiscordBotToken

local error_codes_defined = {
	[200] = 'OK - The request was completed successfully..!',
	[204] = 'OK - No Content',
	[400] = "Error - The request was improperly formatted, or the server couldn't understand it..!",
	[401] = 'Error - The Authorization header was missing or invalid..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[403] = 'Error - The Authorization token you passed did not have permission to the resource..! Your Discord Token is probably wrong or does not have correct permissions attributed to it.',
	[404] = "Error - The resource at the location specified doesn't exist.",
	[429] = 'Error - Too many requests, you hit the Discord rate limit. https://discord.com/developers/docs/topics/rate-limits',
	[502] = 'Error - Discord API may be down?...'
};

local Guilds = {
    ["name"] = "main",
}

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

function GetDiscordRoles(user, guild --[[optional]])
    local discordId = nil
    local guildId = GetGuildId(guild)
    local roles = nil
      for _, id in ipairs(GetPlayerIdentifiers(user)) do
          if string.match(id, "discord:") then
              discordId = string.gsub(id, "discord:", "")
              break;
          end
      end
  
      if discordId then
          -- Get roles for specified guild (or main guild if not specified)
          roles = GetUserRolesInGuild(discordId, guildId)
          -- If specified guild or disabled multiguild option, just return this one
          if guild or Config.Multiguild == false then
              return roles
          end
  
          -- MULTIGUILD SECTION
          -- Keep main guild roles so we can add the rest on top of this list
          
          -- For some reason, referencing roles again will use the global reference that is returned...
          -- because of that, we use this resetRoles list and repopulate. Probably a better way to do this. -- Needs to be looked into
          local resetRoles = {}
          for _, role_id in pairs(roles) do 
              table.insert(resetRoles, role_id);
          end
          roles = resetRoles
          local checkedGuilds = {}
          -- Loop through guilds in config and get the roles from each one.
          for _,id in pairs(Guilds) do
              -- If it's the main guild, we already fetched these roles. NEXT!
              -- We don't really need this check, but maybe someone used their main guild in this config list....
              if tostring(id) == guildId then goto skip end
              if checkedGuilds[id] then goto skip end
              -- Fetch roles for this guild
              local guildRoles = GetUserRolesInGuild(discordId, id)
              checkedGuilds[id] = true
              -- If it didnt return false due to error, add the roles to the list
              if type(guildRoles) == "table" then
                  -- Insert each role into roles list
                  for _,v in pairs(guildRoles) do
                      table.insert(roles, v)
                  end
              end
              ::skip::
          end
          return roles
      else
          print("ERROR: Discord was not connected to user's RedM account...")
          return false
      end
      return false
end


function GetGuildId (guildName)
  local result = tostring(Config.DiscordServerID)
  if guildName and Guilds[guildName] then
    result = tostring(Guilds[guildName])
  end
  return result
end

function DiscordRequest(method, endpoint, jsondata, reason)
    local data = nil
    PerformHttpRequest("https://discord.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and jsondata or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken, ['X-Audit-Log-Reason'] = reason})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetUserRolesInGuild (user, guild)
	-- Error check before starting operation
	if not user then
		print("ERROR: GetUserRolesInGuild requires discord ID")
		return false
	end
	if not guild then
		print("ERROR: GetUserRolesInGuild requires guild ID")
		return false
	end

	-- Check for cached roles
	if Config.CacheDiscordRoles and recent_role_cache[user] and recent_role_cache[user][guild] then
		return recent_role_cache[user][guild]
	end

	-- Request roles for user id
	local endpoint = ("guilds/%s/members/%s"):format(guild, user)
	local member = DiscordRequest("GET", endpoint, {})
	if member.code == 200 then
		local data = json.decode(member.data)
		local roles = data.roles
		if Config.CacheDiscordRoles then
			recent_role_cache[user] = recent_role_cache[user] or {}
			recent_role_cache[user][guild] = roles
			Citizen.SetTimeout(((Config.CacheDiscordRolesTime or 60)*1000), function() recent_role_cache[user][guild] = nil end)
		end
		return roles
	else
        
        if Config.Debug then
            print("INFO: Code 200 was not reached... (TP Libs Configuration, Discord Credentials Missing!) Returning false. [Member Data NOT FOUND] DETAILS: " .. error_codes_defined[member.code])
        end

		return false
	end
end

