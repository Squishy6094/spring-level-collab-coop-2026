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
#include "levels/ccm/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_ccm_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _ccm_segment_7SegmentRomStart, _ccm_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xb, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario), 
	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, ccm_area_1),
		WARP_NODE(0x0A, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_CASTLE_GROUNDS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		MARIO_POS(0x01, 0, 0, 118, -3762),
		OBJECT(E_MODEL_TODD, -432, -24, -6076, 0, 0, 0, (77 << 24), bhvToadMessage),
		OBJECT(MODEL_NONE, 0, 118, -3762, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		OBJECT(E_MODEL_TREEE, 716, 0, -6521, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, 3623, -1446, 560, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, 6447, -1430, 1215, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, 2697, -1588, 3755, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, -779, 0, -6521, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, 1077, 10, -6687, 0, 0, 0, 0x00000000, bhvTree),
		OBJECT(E_MODEL_TREEE, -1140, 10, -6687, 0, 0, 0, 0x00000000, bhvTree),
		TERRAIN(ccm_area_1_collision),
		MACRO_OBJECTS(ccm_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_LEVEL_SNOW),
		TERRAIN_TYPE(TERRAIN_SNOW),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),
	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 0, 118, -3762),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};