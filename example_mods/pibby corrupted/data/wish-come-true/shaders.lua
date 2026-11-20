function onCreatePost()
    -- Shader1: Glitchy
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    -- Shader2: shift glitch
    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    -- Shader3: chrom
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "chrom")

    runHaxeCode([[
        var shaderName1 = "Glitchy";
        game.initLuaShader(shaderName1);
        var shader1 = game.createRuntimeShader(shaderName1);
        game.getLuaObject("Shader1").shader = shader1;

        var shaderName2 = "shift glitch";
        game.initLuaShader(shaderName2);
        var shader2 = game.createRuntimeShader(shaderName2);
        game.getLuaObject("Shader2").shader = shader2;

        var shaderName3 = "chrom";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        game.camGame.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2),
            new openfl.filters.ShaderFilter(shader3)
        ]);
        game.camHUD.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2),
            new openfl.filters.ShaderFilter(shader3)
        ]);
    ]])

    setShaderFloat("Shader1", "AMT", 0)
    setShaderFloat("Shader1", "SPEED", 0)
    setShaderFloat("Shader2", "offsetIntensity", 0)
    setShaderFloat("Shader2", "noiseQuality",100)
    setShaderFloat("Shader3", "amount",0)
end

chrom = 0
function onEvent(n,v1)
    if n == 'AddChrom' then
        chrom = chrom + v1
    end
end

amount = 0
function onUpdatePost()
    setShaderFloat("Shader3", "amount",chrom)
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end

function onUpdate(elapsed)
    chrom = math.lerp(chrom, 0, boundTo(elapsed * 10, 0, 500));
end