#include <ultra64.h>
#include "sm64.h"
#include "behavior_data.h"
#include "model_ids.h"
#include "seq_ids.h"
#include "dialog_ids.h"
#include "segment_symbols.h"
#include "level_commands.h"

#include "game/level_update.h"

#include "levels/scripts.h"

#include "make_const_nonconst.h"
#include "levels/rr/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_rr_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _rr_segment_7SegmentRomStart, _rr_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xb, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd), 
	LOAD_MIO0(0xa, _cloud_floor_skybox_mio0SegmentRomStart, _cloud_floor_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, rr_area_1),
		WARP_NODE(0x0A, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, LEVEL_RR, 0x01, 0x02, WARP_NO_CHECKPOINT),
		WARP_NODE(0x02, LEVEL_RR, 0x01, 0x01, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_BLUE_COIN_SWITCH, -3176, 921, -8587, 0, 0, 0, 0x00000000, id_bhvBlueCoinSwitch),
		OBJECT(E_MODEL_BLUE_COIN, -3421, 1002, -8587, 0, 0, 0, 0x00000000, id_bhvHiddenBlueCoin),
		OBJECT(E_MODEL_BLUE_COIN, -3421, 1002, -8587, 0, 0, 0, 0x00000000, id_bhvHiddenBlueCoin),
		OBJECT(E_MODEL_BLUE_COIN, -3559, 1002, -8587, 0, 0, 0, 0x00000000, id_bhvHiddenBlueCoin),
		OBJECT(E_MODEL_BLUE_COIN, -3703, 1002, -8587, 0, 0, 0, 0x00000000, id_bhvHiddenBlueCoin),
		OBJECT(E_MODEL_BLUE_COIN, -3862, 1002, -8587, 0, 0, 0, 0x00000000, id_bhvHiddenBlueCoin),
		OBJECT(E_MODEL_BOBOMB_BUDDY, -12794, 5667, 6339, 0, 0, 0, 0x00000000, id_bhvBobombBuddyOpensCannon),
		OBJECT(E_MODEL_PURPLE_SWITCH, -1174, 1963, -6147, 0, -45, 0, 0x00000000, id_bhvFloorSwitchHiddenObjects),
		OBJECT(E_MODEL_BREAKABLE_BOX, 10435, 3847, -2433, 0, 0, 0, 0x00000000, id_bhvBreakableBox),
		OBJECT(E_MODEL_BUTTERFLY, -12597, 5667, 5779, 0, 0, 0, 0x00000000, id_bhvTripletButterfly),
		OBJECT(E_MODEL_CANNON_BASE, 3697, 1857, 17, 0, -180, 0, (50 << 24) | (50 << 16) | (50 << 8) | (50), id_bhvCannonBarrel),
		OBJECT(E_MODEL_DL_CANNON_LID, 3707, 1930, 18, 0, 0, 0, 0x00000000, id_bhvCannonClosed),
		OBJECT(E_MODEL_YELLOW_COIN, -4033, 2231, 6161, 0, -180, 0, 0x00020000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -3901, 2231, 6161, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -3750, 2231, 6161, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -3601, 2231, 6161, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -9931, 2150, 5996, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -10064, 2150, 5996, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -9780, 2150, 5996, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -9632, 2150, 5996, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -10742, 3397, 5692, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -10875, 3397, 5692, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -10592, 3397, 5692, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -10443, 3397, 5692, 0, -180, 0, 0x00020000, id_bhvYellowCoin),
		OBJECT(E_MODEL_GOOMBA, 763, 970, -774, 0, 0, 0, 0x00000000, id_bhvGoomba),
		OBJECT(MODEL_NONE, -11181, 4938, 7659, 0, 0, 0, 0x00000000, id_bhvGoombaTripletSpawner),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 1233, -7049, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 1721, -7281, 0, -90, 0, 0x00000000, bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 3590, -7612, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 2138, -7568, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 2574, -7840, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 3015, -8071, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 3427, -7613, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		OBJECT(E_MODEL_BREAKABLE_BOX, -2895, 3278, -7613, 0, -90, 0, 0x00000000, id_bhvHiddenObject),
		MARIO_POS(0x01, -180, 0, 872, 6684),
		OBJECT(E_MODEL_RED_COIN, 9585, 4277, -437, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, 3617, 1073, 3953, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -1346, 1645, -6153, 0, -45, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -6287, 8453, 10676, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -11486, 3390, 5738, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -3428, 1726, -545, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, 10435, 3847, -2433, 0, 0, 0, 0x00000000, id_bhvRedCoin),
		OBJECT(E_MODEL_TRANSPARENT_STAR, -100, 1157, 3403, 0, 0, 0, 0x00000000, id_bhvRedCoinStarMarker),
		OBJECT(E_MODEL_SNUFIT, 6840, 3335, -31, 0, 0, 0, 0x00000000, id_bhvSnufit),
		OBJECT(E_MODEL_STAR, 7487, 4382, 1783, 0, 0, 0, 0x00000000, id_bhvStar),
		OBJECT(E_MODEL_STAR, -2808, 4255, -8361, 0, 0, 0, (1 << 24), id_bhvStar),
		OBJECT(E_MODEL_STAR, -7389, 7633, 10452, 0, 0, 0, (2 << 24), id_bhvStar),
		OBJECT(E_MODEL_BUBBLY_TREE, 241, 887, -986, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_BUBBLY_TREE, -3346, 854, -434, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_BUBBLY_TREE, -13036, 5667, 5771, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(MODEL_NONE, 0, 872, 6684, 0, -180, 0, 0x000A0000, bhvSpinAirborneWarp),
		OBJECT(MODEL_NONE, -5535, 4501, 8529, 0, 0, 0, 0x00010000, id_bhvWarp),
		OBJECT(MODEL_NONE, -22, 830, 6661, 0, -180, 0, 0x00020000, id_bhvWarp),
		TERRAIN(rr_area_1_collision),
		MACRO_OBJECTS(rr_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_SPOOKY),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, -180, 0, 872, 6684),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};