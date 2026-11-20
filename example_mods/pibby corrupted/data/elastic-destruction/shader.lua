function onCreatePost()
    -- الشادر الأول
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    -- الشادر الثاني
    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    -- الشادر الثالث
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "old film")

    runHaxeCode([[
        var shaderName1 = "Glitchy";
        game.initLuaShader(shaderName1);
        var shader1 = game.createRuntimeShader(shaderName1);
        game.getLuaObject("Shader1").shader = shader1;

        var shaderName2 = "shift glitch";
        game.initLuaShader(shaderName2);
        var shader2 = game.createRuntimeShader(shaderName2);
        game.getLuaObject("Shader2").shader = shader2;

        var shaderName3 = "old film";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        game.camGame.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2),
            new openfl.filters.ShaderFilter(shader3)
        ]);
    ]])
    
    -- القيم الابتدائية
    setShaderFloat("Shader1", "AMT", 0)
    setShaderFloat("Shader1", "SPEED", 0)
    setShaderFloat("Shader2", "offsetIntensity", 0)
    setShaderFloat("Shader2", "noiseQuality", 100)
end

function onUpdatePost()
    -- تحديث الوقت لكل الشادرات لمنع تجمد الشاشة أو تمططها
    setShaderFloat("Shader1", "iTime", os.clock())
    setShaderFloat("Shader2", "iTime", os.clock())
    setShaderFloat("Shader3", "iTime", os.clock())

    if curStep == 127 then
        runHaxeCode([[
            game.camGame.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader)
            ]);
        ]])
    end
end