#pragma header

uniform float iTime;
uniform float brightness;
uniform float contrast;
uniform float saturation;

mat4 brightnessMatrix(float b)
{
    return mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        b,   b,   b,   1.0
    );
}

mat4 contrastMatrix(float c)
{
    float t = (1.0 - c) / 2.0;
    return mat4(
        c,   0.0, 0.0, 0.0,
        0.0, c,   0.0, 0.0,
        0.0, 0.0, c,   0.0,
        t,   t,   t,   1.0
    );
}

mat4 saturationMatrix(float s)
{
    vec3 luminance = vec3(0.3086, 0.6094, 0.0820);
    float oneMinusSat = 1.0 - s;

    vec3 red = vec3(luminance.x * oneMinusSat) + vec3(s, 0.0, 0.0);
    vec3 green = vec3(luminance.y * oneMinusSat) + vec3(0.0, s, 0.0);
    vec3 blue = vec3(luminance.z * oneMinusSat) + vec3(0.0, 0.0, s);

    return mat4(
        red,   0.0,
        green, 0.0,
        blue,  0.0,
        0.0,   0.0, 0.0, 1.0
    );
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
    vec4 color = flixel_texture2D(bitmap, uv);

    vec4 result = brightnessMatrix(brightness) *
                  contrastMatrix(contrast) *
                  saturationMatrix(saturation) *
                  color;
    result.a = color.a;
    gl_FragColor = result;
}