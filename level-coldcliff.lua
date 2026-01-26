add_level_data({
    name = "Cold Cliffs",
    creator = "WinbowBreaker Charlotte",
    id = LEVEL_CCM,
    hubPos = {x = 750, y = 300, z = 1850},
    painting = 0,
})
create_streamed_sequence(SEQ_LEVEL_SNOW, "music-cold-cliffs.ogg", {0*16000, 128*16000}, true, 1, 5)

E_MODEL_TODD = smlua_model_util_get_id("largeconcretemistake_geo")
E_MODEL_TREEE = smlua_model_util_get_id("charlotetree_geo")