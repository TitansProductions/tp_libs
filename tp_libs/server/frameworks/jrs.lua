local Functions = {} -- DO NOT TOUCH

if Config.Framework == 'jrs_core' then -- <- THE FRAMEWORK THAT WILL BE CALLED FROM CONFIG.FRAMEWORK OPTION.

    local CORE      = 'jrs_core'
    local INVENTORY = 'jrs_inventory'

    -- jrs_core rebuilds its API table on every getCoreApi() call, so never cache it
    -- (a cached copy would hold dead references after a jrs_core restart).
    local function GetApi()
        local ok, api = pcall(function() return exports[CORE]:getCoreApi() end)
        if ok and type(api) == 'table' then return api end
        return nil
    end

    -- Members of a table that crossed a resource boundary are funcrefs, not plain
    -- functions, so type(fn) == 'function' is NOT reliable. Check ~= nil and pcall.
    local function CallApi(names, ...)
        local api = GetApi()
        if not api then return false, nil end
        for _, name in ipairs(names) do
            if api[name] ~= nil then
                local ok, value = pcall(api[name], ...)
                if ok then return true, value end
            end
        end
        return false, nil
    end

    local function GetValue(value, default)
        if default == nil then
            return value
        end
        if default == false then
            return value or false
        end
        return value == nil and default or value
    end

    local function Inv(method, ...)
        local args = { ... }
        local ok, value = pcall(function() return exports[INVENTORY][method](exports[INVENTORY], table.unpack(args)) end)
        if ok then return value end
        return nil
    end

    -- Waits for jrs_core to be up (instead of erroring like the old VORP loop).
    local attempts = 0
    while GetResourceState(CORE) ~= 'started' and attempts < 30 do
        attempts = attempts + 1
        Wait(1000)
    end

    if GetResourceState(CORE) ~= 'started' then
        error("[JRS-CORE] jrs_core is not started - start it before this resource or wrong framework selected on the Configuration.")
    end

    Citizen.CreateThread(function ()

        -- Returns the active character table of the player (nil if not online / no character selected).
        Functions.GetPlayer = function(source)

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return nil
            end

            local ok, character = pcall(function() return exports[CORE]:GetCharacter(tonumber(source)) end)

            if ok and type(character) == 'table' then
                return character
            end

            print(string.format('The player object with the online source id: (%s) is invalid or in session.', source))
            return nil
        end

        Functions.IsPlayerCharacterSelected = function(source) -- Returns a boolean if player is in session or not.

            if GetPlayerName(source) == nil then
                print(string.format('The player with the online source id: (%s) is not online.', source))
                return false
            end

            local ok, character = pcall(function() return exports[CORE]:GetCharacter(tonumber(source)) end)
            return ok and type(character) == 'table'
        end

        Functions.GetIdentifier = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.identifier
        end

        Functions.GetCharacterId = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.charIdentifier
        end

        Functions.GetGroup = function(source)
            local ok, group = pcall(function() return exports[CORE]:GetGroup(tonumber(source)) end)
            if ok and group ~= nil then return group end

            local xPlayer = Functions.GetPlayer(source)
            if xPlayer == nil then return false end

            return xPlayer.group
        end

        Functions.GetJob = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.job
        end

        Functions.SetJob = function(source, job)
            local xPlayer = Functions.GetPlayer(source)
            if xPlayer == nil then return end
            CallApi({ 'setJob' }, tonumber(source), job, xPlayer.jobgrade or 0)
        end

        Functions.SetJobGrade = function(source, grade)
            local xPlayer = Functions.GetPlayer(source)
            if xPlayer == nil then return end
            CallApi({ 'setJob' }, tonumber(source), xPlayer.job, grade)
        end

        Functions.GetJobGrade = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.jobgrade
        end

        Functions.GetFirstName = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.firstname
        end

        Functions.GetLastName = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.lastname
        end

        -- ACCOUNTS (currency types: 0 = money, 1 = gold)

        Functions.GetMoney = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.money
        end

        Functions.GetGold = function(source)
            local xPlayer = Functions.GetPlayer(source)

            if xPlayer == nil then return false end

            return xPlayer.gold
        end

        Functions.AddMoney = function(source, amount)
            CallApi({ 'addMoney' }, tonumber(source), 0, amount)
        end

        Functions.AddGold = function(source, amount)
            CallApi({ 'addMoney' }, tonumber(source), 1, amount)
        end

        Functions.RemoveMoney = function(source, amount)
            CallApi({ 'removeMoney' }, tonumber(source), 0, amount)
        end

        Functions.RemoveGold = function(source, amount)
            CallApi({ 'removeMoney' }, tonumber(source), 1, amount)
        end

        -- INVENTORY

        Functions.GetUserInventory = function(source)
            return Inv('getUserInventory', source) or {}
        end

        Functions.GetInventoryTotalWeight = function(source)
            return Inv('getInventoryTotalWeight', source) or 0
        end

        Functions.GetInventoryMaxWeight = function(source)
            return Inv('GetMaxWeight', source) or 0
        end

        Functions.AddItemToInventory = function(source, item, amount)
            Inv('addItem', source, item, amount)
        end

        Functions.RemoveItemFromInventory = function(source, item, amount)
            Inv('subItem', source, item, amount)
        end

        Functions.GetItemCount = function(source, item)
            return tonumber(Inv('getItemCount', source, item)) or 0
        end

        Functions.GetItemWeight = function(item)
            local items = Inv('preload_itemtable') or {}

            for _, v in pairs(items) do
                if v.item == item or v.name == item then
                    return tonumber(v.weight) or 0
                end
            end

            return 0
        end

        Functions.CanCarryItem = function(source, item, amount)
            return Inv('canCarryItem', source, item, amount) == true
        end

        Functions.AddWeaponToInventory = function(source, weapon)
            local emptyComponent = {["nothing"] = 0}
            Inv('createWeapon', source, weapon, emptyComponent, emptyComponent)
        end

        Functions.CanCarryWeapons = function(source, weapon)
            -- jrs_inventory exposes no weapon-slot check export, so we compare against its max weapons.
            local maxWeapons = tonumber(Inv('GetMaxWeapons', source))
            local current    = Inv('getWeaponsMe', source)

            if not maxWeapons then return true end

            return type(current) ~= 'table' or #current < maxWeapons
        end

        Functions.GetItems = function()
            local items = Inv('preload_itemtable') or {}
            local result = {}

            for _, v in pairs(items) do
                result[#result + 1] = v
            end

            return result
        end

        -- CONTAINERS (jrs_inventory "storage"; identified by id/name)

        Functions.RegisterContainerInventory = function(name, maxWeight, invConfig)
            if invConfig == nil then
                invConfig = {}
            end

            exports[INVENTORY]:createstorage(0, name, maxWeight)
        end

        Functions.UnRegisterContainer = function(containerId)
            -- jrs_inventory has no remove-storage export, so nothing to do.
        end

        Functions.GetContainerIdByName = function(containerName)
            return containerName -- storage id IS its name on jrs_inventory
        end

        Functions.UpgradeContainerWeight = function(containerId, limit)
            exports[INVENTORY]:updatestorage(0, containerId, limit)
        end

        Functions.DoesContainerExistById = function(containerId)
            return containerId ~= nil -- no exist check export on jrs_inventory, created on demand
        end

        Functions.DoesContainerExistByName = function(containerName)
            return containerName ~= nil
        end

        Functions.OpenContainerInventory = function(source, containerId, title)
            exports[INVENTORY]:openstorage(source, containerId, title)
        end

        AddFunctionsList(Functions) -- DO NOT MODIFY!

        Wait(5000)
        print("^2Sucessfully loaded - [^1JRS-CORE^2] Framework.")

    end)

end
