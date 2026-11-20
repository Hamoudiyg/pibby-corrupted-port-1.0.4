function onCreatePost()
    makeLuaSprite('iconP3', 'icons/icon-minnie', 0,0)

    setProperty('iconP3.y', getProperty('iconP1.y') - 50)
    -- تحديث 1.0.4: setObjectCamera -> setProperty
    setProperty('iconP3.camera', instanceArg('camHUD'), false, true)
    addLuaSprite('iconP3', false)

    setProperty("iconP3._frame.frame.y", 0)
    setProperty("iconP3._frame.frame.width", 150)
    setProperty("iconP3._frame.frame.height", 200)
    setProperty('iconP3.alpha', 0)
    -- تحديث 1.0.4: setObjectOrder -> zIndex
    setProperty('iconP3.zIndex', getProperty('iconP2.zIndex') - 1)
end

function onUpdatePost()
    setProperty('iconP3.x', getProperty('iconP2.x') - 80)
    setProperty('iconP3.scale.x', getProperty('iconP2.scale.x'))
    setProperty('iconP3.scale.y', getProperty('iconP2.scale.y'))
    setProperty('iconP3.alpha', getProperty('iconP2.alpha'))
    setProperty('iconP3.visible', getProperty('iconP2.visible'))

    if getProperty('healthBar.percent') >= 81 then
        setProperty("iconP3._frame.frame.x", 150)
    else
        setProperty("iconP3._frame.frame.x", 0)
    end
end