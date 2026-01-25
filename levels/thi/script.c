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
#include "levels/thi/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_thi_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _thi_segment_7SegmentRomStart, _thi_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	JUMP_LINK(script_func_global_12), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, thi_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_GOOMBA, 822, -74, -2096, 0, 0, 0, (1 << 16), id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, -164, -200, -2440, 0, 0, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, 387, -190, -2906, 0, 0, 0, 0x00000000, id_bhvGoomba),
		MARIO_POS(0x01, 0, -410, -207, 0),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, 3449, -496, 1135, 0, -39, 0, (19 << 24) | (19 << 16) | (19 << 8) | (19), id_bhvMessagePanel),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, -4324, -320, -4099, 0, 56, 0, (78 << 24) | (78 << 16) | (78 << 8) | (78), id_bhvMessagePanel),
		OBJECT(E_MODEL_TOAD, 218, -408, 53, 0, -119, 0, (8 << 24), id_bhvToadMessage),
		OBJECT(E_MODEL_TOAD, 2131, -496, 2605, 0, 154, 0, (18 << 24), id_bhvToadMessage),
		OBJECT(MODEL_NONE, -410, -207, 0, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		OBJECT(E_MODEL_WIGGLER_HEAD, 3582, 855, -3101, 0, 0, 0, 0x00000000, id_bhvWigglerHead),
		TERRAIN(thi_area_1_collision),
		MACRO_OBJECTS(thi_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_GRASS),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, -410, -207, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};