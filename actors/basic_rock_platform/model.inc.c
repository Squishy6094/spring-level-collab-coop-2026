Lights1 basic_rock_platform_basic_rock_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x28, 0x28, 0x28);

Texture basic_rock_platform_darker_inside_rock_rgba16[] = {
	#include "actors/basic_rock_platform/darker_inside_rock.rgba16.inc.c"
};

Vtx basic_rock_platform_basic_rock_platform_mesh_layer_1_vtx_cull[8] = {
	{{{-136, -697, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, 0, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, 0, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-136, -697, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{164, -697, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{164, 0, 115}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{164, 0, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{164, -697, -158}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
};

Vtx basic_rock_platform_basic_rock_platform_mesh_layer_1_vtx_0[24] = {
	{{{164, 0, 115}, 0, {196, 64}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{164, 0, -158}, 0, {-78, 64}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-136, 0, 115}, 0, {196, 364}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-136, 0, -158}, 0, {-78, 364}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{164, -697, 115}, 0, {196, 64}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-136, -697, 115}, 0, {196, 364}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{164, -697, -158}, 0, {470, 64}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-136, -697, -158}, 0, {470, 364}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-136, 0, -158}, 0, {1070, 1062}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{-136, -697, -158}, 0, {1070, 364}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{-136, -697, 115}, 0, {796, 364}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{-136, 0, 115}, 0, {796, 1062}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{164, 0, 115}, 0, {796, 1062}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{164, -697, 115}, 0, {796, 364}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{164, -697, -158}, 0, {522, 364}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{164, 0, -158}, 0, {522, 1062}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{164, 0, -158}, 0, {522, 1062}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{164, -697, -158}, 0, {522, 364}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-136, -697, -158}, 0, {222, 364}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-136, 0, -158}, 0, {222, 1062}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-136, 0, 115}, 0, {222, 1062}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-136, -697, 115}, 0, {222, 364}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{164, -697, 115}, 0, {-78, 364}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{164, 0, 115}, 0, {-78, 1062}, {0x00, 0x00, 0x7F, 0xFF}}},
};

Gfx basic_rock_platform_basic_rock_platform_mesh_layer_1_tri_0[] = {
	gsSPVertex(basic_rock_platform_basic_rock_platform_mesh_layer_1_vtx_0 + 0, 24, 0),
	gsSP2Triangles(0, 1, 2, 0, 2, 1, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 5, 7, 6, 0),
	gsSP2Triangles(8, 9, 10, 0, 8, 10, 11, 0),
	gsSP2Triangles(12, 13, 14, 0, 12, 14, 15, 0),
	gsSP2Triangles(16, 17, 18, 0, 16, 18, 19, 0),
	gsSP2Triangles(20, 21, 22, 0, 20, 22, 23, 0),
	gsSPEndDisplayList(),
};


Gfx mat_basic_rock_platform_basic_rock[] = {
	gsSPSetLights1(basic_rock_platform_basic_rock_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT, TEXEL0, 0, SHADE, 0, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, basic_rock_platform_darker_inside_rock_rgba16),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 0, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0, G_TX_WRAP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};

Gfx mat_revert_basic_rock_platform_basic_rock[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx basic_rock_platform_basic_rock_platform_mesh_layer_1[] = {
	gsSPClearGeometryMode(G_LIGHTING),
	gsSPVertex(basic_rock_platform_basic_rock_platform_mesh_layer_1_vtx_cull + 0, 8, 0),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPCullDisplayList(0, 7),
	gsSPDisplayList(mat_basic_rock_platform_basic_rock),
	gsSPDisplayList(basic_rock_platform_basic_rock_platform_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_basic_rock_platform_basic_rock),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};

