--wb level
--credits: kaktus for captain toad model, sunk for MOPS bhv, squishy and peachypeach for toad bhv,

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
        "RED COIN (TBD NAME)",
        "TBD 2",
        "TBD 3",
        "(TBD METAL CAP STAR)"
    },
})

gLevelValues.wingCapLookUpReq = 0
gBehaviorValues.ToadStar1Requirement = 0

--Models

E_MODEL_CAPTAIN_TOAD = smlua_model_util_get_id("captain_toad_geo")

E_MODEL_PINK_TOAD = smlua_model_util_get_id("pink_toad_geo")

E_MODEL_GREEN_TOAD = smlua_model_util_get_id("green_toad_geo")

E_MODEL_RISING_LAVA_PLATFORM = smlua_model_util_get_id("lava_rock_platform_geo")

--[[ Dialogs I've used/might use in the future

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

smlua_text_utils_dialog_replace(DIALOG_097, 1, 5, 30, 200, "This view looks great.\
You can press C-Up to look\
around! People have been\
murmoring about good luck\
from looking at the sky.")

-- Green Toad Dialog
smlua_text_utils_dialog_replace(DIALOG_016, 1, 5, 30, 200, "Gee, its super hot in here.\
I lost the others, they\
should be further up. Do\
you see those red coins?\
I've tried gathering some,\
but they are all out of\
reach. I'd appreciate help\
collecting them, but be\
careful!")

-- Pink Toad Dialog ()
smlua_text_utils_dialog_replace(DIALOG_068, 1, 4, 30, 200, "Oh, you found Green Toad?\
I was wondering where he\
went. I lost Captain Toad,\
but he should be further\
up. He said he was looking\
for some special treasure,\
but I have no idea what he\
meant by that.")

-- Captain Toad Dialog
smlua_text_utils_dialog_replace(DIALOG_082, 1, 4, 30, 200, "Thanks for finding me.\
I thought I was finished!\
Here, have this star I\
found!")

smlua_text_utils_dialog_replace(DIALOG_154, 1, 4, 30, 200, "I'd explore more, but I'm\
worn out. There should be\
more stars somewhere\
nearby though...")

-- Captain Toad Requirement
add_toad_star_spawn(DIALOG_082, 0, nil, nil, nil, DIALOG_154)

-- Behaviors
local function rising_lava_platform_init(o)
    network_init_object(o, true, { "oTimer" })
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = smlua_collision_util_get("lava_rock_platform_collision")
    o.oFaceAngleYaw = 0
    o.oVelY = 0
    obj_scale(o, 1)
    o.oHomeX = o.oPosX + 385
end

local function rising_lava_platform_loop(o)
load_object_collision_model()
if o.oBehParams2ndByte == 2
then
o.oVelY = (2 * (math.sin(o.oTimer * 0.065)))
end
if o.oBehParams2ndByte == 3
then
o.oVelY = (20 * (math.sin(o.oTimer * 0.06)))
end
if o.oBehParams2ndByte == 4
then
o.oVelY = (18 * (math.sin(o.oTimer * 0.02)))
end
o.oPosY = o.oPosY + o.oVelY
end

id_bhvRisingLavaPlatform = hook_behavior(id_bhvRisingLavaPlatform, OBJ_LIST_SURFACE, true, rising_lava_platform_init, rising_lava_platform_loop)