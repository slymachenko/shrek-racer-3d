shader_type spatial;

render_mode depth_prepass_alpha;
render_mode cull_disabled;
render_mode unshaded;

uniform vec3 base_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float strengh : hint_range(0.0, 1.0) = 0.2;
uniform float weight : hint_range(0.1, 10.0) = 0.2;
uniform bool invert = false;

varying float gradient;

void vertex() {
	float inverter = 1.0;
	if (invert) {
		inverter = -1.0;
	}
	
	gradient = (VERTEX.y - weight) * strengh * inverter;
}

void fragment() {
	ALBEDO = base_color;
	ALPHA = gradient;
}
