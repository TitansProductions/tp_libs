
CoreAPI          = nil
CoreInventoryAPI = nil

Citizen.CreateThread(function ()

	Wait(5000)
		
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
  
    elseif Config.Framework == "rsgv2" then
		CoreAPI = exports['rsg-core']:GetCoreObject()
			
	elseif Config.Framework == "qbcore" then
		CoreAPI = exports['qbr-core']:GetCoreObject()

    elseif Config.Framework == "redmrp" then
        CoreAPI = exports["redem_roleplay"]:RedEM()

        CoreInventoryAPI = {}

        TriggerEvent("redemrp_inventory:getData",function(call)
            CoreInventoryAPI = call
        end)

    elseif Config.Framework == "tpzcore" then

        TriggerEvent("getTPZCore", function(cb) 
            CoreAPI = cb 
        end)

		CoreInventoryAPI = exports.tpz_inventory:getInventoryAPI()

    end


    print("Sucessfully loaded [" .. Config.Framework .. "] Framework...")

end)

-------------------------------------------------
-- Functions
-------------------------------------------------

function GetPlayer(_source)

	if Config.Framework == "vorp" or Config.Framework == 'gum' then

        if CoreAPI.getUser(_source) == nil then
            return nil
        end

        return CoreAPI.getUser(_source).getUsedCharacter

	elseif Config.Framework == "rsg" then
        return CoreAPI.Functions.GetPlayer(_source)

	elseif Config.Framework == "rsgv2" then
        return CoreAPI.Functions.GetPlayer(_source)

	elseif Config.Framework == "qbcore" then
        return exports['qbr-core']:GetPlayer(_source)

    elseif Config.Framework == "redmrp" then
        return CoreAPI.GetPlayer(_source)

    elseif Config.Framework == "tpzcore" then
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

    elseif Config.Framework == "rsgv2" then
		return xPlayer.PlayerData.citizenid

	elseif Config.Framework == "qbcore" then
		return xPlayer.PlayerData.citizenid
	
    elseif Config.Framework == "redmrp" then
        return xPlayer.identifier

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getIdentifier()
    end

	return nil

end

function GetChar(_source)
	local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.charIdentifier

    elseif Config.Framework == "gum" then
		return xPlayer.charIdentifier

	elseif Config.Framework == "rsg" then
		return xPlayer.PlayerData.cid

    elseif Config.Framework == "rsgv2" then
		return xPlayer.PlayerData.cid

	elseif Config.Framework == "qbcore" then
		return xPlayer.PlayerData.cid
	
    elseif Config.Framework == "redmrp" then
        return xPlayer.charid

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getCharacterIdentifier()
    end

	return 1
end

function GetGroup(_source)

    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
        local finished = false
        local group    = "user"

        TriggerEvent("vorp:getCharacter", _source, function(user)
            group = user.group
            finished = true
        end)

        while not finished do
            Wait(50)
        end

		return group

    elseif Config.Framework == "gum" then
        return xPlayer.group

    elseif Config.Framework == "rsg" then

        if CoreAPI.Functions.HasPermission(_source, 'admin') then
            return 'admin'
        end

        return 'user'

    elseif Config.Framework == "rsgv2" then

        if CoreAPI.Functions.HasPermission(_source, 'admin') then
            return 'admin'
        end

        return 'user'

    elseif Config.Framework == "qbcore" then

        return xPlayer.group

    elseif Config.Framework == "redmrp" then

        local finished = false
        local group    = "user"

        TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
            if user ~= nil then
                
                group = user.getGroup()
                finished = true

            end

        end)

        while not finished do
            Wait(50)
        end

		return group

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getGroup()

    end

end

function GetFirstName(_source)
    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.firstname

	elseif Config.Framework == "gum" then
		return xPlayer.firstname

	elseif Config.Framework == "rsg" then
		return xPlayer.PlayerData.charinfo.firstname

    elseif Config.Framework == "rsgv2" then
		return xPlayer.PlayerData.charinfo.firstname

	elseif Config.Framework == "qbcore" then
		
		return xPlayer.PlayerData.charinfo.firstname

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getFirstName()
	end
