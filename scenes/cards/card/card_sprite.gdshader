shader_type canvas_item;

uniform vec4 border_colour:source_color = vec4(1.0);

void fragment() {
	float is_border = max(
		max(step(UV.x, 0.03), step(0.97, UV.x)),
		max(step(UV.y, 0.02), step(0.98, UV.y))
	);

	COLOR = mix(COLOR, border_colour, is_border);
}
