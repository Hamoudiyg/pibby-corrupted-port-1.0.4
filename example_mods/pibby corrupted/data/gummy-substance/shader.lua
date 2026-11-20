function onCreate()
    initLuaShader('CameraGlitch')
    initLuaShader('old film')
end

function onCreatePost()
    -- Shader3: CameraGlitch
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "CameraGlitch")
    setShaderBool('Shader3','vignetteOn',true)
    setShaderBool('Shader3','vignetteMoving',true)

    -- Shader4: old film
    makeLuaSprite("Shader4")
    setSpriteShader("Shader4", "old film")

    runHaxeCode([[
        var shaderName3 = "CameraGlitch";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        var shaderName4 = "old film";
        game.initLuaShader(shaderName4);
        var shader4 = game.createRuntimeShader(shaderName4);
        game.getLuaObject("Shader4").shader = shader4;
    ]])
end

function onStepHit()
    if curStep == 896 then
        runHaxeCode([[
            game.camGame.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader3").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader4").shader)
            ]);
            game.camHUD.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader3").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader4").shader)
            ]);
        ]])
    elseif curStep == 1152 then
        runHaxeCode([[
            game.camGame.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader)
            ]);
            game.camHUD.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader)
            ]);
        ]])
        setShaderFloat("Shader1", "AMT", 0)
        setShaderFloat("Shader1", "SPEED", 0)
        setShaderFloat("Shader2", "offsetIntensity", 0)
        setShaderFloat("Shader2", "noiseQuality",100)
    end
end

function onUpdatePost()
    if curStep >= 896 and curStep < 1152 then
        setShaderFloat("Shader3", "iTime", os.clock())
        setShaderFloat("Shader4", "iTime", os.clock())
    end
end