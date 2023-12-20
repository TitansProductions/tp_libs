
AddEventHandler('getTPAPI', function(cb)
    local apiData = {}

    apiData.getLocale = function(string)
        
        local str = Locales[string]

        if Locales[string] == nil then 
            str = "Locale `" .. string .. "` does not seem to exist." 
        end

        return str

    end

    apiData.getConfiguration = function()
        return Config
    end

    apiData.getFramework = function()
        return Config.Framework
    end
        
    apiData.round = function(number, decimals)
        local power = 10^decimals
        return math.floor(number * power) / power
    end

    apiData.sendNotification = function(source, message, type)
        TriggerEvent('tp_libs:sendNotification', source, message, type)
    end

    apiData.sendToDiscord = function(webhook, name, description, color)
        TriggerEvent('tp_libs:sendToDiscord', webhook, name, description, color)
    end

    -- Framework Functions
    apiData.getPlayer = function(source)
        local rv = GetPlayer(source) return rv
    end

    apiData.getIdentifier = function(source)
        local rv = GetIdentifier(source) return rv
    end

    apiData.getChar = function(source)
        local rv = GetChar(source) return rv
    end

    apiData.getGroup = function(source)
        local rv = GetGroup(source) return rv
    end
        
    apiData.addItemToInventory = function(source, item, quantity)
        AddItemToInventory(source, item, quantity)
    end

    apiData.removeItemFromInventory = function(source, item, quantity)
        RemoveItemFromInventory(source, item, quantity)
    end

    apiData.addWeaponToInventory = function(source, weapon)
        AddWeaponToInventory(source, weapon)
    end

    apiData.getItemCount = function(source, item)
        local rv = GetItemCount(source, item) return rv
    end

    apiData.getMoney = function(source)
        local rv = GetMoney(source) return rv
    end

    apiData.addMoney = function(source, quantity)
        AddMoney(source, quantity)
    end

    apiData.removeMoney = function(source, quantity)
        RemoveMoney(source, quantity)
    end

    apiData.getGold = function(source)
        local rv = GetGold(source) return rv
    end

    apiData.addGold = function(source, quantity)
        AddGold(source, quantity)
    end

    apiData.removeGold = function(source, quantity)
        RemoveGold(source, quantity)
    end

    apiData.canCarryItem = function(source, item, quantity)
        local rv = CanCarryItem(source, item, quantity) return rv
    end

    apiData.canCarryWeapons = function(source, weapon, quantity)
        local rv = CanCarryWeapons(source, weapon, quantity) return rv
    end

    apiData.getUserInventoryContents = function(source)
        local rv = GetUserInventory(source) return rv
    end

    apiData.getJob = function(source)
        local rv = GetJob(source) return rv
    end

    apiData.getJobGrade = function(source)
        local rv = GetJobGrade(source) return rv
    end
        
    apiData.getFirstName = function(source)
        local rv = GetFirstName(source) return rv
    end

    apiData.getLastName = function(source)
        local rv = GetLastName(source) return rv
    end
        
    cb(apiData)
end)

exports('rServerAPI', function()
    local self = {}

    self.addNewCallBack = function(name, cb) TriggerEvent("tp_libs:addNewCallBack", name, cb) end

    self.getLocale = function(string)
        
        local str = Locales[string]

        if Locales[string] == nil then 
            str = "Locale `" .. string .. "` does not seem to exist." 
        end

        return str

    end

    self.getConfiguration = function()
        return Config
    end

    self.getFramework = function()
        return Config.Framework
    end

    self.round = function(number, decimals)
        local power = 10^decimals
        return math.floor(number * power) / power
    end

    self.sendNotification = function(source, message, type)
        TriggerEvent('tp_libs:sendNotification', source, message, type)
    end

    self.sendToDiscord = function(webhook, name, description, color)
        TriggerEvent('tp_libs:sendToDiscord', webhook, name, description, color)
    end

    -- Framework Functions
    self.getPlayer = function(source)
        local rv = GetPlayer(source) return rv
    end

    self.getIdentifier = function(source)
        local rv = GetIdentifier(source) return rv
    end

    self.getChar = function(source)
        local rv = GetChar(source) return rv
    end

    self.getGroup = function(source)
        local rv = GetGroup(source) return rv
    end

    self.addItemToInventory = function(source, item, quantity)
        AddItemToInventory(source, item, quantity)
    end

    self.removeItemFromInventory = function(source, item, quantity)
        RemoveItemFromInventory(source, item, quantity)
    end

    self.addWeaponToInventory = function(source, weapon)
        AddWeaponToInventory(source, weapon)
    end

    self.getItemCount = function(source, item)
        local rv = GetItemCount(source, item) return rv
    end

    self.getMoney = function(source)
        local rv = GetMoney(source) return rv
    end

    self.addMoney = function(source, quantity)
        AddMoney(source, quantity)
    end

    self.removeMoney = function(source, quantity)
        RemoveMoney(source, quantity)
    end

    self.getGold = function(source)
        local rv = GetGold(source) return rv
    end

    self.addGold = function(source, quantity)
        AddGold(source, quantity)
    end

    self.removeGold = function(source, quantity)
        RemoveGold(source, quantity)
    end

    self.canCarryItem = function(source, item, quantity)
        local rv = CanCarryItem(source, item, quantity) return rv
    end

    self.canCarryWeapons = function(source, weapon, quantity)
        local rv = CanCarryWeapons(source, weapon, quantity) return rv
    end

    self.getUserInventoryContents = function(source)
        local rv = GetUserInventory(source) return rv
    end

    self.getJob = function(source)
        local rv = GetJob(source) return rv
    end

    self.getJobGrade = function(source)
        local rv = GetJobGrade(source) return rv
    end

    self.getFirstName = function(source)
        local rv = GetFirstName(source) return rv
    end

    self.getLastName = function(source)
        local rv = GetLastName(source) return rv
    end

    return self
end)
