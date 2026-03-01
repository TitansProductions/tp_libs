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

   ["tp_trash"] = {

        ['TRASHBIN_PLACEMENT']              = "",
        ['LOCK_PLACEMENT']                  = "",
        ['LOCKPICKED']                      = "",
    },
      
    ["tp_backpacks"] = {

        ['DELETE_ALL']              = "",
        ['RENTED']                  = "",
    },

    ["tp_bandits"] = {
        ['SUCCESS_LOOT']            = "",
        ['ROBBED_BY_BANDITS']       = "",
        ['CHEAT']                   = "",
    },

    ["tp_banks"] = {
        ['TRANSACTIONS']            = "",
        ['ROBBERIES']               = "",
    },

    ["tp_beekeepers"] = {
        ['ALL']                     = "",
    },

    ["tp_crayfish"] = {
        ['CRAYFISH_CATCH_SUCCESS']  = "",
        ['CHEAT']                   = "",
    },

    ["tp_grave_robberies"] = {
        ['ALL']                     = "",
    },

    ["tp_housing"] = {
        ['BOUGHT']                  = "",
        ['SOLD']                    = "",
        ['TRANSFERRED']             = "",
        ['UPGRADE']                 = "",
    },

    ["tp_legendhunting"] = {
        ['STARTED']                 = "",
        ['SUCCESS']                 = "",
        ['CHEAT']                   = "",
    },

    ["tp_medical_archives"] = {

        -- MEDICAL_ IS THE DEPARTMENT FROM CONFIG
        -- IN CASE YOU CREATE MORE DEPARTMENTS, YOU MUST ALSO ADD THEM BELOW.
        ['MEDICAL_REGISTER']                = "",
        ['MEDICAL_NEW_FORM']                = "",
        ['MEDICAL_PATIENT_INFO']            = "",
        ['MEDICAL_DELETED_FORM']            = "",
        ['MEDICAL_DELETED_PATIENT']         = "",
    },

    ["tp_mydog"] = {
        ['BUY']                     = "",
        ['SELL']                    = "",
        ['TRANSFER']                = "",
    },

    ["tp_oilfields"] = {
        ['WORKER_ACTIONS']          = "",
        ['DELIVERY_ACTIONS']        = "",
        ['MANAGEMENT_ACTIONS']      = "",
        ['CHEAT']                   = "",
    },

    ["tp_pinboard"] = {
        ['POSTED_NOTE']             = "",
        ['DELETED_POSTED_NOTE']     = "",
        ['BLACKLISTED_URL']         = "",

        -- Below, for TP Pinboards you will need to register from Config.Locations (if you want active webhooks)
        -- the webhooks by the location name (Default config below as an example).

        ['VALENTINE']               = "",
        ['VALENTINE_MAILBOX']       = "",
        ['RHODES']                  = "",
        ['STRAWBERRY']              = "",
        ['BLACKWATER']              = "",
        ['SAINT_DENIS']             = "",

    },

    ["tp_player_auctions"] = {
        ['ALL']                     = "",
        ['CREATE']                  = "",
        ['DELETE']                  = "",
    },
    
    ["tp_stores"] = {
        ['BOUGHT']                  = "",
        ['SOLD']                    = "",
        ['EXCHANGED']               = "",
    },

    ["tp_player_stores"] = {
        ['CREATE']                  = "",
        ['DELETE']                  = "",
        ['RENTED']                  = "",
        ['CANCELLED_RENTING']       = "",
        ['WITHDREW_ACCOUNT']        = "",
        ['DEPOSITED_ACCOUNT']       = "",
        ['BOUGHT']                  = "",
        ['ADD_PRODUCTS']            = "",
        ['REMOVE_PRODUCTS']         = "",
        ['FAILED_TO_PAY_TAX']       = "",
        ['SOLD_PRODUCTS']           = "",
        ['BOUGHT_PRODUCTS']         = "",

    },

    ["tp_stagecoach"] = {
        ['BOUGHT_TRANSPORT_VEHICLE']  = "",
        ['CLIENT_DELIVERY_REWARDS']   = "",
    },

    ["tp_trading_port"] = {
        ['BOUGHT_STORAGE']           = "",
        ['SUBMITTED_NEW_ORDER']      = "",
        ['SOLD_PRODUCT']             = "",
    },

    ["tp_warehouses"] = {
        ['BOUGHT']                   = "",
        ['LOST_OWNERSHIP']           = "",
    },

    ["tp_warehouses"] = {
        ['BOUGHT']                   = "",
        ['LOST_OWNERSHIP']           = "",
    },

    ["tp_world_looting"] = {
        ['ALL']                      = "",
    },

    ["tp_mailbox"] = {

        ['REGISTERED']              = "",
        ['SENT_TELEGRAM']           = "",
        ['SENT_PARCEL']             = "",
        ['RETURNED_PARCEL']         = "",

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
