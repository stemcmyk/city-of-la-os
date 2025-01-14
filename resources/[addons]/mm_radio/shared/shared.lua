Shared.MaxFrequency = 500.00 -- Max Limit of Radio Channel

Shared.Jammer = {
    state = true, -- to use jammer system or not 
    model = 'sm_prop_smug_jammer', -- prop to spawn for jammer
    distance = 30.0, -- range of jammer effective
    permission = {"lspd", "sahp", "lscso"}, -- permission how can setup jammer (job/gang)
    default = {}, -- default jammer setup location 
    range = {
        min = 10.0,
        max = 100.0,
        step = 5.0,
        default = 30.0
    }
}

Shared.Battery = {
    state = false, -- to use battery system or not
    consume = 1, -- battery consume rate
    depletionTime = 1, -- in minute, every 1 minute battery will decrease by consume value
}

Shared.RadioNames = {
    ["1"] = "LSPD CH#1", -- channel value 1
    ["1.%"] = "LSPD CH#1", -- channel value 1.%%%% string formatter
    ["2"] = "LSCSO CH#2",
    ["2.%"] = "LSCSO CH#2",
    ["3"] = "SAHP CH#3",
    ["3.%"] = "SAHP CH#3",
    ["4"] = "LSPD CH#4",
    ["4.%"] = "LSPD CH#4",
    ["5"] = "AMR CH#5",
    ["5.%"] = "AMR CH#5",
    ["6"] = "MRPD CH#6",
    ["6.%"] = "MRPD CH#6",
    ["7"] = "SADOT CH#7",
    ["7.%"] = "SADOT CH#7",
    ["8"] = "MRPD CH#8",
    ["8.%"] = "MRPD CH#8",
    ["9"] = "MRPD CH#9",
    ["9.%"] = "MRPD CH#9",
    ["10"] = "MRPD CH#10",
    ["10.%"] = "MRPD CH#10",
    ["20"] = "YSL CH#1",
    ["20.%"] = "YSL CH#1",
    ["21"] = "D4L CH#1",
    ["21.%"] = "D4L CH#1",
    ["22"] = "WSM CH#1",
    ["22.%"] = "WSM CH#1",
    ["23"] = "STK CH#1",
    ["23.%"] = "STK CH#1",
    ["24"] = "ABM CH#1",
    ["24.%"] = "ABM CH#1",
    ["25"] = "CRIPS CH#1",
    ["25.%"] = "CRIPS CH#1",
    ["26"] = "EBK CH#1",
    ["26.%"] = "EBK CH#1",
    ["27"] = "GG CH#1",
    ["27.%"] = "GG CH#1",
    ["28"] = "PMF CH#1",
    ["28.%"] = "PMF CH#1",
    ["29"] = "TIC CH#1",
    ["29.%"] = "TIC CH#1",
}

Shared.RestrictedChannels = {
    [1] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp", "lscso", "amr"}
    },
    [2] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp","lscso", "amr"}
    },
    [3] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp","lscso", "amr"}
    },
    [4] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp","lscso", "amr"}
    },
    [5] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp","lscso", "amr"}
    },
    [6] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp", "lscso","amr"}
    },
    [7] = { -- channel id
        type = 'job', -- job/gang
        name = {"sadot", "lspd", "sahp", "lscso", "amr"}
    },
    [8] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp", "lscso","amr"}
    },
    [9] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp", "lscso","amr"}
    },
    [10] = { -- channel id
        type = 'job', -- job/gang
        name = {"lspd", "sahp","lscso", "amr"}
    },
    [20] = { -- channel id
        type = 'gang', -- job/gang
        name = {"ysl"}
    },
    [21] = { -- channel id
        type = 'gang', -- job/gang
        name = {"d4l"}
    },
    [22] = { -- channel id
        type = 'gang', -- job/gang
        name = {"wsm"}
    },
    [23] = {
        type = 'gang', -- job/gang
        name = {"stk"}
    },
    [24] = { -- channel id
        type = 'gang', -- job/gang
        name = {"abm"}
    },
    [25] = { -- channel id
        type = 'gang', -- job/gang
        name = {"crips"}
    },
    [26] = {
        type = 'gang', -- job/gang
        name = {"ebk"}
    },
    [27] = { -- channel id
        type = 'gang', -- job/gang
        name = {"gg"}
    },
    [28] = { -- channel id
        type = 'gang', -- job/gang
        name = {"pmf"}
    },
    [29] = { -- channel id
        type = 'gang', -- job/gang
        name = {"tic"}
    },
    
    
    
    
    
    
    
    







}

lib.locale()