Time = 1
CAamount = 0

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
    setShaderFloat("Shader3", "amount", 0)
end

amount = 0
function onUpdatePost()
    setShaderFloat('Shader3', "amount", amount)
end

function onEvent(n,v1)
    if n == 'AddChrom' then
        amount = amount + v1
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'glitch_note' then
        amount = 0.5
    end
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end

function onUpdate(elapsed)
    amount = math.lerp(amount, CAamount + 0.000001, boundTo(elapsed * 10 / Time, 0, 500));
end