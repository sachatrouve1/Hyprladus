//modified version of [this shader](https://github.com/wessles/GLSL-CRT/blob/master/shader.frag)
#version 300 es

precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 FragColor;

const vec3 VIB_RGB_BALANCE = vec3(1.0, 1.0, 1.0);
const float VIB_VIBRANCE = 0.40;

const vec3 VIB_coeffVibrance = VIB_RGB_BALANCE * -VIB_VIBRANCE;

void main() {
	vec2 tc = vec2(v_texcoord.x, v_texcoord.y);

	// Distance from the center
	float dx = abs(0.5 - tc.x);
	float dy = abs(0.5 - tc.y);

	// Square it to smooth the edges
	dx *= dx;
	dy *= dy;

	tc.x -= 0.5;
	tc.x *= 1.0 + (dy * 0.05);
	tc.x += 0.5;

	tc.y -= 0.5;
	tc.y *= 1.0 + (dx * 0.18);
	tc.y += 0.5;

	// Get texel, and add in scanline if need be
	vec4 cta = texture(tex, vec2(tc.x, tc.y));

	cta.rgb += sin(tc.y * 1250.0) * 0.02;

	// Cutoff
	if (tc.y > 1.0 || tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0)
		cta = vec4(0.0);

	// RGB
	vec3 color = vec3(cta[0], cta[1], cta[2]);

	vec3 VIB_coefLuma = vec3(0.212656, 0.715158, 0.072186);
	float luma = dot(VIB_coefLuma, color);
	float max_color = max(color[0], max(color[1], color[2]));
	float min_color = min(color[0], min(color[1], color[2]));
	float color_saturation = max_color - min_color;

	vec3 p_col = vec3(vec3(vec3(vec3(sign(VIB_coeffVibrance) * color_saturation) - 1.0) * VIB_coeffVibrance) + 1.0);

	cta[0] = mix(luma, color[0], p_col[0]);
	cta[1] = mix(luma, color[1], p_col[1]);
	cta[2] = mix(luma, color[2], p_col[2]);

	// --- FXAA PASS -----------------------------------------------------
	vec2 texel = 1.0 / vec2(textureSize(tex, 0));
	vec3 rgbNW = texture(tex, tc + vec2(-1.0, -1.0) * texel).rgb;
	vec3 rgbNE = texture(tex, tc + vec2(1.0, -1.0) * texel).rgb;
	vec3 rgbSW = texture(tex, tc + vec2(-1.0, 1.0) * texel).rgb;
	vec3 rgbSE = texture(tex, tc + vec2(1.0, 1.0) * texel).rgb;
	vec3 rgbM = cta.rgb;

	vec3 lumaWeights = vec3(0.299, 0.587, 0.114);
	float lumaNW = dot(rgbNW, lumaWeights);
	float lumaNE = dot(rgbNE, lumaWeights);
	float lumaSW = dot(rgbSW, lumaWeights);
	float lumaSE = dot(rgbSE, lumaWeights);
	float lumaM = dot(rgbM, lumaWeights);

	float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
	float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));

	vec2 dir;
	dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
	dir.y = ((lumaNW + lumaSW) - (lumaNE + lumaSE));

	float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) * (0.25 * 0.0312), 0.0078125);
	float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
	dir = clamp(dir * rcpDirMin, vec2(-8.0), vec2(8.0)) * texel;

	vec3 rgbA = 0.5 * (
		texture(tex, tc + dir * (1.0 / 3.0 - 0.5)).rgb +
		texture(tex, tc + dir * (2.0 / 3.0 - 0.5)).rgb);
	vec3 rgbB = rgbA * 0.5 + 0.25 * (
		texture(tex, tc + dir * -0.5).rgb +
		texture(tex, tc + dir * 0.5).rgb);

	float lumaB = dot(rgbB, lumaWeights);
	vec3 finalColor = (lumaB < lumaMin || lumaB > lumaMax) ? rgbA : rgbB;
	// -------------------------------------------------------------------

	FragColor = vec4(finalColor, 1.0);
}