end

function GetLastName(_source)
    local xPlayer = GetPlayer(_source)

	if Config.Framework == "vorp" then
		return xPlayer.lastname
		
	elseif Config.Framework == "gum" then
		return xPlayer.lastname

	elseif Config.Framework == "rsg" then

		return xPlayer.PlayerData.charinfo.lastname

    elseif Config.Framework == "rsgv2" then

		return xPlayer.PlayerData.charinfo.lastname

	elseif Config.Framework == "qbcore" then

		return xPlayer.PlayerData.charinfo.lastname

    elseif Config.Framework == "tpzcore" then

        return xPlayer.getLastName()
	end
end

function AddItemToInventory(_source, item, amount, label)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        CoreInventoryAPI.addItem(_source, item, amount)

	elseif Config.Framework == "rsg" then
 
        xPlayer.Functions.AddItem(item, amount)

        TriggerClientEvent('inventory:client:ItemBox', _source, label, "add")
        
    elseif Config.Framework == "rsgv2" then
 
        xPlayer.Functions.AddItem(item, amount)

        TriggerClientEvent('rsg-inventory:client:ItemBox', _source, CoreAPI.Shared.Items[item], "add", amount)
        
	elseif Config.Framework == "qbcore" then
        
		xPlayer.Functions.AddItem(item, amount)

        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add")

    elseif Config.Framework == "gum" then
        CoreInventoryAPI.addItem(_source, item, amount)

    elseif Config.Framework == "redmrp" then

        local ItemData = CoreInventoryAPI.getItem(_source, item)
        ItemData.AddItem(amount)

    elseif Config.Framework == "tpzcore" then
        CoreInventoryAPI.addItem(_source, item, amount)
    end
end

