-- Level Utility
add_level_data({
    name = "Cobalt Constellation",
    creator = "KaylanVT",
    id = LEVEL_DDD,
    color = {r = 0, g = 71, b = 171},
    hubPos = { x = -900, y = 600, z = 600 },
    painting = 0,
    stars = {
        "CAPTAIN TOAD'S LOST SHIP",
        "HOPPING ACROSS THE BROKEN RAINBOW ROAD",
        "THE BULLY SPACE INVASION",
        "CLIMBING UP THE COBALT CASTLE",
        "NOTES AROUND THE RINGS",
        "CONSTELLATION'S RED COINS"
    },
})
create_streamed_sequence(SEQ_LEVEL_WATER, "music-cobalt-constellation.ogg", { 5.27 * 46000, 67.25 * 46000 }, true, 1, 2)

-- Custom Skybox
--#region
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
--#endregion

--Question Coin and Rainbow Note Star
--#region
E_MODEL_QUESTION_COIN = smlua_model_util_get_id("question_coin_geo")
E_MODEL_RAINBOW_NOTE = smlua_model_util_get_id("rainbow_note_geo")
E_SOUND_QUESTION_COIN = audio_sample_load("question_coin.ogg")
E_SOUND_RAINBOW_NOTE = audio_sample_load("rainbow_note.ogg")




local QUESTIONCOIN_IDLE = 0
local QUESTIONCOIN_ACTIVE = 1
local RAINBOWNOTE_IDLE = 0
local RAINBOWNOTE_ACTIVE = 1
local RAINBOWNOTE_RESET = 2

local rainbowTimer = 720
local questionInteract = false
local rainbowNotes = 0

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
    radius            = 80,
    height            = 90,
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
    radius            = 130,
    height            = 80,
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
    obj.oAction = QUESTIONCOIN_IDLE
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
                    spawn_sync_object(id_bhvGoldenCoinSparkles, E_MODEL_SPARKLES, obj.oPosX, obj.oPosY, obj.oPosZ, bhv_question_coin_loop)
                    audio_sample_play(E_SOUND_QUESTION_COIN, oPos, 2.5)
                    cur_obj_disable_rendering()
                    cur_obj_become_intangible()
                    questionInteract = true
                    obj.oAction = QUESTIONCOIN_ACTIVE
                    obj.oInteractStatus = 0
                else
                    cur_obj_enable_rendering()
                    cur_obj_become_tangible()
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
                    cur_obj_enable_rendering()
                    cur_obj_become_tangible()
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
    obj.oAction = RAINBOWNOTE_RESET
    questionInteract = false

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
                if questionInteract ~= false then
                    cur_obj_enable_rendering()
                    cur_obj_become_tangible()
                    obj.oAction = RAINBOWNOTE_ACTIVE

                else   
                cur_obj_disable_rendering()
                cur_obj_become_intangible()
                obj.oTimer = 0
                obj.oInteractStatus = 1
                --[[ if obj_is_valid_for_interaction(obj) ~= true then
                    obj.oAction = RAINBOWNOTE_ACTIVE
                else]]
                end
            end,
            [RAINBOWNOTE_ACTIVE] = function()
                cur_obj_wait_then_blink(rainbowTimer - 70, 70)
                if obj.oTimer < 2 then
                    cur_obj_enable_rendering()
                    cur_obj_become_tangible()
                end
                if (obj.oInteractStatus & INT_STATUS_INTERACTED) ~= 0 then
                    spawn_sync_object(id_bhvGoldenCoinSparkles, E_MODEL_SPARKLES, obj.oPosX, obj.oPosY, obj.oPosZ, bhv_rainbow_note_loop)
                    audio_sample_play(E_SOUND_RAINBOW_NOTE, oPos, 1.5)
                    cur_obj_disable_rendering()
                    cur_obj_become_intangible()
                    rainbowNotes = rainbowNotes + 1
                    obj.oInteractStatus = 0
                
                end

                if obj.oTimer == rainbowTimer then
                    obj.oInteractStatus = 1
                    cur_obj_disable_rendering()
                    cur_obj_become_intangible()
                    obj.oAction = RAINBOWNOTE_RESET
                end
            end,
            [RAINBOWNOTE_RESET] = function()
                rainbowNotes = 0
                questionInteract = false
                obj.oAction = RAINBOWNOTE_IDLE
            end 
        })
    end
