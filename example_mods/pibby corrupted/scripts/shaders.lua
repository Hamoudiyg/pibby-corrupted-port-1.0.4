function onCreatePost()
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    runHaxeCode([[
        var shaderName1 = "Glitchy";
        game.initLuaShader(shaderName1);
        var shader1 = game.createRuntimeShader(shaderName1);
        game.getLuaObject("Shader1").shader = shader1;

        var shaderName2 = "shift glitch";
        game.initLuaShader(shaderName2);
        var shader2 = game.createRuntimeShader(shaderName2);
        game.getLuaObject("Shader2").shader = shader2;

        game.camGame.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2)
        ]);
        game.camHUD.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2)
        ]);
    ]])

    setShaderFloat("Shader1", "AMT", 0)
    setShaderFloat("Shader1", "SPEED", 0)

    setShaderFloat("Shader2", "offsetIntensity", 0)
    setShaderFloat("Shader2", "noiseQuality", 100)
end

amount = 0
glit = 0

function onUpdatePost(elapsed)
    setShaderFloat("Shader2", "noiseIntensity", glit)
    setShaderFloat("Shader2", "colorR", glit * getRandomInt(-40, 40))
    setShaderFloat("Shader2", "colorB", glit * getRandomInt(-40, 40))
    setShaderFloat("Shader2", "colorG", glit * getRandomInt(-40, 40))

    setShaderFloat("Shader2", "iTime", os.clock())
    setShaderFloat("Shader1", "iTime", os.clock())
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'glitch_note' or noteType == 'Bothchr' or (songName == 'wish-come-true' and noteType == 'No Animation') then
        setShaderFloat("Shader1", "AMT", 0.03)
        setShaderFloat("Shader1", "SPEED", 1)
        if getHealth() > 0.1 then
            addHealth(-0.04)
        end
        glit = glit + 0.01
        runTimer('remove', 0.1)
    end
end

function onTimerCompleted(t, loops, loopsLeft)
    if t == 'remove' then
        setShaderFloat("Shader1", "AMT", 0)
        setShaderFloat("Shader1", "SPEED", 0)
    end
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from, to, i)
    return from + (to - from) * i
end

function onUpdate(elapsed)
    glit = math.lerp(glit, 0, boundTo(elapsed * 10, 0, 500))
end