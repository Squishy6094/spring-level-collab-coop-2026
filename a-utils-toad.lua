-- Custom Toad Behavior to allow for very customizable star requirements
local TOAD_MESSAGE_FADED = 0
local TOAD_MESSAGE_OPAQUE = 1
local TOAD_MESSAGE_OPACIFYING = 2
local TOAD_MESSAGE_FADING = 3
local TOAD_MESSAGE_TALKING = 4

local saveFile = get_current_save_file_num() - 1

-- Replace with a much more customizable toad system
local toadStars = {}
---@param o Object
local function toad_message_faded(o)
    if (not o) then return end
    if (o.oDistanceToMario > 700.0) then
        o.oToadMessageRecentlyTalked = 0;
    end
    if (o.oToadMessageRecentlyTalked == 0 and o.oDistanceToMario < 600.0) then
        o.oToadMessageState = TOAD_MESSAGE_OPACIFYING;
    end
end

---@param o Object
local function toad_message_opaque(o)
    if (not o) then return end
    if (o.oDistanceToMario > 700.0) then
        o.oToadMessageState = TOAD_MESSAGE_FADING;
    elseif (o.oToadMessageRecentlyTalked == 0) then
        o.oInteractionSubtype = INT_SUBTYPE_NPC;
        if (o.oInteractStatus & INT_STATUS_INTERACTED ~= 0) then
            o.oInteractStatus = 0;
            o.oToadMessageState = TOAD_MESSAGE_TALKING;
            play_toads_jingle();
        end
    end
end

---@param o Object
local function toad_message_talking(o)
    if (not o) then return end
    local dialogId = (o.oBehParams >> 24) & 0xFF;
    if toadStars[dialogId] ~= nil then
        djui_chat_message_create(tostring(toadStars[dialogId].starRequirement()))
        if toadStars[dialogId].starRequirement() then
            bhv_spawn_star_no_level_exit(gMarioStates[0].marioObj, toadStars[dialogId].starID, 1);
            local collectedStar = save_file_get_star_flags(saveFile, gNetworkPlayers[0].currCourseNum - 1) & (1 << (toadStars[dialogId].starID)) ~= 0
            o.oToadMessageDialogId = collectedStar and toadStars[dialogId].afterDialog or toadStars[dialogId].requirementsDialog
        end
    end
end

---@param o Object
local function toad_message_opacifying(o)
    if (not o) then return end
    o.oOpacity = o.oOpacity + 6 
    if (o.oOpacity == 255) then
        o.oToadMessageState = TOAD_MESSAGE_OPAQUE;
    end
end

---@param o Object
local function toad_message_fading(o)
    if (not o) then return end
    o.oOpacity = o.oOpacity - 6 
    if (o.oOpacity == 81) then
        o.oToadMessageState = TOAD_MESSAGE_FADED;
    end
end

function bhv_custom_toad_message_init(o)
    if (not o) then return end
    local dialogId = (o.oBehParams >> 24) & 0xFF;
    local spawnRequirement = true;
    local starRequirement = true;

    if toadStars[dialogId] ~= nil then
        if toadStars[dialogId].spawnRequirement ~= nil then
            spawnRequirement = toadStars[dialogId].spawnRequirement()
        end
        local collectedStar = save_file_get_star_flags(saveFile, gNetworkPlayers[0].currCourseNum - 1) & (1 << (toadStars[dialogId].starID)) ~= 0
        if collectedStar then
            dialogId = toadStars[dialogId].afterDialogId or o.oToadMessageDialogId;
        end
    end

    if (spawnRequirement) then -- typically star requirement
        o.oToadMessageDialogId = dialogId;
        o.oToadMessageRecentlyTalked = 0;
        o.oToadMessageState = TOAD_MESSAGE_FADED;
        o.oOpacity = 81;
    else
        obj_mark_for_deletion(o);
    end
end

function bhv_custom_toad_message_loop(o)
    if (not o) then return end
    if (o.header.gfx.node.flags & GRAPH_RENDER_ACTIVE ~= 0) then
        o.oInteractionSubtype = 0;
        if o.oToadMessageState == TOAD_MESSAGE_FADED then
            toad_message_faded(o);
        elseif o.oToadMessageState == TOAD_MESSAGE_OPAQUE then
            toad_message_opaque(o);
        elseif o.oToadMessageState == TOAD_MESSAGE_OPACIFYING then
            toad_message_opacifying(o);
        elseif o.oToadMessageState == TOAD_MESSAGE_FADING then
            toad_message_fading(o);
        elseif o.oToadMessageState == TOAD_MESSAGE_TALKING then
            toad_message_talking(o);
        end
    end
    djui_chat_message_create(tostring(o.oToadMessageState))
end

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