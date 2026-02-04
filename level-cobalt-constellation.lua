-- Level Utility
add_level_data({
    name = "Cobalt Constellation",
    creator = "KaylanVT",
    id = LEVEL_DDD,
    hubPos = { x = -900, y = 600, z = 600 },
    painting = 0,
    stars = {
        --"CAPTAIN TOAD'S LOST SHIP",
        --"HOPPING ACROSS THE BROKEN RAINBOW ROAD",
        --"THE BULLY SPACE INVASION",
        --"CLIMBING UP THE COBALT CASTLE",
        --"RED COINS/NOTES AROUND THE RINGS",
        --"CRAZY MASTERS OF COBALT CASTLE"
    },
})
create_streamed_sequence(SEQ_LEVEL_WATER, "music-cobalt-constellation.ogg", { 5.27 * 46000, 67.25 * 46000 }, true, 1, 3)

-- Custom Skybox
local E_MODEL_COBALT_SKYBOX = smlua_model_util_get_id("cobalt_skybox_geo")

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

function SpawnSkybox()
    local skyboxcheck = obj_get_nearest_object_with_behavior_id(o, id_bhv3DSkybox)
    local p = gNetworkPlayers[0]
    if skyboxcheck == nil and p.currLevelNum == LEVEL_DDD then
        spawn_non_sync_object(id_bhv3DSkybox, E_MODEL_COBALT_SKYBOX, l.pos.x, l.pos.y, l.pos.z, nil)
    end
end

hook_event(HOOK_ON_LEVEL_INIT, SpawnSkybox)

--Question Coin and Rainbow Note Star


E_MODEL_QUESTION_COIN = smlua_model_util_get_id("question_coin_geo")
E_MODEL_RAINBOW_NOTE = smlua_model_util_get_id("rainbow_note_geo")
E_SOUND_QUESTION_COIN = audio_sample_load("question_coin.ogg")
E_SOUND_RAINBOW_NOTE = audio_sample_load("rainbow_note.ogg")

local RAINBOWNOTE_IDLE = 0
local RAINBOWNOTE_ACTIVE = 1
local RAINBOWNOTE_RESET = 2

local QUESTIONCOIN_IDLE = 0
local QUESTIONCOIN_ACTIVE = 1

RAINBOWNOTE_STATE = 0

local rainbowTimer = 720
rainbowNotes = 0
maxNotes = 0

local RainbowNoteStarSpawned = false

