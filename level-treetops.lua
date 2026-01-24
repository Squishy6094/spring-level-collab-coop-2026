local PlatformPath = {
    [0]  = {x = 945,  y = 672,  z = -144},
    [1]  = {x = 1024,  y = 689,  z = -406},
    [2]  = {x = 1264,  y = 739,  z = -471},
    [3]  = {x = 1615,  y = 797,  z = -472},
    [4]  = {x = 1965,  y = 855,  z = -472},
    [5]  = {x = 2315,  y = 913,  z = -472},
    [6]  = {x = 2666,  y = 972,  z = -472},
    [7]  = {x = 3016,  y = 1030,  z = -472},
    [8]  = {x = 3300,  y = 1074,  z = -444},
    [9]  = {x = 3578,  y = 1106,  z = -294},
    [10]  = {x = 3668,  y = 1116,  z = 0},
    [11]  = {x = 3578,  y = 1106,  z = 294},
    [12]  = {x = 3300,  y = 1074,  z = 444},
    [13]  = {x = 3016,  y = 1030,  z = 472},
    [14]  = {x = 2724,  y = 981,  z = 472},
    [15]  = {x = 2432,  y = 933,  z = 472},
    [16]  = {x = 2140,  y = 884,  z = 472},
    [17]  = {x = 1848,  y = 836,  z = 472},
    [18]  = {x = 1556,  y = 787,  z = 472},
    [19]  = {x = 1264,  y = 739,  z = 471},
    [20]  = {x = 1024,  y = 689,  z = 406},
    [21]  = {x = 945,  y = 672,  z = 144},
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
    o.oPyramidTopFragmentsScale = o.oPyramidTopFragmentsScale + 0.05
    if PlatformPath[math.floor(o.oPyramidTopFragmentsScale)] == nil then
        o.oPyramidTopFragmentsScale = 0
    end
    o.oEyerokBossUnk10C = o.oPosX
    o.oEyerokBossUnk104 = o.oPosY
    o.oEyerokBossUnk108 = o.oPosZ
    o.oPosX = math.lerp(o.oPosX, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].x, 0.012)
    o.oPosY = math.lerp(o.oPosY, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].y, 0.012)
    o.oPosZ = math.lerp(o.oPosZ, PlatformPath[math.floor(o.oPyramidTopFragmentsScale)].z, 0.012)
    o.oVelX = o.oPosX - o.oEyerokBossUnk10C
    o.oVelY = o.oPosY - o.oEyerokBossUnk104
    o.oVelZ = o.oPosZ - o.oEyerokBossUnk108
end

id_bhvJungleMovingPlatform = hook_behavior(id_bhvJungleMovingPlatform, OBJ_LIST_SURFACE, true, bhv_jungle_moving_platform_init, bhv_jungle_moving_platform_loop)