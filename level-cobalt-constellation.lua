add_level_data({
    name = "Cobalt Constellation",
    creator = "KaylanVT",
    id = LEVEL_DDD,
    hubPos = {x = -900, y = 600, z = 600},
    painting = 0,
    stars = {
        "CAPTAIN TOAD'S LOST SHIP",
        "HOPPING ACROSS THE BROKEN RAINBOW ROAD",
        "THE BULLY SPACE INVASION",
        "CLIMBING UP THE COBALT CASTLE",
        "RED COINS/NOTES AROUND THE RINGS",
        "CRAZY MASTERS OF COBALT CASTLE"
    },
})

create_streamed_sequence(SEQ_LEVEL_WATER, "music-cobalt-constellation.ogg", {5.27*46000, 67.25*46000}, true, 1, 3)

E_MODEL_COBALT_SKYBOX = smlua_model_util_get_id("cobalt_skybox_geo")

-- Behavior
local l = gLakituState

function bhv_skybox_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    obj_scale(o, 10.0)
end

function bhv_skybox_loop(o)
    o.oPosX = l.pos.x
    o.oPosY = l.pos.y
    o.oPosZ = l.pos.z
end

id_bhv3DSkybox = hook_behavior(bhv3DSkybox, OBJ_LIST_LEVEL, false, bhv_skybox_init, bhv_skybox_loop)

-- Example on how to use
function SpawnSkybox()
    local skyboxcheck = obj_get_nearest_object_with_behavior_id(o, id_bhv3DSkybox)
    local p = gNetworkPlayers[0]
    if skyboxcheck == nil and p.currLevelNum == LEVEL_DDD then
        spawn_non_sync_object(id_bhv3DSkybox, E_MODEL_COBALT_SKYBOX, l.pos.x, l.pos.y, l.pos.z, nil)
    end
end

hook_event(HOOK_ON_LEVEL_INIT, SpawnSkybox)