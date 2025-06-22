Config = {}

Config.Debug = true

---------------------------------------------------------------
--[[ General Settings ]]--
---------------------------------------------------------------

-- @Supported Versions: old_vorp, latest_vorp, gum, rsg, rsgv2, qbcore, redemrp, tpzcore
Config.Framework = "tpzcore"

-- The following option is saving all the data before server restart hours
-- (2-3 Minutes atleast before server restart is mostly preferred).
Config.RestartHours = { "7:57" , "13:57", "19:57", "1:57"}

-- As default, we save all data every 15 minutes to avoid data loss in case for server crashes.
-- @param Enabled : Set to false do disable saving every x minutes.
-- @param Duration : Time in minutes.
Config.SaveDataRepeatingTimer = { Enabled = true, Duration = 10 }

---------------------------------------------------------------
--[[ Discord API Configurations ]]--
---------------------------------------------------------------

-- The specified feature is for advanced permissions which are based on the
-- discord roles of your discord server.

-- Your discord server ID.
Config.DiscordServerID = 'xxxxxxxxxxxxxxxxxxxx'

-- Your discord bot token, if does not exist, create a bot in the url below:
-- https://discord.com/developers/applications
Config.DiscordBotToken = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

---------------------------------------------------------------
--[[ Discord Webhooking ]]--
---------------------------------------------------------------

-- All colors can be found here: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
Config.DiscordWebhooking = {
    Label = "Server Name",
    ImageUrl = "https://i.imgur.com/xxxxxxxxx.png",
    Footer = "© Server Name Team",
}

---------------------------------------------------------------
--[[ Documents Menu ]]--
---------------------------------------------------------------

-- DO NOT SET TO false if you don't want a command to open the Documents NUI.
-- Set it to something unknown.
Config.DocumentsCommand = 'documents'
---------------------------------------------------------------
--[[ Notifications ]]--
---------------------------------------------------------------

-- source is always null when called from client.
-- messageType, returns "success" or "error" depends when and where the message is sent.
function SendNotification(source, message, messageType)
    local _source = source

    -- Server Side
    if _source then

        if Config.Framework == "vorp" then
            TriggerClientEvent("vorp:TipRight", _source, message, 3000)

        elseif Config.Framework == "gum" then
            TriggerClientEvent("gum:TipRight", _source, message, 3000)

        elseif Config.Framework == "redemrp" then
            TriggerClientEvent("redem_roleplay:NotifyRight", _source, message, 3000)

        elseif Config.Framework == "rsg" or Config.Framework == 'rsgv2' then
            TriggerClientEvent('RSGCore:Notify', _source, message, 'primary')

        elseif Config.Framework == "qbcore" then
            TriggerClientEvent('QBCore:Notify', _source, message, "success")
            
        elseif Config.Framework == "tpzcore" then
            TriggerClientEvent('tpz_core:sendRightTipNotification', _source, message, 3000)
        end

    -- Client Side
    else

        if Config.Framework == "vorp" then
            TriggerEvent("vorp:TipRight", message, 3000)

        elseif Config.Framework == "gum" then

            TriggerEvent("gum:TipRight", message, 3000)

        elseif Config.Framework == "redemrp" then
            TriggerEvent("redem_roleplay:NotifyRight", message, 3000)

        elseif Config.Framework == "rsg" or Config.Framework == 'rsgv2' then
            TriggerEvent('RSGCore:Notify', message, 'primary')

        elseif Config.Framework == "qbcore" then
            TriggerEvent('QBCore:Notify', message, "success")

        elseif Config.Framework == "tpzcore" then
            TriggerEvent('tpz_core:sendRightTipNotification', message, 3000)
        end
    end

end