end

hook_event(HOOK_ON_LEVEL_INIT,
function ()
    RainbowNoteStarSpawned = false
    rainbowNotes = 0
end
)

---@param obj Object
function bhv_rainbownote_starspawn_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.oHealth = rainbowNotes
end

---@param obj Object
function bhv_rainbownote_starspawn_loop(obj)


    if obj.oHealth ~= rainbowNotes then
        obj.oHealth = rainbowNotes
    end

    obj.oHiddenStarTriggerCounter = obj_count_objects_with_behavior_id(bhvRainbowNote)


    if obj.oHiddenStarTriggerCounter == obj.oHealth and not RainbowNoteStarSpawned then
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

--[[id_bhvQuestionCoin = hook_behavior(nil, OBJ_LIST_LEVEL, false, bhv_question_coin_init, bhv_question_coin_loop,
    "bhvQuestionCoin")
id_bhvRainbownote = hook_behavior(nil, OBJ_LIST_LEVEL, false, bhv_rainbow_note_init, bhv_rainbow_note_loop,
    "bhvRainbownote")]]
--#endregion

-- Dialogue Replacements & Toad Star
--#region
--[[Dialogue currently in use as of writing: 001, 002, 097, 016, 068, 082, 154, 008,
                               018, 019, 078, 151, 168, 152
    Starting Dialogue Defines I'll use at 120 (Unused)]]

E_MODEL_BRIGADE_BLUE = smlua_model_util_get_id("brigade_member_blue_geo")
E_MODEL_BRIGADE_YELLOW = smlua_model_util_get_id("brigade_member_yellow_geo")

-- Blue Toad Dialogue
smlua_text_utils_dialog_replace(DIALOG_120, 1, 6, 30, 200,
"Oh! Am I SO glad\
to see you!\
\
\
\
Can you help us?\
We were searching for\
the captain when we\
were hit and crashed here.\
Those Bullies shot us down\
and are making a mess of\
everything around here!\
They've destroyed Rainbow\
Road and a planet's rings\
with cannonballs.\
\
\
Please be careful!\
I think the Bullies are\
planning on taking over\
that castle over there!\
\
\
Hey! I know!\
Here take this star!\
\
I know its something the\
captain would do...\
It's better in your hands\
than in ours anyway.\
I'm positive that it will\
help against those mean\
Bullies!")

smlua_text_utils_dialog_replace(DIALOG_121, 1, 5, 30, 200,
"I have to do my best\
to fix the starship.\
...\
...\
...\
...\
...\
...\
... I hope the captain\
is ok... I'm worried...")

-- Blue Toad Star
add_toad_star_spawn(DIALOG_120, 0, nil, nil, nil, DIALOG_121)

-- Yellow Toad Dialogue

smlua_text_utils_dialog_replace(DIALOG_122, 1, 6, 30, 200,
"We lost a lot when \
we crashed. I think Blue\
forgot that we had a\
passenger on board. I'm \
going to go look for them\
after a nap...\
*Yawn* I hope they...\
didn't... land in...\
that castle...\
It's so...\
far... away. . .\
... zZz... Zzz...")

--#endregion

-- Simple Planet Rotation
--#region
E_MODEL_GAS_GIANT = smlua_model_util_get_id("gas_giant_geo")

function bhv_gas_giant_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

function bhv_gas_giant_loop(o)
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x30
end

id_bhvGasGiant = hook_behavior(bhvGasGiant, OBJ_LIST_LEVEL, false, bhv_gas_giant_init, bhv_gas_giant_loop)


--#endregion