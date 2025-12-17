
local CurrentTime = 0
UserHeartbeats    = {}

--[[ ------------------------------------------------
   Functions
]]---------------------------------------------------

-- Convert to hex
local toHex = function(str)
    return (str:gsub('.', function(c)
        return string.format('%02X', string.byte(c))
    end))
end

-- Convert back from hex
local fromHex = function(hex)
    return (hex:gsub('..', function(cc)
        local n = tonumber(cc, 16)
        if not n then
            error("Invalid hex sequence: '" .. cc .. "' in [" .. hex .. "]")
        end
        return string.char(n)
    end))
end

-- Encode/Decode wrapper
EncodeHexString = function(str, key)
    local res = {}
    for i = 1, #str do
        local c = str:byte(i)
        local k = key:byte((i - 1) % #key + 1)
        res[#res+1] = string.char((c ~ k) & 0xFF)
    end
    return "0x0x0-" .. toHex(table.concat(res))
end

DecodeHexString = function(hexStr, key)

    hexStr = hexStr:gsub("^0x0x0%-", "")  -- remove prefix only at the start
    
    local str = fromHex(hexStr)
    local res = {}
    for i = 1, #str do
        local c = str:byte(i)
        local k = key:byte((i - 1) % #key + 1)
        res[#res+1] = string.char((c ~ k) & 0xFF)
    end
    return table.concat(res)
end

SendToDiscordWebhook = function(webhook, name, description, color)

    if not webhook or webhook == "" then
        print("Error: Invalid webhook URL.")
        return
    end

    if string.sub(webhook, 1, 6) == "0x0x0-" then
        webhook = DecodeHexString(webhook, "0x0x0-")
    end

    local data = Config.DiscordWebhooking
    local defaultColor = 15105570  -- Define default color as a constant

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or defaultColor,
                ["author"] = {
                    ["name"] = data.Label,
                    ["icon_url"] = data.ImageUrl,
                },
                ["title"] = name,
                ["description"] = description,
                ["footer"] = {
                    ["text"] = data.Footer .. " • " .. os.date("%x %X %p"),
                    ["icon_url"] = data.ImageUrl,

                },
            },

        },
        avatar_url = data.ImageUrl
    }), {
        ['Content-Type'] = 'application/json'
    })
end

SendImageUrlToDiscordWebhook = function(webhook, name, description, url, color)

    if not webhook or webhook == "" then
        print("Error: Invalid webhook URL.")
        return
    end

    if string.sub(webhook, 1, 6) == "0x0x0-" then
        webhook = DecodeHexString(webhook, "0x0x0-")
    end

    local data = Config.DiscordWebhooking
    local defaultColor = 15105570  -- Define default color as a constant

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or defaultColor,
                ["author"] = {
                    ["name"] = data.Label,
                    ["icon_url"] = data.ImageUrl,
                },
                     
                ["title"] = name,
                ["description"] = description,
                     
                ["footer"] = {
                    ["text"] = data.Footer .. " • " .. os.date("%x %X %p"),
                    ["icon_url"] = data.ImageUrl,

                },

                ['image'] = { ['url'] = url },

            },

        },
        avatar_url = data.ImageUrl
    }), {
        ['Content-Type'] = 'application/json'
    })
end

GetUserDiscordRoles = function(_source)
    
    local userRoles  = GetDiscordRoles(_source, Config.DiscordServerID)

    if not userRoles or userRoles == nil then
        userRoles = {}
    end

    return userRoles

end

GetTableLength = function(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end



--[[ ------------------------------------------------
   Events
]]---------------------------------------------------

RegisterServerEvent('tp_libs:sendNotification')
AddEventHandler('tp_libs:sendNotification', function(tsource, message, type)
    local _source = tonumber(tsource)

    if tsource == nil then
        _source = source
    end

    SendNotification(_source, message, type)
end)

RegisterServerEvent('tp_libs:server:onDataUpdate')
AddEventHandler('tp_libs:server:onDataUpdate', function()
    -- todo nothing
end)

RegisterNetEvent("tp_libs:server:heartbeat")
AddEventHandler("tp_libs:server:heartbeat", function() 
    local _source = source

    if UserHeartbeats[_source] == nil then

        UserHeartbeats[_source] = { 
            timer = 0, 
            connection_lost = 0,
        }

    end
    
    UserHeartbeats[_source].timer = GetGameTimer() 
end)

--[[ ------------------------------------------------
   Framework Events
]]---------------------------------------------------

AddEventHandler("vorp:playerJobChange", function(source, newjob, oldjob)
    local _source = source
    TriggerClientEvent("tp_libs:getPlayerJob", _source, newjob)
end)

-----------------------------------------------------------
--[[ Player Data Callback  ]]--
-----------------------------------------------------------

addNewCallBack("tp_libs:getWebhookUrl", function(source, cb, data)
    local webhook = GetWebhookUrlByName(data.webhook)
    return cb(webhook)
end)

addNewCallBack("tp_libs:getPlayerData", function(source, cb, data)
    local _source = source

    while not HasLoadedFunctions() do
        Wait(500)
    end

    if data and data.source ~= nil then
        _source = tonumber(data.source)
    end

    local Functions = GetFunctions()

    if not Functions.IsPlayerCharacterSelected(_source) then 
        return cb(nil)
    end

    _source = tonumber(_source)

    return cb(
        { 
            source          = _source,
            identifier      = Functions.GetIdentifier(_source),
            charIdentifier  = Functions.GetCharacterId(_source),

            firstname       = Functions.GetFirstName(_source),
            lastname        = Functions.GetLastName(_source),

            job             = Functions.GetJob(_source),
            jobGrade        = Functions.GetJobGrade(_source),

            group           = Functions.GetGroup(_source),
            steamName       = GetPlayerName(_source)
        } 
    ) 
end)

--[[ ------------------------------------------------
   Events
]]---------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(60000)

    local time        = os.date("*t") 
    local currentTime = table.concat({time.hour, time.min}, ":")

    local finished    = false
    local shouldSave  = false

    for index, restartHour in pairs (Config.RestartHours) do

      if currentTime == restartHour then
        shouldSave = true
      end

      if next(Config.RestartHours, index) == nil then
        finished = true
      end

    end

    while not finished do
      Wait(1000)
    end

    CurrentTime = CurrentTime + 1

    if Config.SaveDataRepeatingTimer.Enabled and CurrentTime == Config.SaveDataRepeatingTimer.Duration then
      CurrentTime = 0
      shouldSave  = true
    end

    if shouldSave then
      TriggerEvent("tp_libs:server:onDataUpdate")
    end

  end

end)

Citizen.CreateThread(function()
    
    while true do
        Wait(1000)

        local now = GetGameTimer()

        for source, user in pairs(UserHeartbeats) do

            source = tonumber(source)

            local diff  = now - user.timer
            local state = diff > 2000 and 1 or 0 

            user.connection_lost = state

            if GetPlayerName(tonumber(source)) == nil then 
                UserHeartbeats[source] = nil
            end

        end

    end

end)
