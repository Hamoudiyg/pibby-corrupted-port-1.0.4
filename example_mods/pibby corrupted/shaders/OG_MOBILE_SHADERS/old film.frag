#pragma header

uniform float iTime;

vec2 hash2(vec2 p)
{
    vec3 p3 = fract(vec3(p.xyx) * vec3(166.1031, 147.1030, 142.0973));
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.xx + p3.yz) * p3.zy);
}

float simplexNoise(vec2 uv)
{
    const float k1 = 0.366025;
    const float k2 = 0.211324;

    ivec2 idx = ivec2(floor(uv + (uv.x + uv.y) * k1));
    vec2 a = uv - (vec2(idx) - float(idx.x + idx.y) * k2);
    ivec2 tb = a.y > a.x ? ivec2(0, 1) : ivec2(1, 0);
    vec2 b = a - vec2(tb) + k2;
    vec2 c = a - 1.0 + k2 * 2.0;

    vec3 kernel = max(0.5 - vec3(dot(a, a), dot(b, b), dot(c, c)), 0.0);
    vec3 noiseVal = kernel * kernel * kernel * kernel *
        vec3(
            dot(a, hash2(vec2(idx)) * 2.0 - 1.0),
            dot(b, hash2(vec2(idx + tb)) * 2.0 - 1.0),
            dot(c, hash2(vec2(idx + ivec2(1, 1))) * 2.0 - 1.0)
        );

    return dot(vec3(70.0), noiseVal);
}

float verticalLine(vec2 uv, float t)
{
    float uvX = uv.x + t * 0.0000003;
    vec2 xHash = hash2(vec2(uvX, uvX));
    float vertical = step(0.9999996, sin(uvX * 1000.0 * (xHash.x * 0.01 + 0.01)));

    float uvY = uv.y + t * 0.000001;
    vec2 yHash = hash2(vec2(uvY, uvY));
    vertical *= sin(uvY * 1000.0 * yHash.x);

    return clamp(1.0 - vertical, 0.0, 1.0);
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
    float t = iTime;

    float col = 0.0;
    col += verticalLine(uv - 1.0, t) * 0.5;
    col += (1.0 - verticalLine(uv - 3.0, t * 5.0)) * 0.5;
    col *= smoothstep(0.9, 0.83, simplexNoise((uv + hash2(vec2(t, t)) * 154.4541 - 154.4541) * 10.0));
    col *= 1.0 - hash2(uv + t * 0.01).x * 0.25;
    col *= smoothstep(1.5 + hash2(vec2(floor(t * 15.0))).x * 0.3, 0.0, length(uv - 0.5));

    vec4 tex = flixel_texture2D(bitmap, uv);
    float gray = (tex.r + tex.g + tex.b) / 3.0;

    gl_FragColor = vec4(vec3(col * gray), tex.a);
}