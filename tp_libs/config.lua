Config = {}

-- @Supported Versions: vorp, gum, rsg, qbcore, redmrp, tpzcore
Config.Framework = "vorp"

-- All colors can be found here: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
Config.DiscordWebhooking = {
    Label = "Server Name",
    ImageUrl = "https://i.imgur.com/xxxxxxxxx.png",
    Footer = "© Server Name Team",
}

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
        end
    end

end
