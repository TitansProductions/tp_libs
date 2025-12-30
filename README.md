# TP Libs

TP Libs is a free resource (script) which will be used in lot of our scripts for supporting multiple frameworks and also contain a lot of API Functions such as Notifications, Discord Webhooking and Locales System.

This script can also be used by other developers if they are willing.

**Frameworks Supported**


1. TPZ-CORE
2. VORP
3. GUM (NOT FULLY SUPPORTED)
4. RSG
5. RSG V2
6. QBCORE (NOT FULLY SUPPORTED)
7. REDEM:RP (NOT FULLY SUPPORTED)

# Installation

1. When opening the zip file, open `tp_libs-main` directory folder and inside there will be another directory folder which is called as `tp_libs`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tp_libs` after your core essentials (core, characters & inventory) in the resources.cfg or server.cfg, depends where your scripts are located.

# README

The specified Libs script requires a Framework as dependency, **DO NOT** ensure it before the Framework scripts, especially the Framework Base scripts but ensure it **LAST**. 

__example:__

```lua
ensure [Framework]
... (core)
... (characters)
... (inventory)
... etc. 
ensure tp_libs -- depedency
ensure tpz_menu_base -- depedency (standalone, can also be ensured before tp_libs)
ensure tp_inputs -- depedency
ensure tp_notify -- depedency
ensure tp_containers -- depedency
```


