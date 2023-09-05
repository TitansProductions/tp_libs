
CoreAPI          = nil
CoreInventoryAPI = nil

Citizen.CreateThread(function ()

	if Config.Framework == "vorp" then

        TriggerEvent("getCore", function(cb) 
            CoreAPI = cb 
        end)

		CoreInventoryAPI = exports.vorp_inventory:vorp_inventoryApi()
	
	elseif Config.Framework == "gum" then

        TriggerEvent("getCore",function(cb)
            CoreAPI = cb 
        end)

		CoreInventoryAPI = exports.gum_inventory:gum_inventoryApi()
		
	elseif Config.Framework == "rsg" then
		CoreAPI = exports['rsg-core']:GetCoreObject()

	elseif Config.Framework == "qbcore" then

    elseif Config.Framework == "redmrp" then
        CoreAPI = exports["redem_roleplay"]:RedEM()

        CoreInventoryAPI = {}

        TriggerEvent("redemrp_inventory:getData",function(call)
            CoreInventoryAPI = call
        end)

    end

    print("Sucessfully loaded [" .. Config.Framework .. "] Framework...")

end)

-------------------------------------------------
-- Functions
-------------------------------------------------

function GetPlayer(_source)

	if Config.Framework == "vorp" then
        return CoreAPI.getUser(_source).getUsedCharacter

	elseif Config.Framework == "rsg" then
        return CoreAPI.Functions.GetPlayer(_source)

	elseif Config.Framework == "qbcore" then
        return exports['qbr-core']:GetPlayer(_source)

    elseif Config.Framework == "gum" then
        return CoreAPI.getUser(_source).getUsedCharacter

    elseif Config.Framework == "redmrp" then
        return CoreAPI.GetPlayer(_source)
    end

	return nil

end

function GetIdentifier(_source)

    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.identifier

    elseif Config.Framework == "gum" then
		return xPlayer.identifier

	elseif Config.Framework == "rsg" then
		return xPlayer.PlayerData.citizenid

	elseif Config.Framework == "qbcore" then
		return xPlayer.PlayerData.citizenid
	
    elseif Config.Framework == "redmrp" then
        return xPlayer.identifier
    end

	return nil

end

function AddItemToInventory(_source, item, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        CoreInventoryAPI.addItem(_source, item, amount)

	elseif Config.Framework == "rsg" then
 
        xPlayer.Functions.AddItem(item, amount)

        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add")
        
	elseif Config.Framework == "qbcore" then
        
		xPlayer.Functions.AddItem(item, amount)

        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add")

    elseif Config.Framework == "gum" then
        CoreInventoryAPI.addItem(_source, item, amount)

    elseif Config.Framework == "redmrp" then

        local ItemData = CoreInventoryAPI.getItem(_source, item)
        ItemData.AddItem(amount)
    end
end

function RemoveItemFromInventory(_source, item, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        CoreInventoryAPI.subItem(_source, item, amount)

	elseif Config.Framework == "rsg" then
 
		xPlayer.Functions.RemoveItem(item, amount)

	elseif Config.Framework == "qbcore" then
        
		xPlayer.Functions.RemoveItem(item, amount)

    elseif Config.Framework == "gum" then
        CoreInventoryAPI.subItem(_source, item, amount)

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)
        
        ItemData.RemoveItem(amount)

    end
end

function AddWeaponToInventory(_source, weapon)
    if Config.Framework == "vorp" then

        local emptyComponent = {["nothing"] = 0}

        CoreInventoryAPI.createWeapon(_source, weapon, emptyComponent, emptyComponent)

    elseif Config.Framework == "gum" then

        local emptyComponent = {["nothing"] = 0}

        CoreInventoryAPI.createWeapon(_source, weapon, emptyComponent, emptyComponent)

    elseif Config.Framework == "qbcore" then

        local xPlayer = GetPlayer(_source)
        xPlayer.Functions.AddItem(weapon, 1)

        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add")

    elseif Config.Framework == "rsg" then

        local xPlayer = GetPlayer(_source)

        xPlayer.Functions.AddItem(weapon, 1)
        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add")

    elseif Config.Framework == "redmrp" then
        CoreInventoryAPI.addItem(_source, weapon, 100, GetHashKey(weapon))
    end
end

function GetItemCount(_source, item)

    if Config.Framework == "vorp" then
        return CoreInventoryAPI.getItemCount(_source, item)

    elseif Config.Framework == "gum" then

        return CoreInventoryAPI.getItemCount(_source, item)
        
    elseif Config.Framework == "qbcore" then

        local xPlayer = GetPlayer(_source)

        return xPlayer.PlayerData.items[item].amount

    elseif Config.Framework == "rsg" then

        local xPlayer = GetPlayer(_source)

        return xPlayer.PlayerData.items[item].amount

    elseif Config.Framework == "redmrp" then

        local ItemData = CoreInventoryAPI.getItem(_source, item)
        return ItemData.ItemAmount
    end
end

function GetMoney(_source)
    
    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.money

    elseif Config.Framework == "gum" then
		return xPlayer.money

	elseif Config.Framework == "rsg" then
		return xPlayer.Functions.GetMoney('cash')

	elseif Config.Framework == "qbcore" then
		return xPlayer.Functions.GetMoney('cash')
	
    elseif Config.Framework == "redmrp" then
        return xPlayer.getMoney()
    end

	return 0

end

function GetGold(_source)
    
    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.gold

    elseif Config.Framework == "gum" then
		return xPlayer.gold

	elseif Config.Framework == "rsg" then
		return xPlayer.Functions.GetMoney('gold')

	elseif Config.Framework == "qbcore" then
		return xPlayer.Functions.GetMoney('gold')
	end

	return 0
end


    
function CanCarryItem(_source, item, amount)

    if Config.Framework == "vorp" then
        return CoreInventoryAPI.canCarryItem(_source, item, amount) and CoreInventoryAPI.canCarryItems(_source, amount)

    elseif Config.Framework == "gum" then
        return CoreInventoryAPI.canCarryItems(_source, amount)

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)

        if not ItemData.AddItem(amount) then return false else return true end

    elseif Config.Framework == "qbcore" or Config.Framework == "rsg" then
        return true
    end

