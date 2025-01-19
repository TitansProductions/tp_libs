Config = {}

-- @Supported Versions: vorp, gum, rsg, rsgv2, qbcore, redemrp, tpzcore
Config.Framework = "vorp"

Config.Debug = true
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

        elseif Config.Framework == "redmrp" then
            TriggerClientEvent("redemrp_notification:start", _source, message, 3, "success")

        elseif Config.Framework == "rsg" then
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

        elseif Config.Framework == "redmrp" then
            TriggerEvent("redemrp_notification:start", message, 3, "success")

        elseif Config.Framework == "rsg" then
            TriggerEvent('RSGCore:Notify', message, 'primary')

        elseif Config.Framework == "qbcore" then
            TriggerEvent('QBCore:Notify', message, "success")

        elseif Config.Framework == "tpzcore" then
            TriggerEvent('tpz_core:sendRightTipNotification', message, 3000)
        end
    end

end
