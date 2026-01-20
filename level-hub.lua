
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
    local m = gMarioStates[network_local_index_from_global(obj_get_nearest_object_with_behavior_id(o, id_bhvMario).globalPlayerIndex)] ---@type MarioState
    o.oFaceAngleYaw = atan2s(m.pos.z - o.oPosZ, m.pos.x - o.oPosX)
    o.oFaceAnglePitch = -0x4000 + atan2s(m.pos.y - o.oPosY, math.sqrt((m.pos.x - o.oPosX)^2 + (m.pos.z - o.oPosZ)^2))
end

local id_bhvCollabWarp = hook_behavior(nil, OBJ_LIST_LEVEL, true, bhv_collab_warp_init, bhv_collab_warp_loop)

function spawn_collab_warp(levelID, x, y, z)
    ---@param o Object
    spawn_non_sync_object(id_bhvCollabWarp, E_MODEL_STAR, x, y, z, function(o)
        o.oStarSelectorType = levelID
    end)
end

local function on_sync()
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_CASTLE_GROUNDS then return end
    for i = 1, #LEVEL_DATA do
        local data = LEVEL_DATA[i]
        spawn_collab_warp(data.id, data.hubPos.x, data.hubPos.y, data.hubPos.z)
    end
end

hook_event(HOOK_ON_SYNC_VALID, on_sync)

-- Custom Actions
local ACT_MARIO_COLLAB_WARP = allocate_mario_action(ACT_GROUP_CUTSCENE)
local function act_mario_collab_warp(m)
    local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvCollabWarp)
    if m.actionState == 0 then
        m.vel.x = 0
        m.vel.y = 0
        m.vel.z = 0

        m.pos.x = math.lerp(m.pos.x, o.oPosX + sins(o.oFaceAngleYaw) * o.hitboxRadius, 0.1)
        m.pos.y = math.lerp(m.pos.y, o.oPosY, 0.1)
        m.pos.z = math.lerp(m.pos.z, o.oPosZ + coss(o.oFaceAngleYaw) * o.hitboxRadius, 0.1)
        m.faceAngle.y = math.lerp(m.faceAngle.y, math.s16(o.oFaceAngleYaw + 0x8000), 0.1)

        perform_air_step(m, AIR_STEP_NONE)

        if m.controller.buttonPressed & A_BUTTON ~= 0 then
            m.actionState = m.actionState + 1
        elseif m.controller.buttonPressed & B_BUTTON ~= 0 then
            m.forwardVel = -10
            return set_mario_action(m, ACT_BACKWARD_AIR_KB, 1)
        end
    elseif m.actionState == 1 then
        m.actionState = m.actionState + 1
    elseif m.actionState == 2 then
        if m.playerIndex == 0 then
            warp_to_level(o.oStarSelectorType, 1, 0)
            return set_mario_action(m, ACT_DISAPPEARED, 0)
        end
    end
    djui_chat_message_create(tostring(m.actionState))
end
hook_mario_action(ACT_MARIO_COLLAB_WARP, act_mario_collab_warp)

local function mario_update(m)
    local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvCollabWarp)
    if o == nil then return end

    if vec3f_dist({x = o.oPosX, y = o.oPosY, z = o.oPosZ}, m.pos) < o.hitboxRadius and m.action ~= ACT_MARIO_COLLAB_WARP and m.prevAction ~= ACT_MARIO_COLLAB_WARP then
        set_mario_action(m, ACT_MARIO_COLLAB_WARP, 0)
    end
end


hook_event(HOOK_MARIO_UPDATE, mario_update)