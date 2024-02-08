
-- Triggered when character has been selected from
-- any framework. 

RegisterNetEvent("tp_libs:isPlayerReady")
AddEventHandler("tp_libs:isPlayerReady", function()

end)

-- Gets the player job when character is selected.

AddEventHandler("tpz_core:isPlayerReady", function()
    TriggerEvent("tp_libs:isPlayerReady")
end)
