-- @deprecated
AddEventHandler('getTPAPI', function(cb)
    local apiData = {}
    
    apiData.getConfiguration = function()
        return Config
    end

    apiData.getFramework = function()

        local frameworkSelected = Config.Framework

        if frameworkSelected == 'old_vorp' or frameworkSelected == 'latest_vorp' then
            frameworkSelected = 'vorp'
        end

        return frameworkSelected
    end
        
    apiData.RpcCall = function(name, callback, ...) 
        ClientRPC.Callback.TriggerAsync(name, callback, ...) 
    end

    apiData.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end

    cb(apiData)
end)


exports('getAPI', function()
    local self = {}

    self.getConfiguration = function()
        return Config
    end

    self.getFramework = function()

        local frameworkSelected = Config.Framework

        if frameworkSelected == 'old_vorp' or frameworkSelected == 'latest_vorp' then
            frameworkSelected = 'vorp'
        end

        return frameworkSelected
    end

    self.RpcCall = function(name, callback, ...) 
        ClientRPC.Callback.TriggerAsync(name, callback, ...) 
    end

    self.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end
        
    return self
end)

