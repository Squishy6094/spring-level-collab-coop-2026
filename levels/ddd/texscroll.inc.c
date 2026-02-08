void scroll_ddd_dl_Sphere_mesh_layer_1_vtx_0() {
	int i = 0;
	int count = 383;
	int width = 64 * 0x20;

	static int currentX = 0;
	int deltaX;
	Vtx *vertices = segmented_to_virtual(ddd_dl_Sphere_mesh_layer_1_vtx_0);

	deltaX = (int)(1.5099995136260986 * 0x20) % width;

	if (absi(currentX) > width) {
		deltaX -= (int)(absi(currentX) / width) * width * signum_positive(deltaX);
	}

	for (i = 0; i < count; i++) {
		vertices[i].n.tc[0] += deltaX;
	}
	currentX += deltaX;
}

void scroll_ddd() {
	scroll_ddd_dl_Sphere_mesh_layer_1_vtx_0();
};
