shader_type canvas_item;

uniform vec4 icon_colour:source_color = vec4(1.0);

void fragment() {
	COLOR.rgb = icon_colour.rgb;
}
