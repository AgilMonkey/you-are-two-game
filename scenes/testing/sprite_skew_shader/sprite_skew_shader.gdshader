shader_type canvas_item;

uniform float strength = 0.0;

void vertex() {
	if (VERTEX.y < 1.0) {
		VERTEX.x += strength;
	}
}