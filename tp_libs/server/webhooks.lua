
----------------------------------------------
-- Webhooks (ADD ALL YOUR WEBHOOKS HERE)
----------------------------------------------

local WEBHOOKS = {
    
    ["tp_mailbox"] = {

    },
    
}

----------------------------------------------
-- Functions (DONT TOUCH WITHOUT EXPERIENCE)
----------------------------------------------

GetWebhookUrlByName = function(script, webhooktype)
    return WEBHOOKS[script][webhooktype]
end

