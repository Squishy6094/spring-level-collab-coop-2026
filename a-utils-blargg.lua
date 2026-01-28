--WIP Blargg bhv, by Sunk but cleaned up for coopdx

local BLARGG_ACT_SWIM = 0
local BLARGG_ACT_CHASE = 1
local BLARGG_ACT_KNOCKBACK = 2
local BLARGG_ACT_BACKUP = 3

---@param param any
---@param case_table table<any, function>
---@return function?
local function switch(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end

local string_pack = string.pack
local string_unpack = string.unpack

---@param parent Object
---@param model ModelExtendedId
---@param behaviorId BehaviorId
local function spawn_object(parent, model, behaviorId)
    local obj = spawn_non_sync_object(behaviorId, model, 0, 0, 0, nil)
    if not obj then return nil end

    obj_copy_pos_and_angle(obj, parent)
    return obj
end

local _obj_set_hitbox = obj_set_hitbox

function obj_set_hitbox(obj, hitbox)
    local objHitbox = get_temp_object_hitbox()
    for k, v in pairs(hitbox) do
        objHitbox[k] = v
    end
    _obj_set_hitbox(obj, objHitbox)
end

----- Blargg -----

-- Animation ID
local ANM_swim = 0
local ANM_attack = 1

--- Enemy Blargg ---

---@type ObjectHitbox
local sBlarggHitbox = {
    interactType = INTERACT_DAMAGE,
    downOffset = 0,
    damageOrCoinValue = 1,
    health = 0,
    numLootCoins = 0,
    --[[ -- Original, however I believe they're a little too large
    radius = 300,
    height = 235,
    hurtboxRadius = 300,
    hurtboxHeight = 110
    ]]
    radius = 200,
    height = 235,
    hurtboxRadius = 200,
    hurtboxHeight = 110
}

-- Summon visual flames
---@param obj Object
local function bhv_koopa_shell_flame_spawn(obj)
    for i = 0, 2 do
        spawn_object(obj, E_MODEL_RED_FLAME, id_bhvKoopaShellFlame)
    end
end

-- Check if blargg hit Mario
---@param obj Object
local function blargg_check_mario_collision(obj)
    if obj.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        cur_obj_play_sound_2(SOUND_MOVING_LAVA_BURN)
        obj.oInteractStatus = obj.oInteractStatus & ~INT_STATUS_INTERACTED
        obj.oAction = BLARGG_ACT_KNOCKBACK
        obj.oFlags = obj.oFlags & ~OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
        cur_obj_init_animation(ANM_swim)
        obj.oBullyMarioCollisionAngle = obj.oMoveAngleYaw
    end
end

-- Waiting
---@param obj Object
---@param m MarioState
local function blargg_act_swim(obj, m)
    obj.oForwardVel = 5.0
    if obj_return_home_if_safe(obj, obj.oHomeX, obj.oPosY, obj.oHomeZ, 800) == 1 and gMarioStates[0].floor.type ~= SURFACE_DEFAULT then
        obj.oAction = BLARGG_ACT_CHASE
    end
end

-- Mario found, activate chase
---@param obj Object
---@param m MarioState
local function blargg_act_chase_mario(obj, m)
    local homeX = obj.oHomeX
    local posY = obj.oPosY
    local homeZ = obj.oHomeZ

    obj.oFlags = obj.oFlags | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
    obj.oMoveAngleYaw = obj.oFaceAngleYaw
    obj_turn_toward_object(obj, m.marioObj, 16, 4096)

    -- Mario will never ride on a hostile blargg so I don't understand this
    --obj.oForwardVel = (gMarioStates[0].riddenObj == obj) and 40 or 10
    obj.oForwardVel = 10

    bhv_koopa_shell_flame_spawn(obj)
    -- If Mario is too far or is no longer on lava, start swimming
    if is_point_within_radius_of_mario(homeX, posY, homeZ, 5000) == 0 or gMarioStates[0].floor.type == SURFACE_DEFAULT then
        obj.oAction = BLARGG_ACT_SWIM
        cur_obj_init_animation(ANM_swim)
    end
end

-- Hit Mario, recieve the knockback
---@param obj Object
---@param m MarioState
local function blargg_act_knockback(obj, m)
    -- Only activate during BLARGG_ACT_SWIM, it appears
    if obj.oForwardVel < 10.0 and math.s32(obj.oVelY) == 0 then
        obj.oForwardVel = 1.0
        obj.oBullyKBTimerAndMinionKOCounter = obj.oBullyKBTimerAndMinionKOCounter + 1
        obj.oFlags = obj.oFlags | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
        obj.oMoveAngleYaw = obj.oFaceAngleYaw
        obj_turn_toward_object(obj, m.marioObj, 16, 1280)
    else
        -- ! Changed from curAnim to animInfo
        obj.header.gfx.animInfo.animFrame = 0
    end

    -- After some time, start chasing again
    if obj.oBullyKBTimerAndMinionKOCounter == 18 then
        obj.oAction = BLARGG_ACT_CHASE
        obj.oBullyKBTimerAndMinionKOCounter = 0
        cur_obj_init_animation(ANM_attack)
        cur_obj_play_sound_2(SOUND_OBJ2_PIRANHA_PLANT_BITE)
    end
end

---@param obj Object
local function blargg_act_back_up(obj)
    if obj.oTimer == 0 then
        obj.oFlags = obj.oFlags & ~OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
        obj.oMoveAngleYaw = obj.oMoveAngleYaw + 0x8000
    end

    obj.oForwardVel = 5.0

    if obj.oTimer == 15 then
        obj.oMoveAngleYaw = obj.oFaceAngleYaw
        obj.oFlags = obj.oFlags | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW
        obj.oAction = BLARGG_ACT_SWIM
    end
end

local function blargg_backup_check(obj, collisionFlags)
    if collisionFlags & OBJ_COL_FLAG_NO_Y_VEL == 0 and obj.oAction ~= BLARGG_ACT_KNOCKBACK then
        obj.oPosX = obj.oBullyPrevX
        obj.oPosZ = obj.oBullyPrevZ
        obj.oAction = BLARGG_ACT_BACKUP
    end
end

---@param obj Object
local function blargg_step(obj)
    local collisionFlags = 0
    collisionFlags = object_step()
    -- Possibly back up upon hitting a wall
    blargg_backup_check(obj, collisionFlags)
end

---@param obj Object
function bhv_blargg_init(obj)
    obj.oAnimations = gObjectAnimations.blargg_seg5_anims_0500616C
    cur_obj_init_animation(ANM_swim)
    obj.oFlags = OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj_set_model_extended(obj, E_MODEL_BLARGG)
    obj.oGravity = 4.0
    obj.oFriction = 1.0
    obj.oIntangibleTimer = 0
    obj.oBuoyancy = 1.3
    obj.oHomeX = obj.oPosX
    obj.oHomeZ = obj.oPosZ
    obj.oHomeY = obj.oPosY
    obj_set_hitbox(obj, sBlarggHitbox)
    network_init_object(obj, true, nil)
end

---@param obj Object
function bhv_blargg_loop(obj)
    obj.oIntangibleTimer = 0
    
    obj.oBullyPrevX = obj.oPosX
    obj.oBullyPrevY = obj.oPosY
    obj.oBullyPrevZ = obj.oPosZ
    blargg_check_mario_collision(obj)

    ---@type MarioState
    local m = gMarioStates[0]
    -- In this case, since there's a lot of possible states, a switch is faster
    switch (obj.oAction, {
        [BLARGG_ACT_SWIM] = function ()
            blargg_act_swim(obj, m)
            blargg_step(obj)
        end,
        [BLARGG_ACT_CHASE] = function ()
            blargg_act_chase_mario(obj, m)
            blargg_step(obj)
        end,
        [BLARGG_ACT_KNOCKBACK] = function ()
            blargg_act_knockback(obj, m)
            blargg_step(obj)
        end,
        [BLARGG_ACT_BACKUP] = function ()
            obj.oForwardVel = 10.0
            blargg_act_back_up(obj)
            blargg_step(obj)
        end,
        [BULLY_ACT_DEATH_PLANE_DEATH] = function ()
            obj.activeFlags = ACTIVE_FLAG_DEACTIVATED
        end
    })
end

id_bhvBlargg = hook_behavior(nil, OBJ_LIST_GENACTOR, false, bhv_blargg_init, bhv_blargg_loop, "bhvBlargg")