

local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'redemrp' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local REDEM    = exports["redem_roleplay"]:RedEM()
    local REDEMInv = {}

    TriggerEvent("redemrp_inventory:getData",function(call)
        REDEMInv = call
    end)
    
    Citizen.CreateThread(function () 
        
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end
    
            local xPlayer = REDEM.GetPlayer(source)
    
            if xPlayer.loaded() then
                return REDEM.GetPlayer(source)
            end
    
            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end
    
        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.
    
            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end
    
            local xPlayer = REDEM.GetPlayer(source)
            return xPlayer.loaded()
        end
    
        Functions.GetIdentifier = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.identifier
        end
    
        Functions.GetCharacterId = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.charid
        end
    
        Functions.GetGroup = function(source)

            local awaut = false
            local group = "user"
    
            TriggerEvent('redemrp:getPlayerFromId', source, function(user)
                if user ~= nil then
                    
                    group = user.getGroup()
                    await = true
    
                end
    
            end)
    
            while not await do
                Wait(50)
            end
    
            return group
        end
    
        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.job
        end
    
        Functions.GetJobGrade = function(source)
            local xPlayer = Functions.GetPlayer(source)
            return xPlayer.jobgrade
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
            return xPlayer.getMoney()
        end
    
        Functions.GetGold = function(source)
            return 0 -- unknown?
        end
    
        Functions.AddMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.AddMoney(amount)
        end
    
        Functions.AddGold = function(source, amount)
            -- unknown?
        end
    

        Functions.RemoveMoney = function(source, amount)
            local xPlayer = Functions.GetPlayer(source)
            xPlayer.RemoveMoney(amount)
        end
    
        Functions.RemoveGold = function(source, amount)
            -- unknown?
        end
    
        -- INVENTORY
    
        Functions.GetUserInventory = function(source)
            return REDEMInv.getPlayerInventory(source)
        end
    
        Functions.GetInventoryTotalWeight = function(source)
            return 0 -- unknown!
        end
    
        Functions.AddItemToInventory = function(source, item, amount)
            local ItemData = REDEMInv.getItem(source, item)
            ItemData.AddItem(amount)
        end
    
        Functions.GetItemCount = function(source, item, amount)
            local ItemData = REDEMInv.getItem(source, item)
            return ItemData.ItemAmount
        end
    
        Functions.GetItemWeight = function(item)
            local ItemData = nil
            local await = false 
    
            TriggerEvent("redemrp_inventory:getData",function(call)
    
                ItemData = call.getItemData(item) -- return info from config
                await = true
            end)
    
            while not await do
                Wait(1)
            end
    
            if ItemData == nil then
                return 0
            else
                return ItemData.weight
            end

            return 0

        end
    
        Functions.CanCarryItem = function(source, item, amount)
            local ItemData = REDEMInv.getItem(source, item)

            if not ItemData.AddItem(amount) then 
                return false 
            else 
                return true 
            end

            return false
    
        end
    
        Functions.AddWeaponToInventory = function(source, weapon)
            local ItemData = REDEMInv.getItem(source, weapon)
            ItemData.AddItem(1)
        end
    
        Functions.CanCarryWeapons = function(source, weapon)
            local ItemData = REDEMInv.getItem(source, weapon) -- we use the same as item since weapon is item on redemrp.

            if not ItemData.AddItem(amount) then 
                return false 
            else 
                return true 
            end

            return false
        end

        Functions.RegisterContainerInventory = function(containerName, maxWeight, data)
            REDEMInv.createLocker(containerName, "empty")
        end

        Functions.UnRegisterContainer = function(containerName)
            exports["ghmattimysql"]:execute("DELETE FROM stashes WHERE stashid = @stashid", { ["@stashid"] = containerName })
        end

        Functions.GetContainerIdByName = function(containerId) -- we get the name not the id, same as rsg
            return containerId
        end

        Functions.UpgradeContainerWeight = function(containerId, extraWeight)
            -- n/a
        end

        Functions.DoesContainerExistById = function(containerId)
            local exist = exports["ghmattimysql"]:execute('SELECT stashid FROM stashes WHERE id = ?', { containerId })

            if exist == nil then
                exist = false
            end

            return exist ~= nil and true or false
        end

        Functions.DoesContainerExistByName = function(containerName)
            local exist = exports["ghmattimysql"]:execute('SELECT id FROM stashes WHERE stashid = ?', { containerName })

            if exist == nil then
                exist = false
            end

            return exist ~= nil and true or false
        end

        Functions.OpenContainerInventory = function(source, containerName, title) -- requires name not id as rsg
            TriggerClientEvent("redemrp_inventory:OpenLocker", source, containerName)
        end
       
        AddFunctionsList(Functions) -- DO NOT MODIFY!
    
        Wait(5000)
        print("^2Sucessfully loaded - [^1REDEM:RP^2] Framework.")

    end)

end




