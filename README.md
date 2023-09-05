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

API.getConfiguration()
exports.tp_libs:rServerAPI().getConfiguration()

API.sendNotification(source, message, type) -- success, error (This is also supported on client side)

exports.tp_libs:rClientAPI().sendNotification(source, message, type) -- success, error.
exports.tp_libs:rServerAPI().sendNotification(source, message, type) -- success, error.

