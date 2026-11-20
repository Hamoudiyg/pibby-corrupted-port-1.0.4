function onCreatePost()
    -- Shader1, Shader2 (يُفترض أنهما منشأتان في مكان آخر)
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "old film")

    runHaxeCode([[
        var shaderName3 = "old film";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        game.camGame.setFilters([
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader),
            new openfl.filters.ShaderFilter(shader3)
        ]);
        game.camHUD.setFilters([
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader),
            new openfl.filters.ShaderFilter(shader3)
        ]);
        game.camOther.setFilters([
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
            new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader),
            new openfl.filters.ShaderFilter(shader3)
        ]);
    ]])

    addHaxeLibrary("ShaderFilter1", "openfl.filters")
end

function onUpdatePost()
    setShaderFloat("Shader3", "iTime", os.clock())
end