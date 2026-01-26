add_level_data({
    name = "Heart of the Fire",
    creator = "WBmarioo",
    id = LEVEL_LLL,
    hubPos = {x = -900, y = 600, z = -600},
    painting = 0,
    music = 0,
    stars = { --WB for future reference these all need to be uppercase -kaktus
        "SAVING CAPTAIN TOAD",
        "TBD 1",
        "Red Coin (TBD Name)",
        "TBD 2",
        "TBD 3",
        "(TBD Metal Cap Star)"
    },
})

gLevelValues.wingCapLookUpReq = 0
gBehaviorValues.ToadStar1Requirement = 0

E_MODEL_CAPTAIN_TOAD = smlua_model_util_get_id("captain_toad_geo")

E_MODEL_PINK_TOAD = smlua_model_util_get_id("pink_toad_geo")

E_MODEL_GREEN_TOAD = smlua_model_util_get_id("green_toad_geo")

-- Make it so toads never spawn stars through vanilla means
gBehaviorValues.dialogs.ToadStar1Dialog = -1
gBehaviorValues.dialogs.ToadStar2Dialog = -1
gBehaviorValues.dialogs.ToadStar3Dialog = -1

-- Replace with a much more customizable toad system
local toadStars = {
    [DIALOG_082] = {
        requirement = function()
            return true
        end,
        starID = 1,
        afterDialog = DIALOG_154
    }
}


local saveFile = get_current_save_file_num() - 1
---@param o Object
local function bhv_toad_message_init(o)
    if (not o) then return end
    o.oInteractType = INTERACT_TEXT
    o.oFlags = (OBJ_FLAG_PERSISTENT_RESPAWN | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    djui_chat_message_create("init")
    local dialogId = (o.oBehParams >> 24) & 0xFF;
    local requirement = true;

    if toadStars[dialogId] ~= nil then
        if toadStars[dialogId].requirement == nil then
            requirement = toadStars[dialogId].requirement()
            if save_file_get_star_flags(saveFile, gNetworkPlayers[0].currCourseNum - 1) & (1 << (toadStars[dialogId].starID - 1)) ~= 0 and toadStars[dialogId].afterDialog ~= nil then
                o.oToadMessageDialogId = toadStars[dialogId].afterDialog;
            end
        end
    end

    if (requirement) then
        djui_chat_message_create("bing")
        o.oToadMessageDialogId = dialogId;
        o.oToadMessageRecentlyTalked = 0;
        o.oToadMessageState = 0;
        o.oOpacity = 81;
    else
        obj_mark_for_deletion(o);
    end
end

---@param o Object
local function custom_toad_message_talking(o)
    if (not o) then return end
    local dialogId = o.oToadMessageDialogId;
    if toadStars[dialogId] ~= nil then
        if toadStars[dialogId].requirement == nil or toadStars[dialogId].requirement() then
            if toadStars[dialogId].starID ~= nil then
                bhv_spawn_star_no_level_exit(gMarioStates[0].marioObj, toadStars[dialogId].starID, 1);
            end
            if toadStars[dialogId].afterDialog ~= nil then
                o.oToadMessageDialogId = toadStars[dialogId].afterDialog;
            end
        end
    end
end

---@param o Object
local function bhv_toad_message_loop(o)
    if (not o) then return end
    djui_chat_message_create("hooked")
    if (o.header.gfx.node.flags & GRAPH_RENDER_ACTIVE ~= 0) then
        o.oInteractionSubtype = 0;
        djui_chat_message_create("sup")
        if o.oToadMessageState == 4 --[[TOAD_MESSAGE_TALKING]] then
            djui_chat_message_create("oh shit")
            custom_toad_message_talking(o);
        end
    end
end

hook_behavior(id_bhvToadMessage, OBJ_LIST_GENACTOR, false, bhv_toad_message_init, bhv_toad_message_loop)

--[[ Dialogs I should use
* DIALOG_097 from LLL (used)
* DIALOG_016 from LLL (used)
* DIALOG_068 from LLL (used)
* DIALOG_086 from LLL (availible)

-- Please nobody use these (for toad castle stars)
#define TOAD_STAR_1_DIALOG DIALOG_082
#define TOAD_STAR_2_DIALOG DIALOG_076
#define TOAD_STAR_3_DIALOG DIALOG_083

#define TOAD_STAR_1_DIALOG_AFTER DIALOG_154
#define TOAD_STAR_2_DIALOG_AFTER DIALOG_155
#define TOAD_STAR_3_DIALOG_AFTER DIALOG_156


--]]

smlua_text_utils_dialog_replace(DIALOG_097, 1, 4, 30, 200, "This view looks great.\
You can press C-Up to look\
around! If you see a star,\
look up at it, it means\
good luck!")

-- Green Toad Dialog
smlua_text_utils_dialog_replace(DIALOG_016, 1, 4, 30, 200, "Gee, its super hot in here.\
I lost the others, they\
should be further up.\
Be careful!")

-- Pink Toad Dialog
smlua_text_utils_dialog_replace(DIALOG_068, 1, 4, 30, 200, "I hate green toad.\
Literally hue shifted me,\
lame as piss!!!")

-- Captain Toad Dialog
smlua_text_utils_dialog_replace(DIALOG_082, 1, 4, 30, 200, "Thanks for finding me.\
I thought I was finished!\
Here, have this star I\
found!")

smlua_text_utils_dialog_replace(DIALOG_154, 1, 4, 30, 200, "I'd explore more,\
but I'm worn out. There\
should be more stars\
somewhere around...")