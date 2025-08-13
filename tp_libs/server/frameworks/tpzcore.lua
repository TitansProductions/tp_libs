

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
            
        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1TPZ-CORE^2] Framework.")

    end)

end


