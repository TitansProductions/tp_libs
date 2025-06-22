

local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'gum' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local GUM = nil

    TriggerEvent("getCore", function(cb) VORP = cb end)

    local GUMInv = exports.vorp_inventory:gum_inventoryApi() -- Core Inv Getter
    
    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
    
            local xPlayer = GUM.getUser(source)
    
            if xPlayer then -- THIS WILL ALWAYS BE AN ERROR ON GUM
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
    
            local xPlayer = GUM.getUser(source) -- THIS WILL ALWAYS BE AN ERROR ON OLD GUM
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

            local items   = GUMInv.getUserInventory(source)
            local weapons = GUMInv.getUserWeapons(source)
    
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
    
        Functions.AddItemToInventory = function(source, item, amount)
            GUMInv.addItem(source, item, amount)
        end

        Functions.RemoveItemFromInventory = function(source, item, amount)
            GUMInv.subItem(source, item, amount)
        end
    
        Functions.GetItemCount = function(source, item)
            local itemCount = GUMInv.getItemCount(source, item)

            return itemCount or 0
        end
    
        Functions.GetItemWeight = function(item)
            local item = GUMInv.getInventoryItem(item)
            return item.weight or 0
        end
    
        Functions.CanCarryItem = function(source, item, amount)
            local canCarryItem = GUMInv.canCarryItem(source, item, amount)
            return canCarryItem
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local emptyComponent = {["nothing"] = 0}
            CoreInventoryAPI.createWeapon(source, weapon, emptyComponent, emptyComponent)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            local canCarryWeapon, await = false, true

            GUMInv.canCarryWeapons(source, 1, function(canCarry) canCarryWeapon = canCarry await = false end, weapom)

            while await do
                Wait(100)
            end

            return canCarryWeapon
        end
    
        AddFunctionsList(Functions)
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1GUM^2] Framework.")

    end)

end