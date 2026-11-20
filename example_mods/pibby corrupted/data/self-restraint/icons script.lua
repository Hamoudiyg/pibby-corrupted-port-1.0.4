function onCreatePost()
    makeLuaSprite('iconP3', 'icons/icon-pibgirlfriend', 0,0)

    setProperty('iconP3.y', getProperty('iconP1.y') - 50)
    -- تحديث 1.0.4: setObjectCamera -> setProperty
    setProperty('iconP3.camera', instanceArg('camHUD'), false, true)
    addLuaSprite('iconP3', false)

    setProperty("iconP3._frame.frame.y", 0)
    setProperty("iconP3._frame.frame.width", 150)
    setProperty("iconP3._frame.frame.height", 150)
    setProperty('iconP3.alpha', 0)
    -- تحديث 1.0.4: setObjectOrder -> zIndex
    setProperty('iconP3.zIndex', getProperty('iconP2.zIndex') - 1)


    makeLuaSprite('helthBar2', nil, getProperty('healthBar.x'),getProperty('healthBar.y'))
    makeGraphic('helthBar2', getProperty('healthBar.width'),getProperty('healthBar.height') / 1.7, 'a5004d')
    -- تحديث 1.0.4
    setProperty('helthBar2.camera', instanceArg('camHUD'), false, true)
    setProperty('helthBar2.visible',false)
    addLuaSprite('helthBar2')
    -- تحديث 1.0.4
    setProperty('helthBar2.zIndex', getProperty('iconP1.zIndex') - 1)
end

function onUpdatePost()
    if curStep > 1600 then
        setProperty("helthBar2._frame.frame.width", (getProperty('healthBar.percent')) * -6.01 + 601)
        setProperty('helthBar2.alpha', getProperty('healthBar.alpha'))

        setProperty('iconP3.x', getProperty('iconP2.x') - 100)
        setProperty('iconP3.scale.x', getProperty('iconP2.scale.x'))
        setProperty('iconP3.scale.y', getProperty('iconP2.scale.y'))
        setProperty('iconP3.alpha', getProperty('iconP2.alpha'))
        setProperty('iconP3.visible', getProperty('iconP2.visible'))

        if getProperty('healthBar.percent') == 100 then
            setProperty('helthBar2.visible', false)
        else
            setProperty('helthBar2.visible', getProperty('healthBar.visible'))
        end

        if getProperty('healthBar.percent') >= 81 then
            setProperty("iconP3._frame.frame.x", 150)
        else
            setProperty("iconP3._frame.frame.x", 0)
        end
    end
end