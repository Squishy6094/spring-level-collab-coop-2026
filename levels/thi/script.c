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
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x94, LEVEL_THI, 0x02, 0x95, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_GOOMBA, 2240, -74, -2151, 0, 0, 0, (1 << 16), id_bhvGoomba),
		OBJECT(E_MODEL_NONE, 2965, -478, 860, 0, 0, 0, (0x94 << 16), id_bhvWarp),
		OBJECT(E_MODEL_YELLOW_COIN, 1176, 182, -2758, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1529, 353, -3409, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 2079, 560, -3020, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 2471, 788, -3472, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 6844, -393, -1459, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 6548, -393, -1278, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 6370, -393, -970, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 6280, -393, -601, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 6370, -393, -202, 0, 0, 0, (1 << 16), id_bhvYellowCoin),
		OBJECT(E_MODEL_GOOMBA, -164, -200, -2440, 0, 0, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, -3017, -200, -1302, 0, 0, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, 1209, -190, -2238, 0, 0, 0, 0x00000000, id_bhvGoomba),
		MARIO_POS(0x01, 0, -410, -207, 0),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, 3449, -496, 1135, 0, -39, 0, (19 << 24) | (19 << 16) | (19 << 8) | (19), id_bhvMessagePanel),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, -4044, -589, -4153, 0, 56, 0, (78 << 24) | (78 << 16) | (78 << 8) | (78), id_bhvMessagePanel),
		OBJECT(E_MODEL_WOODEN_SIGNPOST, -4831, -398, 3104, 0, 98, 0, (78 << 24) | (78 << 16) | (78 << 8) | (78), id_bhvMessagePanel),
		OBJECT(E_MODEL_STAR, 3586, 1057, -3102, 0, 0, 0, 0x00000000, id_bhvStar),
		OBJECT(E_MODEL_TOAD, 218, -408, 53, 0, -119, 0, (8 << 24), id_bhvToadMessage),
		OBJECT(E_MODEL_TOAD, 2131, -496, 2605, 0, 154, 0, (18 << 24), id_bhvToadMessage),
		OBJECT(E_MODEL_KOOPA_SHELL, 5561, -288, -1614, 0, 0, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(E_MODEL_NONE, 124, -126, 291, 0, 0, 0, (2 << 24) | (2 << 16) | (2 << 8), id_bhvHiddenStar),
		OBJECT(MODEL_NONE, -410, -207, 0, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		TERRAIN(thi_area_1_collision),
		MACRO_OBJECTS(thi_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_GRASS),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	AREA(2, thi_area_2),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x95, LEVEL_THI, 0x01, 0x94, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_EXCLAMATION_BOX, 5109, 787, 962, 0, 56, 0, (6 << 16), id_bhvExclamationBox),
		OBJECT(E_MODEL_YELLOW_COIN, 2182, 196, 1034, 0, 56, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1925, 196, 798, 0, 56, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1795, 196, 505, 0, 56, 0, 0x00000000, id_bhvOneCoin),
		MARIO_POS(0x01, 0, -410, 1839, -1668),
		OBJECT(E_MODEL_SCUTTLEBUG, 5335, 520, -361, 0, 56, 0, 0x00000000, id_bhvScuttlebug),
		OBJECT(E_MODEL_SCUTTLEBUG, 892, 109, -1245, 0, 56, 0, 0x00000000, id_bhvScuttlebug),
		OBJECT(E_MODEL_SCUTTLEBUG, 3579, 328, 1314, 0, 56, 0, 0x00000000, id_bhvScuttlebug),
		OBJECT(E_MODEL_STAR, 4097, 1107, -774, 0, 56, 0, (3 << 24) | (3 << 16) | (3 << 8), id_bhvStar),
		OBJECT(MODEL_NONE, -410, 1839, -1668, 0, 90, 0, (0x95 << 16), bhvSpinAirborneWarp),
		TERRAIN(thi_area_2_collision),
		MACRO_OBJECTS(thi_area_2_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_UNDERGROUND),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, -410, 1839, -1668),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};