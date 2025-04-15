# TP Libs

TP Libs is a free resource (script) which will be used in lot of our scripts for supporting multiple frameworks and also contain a lot of API Functions such as Notifications, Discord Webhooking and Locales System.

This script can also be used by other developers if they are willing.

**Frameworks Supported**


1. TPZ-CORE
2. VORP
3. GUM
4. QBCORE
5. RSG
6. RSG V2
7. REDEM:RP

# Installation

1. When opening the zip file, open `tp_libs-main` directory folder and inside there will be another directory folder which is called as `tp_libs`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tp_libs` after your core essentials (core, characters & inventory) in the resources.cfg or server.cfg, depends where your scripts are located. 

# Developers 

## Player Object & Inventory API

- `isLoaded` returns a boolean value if the player has selected a character or not.
```lua
local isLoaded = API.isPlayerCharacterSelected(source)
```

## Notifications
  
```lua

TriggerServerEvent('tp_libs:sendNotification', source, message, type) -- Client Side to be used
TriggerEvent('tp_libs:sendNotification', source, message, type) -- Server Side to be used.
```

## Discord Webhooking (Server Side ONLY)

Discord Webhooks (Embed)

```lua
-- @param webhook: the webhook url for the httprequest to be sent to the discord server.
-- @param title: the title.
-- @param description: the description.
-- @param color: All colors can be found here: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
TP.sendToDiscord(webhook, title, description, color) -- server to server.
```

Discord Webhooks (Embed) with player parameters.

```lua
-- @param webhook: the webhook url for the httprequest to be sent to the discord server.
-- @param title: the title.
-- @param source : the online player target source.
-- @param steamName : the player target steam name.
-- @param username : the player target character first and lastname.
-- @param identifier : the player target identifier.
-- @param charidentifier : the player target selected character identifier.
-- @param description: the description.
-- @param color: All colors can be found here: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
TP.sendToDiscordWithPlayerParameters(webhook, title, source, steamName, username, identifier, charidentifier, description, color)
```

Discord Webhooks (Embed) with url image support.

```lua
-- @param webhook: the webhook url for the httprequest to be sent to the discord server.
-- @param title: the title.
-- @param description: the description.
-- @param url: the url of the image to be used and displayed.
-- @param color: All colors can be found here: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
TP.sendImageUrlToDiscord(webhook, title, description, url, color) -- server to server.
```

@Credits to VORP-CORE for the Server Callback & Client Callback files.
