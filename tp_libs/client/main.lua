---------------------------------------------------------------
--[[ TP Libs Events ]]--
---------------------------------------------------------------

RegisterNetEvent("tp_libs:isPlayerReady")
AddEventHandler("tp_libs:isPlayerReady", function()

    TriggerServerEvent("tp_libs:registerChatSuggestions")

    Citizen.CreateThread(function() while true do TriggerServerEvent("tp_libs:server:heartbeat") Wait(500) end end)  
end)

RegisterNetEvent("tp_libs:getPlayerJob")
AddEventHandler("tp_libs:getPlayerJob", function(job)
    if Config.Debug then
        print("Job Updated / Changed To: " .. job)
    end

    -- todo nothing
end)

---------------------------------------------------------------
--[[ Framework Events - Character Select ]]--
---------------------------------------------------------------

-- TPZ CORE
AddEventHandler("tpz_core:isPlayerReady", function()
    TriggerEvent("tp_libs:isPlayerReady")
end)

-- VORP
RegisterNetEvent("vorp:SelectedCharacter", function()
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
--[[ Framework Events - Job Update ]]--
---------------------------------------------------------------

-- QBCORE
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    TriggerEvent("tp_libs:getPlayerJob", job)
end)

-- RSG
RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(job)
    TriggerEvent("tp_libs:getPlayerJob", job)
end)

 -- REDEM:RP
RegisterNetEvent('redem_roleplay:JobChange', function(job)
    TriggerEvent("tp_libs:getPlayerJob", job)
end)

-- TPZ Core
RegisterNetEvent("tpz_core:getPlayerJob")
AddEventHandler("tpz_core:getPlayerJob", function(data)

    TriggerEvent("tp_libs:getPlayerJob", data.job)
end)

-- Vorp related only for updaring job every minute
-- it seems that the jobUpdate event does not trigger on vorp most of the times. 
if Config.Framework == "old_vorp" or Config.Framework == "latest_vorp" then

    Citizen.CreateThread(function()

        while true do
            Wait(60000)

            TriggerEvent("tp_libs:ExecuteServerCallBack", "tp_libs:getPlayerJob", function(job)
                TriggerEvent("tp_libs:getPlayerJob", job)
            end)

        end

    end)
end

