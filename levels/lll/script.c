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
#include "levels/lll/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_lll_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _lll_segment_7SegmentRomStart, _lll_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, lll_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE, 0x01, 0x32, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE, 0x01, 0x64, WARP_NO_CHECKPOINT),
		WARP_NODE(0x90, LEVEL_LLL, 0x02, 0x91, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF2, LEVEL_LLL, 0x02, 0x93, WARP_NO_CHECKPOINT),
		MARIO_POS(0x01, 65, -2184, 732, -2234),
		OBJECT(MODEL_WOODEN_SIGNPOST, 2189, 1464, 1066, 0, 45, 0, (77 << 24) | (DIALOG_153 << 16), bhvMessagePanel),
		OBJECT(MODEL_NONE, 1998, 1761, 1599, 0, -45, 0, (0x90 << 16), bhvWarp),
		OBJECT(MODEL_NONE, 1998, 1552, 1599, 0, -45, 0, (0x90 << 16), bhvWarp),
		OBJECT(MODEL_NONE, 2099, 1761, 1498, 0, -45, 0, (0x90 << 16), bhvWarp),
		OBJECT(MODEL_NONE, 2099, 1552, 1498, 0, -45, 0, (0x90 << 16), bhvWarp),
		OBJECT(MODEL_NONE, -2184, 732, -2234, 0, 65, 0, (0x0A << 16), bhvSpinAirborneWarp),
		TERRAIN(lll_area_1_collision),
		MACRO_OBJECTS(lll_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_GRASS),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(2, lll_area_2),
		WARP_NODE(0x0A, LEVEL_LLL, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE, 0x01, 0x32, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE, 0x01, 0x64, WARP_NO_CHECKPOINT),
		WARP_NODE(0x91, LEVEL_LLL, 0x01, 0x91, WARP_NO_CHECKPOINT),
		WARP_NODE(0x93, LEVEL_LLL, 0x02, 0x93, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_CAPTAIN_TOAD, -353, 0, 19, 0, 0, 0, 0x000A0000, bhvToadMessage),
		OBJECT(E_MODEL_GREEN_TOAD, -225, 0, 250, 0, 135, 0, (DIALOG_154 << 24), bhvToadMessage),
		OBJECT(MODEL_EXCLAMATION_BOX, 225, 0, 250, 0, 0, 0, (0x01 << 16), bhvExclamationBox),
		OBJECT(MODEL_NONE, 1747, 800, 319, 0, -90, 0, (0x93 << 16), bhvSpinAirborneWarp),
		OBJECT(E_MODEL_PINK_TOAD, -353, 0, 319, 0, 0, 0, (DIALOG_155 << 24), bhvToadMessage),
		OBJECT(MODEL_RED_COIN, -353, 0, 938, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_NONE, 72, 355, 938, 0, 0, 0, 0x00000000, bhvHiddenRedCoinStar),
		OBJECT(MODEL_NONE, 72, 0, 938, 0, 0, 0, 0x00000000, bhvRedCoinStarMarker),
		OBJECT(MODEL_RED_COIN, -353, 0, 1088, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -353, 0, 1238, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -353, 0, 1388, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -228, 0, 938, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -228, 0, 1088, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -228, 0, 1238, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_RED_COIN, -228, 0, 1388, 0, 0, 0, 0x000A0000, bhvRedCoin),
		OBJECT(MODEL_NONE, 0, 1512, 0, 0, 0, 0, (0x91 << 16), bhvAirborneWarp),
		TERRAIN(lll_area_2_collision),
		MACRO_OBJECTS(lll_area_2_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_UNDERGROUND),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 65, -2184, 732, -2234),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};