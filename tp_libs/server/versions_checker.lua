-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

local function startsWith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local function compareVersions(v1, v2)
   local function splitVersion(v)
       local t = {}
       for num in string.gmatch(v, "%d+") do
           table.insert(t, tonumber(num))
       end
       return t
   end

   local a = splitVersion(v1)
   local b = splitVersion(v2)

   local maxLen = math.max(#a, #b)

   for i = 1, maxLen do
       local x = a[i] or 0
       local y = b[i] or 0

       if x < y then return -1 end
       if x > y then return 1 end
   end

   return 0
end

local function isOutdated(current, latest)
   return compareVersions(current, latest) == -1
end
-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

if Config.VersionChecker then

    AddEventHandler('onResourceStart', function(resourceName)

        -- If the started resource does not start with `tp_` which returns titans productions scripts, we return the code.
        if not startsWith(resourceName, "tp_") then
           return
        end
       
        -- We are now checking if the script which contains and started with the required string does exist in the `githubusercontent`.
        -- To return a valid version.
     
        PerformHttpRequest('https://raw.githubusercontent.com/TitansProductions/' .. resourceName .. '/main/version.txt', function(err, text, headers)
           local currentVersion = GetResourceMetadata(resourceName, 'version')
     
           if not text then 
              -- print('[warn] Currently unable to run a version check for resource {' .. resourceName .. '}.')
              return nil
           end
     
           Wait(5000)

           currentVersion = tostring(currentVersion)
           text = tostring(text)

           if isOutdated(currentVersion, text) then
              local log = string.format("(!) Outdated Resource Version - Current Version: %s | Required Version: %s", currentVersion, text)
              print(('^5['.. resourceName..']%s %s^7'):format('^1', log))
           end
     
        end)
     
    end)

end
