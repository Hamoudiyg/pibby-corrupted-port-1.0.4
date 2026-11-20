function onCreatePost()
    -- Shader3 (old film)
    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "old film")

    -- Shader1 (Glitchy) - يُستخدم لاحقاً في curStep 127
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    -- Shader2 (shift glitch) - يُستخدم لاحقاً في curStep 127
    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    -- ربط الشادرات بالكاميرا باستخدام الطريقة الصحيحة في 1.0.4
    runHaxeCode([[
        var shaderName3 = "old film";
        game.initLuaShader(shaderName3);
        var shader3 = game.createRuntimeShader(shaderName3);
        game.getLuaObject("Shader3").shader = shader3;

        var shaderName1 = "Glitchy";
        game.initLuaShader(shaderName1);
        var shader1 = game.createRuntimeShader(shaderName1);
        game.getLuaObject("Shader1").shader = shader1;

        var shaderName2 = "shift glitch";
        game.initLuaShader(shaderName2);
        var shader2 = game.createRuntimeShader(shaderName2);
        game.getLuaObject("Shader2").shader = shader2;

        game.camGame.setFilters([new openfl.filters.ShaderFilter(shader3)]);
    ]])
end

function onUpdatePost()
    if curStep > 1 and curStep < 127 then
        setShaderFloat("Shader3", "iTime", os.clock())
    end

    if curStep == 127 then
        runHaxeCode([[
            game.camGame.setFilters([
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader1").shader),
                new openfl.filters.ShaderFilter(game.getLuaObject("Shader2").shader)
            ]);
        ]])
    end
end