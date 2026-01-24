LEVEL_DATA = {
    {
        -- Left Front Hub
        name = (math.random(0, 100) == 69 and "Out Pik the Hut" or "Outset Wilds"),
        creator = "Kaktus64",
        id = LEVEL_THI,
        hubPos = {x = -750, y = 300, z = 1850},
        painting = 0,
        music = create_streamed_sequence(SEQ_LEVEL_INSIDE_CASTLE, "music-eshop-2014.ogg", {12.123*16000, 88.931*16000}, true, 1, 1),
    },
    {
        -- Right Front Hub
        name = "Cold Cliffs",
        creator = "WinbowBreaker Charlotte",
        id = LEVEL_CCM,
        hubPos = {x = 750, y = 300, z = 1850},
        painting = 0,
        music = create_streamed_sequence(SEQ_LEVEL_SNOW, "Cold_Cliffs.ogg", {12.123*16000, 88.931*16000}, true, 1, 5),
    },
    {
        -- Back Left Hub
        name = "Bob-omb Battlefield",
        creator = "Nintendo",
        id = LEVEL_BOB,
        hubPos = {x = -900, y = 600, z = -600},
        painting = 0,
        music = {},
    },
    {
        -- Back Center Hub
        name = "Tree-Top Tumble",
        creator = "Saultube",
        id = LEVEL_TTM,
        hubPos = {x = 0, y = 700, z = -1000},
        painting = 0,
        music = {},
    },
    {
        -- Back Right Hub
        name = "Cloudy Towers",
        creator = "Salt",
        id = LEVEL_RR,
        hubPos = {x = 900, y = 600, z = -600},
        painting = 0,
        music = {},
    },
}
