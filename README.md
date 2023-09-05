# tp_libs

TP Libs is a free resource (script) which will be used in lot of our scripts for supporting multiple frameworks and also contain a lot of API Functions such as Notifications, Discord Webhooking and Locales System.

This script can also be used by other developers if they are willing.

**How to use the API exports**

```lua
exports.tp_libs:rClientAPI() -- Client Side
exports.tp_libs:rServerAPI() -- Server Side
```

**How to get API functions**

```lua
local API    = {}

TriggerEvent("getTPAPI", function(cb) API = cb end)
```

```lua

-- Get Configuration (TP Libs)

local config = API.getConfiguration()

local config = exports.tp_libs:rServerAPI().getConfiguration()

-- Get Round Math Function

API.round(number, decimals)

exports.tp_libs:rServerAPI().round(number, decimals)

-- Send Notifications

API.sendNotification(source, message, type) -- success, error (This is also supported on client side)

exports.tp_libs:rClientAPI().sendNotification(source, message, type) -- success, error.
exports.tp_libs:rServerAPI().sendNotification(source, message, type) -- success, error.

-- Send Webhook

API.sendToDiscord(webhook, name, description, color) -- (This is also supported on client side)

exports.tp_libs:rClientAPI().sendToDiscord(webhook, name, description, color)
exports.tp_libs:rServerAPI().sendToDiscord(webhook, name, description, color)

-- Get Player / User.

local xPlayer = API.getPlayer(source)

local xPlayer = exports.tp_libs:rServerAPI().getPlayer(source)

-- getIdentifier

local identifier = API.getIdentifier(source)

local identifier = exports.tp_libs:rServerAPI().getIdentifier(source)

-- Add Items

API.addItemToInventory(source, item, quantity)

exports.tp_libs:rServerAPI().addItemToInventory(source, item, quantity)

-- Add Weapons

API.addWeaponToInventory(source, weapon_name, quantity)

exports.tp_libs:rServerAPI().addWeaponToInventory(source, weapon_name, quantity)

-- Get Item Count

local itemCount = API.getItemCount(source, item)

local itemCount = exports.tp_libs:rServerAPI().getItemCount(source, item)

-- Money Functions

local money = API.getMoney(source)
API.addMoney(source, quantity)
API.removeMoney(source, quantity)

local money = exports.tp_libs:rServerAPI().getMoney(source)
exports.tp_libs:rServerAPI().addMoney(source, quantity)
exports.tp_libs:rServerAPI().removeMoney(source, quantity)

-- Gold Functions

local gold = API.getGold(source)
API.addGold(source, quantity)
API.removeGold(source, quantity)

local gold = exports.tp_libs:rServerAPI().getGold(source)
exports.tp_libs:rServerAPI().addGold(source, quantity)
exports.tp_libs:rServerAPI().removeGold(source, quantity)

-- Can Carry item-s

local canCarry = API.canCarryItem(source, item, quantity)

local canCarry = exports.tp_libs:rServerAPI().canCarryItem(source, item, quantity)

-- Can Carry weapon-s

local canCarryWeapons = API.canCarryWeapons(source, weapon_name, quantity)

local canCarryWeapons = exports.tp_libs:rServerAPI().canCarryWeapons(source, weapon_name, quantity)

-- Get user inventory contents

local inventoryContents = API.getUserInventoryContents(source)

local inventoryContents = exports.tp_libs:rServerAPI().getUserInventoryContents(source)

-- Get job

local job = API.getJob(source)

local job = exports.tp_libs:rServerAPI().getJob(source)

-- Get job grade

local jobGrade = API.getJobGrade(source)

local jobGrade = exports.tp_libs:rServerAPI().getJobGrade(source)

**Server Side Events**

```lua
-- Send notifications

TriggerServerEvent('tp_libs:sendNotification', source, message, type) -- Client Side to be used
TriggerEvent('tp_libs:sendNotification', source, message, type) -- Server Side to be used.
```

```lua

-- Send discord webhooks

TriggerServerEvent('tp_libs:sendToDiscord', webhook, name, description, color) -- Client Side to be used
TriggerEvent('tp_libs:sendToDiscord', webhook, name, description, color) -- Server Side to be used.

```
