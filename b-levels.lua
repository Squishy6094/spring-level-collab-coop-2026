LEVEL_DATA = {
    {
        -- Left Front Hub
        name = (math.random(0, 100) == 69 and "Out Pik the Hut" or "Outset Wilds"),
        creator = "Kaktus64",
        id = LEVEL_THI,
        hubPos = {x = -750, y = 300, z = 1850},
        painting = 0,
        music = create_streamed_sequence(SEQ_LEVEL_GRASS, "music-pikmin.ogg", {0*16000, 82.650*16000}, true, 1, 2.5),
        stars = {
            "CREATURE IN THE POT",
            "KOOPA THE SWIMMER",
            "SPARKLIUM COLLECTING",
            "EMERGENCE CAVERN",
            "CHILLY CREVASSE",
            "THE THIRD CAVE"
        },
    },
    {
        -- Right Front Hub
        name = "Cold Cliffs",
        creator = "WinbowBreaker Charlotte",
        id = LEVEL_CCM,
        hubPos = {x = 750, y = 300, z = 1850},
        painting = 0,
        music = create_streamed_sequence(SEQ_LEVEL_SNOW, "music-cold-cliffs.ogg", {0*16000, 128*16000}, true, 1, 5),
    },
    {
        -- Back Left Hub
        name = "Warner Brothers Studio",
        creator = "WBmarioo",
        id = LEVEL_LLL,
        hubPos = {x = -900, y = 600, z = -600},
        painting = 0,
        music = 0,
        stars = { --WB for future reference these all need to be uppercase -kaktus
            "SAVING CAPTAIN TOAD",
            "TBD 1",
            "Red Coin (TBD Name)",
            "TBD 2",
            "TBD 3",
            "(TBD Metal Cap Star)"
        },
    },
    {
        -- Back Center Hub
        name = "Tree-Top Tumble",
        creator = "Saultube",
        id = LEVEL_TTM,
        hubPos = {x = 0, y = 700, z = -1000},
        painting = 0,
        music = 0,
    },
    {
        -- Back Right Hub
        name = "Cloudy Towers",
        creator = "Salt",
        id = LEVEL_RR,
        hubPos = {x = 900, y = 600, z = -600},
        painting = 0,
        music = create_streamed_sequence(SEQ_LEVEL_SPOOKY, "music-above-the-clouds.ogg", {0*16000, 128*16000}, true, 1, 3),
        stars = {
            "CLIMB THE TWIN TOWERS",
            "QUICK TIME BOX SWITCH",
            "WALL KICKS ARE REQUIRED",
            "RED COINS ABOVE THE CLOUDS",
            "CLEAR CAVE 2",
            "CLEAR CAVE 3"
        },
    },
    music = create_streamed_sequence(SEQ_LEVEL_INSIDE_CASTLE, "music-eshop-2014.ogg", {12.123*16000, 88.931*16000}, true, 1, 1),
}


--- Init data
for i = 1, #LEVEL_DATA do
    local data = LEVEL_DATA[i]
    local stars = data.stars or {}
    local course = get_level_course_num(data.id)
    local levelName = string.upper(data.name)
    smlua_text_utils_course_acts_replace(course, levelName, stars[1] or "?", stars[2] or "?", stars[3] or "?", stars[4] or "?", stars[5] or "?", stars[6] or "?")
end
