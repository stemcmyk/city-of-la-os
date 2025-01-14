-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config = {}

-------------------------------------
-- Check For Updates (Recommended) --
-------------------------------------
Config.CheckForUpdates = true

-----------------------------
-- Clean Database Settings --
-----------------------------
-- CAUTION: Changing this to true will drop(delete) all SQL tables and re-install them
-- Useful for server wipes, major SQL/script changes, etc
-- After running script with Config.CleanDatabase to true, change back to false and restart server/script
Config.CleanDatabase = false

------------------------
-- Item Configuration --
------------------------
Config.WarPhoneItem = 'xphone' -- Name of item of phone

-----------------
-- Gang System --
-----------------
-- Gang System to sync with (When gang system set; when set you cannot have staff create gang via command)
-- Options: false (Will enable Config.AdminMode for staff to use) / 'qb' (QBCore gangs) / 'rcore' (RCore Gangs) / 'esx' (esx_gangs - see docs for small change needed) 'custom' (Custom gang system added in modules/_customize/gang_systems/custom)
Config.GangSystem = false -- Set to false if want to use in phone gang management with Config.AdminMode
-- Use qb-gangs? ^ Put this setting to 'qb' to keep in sync
-- Use rcore_gangs? ^ put this setting to 'rcore' to keep in sync
-- Use esx_gangs? ^ Put this setting to 'esx' an also make changes on our docs: https://docs.wasabiscripts.com

------------------------------------------
-- IF NOT USING Config.GangSystem !!!!! --
------------------------------------------
Config.AdminMode = { -- This ONLY applies if Config.GangSystem = false
    command = 'gpadmin', -- Command for staff to manage gangs(If Config.GangSystem set to false - Default: 'gangphoneadmin' (/gangphoneadmin)
    groups = { 'god', 'admin' } -- User groups who can access command
}

-- ACE PERMISSIONS? Look:
-- Grant the group/user the permission to use admin mode via ace perms, example:
-- add_ace group.admin "gangwar_phone.admin" allow

-----------------------
-- Language Settings --
-----------------------
-- Language Options: 'en', 'fr', 'cn', 'tw', 'de', 'it', 'jp', 'ko', 'pl', 'pt', or 'es'
Config.DefaultLanguage = 'en'

-------------------------------------
-- Deposit/Withdrawling From Phone --
-------------------------------------
Config.PayWagerAccount = 'bank' -- This will be the account it checks for when depositing and withdrawaling for wagers.

------------------
-- War Settings --
------------------
Config.WarCountdownTime = 30 -- In seconds; Default: 30
Config.ToggleLeaderboardKey = 'O'-- Default key to toggle the leaderboard while in war with another gang
Config.EnableMarkers = true -- Enables red markers under rival gang's feet while at war(Only visible to gangs and during war)

Config.WarScoreLocationOffset = { x = 0, y = 0 } -- War score location while in war out of vehicles (all values 0 puts back in default location)
Config.WarScoreLocationInVehicleOffset = { x = 0, y = 85} -- War score location while in war inside vehicle (all values 0 puts in bac default location)

Config.KillFeedLocationOffset = { x = 0, y = 0 } -- Kill feed location on screen

--------------------
-- Error Messages --
--------------------
Config.ErrorMessage = {
    gang_invite_create_fail = '^0[^3WARNING^0] GANG WAR FAILED TO CREATE! - FAILED TO WRITE TO DATABASE!',
    gang_invite_no_players_fail = '^0[^3WARNING^0] GANG WAR FAILED TO START! - FAILED TO DETECT GANGWAR PLAYERS!',
}

---------------------
-- String Messages --
---------------------
Strings = {
    kicked = 'Kicked',
    kicked_message = 'You have been kicked from your gang',
    left_gang = 'Left Gang',
    left_gang_message = 'You have left your gang',
    toggle_scoreboard_control_label = 'Toggle Leaderboard(In War)',
    no_money = 'Insuffucient Funds',
    no_money_desc = 'You do not have the funds to do this!',
    fight = 'FIGHT!',
    no_permission = 'No Permission',
    no_permission_desc = 'You do not have permission to do this!',
    admin_mode_enabled = 'Admin Mode Enabled',
    admin_mode_enabled_desc = 'You are now in admin mode and can manage gangs via phone!',
    admin_mode_disabled = 'Admin Mode Disabled',
    admin_mode_disabled_desc = 'You are no longer in admin mode!',
    error = 'Error',
    error_desc = 'An unknown error has occured!',
    no_gang = 'No Gang',
    no_gang_desc = 'You are not in a gang to use this!',

    -- Message notifications
    accepted_war_invite = '%s accepted a war invite with %s',
    declined_war_invite = '%s declined a war invite with %s',
    cancelled_war_invite = '%s cancelled a war invite with %s',

    accepted_gang_invite = '%s accepted a gang invite from %s',
    declined_gang_invite = '%s declined a gang invite from %s',
    cancelled_gang_invite = '%s cancelled a gang invite for %s',

    gang_deleted = 'Gang Deleted',
    gang_deleted_desc = 'The gang you were in was deleted!',
    
    defeat = 'DEFEATED',
    victory = 'VICTORY',
    lost_war = 'Your gang has lost the war!',
    won_war = 'Your gang has won the war!',
    war_over = 'WAR OVER',


}