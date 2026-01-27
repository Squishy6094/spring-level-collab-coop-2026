Lights1 lava_rock_platform_lava_rock_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x28, 0x28, 0x28);

Texture lava_rock_platform_lava_rock_rgba16[] = {
	#include "actors/lava_rock_platform/lava_rock.rgba16.inc.c"
};

Vtx lava_rock_platform_lava_rock_platform_mesh_layer_1_vtx_cull[8] = {
	{{{-136, -697, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, 0, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, 0, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, -697, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{95, -697, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{95, 0, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{95, 0, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{95, -697, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
};

Vtx lava_rock_platform_lava_rock_platform_mesh_layer_1_vtx_0[18] = {
	{{{95, -697, 115}, 0, {1212, 1199}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-136, -697, 90}, 0, {767, 1152}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{39, -697, -158}, 0, {1104, 673}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{95, 0, 115}, 0, {1212, 1199}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{39, 0, -158}, 0, {1104, 673}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-136, 0, 90}, 0, {767, 1152}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{39, -697, -158}, 0, {1363, 1679}, {0x98, 0x00, 0xB7, 0xFF}}},
	{{{-136, 0, 90}, 0, {884, 337}, {0x98, 0x00, 0xB7, 0xFF}}},
	{{{39, 0, -158}, 0, {1363, 337}, {0x98, 0x00, 0xB7, 0xFF}}},
	{{{-136, -697, 90}, 0, {884, 1679}, {0x98, 0x00, 0xB7, 0xFF}}},
	{{{95, 0, 115}, 0, {836, 337}, {0x7C, 0x00, 0xE6, 0xFF}}},
	{{{39, -697, -158}, 0, {1363, 1679}, {0x7C, 0x00, 0xE6, 0xFF}}},
	{{{39, 0, -158}, 0, {1363, 337}, {0x7C, 0x00, 0xE6, 0xFF}}},
	{{{95, -697, 115}, 0, {836, 1679}, {0x7C, 0x00, 0xE6, 0xFF}}},
	{{{-136, -697, 90}, 0, {767, 1679}, {0xF2, 0x00, 0x7E, 0xFF}}},
	{{{95, 0, 115}, 0, {1212, 337}, {0xF2, 0x00, 0x7E, 0xFF}}},
	{{{-136, 0, 90}, 0, {767, 337}, {0xF2, 0x00, 0x7E, 0xFF}}},
	{{{95, -697, 115}, 0, {1212, 1679}, {0xF2, 0x00, 0x7E, 0xFF}}},
};

Gfx lava_rock_platform_lava_rock_platform_mesh_layer_1_tri_0[] = {
	gsSPVertex(lava_rock_platform_lava_rock_platform_mesh_layer_1_vtx_0 + 0, 18, 0),
	gsSP2Triangles(0, 1, 2, 0, 3, 4, 5, 0),
	gsSP2Triangles(6, 7, 8, 0, 6, 9, 7, 0),
	gsSP2Triangles(10, 11, 12, 0, 10, 13, 11, 0),
	gsSP2Triangles(14, 15, 16, 0, 14, 17, 15, 0),
	gsSPEndDisplayList(),
};


Gfx mat_lava_rock_platform_lava_rock[] = {
	gsSPSetLights1(lava_rock_platform_lava_rock_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, lava_rock_platform_lava_rock_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 4095, 128),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 16, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0, G_TX_WRAP | G_TX_NOMIRROR, 6, 0),
	gsDPSetTileSize(0, 0, 0, 252, 252),
	gsSPEndDisplayList(),
};

Gfx mat_revert_lava_rock_platform_lava_rock[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx lava_rock_platform_lava_rock_platform_mesh_layer_1[] = {
	gsSPClearGeometryMode(G_LIGHTING),
	gsSPVertex(lava_rock_platform_lava_rock_platform_mesh_layer_1_vtx_cull + 0, 8, 0),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPCullDisplayList(0, 7),
	gsSPDisplayList(mat_lava_rock_platform_lava_rock),
	gsSPDisplayList(lava_rock_platform_lava_rock_platform_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_lava_rock_platform_lava_rock),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

