local Functions, LoadedFunctions = {}, false

exports('getAPI', function()
    local self = {}

    self.addNewCallBack = function(name, cb) TriggerEvent("tp_libs:addNewCallBack", name, cb) end

    -- GENERAL API FUNCTIONS.

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

    self.getWebhookUrl = function(webhook)
        return GetWebhookUrlByName(webhook)
    end

    -- GENERAL UTILITY API FUNCTIONS

    self.sendNotification = function(source, message, type)
        TriggerEvent('tp_libs:sendNotification', source, message, type)
    end

    self.sendToDiscord = function(webhook, title, description, color)
        SendToDiscordWebhook(webhook, title, description, color)
    end

    self.sendImageUrlToDiscord = function(webhook, title, description, url, color)
        SendImageUrlToDiscordWebhook(webhook, title, description, url, color)
    end
    
    self.sendToDiscordWithPlayerParameters = function(webhook, title, source, steamName, username, identifier, charidentifier, description, color)
        local message = string.format("**Online Player ID:** `%s`\n**Steam Name:** `%s`\n**First & Last Name**: `%s`\n**Steam Identifier:** `%s`\n**Character Id:** `%s`\n\n**Description:**\n" .. description, source, steamName, username, identifier, charidentifier)
        SendToDiscordWebhook(webhook, title, message, color)
    end

    self.GetSeparatedPlayersByDistance = function(coords, radius)
        local nearbyPlayers, farPlayers = {}, {}

        local players = GetPlayers()

        for _, playerId in ipairs(players) do

            playerId = tonumber(playerId)

            local playerCoords = GetEntityCoords(GetPlayerPed(playerId)) -- Get the player's coordinates
    
            -- Calculate the distance between the player and the center
            local distance = #(coords - playerCoords)
    
            -- Categorize players based on their distance
            if distance <= radius then
                table.insert(nearbyPlayers, playerId)
            else
                table.insert(farPlayers, playerId)
            end
        end
    
        return nearbyPlayers, farPlayers
    end

    self.TriggerClientEventAsyncByCoords = function(eventName, data, coords, radius, delay, multiplyDelay, multiplyMinPlayers)
        -- Separate players into nearby and far based on the radius
        local nearbyPlayers, farPlayers = self.GetSeparatedPlayersByDistance(coords, radius)

        -- Update nearby players immediately
        for _, playerId in ipairs(nearbyPlayers) do
            TriggerClientEvent(eventName, playerId, data)
        end

        -- An extra option to multiply the delay if the far players are less than the minimum input.
        -- Example: If multiplyMinPlayers input is 40, it will multiply the update delay but if the players
        -- are more than 40, it will not multiply but use the default delay input.
        -- The multiply feature is for the 40 players to take the same time to be updated as it should in 80 players.
        -- If delay is 200 (WITHOUT MULTIPLY), it would take with 80 players 16 seconds to be updated, but in 40 players, it would take 8 seconds
        -- but this if option is multiplying, it will take 16 seconds to be updated for 40 players and not 8 seconds, we prefer that for better performance.
        if multiplyDelay and GetTableLength(farPlayers) <= multiplyMinPlayers then
            delay = delay * 2
        end

        -- Update far players in batches with a delay
        Citizen.CreateThread(function()
    
            -- Send the event to each player in the batch
            for _, playerId in ipairs(farPlayers) do
                TriggerClientEvent(eventName, playerId, data)
                -- Wait for the specified delay before the next update loop.
                Citizen.Wait(delay)
            end

        end)

    end

    self.TriggerClientEventByJobs = function(eventName, data, jobs) 

        local players = GetPlayers()

        for _, playerId in ipairs(players) do

            playerId = tonumber(playerId)

            if Functions.IsPlayerCharacterSelected(playerId) then

                local playerJob = Functions.GetJob(playerId)

                for index, job in pairs (jobs) do 

                    if job == playerJob then
                        TriggerClientEvent(eventName, playerId, data)
                    end

                end

            end

        end


    end

    self.getDiscordRoles = function(source)
        local cb = GetUserDiscordRoles(source)
        return cb
    end
        
    self.hasLostConnection = function(source)
        if UserHeartbeats[source] == nil then return false end 

        return UserHeartbeats[source] == 1 and true or false
    end

    -- FRAMEWORK RELATED API FUNCTIONS

    self.getPlayer = function(source)
        local cb = Functions.GetPlayer(source)
        return cb
    end

    self.isPlayerCharacterSelected = function(source)
        local cb = Functions.IsPlayerCharacterSelected(source)
        return cb
    end

    self.getIdentifier = function(source)
        local cb = Functions.GetIdentifier(source)
        return cb
    end

    self.getChar = function(source)
        local cb = Functions.GetCharacterId(source)
        return cb
    end

    self.getGroup = function(source)
        local cb = Functions.GetGroup(source)
        return cb
    end

    self.getJob = function(source)
        local cb = Functions.GetJob(source)
        return cb
    end

    self.setJob = function(source, job)
        Functions.SetJob(source, job)
    end
        
    self.getJobGrade = function(source)
        local cb = Functions.GetJobGrade(source)
        return cb
    end
        
    self.getFirstName = function(source)
        local cb = Functions.GetFirstName(source)
        return cb
    end

    self.getLastName = function(source)
        local cb = Functions.GetLastName(source)
        return cb
    end
    
    self.getMoney = function(source)
        local cb = Functions.GetMoney(source)
        return cb
    end

    self.getGold = function(source)
        local cb = Functions.GetGold(source)
        return cb
    end

    self.addMoney = function(source, quantity)
        Functions.AddMoney(source, quantity)
    end

    self.addGold = function(source, quantity)
        Functions.AddGold(source, quantity)
    end

    self.removeMoney = function(source, quantity)
        Functions.RemoveMoney(source, quantity)
    end

    self.removeGold = function(source, quantity)
        Functions.RemoveGold(source, quantity)
    end

    self.getUserInventoryContents = function(source)
        local cb = Functions.GetUserInventory(source)
        return cb
    end

    self.getInventoryTotalWeight = function(source)
        local cb = Functions.GetInventoryTotalWeight(source)
        return cb
    end
            
    self.getInventoryMaxWeight = function(source)
        local cb = Functions.GetInventoryMaxWeight(source)
        return cb
    end
        
    self.addItemToInventory = function(source, item, quantity, label)
        Functions.AddItemToInventory(source, item, quantity, label)
    end

    self.getItemCount = function(source, item)
        local cb = Functions.GetItemCount(source, item)
        return cb
    end
        
    self.getItemWeight = function(item)
        local cb = Functions.GetItemWeight(item)
        return cb
    end

    self.canCarryItem = function(source, item, quantity)
        local cb = Functions.CanCarryItem(source, item, quantity)
        return cb
    end

    self.removeItemFromInventory = function(source, item, quantity, label)
        Functions.RemoveItemFromInventory(source, item, quantity, label)
    end

    self.addWeaponToInventory = function(source, weapon)
        Functions.AddWeaponToInventory(source, weapon)
    end

    self.canCarryWeapons = function(source, weapon, quantity)
        local cb = Functions.CanCarryWeapons(source, weapon, quantity)
        return cb
    end

    self.getItems = function()
        return Functions.GetItems()
    end

    self.RegisterContainerInventory = function(containerName, maxWeight, data)
        Functions.RegisterContainerInventory(containerName, maxWeight, data)
    end

    self.UnRegisterContainer = function(containerId)
        Functions.UnRegisterContainer(containerId)
    end

    self.GetContainerIdByName = function(containerName)
        local containerId = Functions.GetContainerIdByName(containerName)
        local count = 0
            
        while (containerId == nil or containerId == 0) do 
            Wait(100)

            count = count + 1
            containerId = Functions.GetContainerIdByName(containerName)

            if count == 10 then
                break
            end
        end
            
        return containerId
    end

    self.UpgradeContainerWeight = function(containerId, extraWeight)
        Functions.UpgradeContainerWeight(containerId, extraWeight)
    end

    return self

end)

AddFunctionsList = function(list)
    Functions = list
    LoadedFunctions = true
end

GetFunctions = function()
    return Functions
end

HasLoadedFunctions = function()
    return LoadedFunctions
end
