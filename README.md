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

SOON - REWORK

**Events**

* Notifications
  
```lua

TriggerServerEvent('tp_libs:sendNotification', source, message, type) -- Client Side to be used
TriggerEvent('tp_libs:sendNotification', source, message, type) -- Server Side to be used.
```

* Discord Webhooking
  
```lua



```

@Credits to VORP-CORE for the Server Callback & Client Callback files.
