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

    apiData.GetWebhookUrl = function(webhook)
        local wait = true
        local data_result
    
        TriggerEvent("tp_libs:ExecuteServerCallBack", "tp_libs:getWebhookUrl", function(cb) data_result = cb wait = false end, { webhook = webhook } )
    
        while wait do
            Wait(10)
        end
    
        return data_result
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

    self.GetWebhookUrl = function(webhook)
        local wait = true
        local data_result
    
        TriggerEvent("tp_libs:ExecuteServerCallBack", "tp_libs:getWebhookUrl", function(cb) data_result = cb wait = false end, { webhook = webhook } )
    
        while wait do
            Wait(10)
        end
    
        return data_result
    end

    self.sendNotification = function(source, message, type)
        TriggerServerEvent('tp_libs:sendNotification', source, message, type)
    end
        
    return self
end)