function RemoveItemFromInventory(_source, item, amount, label)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then
        CoreInventoryAPI.subItem(_source, item, amount)

	elseif Config.Framework == "rsg" then
 
		xPlayer.Functions.RemoveItem(item, amount)

		TriggerClientEvent('inventory:client:ItemBox', _source, label, "remove")

	elseif Config.Framework == "rsgv2" then
 
		xPlayer.Functions.RemoveItem(item, amount)

		TriggerClientEvent('rsg-inventory:client:ItemBox', _source, CoreAPI.Shared.Items[item], "remove", amount)

	elseif Config.Framework == "qbcore" then
        
		xPlayer.Functions.RemoveItem(item, amount)

    elseif Config.Framework == "gum" then
        CoreInventoryAPI.subItem(_source, item, amount)

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)
        
        ItemData.RemoveItem(amount)

    elseif Config.Framework == "tpzcore" then
        CoreInventoryAPI.removeItem(_source, item, amount)

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
        TriggerClientEvent('inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add", 1)

    elseif Config.Framework == "rsgv2" then

        local xPlayer = CoreAPI.Functions.GetPlayer(_source)

        xPlayer.Functions.AddItem(weapon, 1)
        TriggerClientEvent('rsg-inventory:client:ItemBox', _source, CoreAPI.Shared.Items[weapon], "add", 1)

    elseif Config.Framework == "redmrp" then
        CoreInventoryAPI.addItem(_source, weapon, 100, GetHashKey(weapon))

    elseif Config.Framework == "tpzcore" then
        CoreInventoryAPI.addWeapon(_source, weapon)
    end
end

function GetItemCount(_source, item)

    if Config.Framework == "vorp" then
        return CoreInventoryAPI.getItemCount(_source, item)

    elseif Config.Framework == "gum" then

        return CoreInventoryAPI.getItemCount(_source, item)
        
    elseif Config.Framework == "qbcore" then

        local xPlayer = GetPlayer(_source)

        return CoreInventoryAPI.getItemCount(tonumber(_source), id)

    elseif Config.Framework == "rsg" then

        local xPlayer = GetPlayer(_source)

        if xPlayer.Functions.GetItemByName(item) == nil then
            return 0
        else
            local amountitem = xPlayer.Functions.GetItemByName(item).amount
            return amountitem
        end

    elseif Config.Framework == "rsgv2" then

        local xPlayer = CoreAPI.Functions.GetPlayer(_source)

        if xPlayer.Functions.GetItemByName(item) == nil then
            return 0
        else
            local amountitem = xPlayer.Functions.GetItemByName(item).amount
            return amountitem
        end

    elseif Config.Framework == "redmrp" then

        local ItemData = CoreInventoryAPI.getItem(_source, item)
        return ItemData.ItemAmount

    elseif Config.Framework == "tpzcore" then

        local count = CoreInventoryAPI.getItemQuantity(_source, item)
        return count

    end
end

function GetItemWeight(targetItem)

    if Config.Framework == "vorp" then

        local item = exports.vorp_inventory:getInventoryItem(targetItem)

        return item.weight or 0

    elseif Config.Framework == "gum" then

        local item = exports.gum_inventory:getInventoryItem(targetItem)

        return item.weight or 0
        
    elseif Config.Framework == "qbcore" then

        return 0

    elseif Config.Framework == "rsg" then

        local weight = exports['rsg-inventory']:GetItemWeight(targetItem)

        return weight or 0

    elseif Config.Framework == "rsgv2" then

        local weight = exports['rsg-inventory']:GetItemWeight(targetItem)

        return weight or 0
        
    elseif Config.Framework == "redmrp" then

        return 0

    elseif Config.Framework == "tpzcore" then

        local count = exports.tpz_inventory:getInventoryAPI().getItemWeight(targetItem)
        return count or 0

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

    elseif Config.Framework == "rsgv2" then
		return xPlayer.Functions.GetMoney('cash')

	elseif Config.Framework == "qbcore" then
		return xPlayer.Functions.GetMoney('cash')
	
    elseif Config.Framework == "redmrp" then
        return xPlayer.getMoney()

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getAccount(0)
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
        
    elseif Config.Framework == "rsgv2" then
		return xPlayer.Functions.GetMoney('gold')

	elseif Config.Framework == "qbcore" then
		return xPlayer.Functions.GetMoney('gold')

    elseif Config.Framework == "tpzcore" then
        return xPlayer.getAccount(2)
	end

	return 0
end

function GetCents(_source)
    
    local xPlayer = GetPlayer(_source)

	if Config.Framework == "tpzcore" then
        return xPlayer.getAccount(1)
	end

	return 0
end

    
function CanCarryItem(_source, item, amount)

    if Config.Framework == "vorp" then
		
        return CoreInventoryAPI.canCarryItem(_source, item, amount)

    elseif Config.Framework == "gum" then

	local canCarry = false
	local finished = false
		
	TriggerEvent("gumCore:canCarryItem", _source, item, amount, function(cb)
	    canCarry = cb
	    finished = true
	end)

	while not finished do
	  Wait(50)
        end
		
        return canCarry

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)

        if not ItemData.AddItem(amount) then return false else return true end

    elseif Config.Framework == "qbcore" or Config.Framework == "rsg" or Config.Framework == "rsgv2" then
        return true

    elseif Config.Framework == "tpzcore" then

        return CoreInventoryAPI.canCarryItem(_source, item, amount)
    end

end

function CanCarryWeapons(_source, item, amount)

    if Config.Framework == "vorp" then

        local canCarry, finished = false, false

        CoreInventoryAPI.canCarryWeapons(_source, amount, function(invWeaponAvailable)

            canCarry = invWeaponAvailable
            finished = true

        end, item)

        while not finished do
            Wait(50)
        end

        return canCarry

    elseif Config.Framework == "redmrp" then
        local ItemData = CoreInventoryAPI.getItem(_source, item)

        if not ItemData.AddItem(amount) then return false else return true end

    elseif Config.Framework == "tpzcore" then
        
        return CoreInventoryAPI.canCarryWeapon(_source, item)

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

    elseif Config.Framework == "rsgv2" then
        xPlayer.Functions.AddMoney('cash', amount)

    elseif Config.Framework == "redmrp" then
        xPlayer.AddMoney(amount)

    elseif Config.Framework == "tpzcore" then
        xPlayer.addAccount(0, amount)
    end
