add_level_data({
    name = "Cloudy Towers",
    creator = "Salt",
    id = LEVEL_RR,
    hubPos = {x = 900, y = 600, z = -600},
    painting = 0,
    stars = {
        "CLIMB THE DOUBLE TOWERS",
        "QUICK TIME BOX SWITCH",
        "WALL KICKS ARE REQUIRED",
        "RED COINS ABOVE THE CLOUDS",
        "CLEAR CAVE 2",
        "CLEAR CAVE 3"
    },
})

create_streamed_sequence(SEQ_LEVEL_SPOOKY, "music-above-the-clouds.ogg", {0*16000, 128*16000}, true, 1, 3)
