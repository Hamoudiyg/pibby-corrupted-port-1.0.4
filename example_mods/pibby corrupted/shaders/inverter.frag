#pragma header

uniform float iTime;
uniform int invert; // 0 = original color, 1 = inverted color

void main()
{
    vec2 uv = openfl_TextureCoordv;
    vec4 tex = flixel_texture2D(bitmap, uv);

    if (invert == 0)
    {
        gl_FragColor = tex;
    }
    else
    {
        gl_FragColor = vec4((vec3(tex.a) - tex.rgb), tex.a);
    }
}