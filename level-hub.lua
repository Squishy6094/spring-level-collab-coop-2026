add_level_data({
    name = "Spring Level Collab 2026",
    creator = "Squishy6094",
    id = LEVEL_CASTLE_GROUNDS,
    painting = 0,
})
create_streamed_sequence(SEQ_LEVEL_INSIDE_CASTLE, "music-eshop-2014.ogg", {12.123*16000, 88.931*16000}, true, 1, 1)

local E_MODEL_COLLAB_PAINTING = smlua_model_util_get_id("painting_custom_geo")
local ACT_MARIO_COLLAB_WARP = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_INTANGIBLE)
local PAINTING_ANIM_RIPPLE = "painting_ripple"

-- Anims
smlua_anim_util_register_animation(PAINTING_ANIM_RIPPLE, 257, 0, 0, 1, 25, { 
	0, 0, -3, -7, -11, -10, -6, -3, -2, 
	-1, 0, 0, 0, 0, 0, -1, -2, -2, 
	-3, -3, -3, -2, -1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, -25, -50, -33, -2, 15, 10, 
	-3, -18, -25, -19, -4, 10, 16, 14, 10, 
	3, -3, -8, -10, -9, -6, -4, -1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 50, 100, 66, 
	4, -29, -21, 5, 36, 50, 37, 8, -20, 
	-34, -30, -22, -12, -1, 7, 10, 9, 6, 
	4, 1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 
},{ 
	1, 0, 1, 1, 22, 2, 25, 24, 25, 
	49, 25, 74, 1, 99, 1, 100, 25, 101, 
	25, 126, 25, 151, 25, 176, 1, 201, 1, 
	202, 25, 203, 25, 228, 25, 253, 25, 278, 
});

-- Custom Objects
--- @param o Object
local function bhv_collab_warp_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oIntangibleTimer = 0
    o.oGraphYOffset = -5
    o.oDamageOrCoinValue = 2
    obj_scale(o, 1)

    o.hitboxRadius = 300
    --o.hitboxHeight = 100
    o.oGravity = 3
    o.oFriction = 0.8
    o.oBuoyancy = 1

    o.oHomeY = o.oPosY

    o.oVelY = 50
end

--- @param o Object
local function bhv_collab_warp_loop(o)
    o.oPosY = o.oHomeY + math.sin((get_global_timer() + 10*o.oStarSelectorType)*0.02)*50
    
    local m = nearest_mario_state_to_object(o) ---@type MarioState
    if m.action ~= ACT_MARIO_COLLAB_WARP then
        o.oFaceAngleYaw = atan2s(m.pos.z - o.oPosZ, m.pos.x - o.oPosX)
        o.oFaceAnglePitch = -0x4000 + atan2s(m.pos.y - o.oPosY, math.sqrt((m.pos.x - o.oPosX)^2 + (m.pos.z - o.oPosZ)^2))
    else
        o.oFaceAnglePitch = 0
    end
end

local id_bhvCollabWarp = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_collab_warp_init, bhv_collab_warp_loop, "bhvCollabWarp")

function spawn_collab_warp(levelDataID, x, y, z)
    ---@param o Object
    return spawn_non_sync_object(id_bhvCollabWarp, E_MODEL_COLLAB_PAINTING, x, y, z, function(o)
        o.oStarSelectorType = levelDataID
        o.oBehParams = LEVEL_DATA[levelDataID].painting
    end)
end

local function on_sync()
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_GROUNDS then return end
    for i = 1, #LEVEL_DATA do
        local data = LEVEL_DATA[i]
        if data.hubPos ~= nil then
            spawn_collab_warp(i, data.hubPos.x, data.hubPos.y, data.hubPos.z)
        end
    end
end

hook_event(HOOK_ON_SYNC_VALID, on_sync)

