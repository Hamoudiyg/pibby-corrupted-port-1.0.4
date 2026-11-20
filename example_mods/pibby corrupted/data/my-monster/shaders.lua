function onCreatePost()
    -- Shader1: Glitchy
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    -- Shader2: shift glitch
    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    -- Shader3: CameraGlitch (سيتم استخدامه أولاً)
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "CameraGlitch")
    setShaderBool('Shader3','vignetteOn',true)
    setShaderBool('Shader3','vignetteMoving',true)

    -- Shader4: inverter (سيتم استخدامه لاحقاً بدلاً من Shader3)
    makeLuaSprite("Shader4")
    setSpriteShader("Shader4", "inverter")

    runHaxeCode([[
        var shaderName1 = "Glitchy";
        game.initLuaShader(shaderName1);
        var shader1 = game.createRuntimeShader(shaderName1);
        game.getLuaObject("Shader1").shader = shader1;

        var shaderName2 = "shift glitch";
        game.initLuaShader(shaderName2);
        var shader2 = game.createRuntimeShader(shaderName2);
        game.getLuaObject("Shader2").shader = shader2;

        var shaderName3 = "CameraGlitch";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        var shaderName4 = "inverter";
        game.initLuaShader(shaderName4);
        var shader4 = game.createRuntimeShader(shaderName4);
        game.getLuaObject("Shader4").shader = shader4;

        // التطبيق الأولي لـ CameraGlitch
        game.camGame.setFilters([new openfl.filters.ShaderFilter(shader3)]);
        game.camHUD.setFilters([new openfl.filters.ShaderFilter(shader3)]);
    ]])
end

function onUpdatePost()
    if curStep < 1024 then
        setShaderFloat('Shader3','iTime',os.clock())
    end
end

function onStepHit()
    if curStep == 1024 then
        runHaxeCode([[
            game.camGame.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader4").shader)
            ]);
            game.camHUD.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader4").shader)
            ]);
        ]])

        setShaderFloat("Shader1", "AMT", 0)
        setShaderFloat("Shader1", "SPEED", 0)
        setShaderFloat("Shader2", "offsetIntensity", 0)
        setShaderFloat("Shader2", "noiseQuality",100)
        setShaderInt("Shader4", "invert", 0) -- نستخدم Shader4 هنا كبديل لـ Shader3
    end
end

function opponentNoteHit(id, dir, noteType)
    if noteType == 'glitch_note' then
        setShaderFloat("Shader2", "noiseQuality", 50)
        setShaderInt("Shader4", "invert", 1)
        runTimer('remove', 0.1)
    end
end

function onTimerCompleted(t)
    if t == 'remove' then
        setShaderFloat("Shader2", "offsetIntensity", 0)
        setShaderInt("Shader4", "invert", 0)
    end
end