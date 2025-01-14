-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local WASABI_SCREENSHOT_WEBHOOK = GetConvar("wasabi_screenshot_webhook", nil)
local WASABI_OTHER_WEBHOOK = GetConvar("wasabi_other_webhook", nil)
Webhooks = {
    ['screenshot'] = {
        enabled = true, -- Enable screenshot what a player is doing while spectating
        webhook = WASABI_SCREENSHOT_WEBHOOK, -- Webhook url
    },
    ['revive'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['heal'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['kick'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['ban'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['money'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['item'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['zones'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['skin'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['invisible'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['godmode'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['freeze'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['noclip'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    },
    ['teleport'] = {
        enabled = true, -- Enable discord log
        webhook = WASABI_OTHER_WEBHOOK, -- Webhook url
        color = 1127128, -- Embed color
    }
}
