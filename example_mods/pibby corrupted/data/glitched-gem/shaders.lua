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
    setShaderFloat("Shader2", "noiseQuality", 100)
    setShaderFloat("Shader3", "amount", 0)
end

chrom = 0
function onEvent(n,v1)
    if n == 'AddChrom' then
        chrom = chrom + v1
    end
end

amount = 0
glit = 0
function onUpdatePost()
    setShaderFloat("Shader2", "noiseIntensity", glit)
    setShaderFloat("Shader3", "amount",chrom)
    setShaderFloat("Shader2", "colorR", glit * getRandomInt(-40,40))
    setShaderFloat("Shader2", "colorB", glit * getRandomInt(-40,40))
    setShaderFloat("Shader2", "colorG", glit * getRandomInt(-40,40))

    setShaderFloat("Shader2", "iTime", os.clock())
    setShaderFloat("Shader1", "iTime", os.clock())

    if curStep >= 888 and curStep < 896 then
        chrom = chrom + 0.2
    end
    if curStep >= 920 and curStep < 928 then
        chrom = chrom + 0.2
    end
    if curStep >= 952 and curStep < 960 then
        chrom = chrom + 0.2
    end
    if curStep >= 984 and curStep < 992 then
        chrom = chrom + 0.2
    end
    if curStep >= 1016 and curStep < 1024 then
        chrom = chrom + 0.2
    end
    if curStep >= 1048 and curStep < 1056 then
        chrom = chrom + 0.2
    end
    if curStep >= 1080 and curStep < 1088 then
        chrom = chrom + 0.2
    end

    if curStep == 896 or curStep == 928 or curStep == 960 or curStep == 992 or curStep == 1024 or curStep == 1056 or curStep == 1088 then
        chrom = 0
    end

    if curStep >= 1502 and curStep < 1506 then
        setShaderFloat("Shader1", "AMT", 0.03)
        setShaderFloat("Shader1", "SPEED", 1)
        glit = glit + 0.01
        runTimer('remove', 0.1)
        setShaderInt('dad', 'invert', 1)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'glitch_note' then
        setShaderFloat("Shader1", "AMT", 0.03)
        setShaderFloat("Shader1", "SPEED", 1)
        glit = glit + 0.01
        runTimer('remove', 0.1)
    end
end

function onTimerCompleted(t)
    if t == 'remove' then
        setShaderFloat("Shader1", "AMT", 0)
        setShaderFloat("Shader1", "SPEED", 0)
    end
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from,to,i)
    return from+(to-from)*i
end

function onUpdate(elapsed)
    glit = math.lerp(glit, 0, boundTo(elapsed * 10, 0, 500));
    if curStep < 888 or curStep > 1120 then
        chrom = math.lerp(chrom, 0, boundTo(elapsed * 7, 0, 500));
    end
end