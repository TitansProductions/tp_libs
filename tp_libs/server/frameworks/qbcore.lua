local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'qbocore' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local QBCORE = exports['qbr-core']:GetCoreObject() -- Core Getter

    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
            local xPlayer = exports['qbr-core']:GetPlayer(source)

            if xPlayer then -- NOT SURE IF IT WORKS FOR QBCORE TO PREVENT ERRORS IF PLAYER IS IN SESSION.
                return exports['qbr-core']:GetPlayer(source)
            end
    
            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end
    
        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.
    
            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end
    
            local xPlayer = exports['qbr-core']:GetPlayer(source)
            return xPlayer ~= nil -- NOT SURE IF IT WORKS FOR QBCORE TO PREVENT ERRORS IF PLAYER IS IN SESSION.
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
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.group
        end
    
        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return tostring(xPlayer.PlayerData.job.name)
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
            return QBCORE.Player.GetTotalWeight(xPlayer.PlayerData.items)
        end
    
        Functions.AddItemToInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCORE.Shared.Items[item], "add")
        end
    
        Functions.RemoveItemFromInventory = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCORE.Shared.Items[item], "remove")
        end

        Functions.GetItemCount = function(source, item, amount)
            local xPlayer = Functions.GetPlayer(source)
            return QBCORE.getItemCount(tonumber(source), item)
        end
    
        Functions.GetItemWeight = function(item)
            local weight = 0
    
            return weight
        end
    
        Functions.CanCarryItem = function(source, item, amount)

            if not exports['qbr-inventory']:CanAddItem(source, item, amount) then
                return false
            end
    
            return true
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.Functions.AddItem(weapon, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCORE.Shared.Items[weapon], "add", 1)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            
            if not exports['qbr-inventory']:CanAddItem(source, weapon, 1) then
                return false
            end
    
            return true
    
        end
    
        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1QBCORE^2] Framework.")

    end)

end
