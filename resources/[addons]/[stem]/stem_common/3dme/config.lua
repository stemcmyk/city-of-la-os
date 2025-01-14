-- @desc Shared config file
-- @author Elio
-- @version 2.0

-- Global configuration
Config_3dme = {
    language = 'en',
    color = { r = 230, g = 230, b = 230, a = 255 }, -- Text color
    font = 0, -- Text font
    time = 5000, -- Duration to display the text (in ms)
    scale = 0.5, -- Text scale
    dist = 250, -- Min. distance to draw 
    Languages = {
        ['en'] = {
            commandName = 'me',
            commandDescription = 'Display an action above your head.',
            commandSuggestion = {{ name = 'action', help = '"licking my balls" for example.'}},
            prefix = ''
        },
    }
}

