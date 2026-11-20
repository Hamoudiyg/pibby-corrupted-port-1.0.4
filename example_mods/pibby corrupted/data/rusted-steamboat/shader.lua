function onCreatePost()
    -- Shader1: Glitchy
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    -- Shader2: shift glitch
    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    -- Shader3: old film
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
        game.camHUD.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2),
            new openfl.filters.ShaderFilter(shader3)
        ]);
        game.camOther.setFilters([
            new openfl.filters.ShaderFilter(shader1),
            new openfl.filters.ShaderFilter(shader2),
            new openfl.filters.ShaderFilter(shader3)
        ]);
    ]])

    addHaxeLibrary("ShaderFilter1", "openfl.filters")
end

function onUpdatePost()
    setShaderFloat("Shader3", "iTime", os.clock())
end