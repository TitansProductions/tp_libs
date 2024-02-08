
-- Triggered when character has been selected from
-- any framework. 

RegisterNetEvent("tp_libs:isPlayerReady")
AddEventHandler("tp_libs:isPlayerReady", function()

end)

-- Gets the player job when character is selected.

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

