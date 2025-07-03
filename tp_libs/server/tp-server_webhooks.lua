-- local webhook = exports.tp_webhooks:GetWebhookUrl("TP_MAILBOX")

------------------------------------------
-- Webhooks
------------------------------------------

local WEBHOOKS = {
    ["TP_MAILBOX"] = "xxxxxxxxxxxxxxxxxxxxxxxxxxx",
}

------------------------------------------
-- Functions
------------------------------------------

GetWebhookUrlByName = function(webhook)
    if webhook = nil then
        print("The webhook input seems to be null (invalid).")
        return "n/a"
    end
    
    if WEBHOOKS[webhook] == nil then
        print(string.format("The webhook input %s is not registered on WEBHOOKS table."), webhook )
        return "n/a"
    end
    
    return WEBHOOKS[webhook]
end)
