-- Custom Toad Behavior to allow for very customizable star requirements
local TOAD_MESSAGE_FADED = 0
local TOAD_MESSAGE_OPAQUE = 1
local TOAD_MESSAGE_OPACIFYING = 2
local TOAD_MESSAGE_FADING = 3
local TOAD_MESSAGE_TALKING = 4

local TOAD_SUBACTION_BEFORE_REQUIREMENT = 0
local TOAD_SUBACTION_AFTER_REQUIREMENT = 1
local TOAD_SUBACTION_STAR_SPAWNED = 2

-- Replace with a much more customizable toad system
local toadStars = {}

-- Don't let the game use these
gBehaviorValues.ToadStar1Requirement = 0xFFFF
gBehaviorValues.ToadStar2Requirement = 0xFFFF
gBehaviorValues.ToadStar3Requirement = 0xFFFF
gBehaviorValues.dialogs.ToadStar1Dialog = 0xFFFF
gBehaviorValues.dialogs.ToadStar2Dialog = 0xFFFF
gBehaviorValues.dialogs.ToadStar3Dialog = 0xFFFF
gBehaviorValues.dialogs.ToadStar1AfterDialog = 0xFFFF
gBehaviorValues.dialogs.ToadStar2AfterDialog = 0xFFFF
gBehaviorValues.dialogs.ToadStar3AfterDialog = 0xFFFF

function bhv_custom_toad_message_init(o)
    o.oFlags = o.oFlags | (OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oAnimations = gObjectAnimations.toad_seg6_anims_0600FB58
    cur_obj_init_animation(6)
    o.oInteractType = INTERACT_TEXT
    o.hitboxRadius = 80
    o.hitboxHeight = 100
    o.oIntangibleTimer = 0
    bhv_init_room()

    local dialogId = (o.oBehParams >> 24) & 0xFF
    local toadData = toadStars[dialogId]

    if toadData then

        -- Delete toad if spawn requirement is not met
        if toadData.spawnRequirement ~= nil and not toadData.spawnRequirement() then
            obj_mark_for_deletion(o)
        end

        -- Check if star is already collected
        -- If so, skip directly to dialog after star
        local saveFile = get_current_save_file_num() - 1
        local collectedStar = save_file_get_star_flags(saveFile, gNetworkPlayers[0].currCourseNum - 1) & (1 << (toadData.starID)) ~= 0
        if collectedStar then
            dialogId = toadData.afterDialogId or o.oToadMessageDialogId
            o.oSubAction = TOAD_SUBACTION_STAR_SPAWNED
        else
            o.oSubAction = TOAD_SUBACTION_BEFORE_REQUIREMENT
        end
    end

    o.oToadMessageDialogId = dialogId
    o.oToadMessageRecentlyTalked = 0
    o.oToadMessageState = TOAD_MESSAGE_FADED
    o.oOpacity = 81
end

function bhv_custom_toad_message_loop(o)
    local dialogId = (o.oBehParams >> 24) & 0xFF
    local toadData = toadStars[dialogId]
    local requirementDialogId = toadData and toadData.requirementDialogId or dialogId

    if toadData then

        -- Check requirement
        if o.oToadMessageState == TOAD_MESSAGE_TALKING and o.oSubAction ~= TOAD_SUBACTION_STAR_SPAWNED then

            -- Passed requirement?
            if not toadData.starRequirement or toadData.starRequirement() then
                o.oSubAction = TOAD_SUBACTION_AFTER_REQUIREMENT
            else
                o.oSubAction = TOAD_SUBACTION_BEFORE_REQUIREMENT
            end
        end

        -- Update dialog
        if o.oSubAction == TOAD_SUBACTION_STAR_SPAWNED then
            o.oToadMessageDialogId = toadData.afterDialogId or dialogId
        elseif o.oSubAction == TOAD_SUBACTION_AFTER_REQUIREMENT then
            o.oToadMessageDialogId = toadData.requirementDialogId or dialogId
        else
            o.oToadMessageDialogId = dialogId
        end
    end

    -- Update Toad
    bhv_toad_message_loop()

    if toadData then

        -- Check spawn star
        if o.oToadMessageState == TOAD_MESSAGE_FADING and o.oToadMessageRecentlyTalked == 1 and o.oSubAction == TOAD_SUBACTION_AFTER_REQUIREMENT then
            bhv_spawn_star_no_level_exit(gMarioStates[0].marioObj, toadData.starID, 1)
            o.oSubAction = TOAD_SUBACTION_STAR_SPAWNED
        end
    end
end

hook_behavior(id_bhvToadMessage, OBJ_LIST_GENACTOR, true, bhv_custom_toad_message_init, bhv_custom_toad_message_loop, "bhvToadMessage")

---@param dialogId integer The dialog ID that the toad spawns with
---@param starID integer The ID of the star spawned (0-5)
---@param spawnRequirement function? The requirement for the toad the spawn, will immediatly 
---@param starRequirement function? The requirement for the toad to give you his star
---@param requirementDialogId integer? The dialog ID toad is set to if you talk to him after passing his requirement
---@param afterDialogId integer? The dialog ID toad is set to if you talk to him after he gives you his star
function add_toad_star_spawn(dialogId, starID, spawnRequirement, starRequirement, requirementDialogId, afterDialogId)
    spawnRequirement = spawnRequirement or function() return true end
    starRequirement = starRequirement or function() return true end
    requirementDialogId = requirementDialogId or dialogId
    afterDialogId = afterDialogId or dialogId
    toadStars[dialogId] = {
        spawnRequirement = spawnRequirement,
        starRequirement = starRequirement,
        starID = starID,
        requirementDialogId = requirementDialogId,
        afterDialogId = afterDialogId,
    }
end