end

function AddCents(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "tpzcore" then
        xPlayer.addAccount(1, amount)
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

    elseif Config.Framework == "rsgv2" then
        xPlayer.Functions.AddMoney('gold', amount)

    elseif Config.Framework == "tpzcore" then
        xPlayer.addAccount(2, amount)
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

    elseif Config.Framework == "rsgv2" then
        xPlayer.Functions.RemoveMoney('cash', amount)

    elseif Config.Framework == "redmrp" then

        xPlayer.RemoveMoney(amount)

    elseif Config.Framework == "tpzcore" then
        xPlayer.removeAccount(0, amount)

    end

end

function RemoveCents(_source, amount)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "tpzcore" then
        xPlayer.removeAccount(1, amount)
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

    elseif Config.Framework == "rsgv2" then
        xPlayer.Functions.RemoveMoney('gold', amount)   --updatev2

    elseif Config.Framework == "tpzcore" then
        xPlayer.removeAccount(2, amount)
    end

end

function GetUserInventory(_source)
    if Config.Framework == "vorp" then

        local items = CoreInventoryAPI.getUserInventory(_source)
        local weapons = CoreInventoryAPI.getUserWeapons(_source)

        for k, v in pairs (weapons) do

            v.metadata = { quality = 1 }
            v.quantity = 1
            v.type = "weapon"

            table.insert(items, v)
        end

        return items
		
    elseif Config.Framework == "gum" then

        return CoreInventoryAPI.getUserInventory(_source)

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        local xPlayer = GetPlayer(_source)
        
        return xPlayer.PlayerData.items
        
    elseif Config.Framework == "rsgv2" then

        local xPlayer = GetPlayer(_source)
        
        return xPlayer.PlayerData.items

    elseif Config.Framework == "redmrp" then

        return CoreInventoryAPI.getPlayerInventory(_source)

    elseif Config.Framework == "tpzcore" then

        return CoreInventoryAPI.getInventoryContents(_source)

    end
end

function GetInventoryTotalWeight(_source)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        return xPlayer.invCapacity

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        return CoreAPI.Player.GetTotalWeight(xPlayer.PlayerData.items)

    elseif Config.Framework == "rsgv2" then
        local totalWeight = exports['rsg-inventory']:GetTotalWeight(xPlayer.PlayerData.items)
        return totalWeight

    elseif Config.Framework == "tpzcore" then
        return CoreInventoryAPI.getInventoryTotalWeight(_source)
    end

    return 0

end

function GetJob(_source)

    local xPlayer = GetPlayer(_source)

    if Config.Framework == "vorp" then

        return xPlayer.job

    elseif Config.Framework == "gum" then

        return xPlayer.job

    elseif Config.Framework == "rsg" or Config.Framework == "qbcore" then

        return tostring(xPlayer.PlayerData.job.name)

    elseif Config.Framework == "rsgv2" then

        return tostring(xPlayer.PlayerData.job.name)

    elseif Config.Framework == "redmrp" then

        return xPlayer.job

    elseif Config.Framework == "tpzcore" then

        return xPlayer.getJob()

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

    elseif Config.Framework == "rsgv2" then

        return xPlayer.PlayerData.job.grade.level

    elseif Config.Framework == "redmrp" then

        return xPlayer.jobgrade

    elseif Config.Framework == "tpzcore" then

        return 0 -- to-do

    end
end

function GetDiscordRoles(_source)
    
    local userRoles  = GetDiscordRoles(_source, Config.DiscordServerID)

    if not userRoles or userRoles == nil then
        userRoles = {}
    end

    return userRoles

end
