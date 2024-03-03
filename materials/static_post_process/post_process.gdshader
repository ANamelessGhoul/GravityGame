shader_type canvas_item;

uniform float static_amount : hint_range(0, 1) = 0.0;

float rand(vec2 uv)
{
    float noise = (fract(sin(dot(uv ,vec2(12.9898,78.233)*2.0)) * 43758.5453));
    return noise;
}

void fragment(){
	vec3 static = vec3((rand(UV + vec2(sin(TIME)))));
	COLOR.rgb = mix(texture(TEXTURE, UV).rgb, static, static_amount);
	
}