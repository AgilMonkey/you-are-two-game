shader_type canvas_item;

uniform float strength = 0.5;

void vertex() {
	if (VERTEX.y == 0.0)
    	VERTEX.x += strength * 10.0;
}