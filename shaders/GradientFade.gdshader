shader_type spatial;

render_mode cull_disabled;
render_mode unshaded;

uniform vec3 base_color : source_color = vec3(1.0, 1.0, 1.0);
uniform vec3 aabb = vec3(1.0, 2.0, 1.0);

varying float gradient;

void vertex() {
	gradient = 1.0 - clamp(VERTEX.y / aabb.y, 0, 1.0);
}

void fragment() {
	
	ALBEDO = base_color;
	ALPHA = gradient;
}
