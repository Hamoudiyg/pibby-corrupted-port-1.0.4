#pragma header

uniform float iTime;
uniform float range;
uniform float noiseQuality;
uniform float noiseIntensity;
uniform float offsetIntensity;
uniform float colorR;
uniform float colorG;
uniform float colorB;

float rand(vec2 co)
{
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset)
{
    float edge0 = pos - range;
    float edge1 = pos + range;

    float x = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
    return x;
}

void main()
{
    vec2 uv = openfl_TextureCoordv;

    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        float d = mod(iTime * i, 1.7);
        float angle = mod(0.24 * iTime * i + 1.5707963, 3.14159265) - 1.5707963;
        float o = sin(1.0 - clamp(tan(angle), -20.0, 20.0)) * offsetIntensity;
        uv.x += verticalBar(d, uv.y, o);
    }

    float safeNoiseQ = max(noiseQuality, 1.0);
    float uvY = floor(uv.y * safeNoiseQ) / safeNoiseQ;
    float noise = rand(vec2(iTime * 0.00001, uvY));
    uv.x += noise * noiseIntensity;

    float wave = cos(iTime * 0.97) * 0.0073;
    vec2 offsetR = vec2(wave * colorR, 0.0);
    vec2 offsetG = vec2(wave * colorG, 0.0);
    vec2 offsetB = vec2(wave * colorB, 0.0);

    float r = flixel_texture2D(bitmap, uv + offsetR).r;
    float g = flixel_texture2D(bitmap, uv + offsetG).g;
    float b = flixel_texture2D(bitmap, uv + offsetB).b;
    float a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;

    gl_FragColor = vec4(r, g, b, a);
}