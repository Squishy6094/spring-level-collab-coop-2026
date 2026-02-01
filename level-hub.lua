-- Init Level

add_level_data({
    name = "Spring Level Collab 2026",
    creator = "Squishy6094",
    id = LEVEL_CASTLE_GROUNDS,
    painting = 0,
    stars = {
        "Admired Artwork"
    }
})
create_streamed_sequence(SEQ_LEVEL_INSIDE_CASTLE, "music-eshop-2014.ogg", {12.123*16000, 88.931*16000}, true, 1, 1)

-- Toad Sequence
add_level_data({
    name = "Out Pikmin the Hut",
    creator = "#JOBFIRED",
    painting = 0,
    color = {r = 255, g = 255, b = 50},
    hubPos = {x = -3650, y = 200, z = 1600}
})

smlua_text_utils_dialog_replace(DIALOG_001, 1, 6, 95, 200,
--the museum, taking in--
"Oh! Hello there Mario!\
\
I was just wandering\
around the museum, taking\
in as much artwork as I\
could feast my eyes upon!\
Noteably though, this\
place seems to focus on\
'Quality over Quantity,'\
and thus this painting\
was hidden back here\
since it doesn't fit in.\
But in all honesty, I've\
been pondering on what the\
artist intended when they\
painted such a beautiful\
yet thought-worthy\
canvas?\
Maybe only time will tell...\
\
\
\
\
Hmmm...\
Oh I'm sorry, I bet you're\
in a hurry. Please take\
this star as a thanks for\
pondering with me! I hope\
we can ponder together\
another time!")

smlua_text_utils_dialog_replace(DIALOG_002, 0, 2, 95, 200,
"Hmmm...\
What if maybe....\
it was a theory piece,\
but it seems so alien...\
Wait! It could be an\
extraterrestrial piece!\
No that's just ridiculous,\
not even a chance...")

add_toad_star_spawn(DIALOG_001, 0, nil, nil, nil, DIALOG_002)

local E_MODEL_COLLAB_PAINTING = smlua_model_util_get_id("painting_custom_geo")
local ACT_MARIO_COLLAB_WARP = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_INTANGIBLE)
local PAINTING_ANIM_RIPPLE = "painting_ripple"

local function lerp_s16(a, b, t)
    a = math.s16(a)
    b = math.s16(b)

    local delta = b - a

    if delta > 0x8000 then
        delta = delta - 0x10000
    elseif delta < -0x8000 then
        delta = delta + 0x10000
    end

    return math.s16(a + delta * t)
end

