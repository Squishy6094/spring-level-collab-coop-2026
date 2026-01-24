local PlatformPath = { -- from levels\ttm\area_1\spline.inc.c
    [0]  = {x = 945,  y = 672,  z = -144},
    [1]  = {x = 1024,  y = 689,  z = -406},
    [2]  = {x = 1264,  y = 739,  z = -788},
    [3]  = {x = 1848,  y = 836,  z = -972},
    [4]  = {x = 2432,  y = 933,  z = -972},
    [5]  = {x = 3016,  y = 1030,  z = -789},
    [6]  = {x = 3300,  y = 1074,  z = -582},
    [7]  = {x = 3578,  y = 1106,  z = -294},
    [8]  = {x = 3668,  y = 1116,  z = 0},
    [9]  = {x = 3578,  y = 1106,  z = 294},
    [10]  = {x = 3300,  y = 1074,  z = 582},
    [11]  = {x = 3016,  y = 1030,  z = 789},
    [12]  = {x = 2432,  y = 933,  z = 972},
    [13]  = {x = 1848,  y = 836,  z = 972},
    [14]  = {x = 1264,  y = 739,  z = 788},
    [15]  = {x = 1024,  y = 689,  z = 406},
    [16]  = {x = 945,  y = 672,  z = 144},
}

E_MODEL_TREETOPS_PLATFORM_MOVING = smlua_model_util_get_id("treetoplevelplatform_geo")

--- @param o Object
local function bhv_jungle_moving_platform_init(o)
    network_init_object(o, true, { "oPyramidTopFragmentsScale" })
    o.oPyramidTopFragmentsScale = 0
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oPyramidTopFragmentsScale = 0
    o.collisionData = smlua_collision_util_get("treetoplevelplatform_collision")
end

--- @param o Object
local function bhv_jungle_moving_platform_loop(o)
    load_object_collision_model()
    o.oPyramidTopFragmentsScale = o.oPyramidTopFragmentsScale + 0.04
    if PlatformPath[math.floor(o.oPyramidTopFragmentsScale)] == nil then
        o.oPyramidTopFragmentsScale = 0
    end
    o.oEyerokBossUnk10C = o.oPosX
    o.oEyerokBossUnk104 = o.oPosY
    o.oEyerokBossUnk108 = o.oPosZ
    o.oPosX = math.lerp(o.oPosX, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].x, 0.062)
    o.oPosY = math.lerp(o.oPosY, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].y, 0.062)
    o.oPosZ = math.lerp(o.oPosZ, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].z, 0.062)
    o.oVelX = o.oPosX - o.oEyerokBossUnk10C
    o.oVelY = o.oPosY - o.oEyerokBossUnk104
    o.oVelZ = o.oPosZ - o.oEyerokBossUnk108
end

id_bhvJungleMovingPlatform = hook_behavior(id_bhvJungleMovingPlatform, OBJ_LIST_SURFACE, true, bhv_jungle_moving_platform_init, bhv_jungle_moving_platform_loop)