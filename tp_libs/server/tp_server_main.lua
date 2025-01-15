
--[[ ------------------------------------------------
   Events
]]---------------------------------------------------

RegisterServerEvent('tp_libs:sendNotification')
AddEventHandler('tp_libs:sendNotification', function(tsource, message, type)
    local _source = tonumber(tsource)

    if tsource == nil then
        _source = source
    end

    SendNotification(_source, message, type)
end)

RegisterServerEvent("tp_libs:sendToDiscord")
AddEventHandler("tp_libs:sendToDiscord", function(webhook, name, description, color)
    local data = Config.DiscordWebhooking

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or 15105570,
                ["author"] = {
                    ["name"] = data.Label,
                    ["icon_url"] = data.ImageUrl,
                },
                ["title"] = name,
                ["description"] = description,
                ["footer"] = {
                    ["text"] = data.Footer .. " • " .. os.date("%x %X %p"),
                    ["icon_url"] = data.ImageUrl,

                },
            },

        },
        avatar_url = data.ImageUrl
    }), {
        ['Content-Type'] = 'application/json'
    })
end)

RegisterServerEvent("tp_libs:sendImageUrlToDiscord")
AddEventHandler("tp_libs:sendImageUrlToDiscord", function(webhook, url, color)
    local data = Config.DiscordWebhooking

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or 15105570,
                ["author"] = {
                    ["name"] = data.Label,
                    ["icon_url"] = data.ImageUrl,
                },

                ["footer"] = {
                    ["text"] = data.Footer .. " • " .. os.date("%x %X %p"),
                    ["icon_url"] = data.ImageUrl,

                },

                ['image'] = { ['url'] = url },

            },

        },
        avatar_url = data.ImageUrl
    }), {
        ['Content-Type'] = 'application/json'
    })
end)

--[[ ------------------------------------------------
   Framework Events
]]---------------------------------------------------

AddEventHandler("vorp:playerJobChange", function(source, job)
    local _source = source
    TriggerClientEvent("tp_libs:getPlayerJob", _source, job)
end)

-----------------------------------------------------------
--[[ Player Data Callback  ]]--
-----------------------------------------------------------

addNewCallBack("tp_libs:getPlayerData", function(source, cb)
    local _source = source

    return cb(
        { 
            source          = tonumber(_source),
            identifier      = API.getIdentifier(_source),
            charIdentifier  = API.getChar(_source),

            firstname       = API.getFirstName(_source),
            lastname        = API.getLastName(_source),

            job             = API.getJob(_source),
            jobGrade        = API.getJobGrade(_source),

            group          = API.getGroup(_source),
        } 
    ) 
end)
