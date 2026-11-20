function onCreate()
    makeLuaSprite('boat', 'backgrounds/ivashkaBG/first_song/boat')
    makeLuaSprite('barrel', 'backgrounds/ivashkaBG/first_song/barrel',950,1314)
    makeLuaSprite('candle', 'backgrounds/ivashkaBG/first_song/candle',1510,1765)

    addLuaSprite('boat')
    addLuaSprite('barrel')
    addLuaSprite('candle', true)

    makeLuaSprite('photo', 'backgrounds/ivashkaBG/first_song/photo',610,250)
    makeLuaSprite('ramka', 'backgrounds/ivashkaBG/first_song/ramka')

    addLuaSprite('photo')
    addLuaSprite('ramka',true)
end

function rgbToHex(array)
    return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function onCreatePost()
    setHealthBarColors('0E673B',rgbToHex(getProperty('boyfriend.healthColorArray')))
    -- تحديث 1.0.4: setObjectOrder -> zIndex
    setProperty('barrel.zIndex', getProperty('dadGroup.zIndex') + 1)
    setProperty('gfGroup.zIndex', getProperty('barrel.zIndex') + 1)
    setProperty('boyfriendGroup.zIndex', getProperty('barrel.zIndex') + 2)

    setProperty('photo.visible',false)
    setProperty('ramka.visible',false)
end