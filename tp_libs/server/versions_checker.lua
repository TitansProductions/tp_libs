-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

local function startsWith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
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
          
           -- We print ONLY if the version is outdated.
           if tostring(currentVersion) ~= tostring(text) then
              local log = string.format("(!) Outdated version - current: %s | required: %s", currentVersion, text)
              print(('^5['.. resourceName..']%s %s^7'):format('^1', log))
           end
     
        end)
     
    end)

end
