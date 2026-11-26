#pragma header

uniform float iTime;
uniform float AMT;   // 0 - 1 glitch amount
uniform float SPEED; // 0 - 1 speed

float random2d(vec2 n)
{
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange(in vec2 seed, in float minVal, in float maxVal)
{
    return minVal + random2d(seed) * (maxVal - minVal);
}

float insideRange(float v, float bottom, float top)
{
    return step(bottom, v) - step(top, v);
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
    float time = floor(iTime * SPEED * 60.0);

    vec3 outCol = flixel_texture2D(bitmap, uv).rgb;
    float maxOffset = AMT / 2.0;
    float activeSlices = 10.0 * AMT;

    for (int i = 0; i < 10; i++)
    {
        if (float(i) < activeSlices)
        {
            float fi = float(i);
            float sliceY = random2d(vec2(time, 2345.0 + fi));
            float sliceH = random2d(vec2(time, 9035.0 + fi)) * 0.25;
            float hOffset = randomRange(vec2(time, 9625.0 + fi), -maxOffset, maxOffset);
            vec2 uvOff = uv;
            uvOff.x = fract(uvOff.x + hOffset);
            if (insideRange(uv.y, sliceY, fract(sliceY + sliceH)) == 1.0)
            {
                outCol = flixel_texture2D(bitmap, uvOff).rgb;
            }
        }
    }

    float maxColOffset = AMT / 6.0;
    float rnd = random2d(vec2(time, 9545.0));
    vec2 colOffset = vec2(
        randomRange(vec2(time, 9545.0), -maxColOffset, maxColOffset),
        randomRange(vec2(time, 7205.0), -maxColOffset, maxColOffset)
    );

    if (rnd < 0.33)
    {
        outCol.r = flixel_texture2D(bitmap, uv + colOffset).r;
    }
    else if (rnd < 0.66)
    {
        outCol.g = flixel_texture2D(bitmap, uv + colOffset).g;
    }
    else
    {
        outCol.b = flixel_texture2D(bitmap, uv + colOffset).b;
    }

    gl_FragColor = vec4(outCol, flixel_texture2D(bitmap, uv).a);
}