---@param param any
---@param case_table table<any, function>
---@return function?
local function switch(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end



---@type ObjectHitbox
sRainbowNoteHitbox = {
    interactType      = INTERACT_COIN,
    downOffset        = 0,
    damageOrCoinValue = 0,
    health            = 0,
    numLootCoins      = 0,
    radius            = 100,
    height            = 60,
    hurtboxRadius     = 0,
    hurtboxHeight     = 0,
}

---@type ObjectHitbox
sQuestionCoinHitbox = {
    interactType      = INTERACT_COIN,
    downOffset        = 0,
    damageOrCoinValue = 0,
    health            = 0,
    numLootCoins      = 0,
    radius            = 150,
    height            = 100,
    hurtboxRadius     = 0,
    hurtboxHeight     = 0,
}

--- @param obj Object
function obj_set_hitbox(obj, hitbox)
    if obj == nil or hitbox == nil then return end
    if (obj.oFlags & OBJ_FLAG_30) == 0 then
        obj.oFlags = obj.oFlags | OBJ_FLAG_30

        obj.oInteractType = hitbox.interactType
        obj.oDamageOrCoinValue = hitbox.damageOrCoinValue
        obj.oHealth = hitbox.health
        obj.oNumLootCoins = hitbox.numLootCoins

        cur_obj_become_tangible()
    end

    obj.hitboxRadius = obj.header.gfx.scale.x * hitbox.radius
    obj.hitboxHeight = obj.header.gfx.scale.y * hitbox.height
    obj.hurtboxRadius = obj.header.gfx.scale.x * hitbox.hurtboxRadius
    obj.hurtboxHeight = obj.header.gfx.scale.y * hitbox.hurtboxHeight
    obj.hitboxDownOffset = obj.header.gfx.scale.x * hitbox.downOffset
end

---@param obj Object
function bhv_question_coin_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj_set_hitbox(obj, sQuestionCoinHitbox)
    obj_set_model_extended(obj, E_MODEL_QUESTION_COIN)
    network_init_object(obj, false, {
        "oAction"
    })
end

---@param obj Object
function bhv_question_coin_loop(obj)
    local oPos = {}
    oPos.x = obj.oPosX
    oPos.y = obj.oPosY
    oPos.z = obj.oPosZ

    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 0x300

    if RainbowNoteStarSpawned then
        obj_mark_for_deletion(obj)
    else
        switch(obj.oAction, {
            [QUESTIONCOIN_IDLE] = function()
                if (obj.oInteractStatus & INT_STATUS_INTERACTED) ~= 0 then
                    cur_obj_disable_rendering_and_become_intangible(obj)
                    spawn_sync_object(id_bhvGoldenCoinSparkles, E_MODEL_SPARKLES, obj.oPosX, obj.oPosY, obj.oPosZ, bhv_golden_coin_sparkles_loop)
                    audio_sample_play(E_SOUND_QUESTION_COIN, oPos, 2.5)
                    obj.oAction = QUESTIONCOIN_ACTIVE
                    RAINBOWNOTE_STATE = 1
                    obj.oInteractStatus = 0
                else
                    cur_obj_enable_rendering_and_become_tangible(obj)
                    obj.oInteractStatus = 1
                end
            end,
            [QUESTIONCOIN_ACTIVE] = function()
                if obj.oTimer < (rainbowTimer - 70) then
                    play_sound(SOUND_GENERAL2_SWITCH_TICK_FAST, gGlobalSoundSource)
                else
                    play_sound(SOUND_GENERAL2_SWITCH_TICK_SLOW, gGlobalSoundSource)
                end

                if obj.oTimer == rainbowTimer then
                    stop_sound(SOUND_GENERAL2_SWITCH_TICK_FAST, gGlobalSoundSource)
                    cur_obj_enable_rendering_and_become_tangible(obj)
                    obj.oAction = QUESTIONCOIN_IDLE
                    obj.oInteractStatus = 1
                end
            end
        })
    end
end

---@param obj Object
function bhv_rainbow_note_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj_set_hitbox(obj, sRainbowNoteHitbox)
    obj_set_model_extended(obj, E_MODEL_RAINBOW_NOTE)
    network_init_object(obj, false, {
        "oAction"
    })
    rainbowNotes = obj_count_objects_with_behavior_id(bhvRainbowNote)
end

---@param obj Object
function bhv_rainbow_note_loop(obj)
    local oPos = {}
    oPos.x = obj.oPosX
    oPos.y = obj.oPosY
    oPos.z = obj.oPosZ
    cur_obj_scale(1.5)

    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 0x500


    if RainbowNoteStarSpawned then
        obj_mark_for_deletion(obj)
    else
        switch(obj.oAction, {
            [RAINBOWNOTE_IDLE] = function()
                cur_obj_disable_rendering_and_become_intangible(obj)
                obj.oInteractStatus = 1
                if RAINBOWNOTE_STATE == 1 then
                    obj.oAction = RAINBOWNOTE_ACTIVE
                end
            end,
            [RAINBOWNOTE_ACTIVE] = function()
                if (obj.oInteractStatus & INT_STATUS_INTERACTED) ~= 0 then
                    cur_obj_disable_rendering_and_become_intangible(obj)
                    spawn_sync_object(id_bhvGoldenCoinSparkles, E_MODEL_SPARKLES, obj.oPosX, obj.oPosY, obj.oPosZ, bhv_golden_coin_sparkles_loop)
                    audio_sample_play(E_SOUND_RAINBOW_NOTE, oPos, 1.5)
                    obj.oInteractStatus = 0
                    rainbowNotes = rainbowNotes - 1
                else
                    cur_obj_enable_rendering_and_become_tangible(obj)
                    obj.oInteractStatus = 1
                end

                if cur_obj_wait_then_blink(rainbowTimer - 70, 70) then
                    cur_obj_disable_rendering_and_become_intangible(obj)
                    obj.oAction = RAINBOWNOTE_RESET
                end
            end,
            [RAINBOWNOTE_RESET] = function()
                rainbowNotes = obj_count_objects_with_behavior_id(bhvRainbowNote)
                obj.oAction = RAINBOWNOTE_IDLE
            end
        })
    end
end

hook_event(HOOK_ON_LEVEL_INIT, function()
    RainbowNoteStarSpawned = false
end)

---@param obj Object
function bhv_rainbownote_starspawn_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
end

---@param obj Object
function bhv_rainbownote_starspawn_loop(obj)
    obj.oHiddenStarTriggerCounter = 0

    if obj.oHiddenStarTriggerCounter == rainbowNotes and not RainbowNoteStarSpawned then
        spawn_red_coin_cutscene_star(obj.oPosX, obj.oPosY, obj.oPosZ)
        RainbowNoteStarSpawned = true
        obj_mark_for_deletion(obj)
    end
end

hook_event(HOOK_ON_OBJECT_UNLOAD,
    ---@param obj Object
    function(obj)
        -- Force spawn star for newly entering players
        if obj_has_behavior_id(obj, bhvRainbowNote_StarSpawn) == 1 and obj.oHiddenStarTriggerCounter ~= obj.oHealth and not RainbowNoteStarSpawned then
            local starspawn_obj = obj_get_first_with_behavior_id(bhvRainbowNote_StarSpawn)
            spawn_red_coin_cutscene_star(starspawn_obj.oPosX, starspawn_obj.oPosY, starspawn_obj.oPosZ)
            RainbowNoteStarSpawned = true
        end
    end)

id_bhvQuestionCoin = hook_behavior(nil, OBJ_LIST_LEVEL, false, bhv_question_coin_init, bhv_question_coin_loop,
    "bhvQuestionCoin")
id_bhvRainbownote = hook_behavior(nil, OBJ_LIST_LEVEL, false, bhv_rainbow_note_init, bhv_rainbow_note_loop,
    "bhvRainbownote")
