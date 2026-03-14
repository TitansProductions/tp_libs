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

    apiData.openContainerInventory = function(containerId, title)
        TriggerServerEvent("tp_libs:server:openContainerInventory", containerId, title)
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

    self.GetPlayerData = function()
        local wait = true
        local data_result
    
        TriggerEvent("tp_libs:ExecuteServerCallBack", "tp_libs:getPlayerData", function(cb)
            data_result = cb
            wait = false
        end)
    
        while wait do
            Wait(25)
        end
    
        return data_result
    
    end

    self.openContainerInventory = function(containerId, title)
        TriggerServerEvent("tp_libs:server:openContainerInventory", containerId, title)
    end

    self.PlayAnimation = function(ped, anim)
    
        if not DoesAnimDictExist(anim.dict) then
            return false
        end
        
        local await = 10000
        local loaded = true
    
        RequestAnimDict(anim.dict)
        
        while not HasAnimDictLoaded(anim.dict) do
    
            await = await - 10
    
            if await <= 0 then
                loaded = false
                break
            end
    
            Citizen.Wait(10)
        end
    
        if loaded then
            TaskPlayAnim(ped, anim.dict, anim.name, anim.blendInSpeed, anim.blendOutSpeed, anim.duration, anim.flag, anim.playbackRate, false, false, false, '', false)
            RemoveAnimDict(anim.dict)
        end
    
        return loaded
    end
    

    return self
end)




