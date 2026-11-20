function rgbToHex(array)return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])end

function onCreatePost()
    makeLuaSprite('iconP3', 'icons/icon-finn', 0,0)

    setProperty('iconP3.y', getProperty('iconP1.y') - 50)
    -- تحديث 1.0.4: setObjectCamera -> setProperty
    setProperty('iconP3.camera', instanceArg('camHUD'), false, true)
    addLuaSprite('iconP3')

    setProperty("iconP3._frame.frame.y", 0)
    setProperty("iconP3._frame.frame.width", 150)
    setProperty("iconP3._frame.frame.height", 150)

    -- تحديث 1.0.4: setObjectOrder -> zIndex
    setProperty('iconP3.zIndex', getProperty('iconP2.zIndex') - 1)

    makeLuaSprite('helthBar2', nil, getProperty('healthBar.x'),getProperty('healthBar.y'))
    makeGraphic('helthBar2', getProperty('healthBar.width'),getProperty('healthBar.height') / 1.7, rgbToHex(getProperty('gf.healthColorArray')))
    -- تحديث 1.0.4
    setProperty('helthBar2.camera', instanceArg('camHUD'), false, true)
    addLuaSprite('helthBar2')
    -- تحديث 1.0.4
    setProperty('helthBar2.zIndex', getProperty('iconP1.zIndex') - 1)
end

function onUpdatePost()
    setProperty("helthBar2._frame.frame.width", (getProperty('healthBar.percent')) * -6.01 + 601)

    setProperty('iconP3.x', getProperty('iconP2.x') - 60)
    setProperty('iconP3.scale.x', getProperty('iconP2.scale.x'))
    setProperty('iconP3.scale.y', getProperty('iconP2.scale.y'))
    setProperty('helthBar2.alpha', getProperty('healthBar.alpha'))
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