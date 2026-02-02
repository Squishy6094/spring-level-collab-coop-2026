#include "src/game/envfx_snow.h"

const GeoLayout question_coin_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, question_coin___Coin_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, question_coin___Coin_mesh_layer_5),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
