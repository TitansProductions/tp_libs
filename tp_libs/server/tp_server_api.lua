
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

    apiData.sendToDiscord = function(webhook, title, description, color)
        SendToDiscordWebhook(webhook, title, description, color)
    end

    apiData.sendImageUrlToDiscord = function(webhook, title, description, url, color)
        SendImageUrlToDiscordWebhook(webhook, title, description, url, color)
    end
    
    apiData.sendToDiscordWithPlayerParameters = function(webhook, title, source, steamName, username, identifier, charidentifier, description, color)
        local message = string.format("**Online Player ID:** `%s`\n**Steam Name:** `%s`\n**First & Last Name**: `%s`\n**Steam Identifier:** `%s`\n**Character Id:** `%s`\n\n**Description:**\n" .. description, source, steamName, username, identifier, charidentifier)
        SendToDiscordWebhook(webhook, title, message, color)
    end

        apiData.GetSeparatedPlayersByDistance = function(coords, radius)
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

    apiData.TriggerClientEventAsyncByCoords = function(eventName, data, coords, radius, delay, multiplyDelay, multiplyMinPlayers)
        -- Separate players into nearby and far based on the radius
        local nearbyPlayers, farPlayers = apiData.GetSeparatedPlayersByDistance(coords, radius)

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

    apiData.TriggerClientEventByJobs = function(eventName, data, jobs) 

        local players = GetPlayers()

        for _, playerId in ipairs(players) do

            playerId = tonumber(playerId)

            if IsPlayerCharacterSelected(playerId) then

                local playerJob = GetJob(playerId)

                for index, job in pairs (jobs) do 

                    if job == playerJob then
                        TriggerClientEvent(eventName, playerId, data)
                    end

                end

            end

        end


    end

    -- Framework Functions
        
    apiData.isPlayerCharacterSelected = function(source)
        local rv = IsPlayerCharacterSelected(source) return rv
    end

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
        
    apiData.addItemToInventory = function(source, item, quantity, label)
        AddItemToInventory(source, item, quantity, label)
    end

    apiData.removeItemFromInventory = function(source, item, quantity, label)
        RemoveItemFromInventory(source, item, quantity, label)
    end

    apiData.addWeaponToInventory = function(source, weapon)
        AddWeaponToInventory(source, weapon)
    end

    apiData.getItemCount = function(source, item)
        local rv = GetItemCount(source, item) return rv
    end
        
    apiData.getItemWeight = function(item)
        local rv = GetItemWeight(item) return rv
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

    apiData.getInventoryTotalWeight = function(source)
        return GetInventoryTotalWeight(source)
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
    
    apiData.getDiscordRoles = function(source)
        local rv = GetUserDiscordRoles(source) return rv
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

    -- Framework Functions

    self.isPlayerCharacterSelected = function(source)
        local rv = IsPlayerCharacterSelected(source) return rv
    end
        
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

    self.addItemToInventory = function(source, item, quantity, label)
        AddItemToInventory(source, item, quantity, label)
    end

    self.removeItemFromInventory = function(source, item, quantity, label)
        RemoveItemFromInventory(source, item, quantity, label)
    end

    self.addWeaponToInventory = function(source, weapon)
        AddWeaponToInventory(source, weapon)
    end

    self.getItemCount = function(source, item)
        local rv = GetItemCount(source, item) return rv
    end

    self.getItemWeight = function(item)
        local rv = GetItemWeight(item) return rv
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

    self.getInventoryTotalWeight = function(source)
        return GetInventoryTotalWeight(source)
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

    self.getDiscordRoles = function(source)
        local rv = GetUserDiscordRoles(source) return rv
    end

    return self
end)
