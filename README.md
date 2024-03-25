# TP Libs

TP Libs is a free resource (script) which will be used in lot of our scripts for supporting multiple frameworks and also contain a lot of API Functions such as Notifications, Discord Webhooking and Locales System.

This script can also be used by other developers if they are willing.

**Frameworks Supported**


1. TPZ-CORE
2. VORP
3. GUM
4. QBCORE
5. RSG
6. REDMRP

# Installation

1. When opening the zip file, open `tp_libs-main` directory folder and inside there will be another directory folder which is called as `tp_libs`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tp_libs` after your core essentials (core, characters & inventory) in the resources.cfg or server.cfg, depends where your scripts are located. 

# Developers 

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

-- Get Char Identifier

local charIdentifier = API.getChar(source)

local charIdentifier = exports.tp_libs:rServerAPI().getChar(source)

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

```


**Events**

* Notifications
  
```lua

TriggerServerEvent('tp_libs:sendNotification', source, message, type) -- Client Side to be used
TriggerEvent('tp_libs:sendNotification', source, message, type) -- Server Side to be used.
```

* Discord Webhooking
  
```lua
TriggerServerEvent('tp_libs:sendToDiscord', webhook, name, description, color) -- Client Side to be used
TriggerEvent('tp_libs:sendToDiscord', webhook, name, description, color) -- Server Side to be used.

```

@Credits to VORP-CORE for the Server Callback & Client Callback files.
