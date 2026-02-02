#include "src/game/envfx_snow.h"

const GeoLayout rainbow_note_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, rainbow_note_Rainbow_Note_mesh_layer_1),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
