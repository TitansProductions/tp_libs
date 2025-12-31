

local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'latest_vorp' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local VORP    = exports.vorp_core:GetCore() -- Core Getter
    local VORPInv = exports.vorp_inventory -- Core Inv Getter

    local function GetValue(value, default)
        if default == nil then
            return value
        end
        if default == false then
            return value or false
        end
        return value == nil and default or value
    end
    
    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
    
            local xPlayer = VORP.getUser(source)
    
            if xPlayer then
                return xPlayer.getUsedCharacter
            end
    
            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end
    
        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.
    
            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end
    
            local xPlayer = VORP.getUser(source)
            return xPlayer ~= nil
        end
    
        Functions.GetIdentifier = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.identifier
        end
    
        Functions.GetCharacterId = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.charIdentifier
        end
    
        Functions.GetGroup = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.group
        end
    
        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.job
        end
            
        Functions.SetJob = function(source, job)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.setJob(job)
        end

        Functions.GetJobGrade = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.jobGrade
        end
    
        Functions.GetFirstName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.firstname
        end
    
        Functions.GetLastName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.lastname
        end
    
        -- ACCOUNTS
    
        Functions.GetMoney = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.money
        end
    
        Functions.GetGold = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.gold
        end
    
        Functions.AddMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addCurrency(0, amount)
        end
    
        Functions.AddGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addCurrency(1, amount)
        end
    
        Functions.RemoveMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.removeCurrency(0, amount)
        end
    
        Functions.RemoveGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.removeCurrency(1, amount)
        end
    
        -- INVENTORY
    
        Functions.GetUserInventory = function(source)

            local items   = exports.vorp_inventory:vorp_inventoryApi().getUserInventory(source)
            local weapons = exports.vorp_inventory:vorp_inventoryApi().getUserWeapons(source)
                
            --local items   = VORPInv:getInventoryItems(source)
            --local weapons = VORPInv:getUserInventoryWeapons(source)
    
            for k, v in pairs (weapons) do
    
                v.metadata = { quality = 1 }
                v.quantity = 1
                v.type = "weapon"
    
                table.insert(items, v)
            end
    
            return items
        end
    
        Functions.GetInventoryTotalWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.invCapacity
        end
            
        Functions.GetInventoryMaxWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.invCapacity
        end
            
        Functions.AddItemToInventory = function(source, item, amount)
            VORPInv:addItem(source, item, amount)
        end

        Functions.RemoveItemFromInventory = function(source, item, amount)
            VORPInv:subItem(source, item, amount)
        end
    
        Functions.GetItemCount = function(source, item)

            local itemCount, await = 0, true

            VORPInv:getItemCount(source, function(count) itemCount = count await = false end, item)

            while await do
                Wait(100)
            end

            return itemCount or 0
        end
    
        Functions.GetItemWeight = function(item)
            local item = VORPInv.getDBItem(nil, item)
            return item.weight or 0
        end
    
        Functions.CanCarryItem = function(source, item, amount)
            local canCarryItem = VORPInv:canCarryItem(source, item, amount)
            return canCarryItem
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local hours, minutes, seconds = os.date('%H'), os.date('%M'), os.date('%S')
            local serialNumber = tonumber(hours) .. tonumber(minutes) .. tonumber(seconds)  .. math.random(1, 9).. math.random(1, 9).. math.random(1, 9)
            VORPInv:createWeapon(source, weapon, "0", {}, {} , nil, serialNumber)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            local canCarryWeapon, await = false, true

            VORPInv:canCarryWeapons(source, 1, function(canCarry) canCarryWeapon = canCarry await = false end, weapom)

            while await do
                Wait(100)
            end

            return canCarryWeapon
        end

        Functions.GetItems = function()
            local await = true
            local items = {}

            exports.ghmattimysql:execute("SELECT * FROM `items`", {}, function(result)
                items = result
                await = false
            end)

            while await do
                Wait(10)
            end

            return items
        end
            
        Functions.RegisterContainerInventory = function(name, maxWeight, invConfig)
            local containerId = exports.vorp_inventory:getCustomInventoryIdByName(name)

            if not containerId or containerId == 0 then
                local id = os.time()
                id = tostring(id)

                if invConfig == nil then
                    invConfig = {}
                end
                
                local invData = {
                    id = id,
                    name = name,
                    limit = maxWeight,
                    acceptWeapons = GetValue(invConfig.acceptWeapons, false),
                    shared = GetValue(invConfig.shared, true),
                    ignoreItemStackLimit = GetValue(invConfig.ignoreStackLimit, true),
                    whitelistItems = GetValue(invConfig.useWhitelist, invConfig.whitelist and true or false),
                    UseBlackList = GetValue(invConfig.useBlackList, invConfig.blacklist and true or false),
                    whitelistWeapons = GetValue(invConfig.useWeaponlist, invConfig.weaponlist and true or false),
                }
                
                VORPInv:registerInventory(invData)
            end
        end

        Functions.UnRegisterContainer = function(containerId)
            VORPInv:removeInventory(containerId)
        end

        Functions.GetContainerIdByName = function(containerName)
            local containerId = exports.vorp_inventory:getCustomInventoryIdByName(containerName)
            return containerId
        end

        Functions.UpgradeContainerWeight = function(containerId, limit) -- vorp does not support it, we use limit replacement only
            setCustomInventoryLimit(containerId, limit)
        end

        Functions.DoesContainerExistById = function(containerId)
            local exist = exports.vorp_inventory:isCustomInventoryRegistered(containerId)

            if exist == nil then
                exist = VORPInv:isCustomInventoryRegistered(containerId)
            end

            return exist
        end

        Functions.DoesContainerExistByName = function(containerId) -- no name available, id only. 
            local exist = exports.vorp_inventory:isCustomInventoryRegistered(containerId)

            if exist == nil then
                exist = VORPInv:isCustomInventoryRegistered(containerId)
            end

            return exist
        end

        Functions.OpenContainerInventory = function(source, containerId, title)
            exports.vorp_inventory:openInventory(source, containerId)
        end
    
        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1VORP-CORE^2] Framework.")

    end)

end








