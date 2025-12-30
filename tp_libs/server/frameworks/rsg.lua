local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'rsg' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local RSG = exports['rsg-core']:GetCoreObject() -- Core Getter

    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
            local xPlayer = RSG.Functions.GetPlayer(source)

            if xPlayer then -- NOT SURE IF IT WORKS FOR RSG TO PREVENT ERRORS IF PLAYER IS IN SESSION.
                return RSG.Functions.GetPlayer(source)
            end
    
            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end
    
        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.
    
            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end
    
            local xPlayer = RSG.Functions.GetPlayer(source)
            return xPlayer ~= nil -- NOT SURE IF IT WORKS FOR RSG TO PREVENT ERRORS IF PLAYER IS IN SESSION.
        end
    
        Functions.GetIdentifier = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.citizenid
        end
    
        Functions.GetCharacterId = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.cid
        end
    
        Functions.GetGroup = function(source)

            if RSG.Functions.HasPermission(source, 'admin') then
                return 'admin'
            end

            if RSG.Functions.HasPermission(source, 'moderator') then
                return 'moderator'
            end

            if RSG.Functions.HasPermission(source, 'mod') then
                return 'mod'
            end

            return 'user'

        end
    
        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return tostring(xPlayer.PlayerData.job.name)
        end
        
        Functions.SetJob = function(source, job)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.SetJob(job, 0)
        end
            
        Functions.GetJobGrade = function(source)
            local xPlayer = Functions.GetPlayer(source)
            local grade = xPlayer.PlayerData.job.grade.level or PlayerData.job.grade or PlayerData.job.level or 0

            return grade
        end
    
        Functions.GetFirstName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.charinfo.firstname
        end
    
        Functions.GetLastName = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.charinfo.lastname
        end
    
        -- ACCOUNTS
    
        Functions.GetMoney = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.Functions.GetMoney('cash')
        end
    
        Functions.GetGold = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.Functions.GetMoney('gold')
        end
    
        Functions.AddMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddMoney('cash', amount)
        end
    
        Functions.AddGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddMoney('gold', amount)
        end
    
    
        Functions.RemoveMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.RemoveMoney('cash', amount)
        end
    
        Functions.RemoveGold = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.RemoveMoney('gold', amount)
        end
    
        -- INVENTORY
    
        Functions.GetUserInventory = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.items
        end
    
        Functions.GetInventoryTotalWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return RSG.Player.GetTotalWeight(xPlayer.PlayerData.items)
        end

        Functions.GetInventoryMaxWeight = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.PlayerData.weight
        end
    
        Functions.AddItemToInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, RSG.Shared.Items[item], "add")
        end
    
        Functions.RemoveItemFromInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, RSG.Shared.Items[item], "remove")
        end

        Functions.GetItemCount = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer.Functions.GetItemByName(item) == nil then
                return 0
            else
                local amountitem = xPlayer.Functions.GetItemByName(item).amount
                return amountitem
            end

            return 0
        end
    
        Functions.GetItemWeight = function(item)
            local weight = 0

            if RSG.Shared.Items[item] then
    
                weight = RSG.Shared.Items[item].weight
            end
    
            return weight
        end
    
        Functions.CanCarryItem = function(source, item, amount)

            if not exports['rsg-inventory']:CanAddItem(source, item, amount) then
                return false
            end
    
            return true
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddItem(weapon, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RSG.Shared.Items[weapon], "add", 1)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            
            if not exports['rsg-inventory']:CanAddItem(source, weapon, 1) then
                return false
            end
    
            return true
    
        end
            
        Functions.GetItems = function() -- returns all server items in a table
            return RSG.Shared.Items
        end

       Functions.RegisterContainerInventory = function(containerName, maxWeight, invConfig)
            local id = os.time()
            id = tostring(id)
            
            local config = {
                id = tonumber(id),
                label = containerName,
                name = containerName, 
                maxweight = maxWeight and (maxWeight * 1000), --convert kg to g
                slots = invConfig.maxSlots
            }

            exports['rsg-inventory']:CreateInventory(id, config)
                
        end

        Functions.UnRegisterContainer = function(containerId)
            MySQL.update("DELETE FROM inventories WHERE identifier = ?", { containerId })
            return exports['rsg-inventory'].DeleteInventory(containerId)
        end

        Functions.GetContainerIdByName = function(containerName)
            return 0
        end

        Functions.UpgradeContainerWeight = function(containerId, extraWeight)
            -- n/a
        end

        Functions.DoesContainerExistById = function(containerId)
            return false
        end

        Functions.DoesContainerExistByName = function(containerName)
            return false
        end
            
        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1RSG^2] Framework.")

    end)

end


