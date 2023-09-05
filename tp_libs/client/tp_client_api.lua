AddEventHandler('getTPAPI', function(cb)
    local apiData = {}
    
    apiData.RpcCall = function(name, callback, ...) 
        ClientRPC.Callback.TriggerAsync(name, callback, ...) 
    end

    apiData.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end

    cb(apiData)
end)


exports('rClientAPI', function()
    local self = {}

    self.getLocale = function(string)
        
        local str = Locales[string]

        if Locales[string] == nil then 
            str = "Locale `" .. string .. "` does not seem to exist." 
        end

        return str
    end

    self.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end

    return self
end)