end

function CanCarryWeapons(_source, item, amount)

    if Config.Framework == "vorp" then

        CoreInventoryAPI.canCarryWeapons(_source, amount, function(invWeaponAvailable)
            return invWeaponAvailable
        end, item)

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)

        if not ItemData.AddItem(amount) then return false else return true end

    else
        return true
    end

end

function AddMoney(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        xPlayer.addCurrency(0, amount)

    elseif Config.Framework == "gum" then
        xPlayer.addCurrency(0, amount)

    elseif Config.Framework == "qbcore" then 
        xPlayer.Functions.AddMoney('cash', amount)
        
    elseif Config.Framework == "rsg" then
        xPlayer.Functions.AddMoney('cash', amount)

    elseif Config.Framework == "redmrp" then
        xPlayer.AddMoney(amount)
    end
end

function AddGold(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        xPlayer.addCurrency(1, amount)

    elseif Config.Framework == "gum" then
        xPlayer.addCurrency(1, amount)

    elseif Config.Framework == "qbcore" then 
        xPlayer.Functions.AddMoney('gold', amount)
        
    elseif Config.Framework == "rsg" then
        xPlayer.Functions.AddMoney('gold', amount)
    end

end

function RemoveMoney(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        xPlayer.removeCurrency(0, amount)

    elseif Config.Framework == "gum" then
        xPlayer.removeCurrency(0, amount)

    elseif Config.Framework == "qbcore" then 
        xPlayer.Functions.RemoveMoney('cash', amount)
        
    elseif Config.Framework == "rsg" then
        xPlayer.Functions.RemoveMoney('cash', amount)

    elseif Config.Framework == "redmrp" then

        xPlayer.RemoveMoney(amount)
    end

end

function RemoveGold(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        xPlayer.removeCurrency(1, amount)

    elseif Config.Framework == "gum" then
        xPlayer.removeCurrency(1, amount)

    elseif Config.Framework == "qbcore" then 
        xPlayer.Functions.RemoveMoney('gold', amount)
        
    elseif Config.Framework == "rsg" then
        xPlayer.Functions.RemoveMoney('gold', amount)
    end

end

function GetUserInventory(_source)
    if Config.Framework == "vorp" then

        return CoreInventoryAPI.getUserInventory(_source)

    elseif Config.Framework == "gum" then

        return CoreInventoryAPI.getUserInventory(_source)

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        return nil

    elseif Config.Framework == "redmrp" then

        return CoreInventoryAPI.getPlayerInventory(_source)

    end
end

function GetJob(_source)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        return xPlayer.job

    elseif Config.Framework == "gum" then

        return xPlayer.job

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        return tostring(xPlayer.PlayerData.job.name)

    elseif Config.Framework == "redmrp" then

        return xPlayer.job

    end
end

function GetJobGrade(_source)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        return xPlayer.jobGrade

    elseif Config.Framework == "gum" then

        return xPlayer.jobGrade

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        return 0

    elseif Config.Framework == "redmrp" then

        return xPlayer.jobgrade

    end
end
