

local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'tpzcore' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local TPZ    = exports.tpz_core:getCoreAPI() -- Core Getter
    local TPZInv = exports.tpz_inventory:getInventoryAPI() -- Core Inv Getter (EXAMPLE, INVENTORY API IS ALSO USED ON PLAYER OBJECT FOR TPZ-CORE)
    
    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
    
            local xPlayer = TPZ.GetPlayer(source)
    
            if xPlayer.loaded() then
                return TPZ.GetPlayer(source)
            end
    
            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end
    
        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.
    
            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end
    
            local xPlayer = TPZ.GetPlayer(source)
            return xPlayer.loaded()
        end
    
        Functions.GetIdentifier = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getIdentifier()
        end
    
        Functions.GetCharacterId = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getCharacterIdentifier()
        end
    
        Functions.GetGroup = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getGroup()
        end
    
        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getJob()
        end
    
        Functions.SetJob = function(source, job)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.setJob(job)
        end
    
        Functions.GetJobGrade = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getJobGrade()
        end
    
        Functions.GetFirstName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getFirstName()
        end
    
        Functions.GetLastName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getLastName()
        end
    
        -- ACCOUNTS
    
        Functions.GetMoney = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getAccount(0)
        end
    
        Functions.GetGold = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getAccount(1)
        end
    
        Functions.AddMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addAccount(0, amount)
        end
    
        Functions.AddGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addAccount(1, amount)
        end
    
    
        Functions.RemoveMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.removeAccount(0, amount)
        end
    
        Functions.RemoveGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.removeAccount(1, amount)
        end
    
        -- INVENTORY
    
        Functions.GetUserInventory = function(source)
            return TPZInv.getInventoryContents(source)
        end
    
        Functions.GetInventoryTotalWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getInventoryTotalWeight()
        end

        Functions.GetInventoryMaxWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getInventoryWeightCapacity()
        end
    
        Functions.AddItemToInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addItem(item, amount)
        end

        Functions.RemoveItemFromInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.removeItem(item, amount)
        end
    
        Functions.GetItemCount = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.getItemQuantity(item)
        end
    
        Functions.GetItemWeight = function(item)
            local count = TPZInv.getItemWeight(item)
            return count
        end
    
        Functions.CanCarryItem = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.canCarryItem(item, amount)
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.addWeapon(weapon)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.canCarryWeapon(weapon)
        end

        Functions.GetItems = function() -- returns all server items in a table
            return TPZInv.getSharedItems()
        end

        Functions.RegisterContainerInventory = function(containerName, maxWeight, data)
            -- @param containerName: requires a container name.
            -- @param containerWeight: requires the maximum container weight.
            -- @param insert : requires a boolean value (false / true) to insert to the containers database the new registered container inventory / not
            -- @param contents: a non-required parameter which requires a table form (only experienced developers).
            -- @param data : a non-required parameter which allows your container to have unique data.
            -- For example: { allowlisted = 1 } - this data allows this container to not remove any durability from food items.

            if data == nil then data = {} end

            local insert = data.insert or true
            local contents = data.contents or nil
            local _data = data.data or nil
                
            TriggerEvent("tpz_inventory:registerContainerInventory", containerName, maxWeight, insert, contents, _data)
        end

        Functions.UnRegisterContainer = function(containerId)
            TriggerEvent("tpz_inventory:unregisterCustomContainer", containerId)
        end

        Functions.GetContainerIdByName = function(containerName)
            local containerId = TPZInv.getContainerIdByName(containerName)
            return containerId
        end

        Functions.UpgradeContainerWeight = function(containerId, extraWeight)
            -- @param containerId: requires a container id (not name).
            -- @param extraWeight: requires a double integer value.
            TriggerEvent("tpz_inventory:upgradeContainerInventoryWeight", containerId, extraWeight)
        end

        Functions.DoesContainerExistById = function(containerId)
            local containerExist = TPZInv.doesContainerExistById(containerId)
            return containerExist
        end

        Functions.DoesContainerExistByName = function(containerName)
            local containerExist = TPZInv.doesContainerExistByName(containerName)
            return containerExist
        end

        Functions.OpenContainerInventory = function(source, containerId, title)
            TriggerClientEvent("tpz_inventory:openInventoryContainerById", source, containerId, title, false, false, nil)
        end

        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1TPZ-CORE^2] Framework.")

    end)

end







