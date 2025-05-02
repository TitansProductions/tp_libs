
local CurrentTime = 0

--[[ ------------------------------------------------
   Functions
]]---------------------------------------------------

SendToDiscordWebhook = function(webhook, name, description, color)

    if not webhook or webhook == "" then
        print("Error: Invalid webhook URL.")
        return
    end

    local data = Config.DiscordWebhooking
    local defaultColor = 15105570  -- Define default color as a constant

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or defaultColor,
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
end

SendImageUrlToDiscordWebhook = function(webhook, name, description, url, color)

    if not webhook or webhook == "" then
        print("Error: Invalid webhook URL.")
        return
    end

    local data = Config.DiscordWebhooking
    local defaultColor = 15105570  -- Define default color as a constant

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = color or defaultColor,
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

                ['image'] = { ['url'] = url },

            },

        },
        avatar_url = data.ImageUrl
    }), {
        ['Content-Type'] = 'application/json'
    })
end

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

RegisterServerEvent('tp_libs:server:update')
AddEventHandler('tp_libs:server:update', function()
    -- todo nothing
end)

--[[ ------------------------------------------------
   Framework Events
]]---------------------------------------------------

AddEventHandler("vorp:playerJobChange", function(source, newjob, oldjob)
    local _source = source
    TriggerClientEvent("tp_libs:getPlayerJob", _source, newjob)
end)

-----------------------------------------------------------
--[[ Player Data Callback  ]]--
-----------------------------------------------------------

addNewCallBack("tp_libs:getPlayerData", function(source, cb, data)
    local _source = source

    if data and data.source ~= nil then
        _source = tonumber(data.source)
    end

    if not IsPlayerCharacterSelected(_source) then 
        return nil
    end

    return cb(
        { 
            source          = tonumber(_source),
            identifier      = GetIdentifier(_source),
            charIdentifier  = GetChar(_source),

            firstname       = GetFirstName(_source),
            lastname        = GetLastName(_source),

            job             = GetJob(_source),
            jobGrade        = GetJobGrade(_source),

            group           = GetGroup(_source),
        } 
    ) 
end)

--[[ ------------------------------------------------
   Events
]]---------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(60000)

    local time        = os.date("*t") 
    local currentTime = table.concat({time.hour, time.min}, ":")

    local finished    = false
    local shouldSave  = false

    for index, restartHour in pairs (Config.RestartHours) do

      if currentTime == restartHour then
        shouldSave = true
      end

      if next(Config.RestartHours, index) == nil then
        finished = true
      end

    end

    while not finished do
      Wait(1000)
    end

    CurrentTime = CurrentTime + 1

    if Config.SaveDataRepeatingTimer.Enabled and CurrentTime == Config.SaveDataRepeatingTimer.Duration then
      CurrentTime = 0
      shouldSave  = true
    end

    if shouldSave then
      TriggerEvent("tp_libs:server:onDataUpdate")
    end

  end

end)
