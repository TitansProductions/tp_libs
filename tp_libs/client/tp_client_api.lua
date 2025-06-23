-- @deprecated
AddEventHandler('getTPAPI', function(cb)
    local apiData = {}
    
    apiData.getConfiguration = function()
        return Config
    end

    apiData.getFramework = function()
        return Config.Framework
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
        return Config.Framework
    end

    self.RpcCall = function(name, callback, ...) 
        ClientRPC.Callback.TriggerAsync(name, callback, ...) 
    end

    self.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end
        
    return self
end)
