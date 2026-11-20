target = false
function onEvent(n,v1,v2)
    if n == 'camera_target' then
        target = v1

        if not (v2 == 'inst') then
            setProperty('cameraSpeed', v2)
            targetS = v2
        else
            targetS = getProperty('cameraSpeed')
            runTimer('normallol', 0.05)
            setProperty('cameraSpeed', 10000)
        end
    end
end

function onTimerCompleted(t)
    if t == 'normallol' then
        setProperty('cameraSpeed', targetS)
    end
end

function onUpdate()
    if target == 'bf' then
        cameraSetTarget('boyfriend')
    elseif target == 'dad' then
        cameraSetTarget('dad')
    elseif target == 'gf' then
        -- تحديث 1.0.4: استخدام خصائص الكاميرا المتاحة مباشرة
        local gfX = getProperty('gf.getScreenPosition().x') -- أو getProperty('gf.x') حسب الحاجة
        local gfY = getProperty('gf.getScreenPosition().y')
        local camOffsetX = getProperty('gf.cameraPosition[0]') or 0
        local camOffsetY = getProperty('gf.cameraPosition[1]') or 0
        local gfOffsetX = getProperty('girlfriendCameraOffset[0]') or 0
        local gfOffsetY = getProperty('girlfriendCameraOffset[1]') or 0

        setProperty('camFollow.x', gfX + camOffsetX + gfOffsetX)
        setProperty('camFollow.y', gfY + camOffsetY + gfOffsetY)
    end
end