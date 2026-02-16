add_level_data({
    name = "Tree-Top Tumble",
    creator = "Saultube",
    id = LEVEL_TTM,
    hubPos = {x = 0, y = 700, z = -1000},
    painting = 0,
    music = create_streamed_sequence(SEQ_EVENT_PEACH_MESSAGE, "saul_song.ogg", {0*16000, 120.105*16000}, true, 1, 5), --unused song for saul game 3d, also temporary, loops awfully
})

-- MISC STUFF

function geo_vine_position(node, matStackIndex)
    local torso = cast_graph_node(node.next)

    VinePos = {x = torso.translation.x, y = torso.translation.y, z = torso.translation.z}
end

function MarioUpdateShit(m)
    if m.playerIndex == 0 then
        if VinePos.x ~= nil then
            m.pos.x = VinePos.x
            m.pos.y = VinePos.y
            m.pos.z = VinePos.z
        end
    end
end

-- ANIMATIONS

smlua_anim_util_register_animation('PLATFORM_MOVING', 0, 0, 0, 1, 80, { 
	0, 0, 65534, 65533, 65531, 0, 65534, 65533, 65531, 
	65533, 0, 65534, 65533, 65531, 0, 65534, 65533, 65531, 
	65533, 65534, 0, 65534, 65533, 65531, 0, 65534, 65533, 
	65531, 65533, 0, 65534, 65533, 65531, 0, 65534, 65533, 
	65531, 65533, 0, 65534, 65533, 65531, 0, 65534, 65533, 
	65531, 65533, 0, 65534, 65533, 65531, 0, 65534, 65533, 
	65531, 65533, 65534, 0, 65534, 65533, 65531, 0, 65534, 
	65533, 65531, 65533, 0, 65534, 65533, 65531, 0, 65534, 
	65533, 65531, 65533, 0, 65534, 65533, 65531, 0, 0, 
	0, 0, 0, 0, 0, 830, 1659, 2489, 3318, 
	4148, 4977, 5807, 6636, 7466, 8296, 9125, 9955, 10784, 
	11614, 12443, 13273, 14102, 14932, 15762, 16591, 17421, 18250, 
	19080, 19909, 20739, 21568, 22398, 23228, 24057, 24887, 25716, 
	26546, 27375, 28205, 29034, 29864, 30694, 31523, 32353, 33182, 
	34012, 34841, 35671, 36501, 37330, 38160, 38989, 39819, 40648, 
	41478, 42307, 43137, 43967, 44796, 45626, 46455, 47285, 48114, 
	48944, 49773, 50603, 51433, 52262, 53092, 53921, 54751, 55580, 
	56410, 57239, 58069, 58899, 59728, 60558, 61387, 62217, 63046, 
	63876, 64705, 0, 0, 0, 0, 64705, 63876, 63046, 
	62217, 61387, 60558, 59728, 58899, 58069, 57239, 56410, 55580, 
	54751, 53921, 53092, 52262, 51433, 50603, 49773, 48944, 48114, 
	47285, 46455, 45626, 44796, 43967, 43137, 42307, 41478, 40648, 
	39819, 38989, 38160, 37330, 36501, 35671, 34841, 34012, 33182, 
	32353, 31523, 30694, 29864, 29034, 28205, 27375, 26546, 25716, 
	24887, 24057, 23228, 22398, 21568, 20739, 19909, 19080, 18250, 
	17421, 16591, 15762, 14932, 14102, 13273, 12443, 11614, 10784, 
	9955, 9125, 8296, 7466, 6636, 5807, 4977, 4148, 3318, 
	2489, 1659, 830, 65535, 0, 

},{ 
	1, 0, 79, 1, 1, 80, 1, 81, 1, 
	82, 1, 83, 1, 84, 80, 85, 1, 165, 
	1, 166, 80, 167, 1, 247, 

});

-- MAIN THINGS

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
    smlua_anim_util_set_animation(o, 'PLATFORM_MOVING')
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