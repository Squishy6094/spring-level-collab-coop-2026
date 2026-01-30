add_level_data({
    name = "Cloudy Towers",
    creator = "Salt",
    id = LEVEL_RR,
    hubPos = {x = 900, y = 600, z = -600},
    painting = 0,
    stars = {
        "TREK UP THE RED TOWERS",
        "QUICK TIME BOX SWITCH",
        "WALL KICKS ARE REQUIRED",
        "RED COINS ABOVE THE CLOUDS",
        "STAR WITHIN THE STONE TOWER",
        "REACH THE HIGHEST POINT"
    },
})

create_streamed_sequence(SEQ_LEVEL_SPOOKY, "music-above-the-clouds.ogg", {0*16000, 128*16000}, true, 1, 3)
create_streamed_sequence(SEQ_EVENT_MERRY_GO_ROUND, "music-cabbage-cavern.ogg", {0*16000, 150*16000}, true, 1, 3)
