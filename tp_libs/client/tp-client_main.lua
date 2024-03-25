
-- Triggered when character has been selected from
-- any framework. 

RegisterNetEvent("tp_libs:isPlayerReady")
AddEventHandler("tp_libs:isPlayerReady", function()

end)

-- TPZ CORE
AddEventHandler("tpz_core:isPlayerReady", function()
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- VORP
RegisterNetEvent("vorp:SelectedCharacter", function(charId)
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- GUM
RegisterNetEvent("gum:SelectedCharacter", function(charId)
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- RSG CORE
AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- QBCORE
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- Redemrp

AddEventHandler("redemrp_charselect:SpawnCharacter", function()
    Wait(5000)
    TriggerEvent("tp_libs:isPlayerReady")
end)


---------------------------------------------------------------
--[[ Job Update ]]--
---------------------------------------------------------------

RegisterNetEvent("tp_libs:getPlayerJob")
AddEventHandler("tp_libs:getPlayerJob", function(job)
    -- todo nothing
end)

-- QBCORE
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    TriggerEvent("tp_libs:getPlayerJob", job)
end)

-- RSG
RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(job)
    TriggerEvent("tp_libs:getPlayerJob", job)
end)

-- TPZ Core
RegisterNetEvent("tpz_core:getPlayerJob")
AddEventHandler("tpz_core:getPlayerJob", function(data)

    TriggerEvent("tp_libs:getPlayerJob", data.job)
end)