-- Anims
smlua_anim_util_register_animation(PAINTING_ANIM_RIPPLE, 257, 0, 0, 1, 30, { 
	0, 0, -3, -9, -14, -13, -12, -10, -8, 
	-6, -3, -2, 0, 0, 0, -1, -2, -2, 
	-3, -3, -3, -3, -2, -2, -1, -1, 0, 
	0, 65163, 64791, 65056, 13, 278, 77, 65239, 65039, 
	65201, 65502, 130, 121, 99, 70, 41, 17, 7, 
	4, 3, 2, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 1, 0, -1, -2, 
	-3, -3, -2, -1, -1, 0, 0, -13, -26, 
	-17, 0, 10, 3, -9, -16, -15, -13, -10, 
	-6, -3, 0, 2, 4, 4, 4, 3, 3, 
	2, 1, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, -39, -77, 
	-46, 12, 44, 24, -13, -32, -4, 24, 19, 
	7, -5, -11, -11, -12, -12, -6, 4, 9, 
	8, 5, 2, -1, -2, -2, -1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 86, 172, 103, -27, -97, -55, 24, 
	66, 12, -43, -35, -16, 4, 19, 24, 26, 
	26, 16, -4, -14, -13, -8, -3, 2, 4, 
	3, 2, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 

},{ 
	1, 0, 1, 1, 25, 2, 30, 27, 30, 
	57, 30, 87, 1, 117, 14, 118, 25, 132, 
	30, 157, 30, 187, 30, 217, 1, 247, 1, 
	248, 29, 249, 30, 278, 30, 308, 30, 338, 
	1, 368, 1, 369, 30, 370, 30, 400, 30, 
	430, 30, 460, 

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
    o.oPosY = o.oHomeY + math.random(9999, 99999)

    o.oVelY = 50
end

--- @param o Object
local function bhv_collab_warp_loop(o)
    o.oPosY = math.lerp(o.oPosY, o.oHomeY + math.sin((get_global_timer() + 10*o.oStarSelectorType)*0.02)*50, 0.1)
    
    local m = nearest_mario_state_to_object(o) ---@type MarioState
    if m.action ~= ACT_MARIO_COLLAB_WARP then
        o.oFaceAngleYaw = lerp_s16(o.oFaceAngleYaw, atan2s(m.pos.z - o.oPosZ, m.pos.x - o.oPosX), 0.1)
        o.oFaceAnglePitch = lerp_s16((-0x4000 + atan2s(m.pos.y - o.oPosY, math.sqrt((m.pos.x - o.oPosX)^2 + (m.pos.z - o.oPosZ)^2)))*0.2, o.oFaceAnglePitch, 0.1)
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
        m.faceAngle.y = lerp_s16(m.faceAngle.y, math.s16(o.oFaceAngleYaw + 0x8000), 0.1)
        if m.playerIndex == 0 then
            localWarpData = LEVEL_DATA[o.oStarSelectorType]
        end

        if m.controller.buttonPressed & A_BUTTON ~= 0 then
            m.actionState = m.actionState + 1
        elseif m.controller.buttonPressed & B_BUTTON ~= 0 then
            m.forwardVel = -10
            return set_mario_action(m, ACT_SOFT_BONK, 1)
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

    if vec3f_dist({x = o.oPosX, y = o.oPosY, z = o.oPosZ}, m.pos) < o.hitboxRadius and LEVEL_DATA[o.oStarSelectorType].id ~= nil and m.action ~= ACT_MARIO_COLLAB_WARP and m.prevAction ~= ACT_MARIO_COLLAB_WARP then
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

local saveFile = get_current_save_file_num() - 1
local offsetMax = 300
local offset = 300
local paintingTrans = 255
local function hud_painting_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    local m = gMarioStates[0]
    local l = gLakituState
    paintingTrans = math.lerp(paintingTrans, localWarpData == nil and 0 or 255, 0.1)

    local o = obj_get_first_with_behavior_id(id_bhvCollabWarp)
    if o == nil then return end
    repeat
        local currWarpData = LEVEL_DATA[o.oStarSelectorType]
        local screenPos = {x = 0, y = 0, z = 0}
        local objPos = {x = o.oPosX, y = o.oPosY + 200, z = o.oPosZ}
        local marioPos = (m.action == ACT_MARIO_COLLAB_WARP and m.actionState == 2) and objPos or m.pos
        djui_hud_world_pos_to_screen_pos(objPos, screenPos)
        local fov = get_current_fov()/40
        local scale = math.min(o.hitboxRadius/vec3f_dist(objPos, l.pos), 1)*fov
        local trans = math.clamp((math.min(o.hitboxRadius/(vec3f_dist(objPos, marioPos)), 1) - 0.2)*3, 0, 1)*255

        djui_hud_set_font(FONT_RECOLOR_HUD)
        local lvlColor = currWarpData.color or {r = 255, g = 255, b = 255}
        djui_hud_set_color(lvlColor.r, lvlColor.g, lvlColor.b, trans)
        djui_hud_print_text(currWarpData.name, screenPos.x - djui_hud_measure_text(currWarpData.name)*scale, screenPos.y - 50*scale, scale*2)
        djui_hud_print_text(currWarpData.creator, screenPos.x - djui_hud_measure_text(currWarpData.creator)*scale*0.5, screenPos.y - 16*scale, scale)


        local objPos = {x = o.oPosX, y = o.oPosY - 200, z = o.oPosZ}
        djui_hud_world_pos_to_screen_pos(objPos, screenPos)

        djui_hud_set_color(255, 255, 255, trans)
        local starCount = 0
        local starCountTotal = 0
        if currWarpData.stars ~= nil then
            starCountTotal = #currWarpData.stars
            for i = 1, starCountTotal do
                if save_file_get_star_flags(saveFile, get_level_course_num(currWarpData.id) - 1) & (1 << (i - 1)) ~= 0 then
                    starCount = starCount + 1
                end
            end

            djui_hud_set_font(FONT_HUD)
            local starCountString = tostring(starCount) .. "/" .. tostring(starCountTotal)
            djui_hud_print_text(starCountString, screenPos.x - (djui_hud_measure_text(starCountString) - 16)*scale, screenPos.y, scale*2)
            djui_hud_render_texture(gTextures.star, screenPos.x - (djui_hud_measure_text(starCountString) + 16)*scale, screenPos.y, scale*2, scale*2)
        end

        o = obj_get_next_with_same_behavior_id(o)
    until o == nil
    offset = math.lerp(offset, m.action == ACT_MARIO_COLLAB_WARP and 0 or offsetMax, 0.1)

    --if offset < offsetMax - 1 then
    --    djui_hud_print_text(localWarpData.name, 50 - offset, 50, 1)
    --    djui_hud_print_text(localWarpData.creator, 50 - offset, 70, 1)
    --end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_painting_render)

-- Painting Switch State
function geo_painting_switch_state(n)
    local node = cast_graph_node(n)
    node.selectedCase = 0
end