-- Custom Actions
local localWarpData = nil
---@param m MarioState
local function act_mario_collab_warp(m)
    local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvCollabWarp)
    m.vel.x = 0
    m.vel.y = 0
    m.vel.z = 0
    if m.actionState == 0 then -- Hover and wait for input
        set_character_animation(m, CHAR_ANIM_GENERAL_FALL);
        m.pos.x = math.lerp(m.pos.x, o.oPosX + sins(o.oFaceAngleYaw) * o.hitboxRadius, 0.1)
        m.pos.y = math.lerp(m.pos.y, o.oPosY - 50, 0.1)
        m.pos.z = math.lerp(m.pos.z, o.oPosZ + coss(o.oFaceAngleYaw) * o.hitboxRadius, 0.1)
        m.faceAngle.y = math.lerp(m.faceAngle.y, math.s16(o.oFaceAngleYaw + 0x8000), 0.1)
        if m.playerIndex == 0 then
            localWarpData = LEVEL_DATA[o.oStarSelectorType]
        end

        if m.controller.buttonPressed & A_BUTTON ~= 0 then
            m.actionState = m.actionState + 1
        elseif m.controller.buttonPressed & B_BUTTON ~= 0 then
            m.forwardVel = -10
            return set_mario_action(m, ACT_BACKWARD_AIR_KB, 1)
        end
    elseif m.actionState == 1 then -- Entrance Cutscene
        m.pos.x = math.lerp(m.pos.x, o.oPosX, m.actionTimer/30)
        m.pos.y = math.lerp(m.pos.y, o.oPosY, m.actionTimer/30)
        m.pos.z = math.lerp(m.pos.z, o.oPosZ, m.actionTimer/30)
        if vec3f_dist(m.pos, {x = o.oPosX, y = o.oPosY, z = o.oPosZ}) < 10 then
            m.actionState = m.actionState + 1
            smlua_anim_util_set_animation(o, PAINTING_ANIM_RIPPLE)
        end
        m.actionTimer = m.actionTimer + 1
    elseif m.actionState == 2 then -- Vanish and warp
        m.actionTimer = m.actionTimer + 1
        m.pos.y = o.oPosY + 9000
        if m.actionTimer == 1 and m.playerIndex == 0 then
            play_transition(WARP_TRANSITION_FADE_INTO_CIRCLE, 30, 0, 0, 0)
        end
        if m.actionTimer > 30 then
            set_character_animation(m, CHAR_ANIM_A_POSE);
            stop_and_set_height_to_floor(m);
            if m.playerIndex == 0 and localWarpData ~= nil then
                set_mario_action(m, ACT_DISAPPEARED, 0)
                warp_to_level(localWarpData.id, 1, 0)
            end
            m.actionState = m.actionState + 1
        end
    end
    
    vec3f_copy(m.marioObj.header.gfx.pos, m.pos)
    m.marioObj.header.gfx.angle.y = m.faceAngle.y
end
hook_mario_action(ACT_MARIO_COLLAB_WARP, act_mario_collab_warp)

local inWarp = false
local camLeftRight = true
local camSpeed = 0.05
local function mario_update(m)
    local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvCollabWarp)
    if o == nil then return end

    if vec3f_dist({x = o.oPosX, y = o.oPosY, z = o.oPosZ}, m.pos) < o.hitboxRadius and m.action ~= ACT_MARIO_COLLAB_WARP and m.prevAction ~= ACT_MARIO_COLLAB_WARP then
        set_mario_action(m, ACT_MARIO_COLLAB_WARP, 0)
    end

    if m.playerIndex == 0 then
        if m.action == ACT_MARIO_COLLAB_WARP then
            inWarp = true
            camera_freeze()
            if m.actionState ~= 2 then
                local focusPos = {
                    x = math.lerp(gLakituState.focus.x, o.oPosX, camSpeed),
                    y = math.lerp(gLakituState.focus.y, o.oPosY, camSpeed),
                    z = math.lerp(gLakituState.focus.z, o.oPosZ, camSpeed)
                }
                vec3f_copy(gLakituState.focus, focusPos)

                local camAngle = m.faceAngle.y + 0x6000 * (camLeftRight and 1 or -1)
                local camPos = {
                    x = math.lerp(gLakituState.pos.x, m.pos.x + sins(camAngle)*500, camSpeed),
                    y = math.lerp(gLakituState.pos.y, o.oPosY + 10, camSpeed),
                    z = math.lerp(gLakituState.pos.z, m.pos.z + coss(camAngle)*500, camSpeed),
                }
                camPos.y = collision_find_surface_on_ray(camPos.x, camPos.y + 300, camPos.z, 0, -300, 0).hitPos.y

                local camHit = collision_find_surface_on_ray(focusPos.x, focusPos.y, focusPos.z, camPos.x - focusPos.x, camPos.y - focusPos.y, camPos.z - focusPos.z).hitPos
                vec3f_copy(gLakituState.pos, camHit)
            end
        elseif inWarp then
            camera_unfreeze()
            inWarp = false
        else
            camLeftRight = math.s16(o.oFaceAngleYaw + 0x8000 - gLakituState.yaw) > 0
        end
    end 
end

local offsetMax = 300
local offset = 300
local function hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    local m = gMarioStates[0]
    if localWarpData == nil then return end
    offset = math.lerp(offset, m.action == ACT_MARIO_COLLAB_WARP and 0 or offsetMax, 0.1)

    if offset < offsetMax - 1 then
        djui_hud_set_font(FONT_RECOLOR_HUD)
        djui_hud_set_color(0, 255, 0, 255)
        djui_hud_print_text(localWarpData.name, 50 - offset, 50, 1)
        djui_hud_print_text(localWarpData.creator, 50 - offset, 70, 1)
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_HUD_RENDER, hud_render)

-- Painting Switch State
function geo_painting_switch_state(n)
    local node = cast_graph_node(n)
    node.selectedCase = 0
end