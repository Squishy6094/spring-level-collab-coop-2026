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
#include "levels/ttm/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_ttm_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _ttm_segment_7SegmentRomStart, _ttm_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _clouds_skybox_mio0SegmentRomStart, _clouds_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, ttm_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x84, LEVEL_TTM, 0x02, 0x0A, WARP_CHECKPOINT),
		OBJECT(E_MODEL_HMC_WOODEN_DOOR, 330, 99, 197, 0, -90, 0, 0x00000000, bhvDoor),
		OBJECT(MODEL_NONE, 4609, 427, 90, 0, -17, 0, (0x84 << 16), id_bhvWarp),
		OBJECT(MODEL_NONE, 5175, 327, 367, 0, -20, 0, (0x46 << 16), id_bhvInstantActiveWarp),
		MARIO_POS(0x01, 0, 600, 1100, -200),
		OBJECT(E_MODEL_TREETOPS_PLATFORM_MOVING, 934, 662, 2, 0, 0, 0, 0x00000000, id_bhvJungleMovingPlatform),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, 480, 99, 488, 0, 90, 0, (77 << 24), bhvMessagePanel),
		OBJECT(MODEL_NONE, 600, 1100, -200, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		TERRAIN(ttm_area_1_collision),
		MACRO_OBJECTS(ttm_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_EVENT_PEACH_MESSAGE),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(2, ttm_area_2),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x46, LEVEL_TTM, 0x01, 0x46, WARP_NO_CHECKPOINT),
		WARP_NODE(0x96, LEVEL_TTM, 0x02, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_NONE, -692, -88, 0, 0, 0, 0, (0x12 << 24) | (0x46 << 16), bhvWarp),
		MARIO_POS(0x01, 90, -300, 0, 0),
		OBJECT(MODEL_NONE, 555, -2578, 0, 0, 0, 0, (0x60 << 24) | (0x96 << 16), bhvWarp),
		OBJECT(E_MODEL_TTC_ROTATING_CUBE, 1279, 464, 0, 0, 0, 0, 0x00000000, bhvTTCRotatingSolid),
		OBJECT(MODEL_NONE, -300, 0, 0, 0, 90, 0, 0x000A0000, bhvSpinAirborneWarp),
		TERRAIN(ttm_area_2_collision),
		MACRO_OBJECTS(ttm_area_2_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_GRASS),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 90, -300, 0, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};