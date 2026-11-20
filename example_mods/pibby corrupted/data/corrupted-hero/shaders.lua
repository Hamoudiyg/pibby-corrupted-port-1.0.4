Time = 50
CAamount = 0
amount = 0

function onCreatePost()
    -- إنشاء الشادرات مرة واحدة فقط عند بدء الأغنية
    makeLuaSprite("Shader1")
    setSpriteShader("Shader1", "Glitchy")

    makeLuaSprite("Shader2")
    setSpriteShader("Shader2", "shift glitch")

    makeLuaSprite("Shader3")
    setSpriteShader("Shader3", "chrom")

    -- ربط الشادرات بالكاميرات باستخدام الطريقة الصحيحة في 1.0.4
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

    -- القيم الأولية (مطابقة للأصل)
    setShaderFloat("Shader1", "AMT", 0)
    setShaderFloat("Shader1", "SPEED", 0)
    setShaderFloat("Shader2", "offsetIntensity", 0)
    setShaderFloat("Shader2", "noiseQuality", 100)
    setShaderFloat("Shader3", "amount", 0)
end

function onStepHit()
    if curStep == 1808 then
        -- لا حاجة لإعادة إنشاء الشادرات هنا، تم إنشاؤها في onCreatePost
        -- فقط تأكد من أن القيم الأولية صحيحة (تم ذلك بالفعل)
    elseif curStep == 1953 then
        setShaderFloat("Shader3", "amount", 0)
    end
end

function onBeatHit()
    if curStep > 1808 and curStep <= 1952 then
        if curBeat % 8 == 6 then
            Time = 5
            CAamount = 3
        end

        if curBeat % 8 == 0 then
            Time = 0.1
            CAamount = 0
        end
    end
end

function onUpdatePost()
    if curStep >= 1808 and curStep <= 1952 then
        setShaderFloat('Shader3', "amount", amount)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'glitch_note' then
        amount = 0
    end
end

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.lerp(from, to, i)
    return from + (to - from) * i
end

function onUpdate(elapsed)
    if curStep >= 1808 and curStep <= 1952 then
        amount = math.lerp(amount, CAamount + 0.000001, boundTo(elapsed * 10 / Time, 0, 500))
    end
end