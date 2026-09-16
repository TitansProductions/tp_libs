----------------------------------------------
-- Webhooks (ADD ALL YOUR WEBHOOKS HERE)
----------------------------------------------

/*
   Insert all the webhooks on the scripts you are having below.

   All of our webhooks are located here and not through the script config, the configuration file is shared,
   and since it is shared, a RedM Executer can find all of your script webhooks easily and spam or share them to others.

   (!) IF A SCRIPT IS NOT BELOW, IT MEANS THAT IT DOES NOT HAVE ANY WEBHOOKS AVAILABLE.
*/

local WEBHOOKS = {

   ["tp_companies"] = {
        ['COMMANDS']                = "webhook_url_here",
   }, 
      
   ["tp_wildlife_missions"] = {
        ['RECEIVED_REWARDS']        = "webhook_url_here",
   }, 
      
   ["tp_cod_zombies"]               = {
        ['VALENTINE']               = "webhook_url_here", -- default map name
   }, 
   
    ["tp_stables"] = {
        ['COMMANDS']                = "webhook_url_here",
        ['BOUGHT']                  = "webhook_url_here",
        ['SOLD']                    = "webhook_url_here",
        ['SOLD_TAMED_HORSE']        = "webhook_url_here",
        ['TRANSFERRED']             = "webhook_url_here",
        ['RECEIVED_TAMED_HORSE']    = "webhook_url_here",
        ['BREEDING']                = "webhook_url_here",
    },

      
   ["tp_clans"] = {
        ['COMMANDS']                = "webhook_url_here",
        ['FAILED_TO_PAY_TAX']       = "webhook_url_here",
        ['DELETED_CLAN']            = "webhook_url_here",
        ['RAIDS']                   = "webhook_url_here",
    },
      
   ["tp_ranch"] = {
        ['BOUGHT']                  = "webhook_url_here",
        ['STORES']                  = "webhook_url_here",
        ['LEDGER_TRANSACTIONS']     = "webhook_url_here",
        ['MEMBERS']                 = "webhook_url_here",
        ['CHEAT']                   = "webhook_url_here",
        ['FAILED_TO_PAY_TAX']       = "webhook_url_here",
   },
      
   ["tp_trash"] = {
        ['ALL']                     = "webhook_url_here",
    },
      
    ["tp_backpacks"] = {
        ['ALL']                     = "webhook_url_here",
    },

    ["tp_bandits"] = {
        ['SUCCESS_LOOT']            = "webhook_url_here",
        ['ROBBED_BY_BANDITS']       = "webhook_url_here",
        ['CHEAT']                   = "webhook_url_here",
    },

    ["tp_banks"] = {
        ['TRANSACTIONS']            = "webhook_url_here",
        ['ROBBERIES']               = "webhook_url_here",
    },

    ["tp_beekeepers"] = {
        ['ALL']                     = "webhook_url_here",
    },

    ["tp_crayfish"] = {
        ['CRAYFISH_CATCH_SUCCESS']  = "webhook_url_here",
        ['CHEAT']                   = "webhook_url_here",
    },

    ["tp_grave_robberies"] = {
        ['ALL']                     = "webhook_url_here",
    },

    ["tp_housing"] = {
        ['BOUGHT']                  = "webhook_url_here",
        ['SOLD']                    = "webhook_url_here",
        ['TRANSFERRED']             = "webhook_url_here",
        ['UPGRADE']                 = "webhook_url_here",
    },

    ["tp_legendhunting"] = {
        ['STARTED']                 = "webhook_url_here",
        ['SUCCESS']                 = "webhook_url_here",
        ['CHEAT']                   = "webhook_url_here",
    },

    ["tp_medical_archives"] = {

        -- MEDICAL_ IS THE DEPARTMENT FROM CONFIG
        -- IN CASE YOU CREATE MORE DEPARTMENTS, YOU MUST ALSO ADD THEM BELOW.
        ['MEDICAL_REGISTER']        = "webhook_url_here",
        ['MEDICAL_NEW_FORM']        = "webhook_url_here",
        ['MEDICAL_PATIENT_INFO']    = "webhook_url_here",
        ['MEDICAL_DELETED_FORM']    = "webhook_url_here",
        ['MEDICAL_DELETED_PATIENT'] = "webhook_url_here",
    },

    ["tp_mydog"] = {
        ['BUY']                     = "webhook_url_here",
        ['SELL']                    = "webhook_url_here",
        ['TRANSFER']                = "webhook_url_here",
    },

    ["tp_oilfields"] = {
        ['WORKER_ACTIONS']          = "webhook_url_here",
        ['DELIVERY_ACTIONS']        = "webhook_url_here",
        ['MANAGEMENT_ACTIONS']      = "webhook_url_here",
        ['CHEAT']                   = "webhook_url_here",
    },

    ["tp_pinboard"] = {
        ['POSTED_NOTE']             = "webhook_url_here",
        ['DELETED_POSTED_NOTE']     = "webhook_url_here",
        ['BLACKLISTED_URL']         = "webhook_url_here",

        -- Below, for TP Pinboards you will need to register from Config.Locations (if you want active webhooks)
        -- the webhooks by the location name (Default config below as an example).

        ['VALENTINE']               = "webhook_url_here",
        ['VALENTINE_MAILBOX']       = "webhook_url_here",
        ['RHODES']                  = "webhook_url_here",
        ['STRAWBERRY']              = "webhook_url_here",
        ['BLACKWATER']              = "webhook_url_here",
        ['SAINT_DENIS']             = "webhook_url_here",

    },

    ["tp_player_auctions"] = {
        ['ALL']                     = "webhook_url_here",
        ['CREATE']                  = "webhook_url_here",
        ['DELETE']                  = "webhook_url_here",
    },
    
    ["tp_stores"] = {
        ['BOUGHT']                  = "webhook_url_here",
        ['SOLD']                    = "webhook_url_here",
        ['EXCHANGED']               = "webhook_url_here",
    },

    ["tp_player_stores"] = {
        ['CREATE']                  = "webhook_url_here",
        ['DELETE']                  = "webhook_url_here",
        ['RENTED']                  = "webhook_url_here",
        ['CANCELLED_RENTING']       = "webhook_url_here",
        ['WITHDREW_ACCOUNT']        = "webhook_url_here",
        ['DEPOSITED_ACCOUNT']       = "webhook_url_here",
        ['BOUGHT']                  = "webhook_url_here",
        ['ADD_PRODUCTS']            = "webhook_url_here",
        ['REMOVE_PRODUCTS']         = "webhook_url_here",
        ['FAILED_TO_PAY_TAX']       = "webhook_url_here",
        ['SOLD_PRODUCTS']           = "webhook_url_here",
        ['BOUGHT_PRODUCTS']         = "webhook_url_here",

    },

    ["tp_stagecoach"] = {
        ['BOUGHT_TRANSPORT_VEHICLE'] = "webhook_url_here",
        ['CLIENT_DELIVERY_REWARDS']  = "webhook_url_here",
    },

    ["tp_trading_port"] = {
        ['BOUGHT_STORAGE']           = "webhook_url_here",
        ['SUBMITTED_NEW_ORDER']      = "webhook_url_here",
        ['SOLD_PRODUCT']             = "webhook_url_here",
    },

    ["tp_warehouses"] = {
        ['BOUGHT']                   = "webhook_url_here",
        ['LOST_OWNERSHIP']           = "webhook_url_here",
    },

    ["tp_warehouses"] = {
        ['BOUGHT']                   = "webhook_url_here",
        ['LOST_OWNERSHIP']           = "webhook_url_here",
    },

    ["tp_world_looting"] = {
        ['ALL']                      = "webhook_url_here",
    },

    ["tp_mailbox"] = {

        ['REGISTERED']              = "webhook_url_here",
        ['SENT_TELEGRAM']           = "webhook_url_here",
        ['SENT_PARCEL']             = "webhook_url_here",
        ['RETURNED_PARCEL']         = "webhook_url_here",

    },
    
}

----------------------------------------------
-- Functions (DONT TOUCH WITHOUT EXPERIENCE)
----------------------------------------------

GetWebhookUrlByName = function(script, webhooktype)

    if WEBHOOKS[script][webhooktype] == nil then 
        print(string.format('Attempted to retrieve GetWebhookUrlByName from an non valid webhook type of the mentioned script: { script: %s, type: %s }', script, webhooktype))
        return "N/A"
    end
   
    return WEBHOOKS[script][webhooktype]
end
