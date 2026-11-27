local gbgActive = false

local function getFinnSprite()
    if dadName == 'AT/finn' then
        return 'dad'
    elseif gfName == 'AT/finn' then
        return 'gf'
    end
    return 'dad'
end

local function rgbToHex(array)
    return (array[1] * 65536) + (array[2] * 256) + array[3]
end

local function resetColor(spr)
    setProperty(spr .. '.colorTransform', nil)
    local oa = getProperty(spr .. '.alpha')
    setProperty(spr .. '.alpha', 0)
    setProperty(spr .. '.alpha', oa)
end

local function applySlashColor()
    local target = getFinnSprite()
    if gbgActive then
        setProperty('finn_attack.colorTransform.color', rgbToHex(getProperty(target .. '.healthColorArray')))
    else
        resetColor('finn_attack')
    end
end

local function syncSlashPos()
    local target = getFinnSprite()
    setProperty('finn_attack.x', getProperty(target .. '.x'))
    setProperty('finn_attack.y', getProperty(target .. '.y'))
end

local function runSlash(isMiss)
    local target = getFinnSprite()
    syncSlashPos()

    playAnim('finn_attack', 'attack', true)
    setProperty('finn_attack.visible', true)
    applySlashColor()
    setProperty(target .. '.visible', false)
    playSound('slice', 0.2)

    triggerEvent('Play Animation', isMiss and 'hit' or 'dodge', 'bf')
    cancelTimer('endanim')
    runTimer('endanim', 0.48)
    triggerEvent('Screen Shake', '0.1,0.03', '0.1,0.03')
end

function onCreate()
    precacheSound('slice')

    local noteCount = getProperty('unspawnNotes.length') - 1
    for i = 0, noteCount do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Sword Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'Sword')
            setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
        end
    end

    makeAnimatedLuaSprite('finn_attack', 'special_Anims/slash')
    addAnimationByPrefix('finn_attack', 'attack', 'Finn Slash', 24, false)
    scaleObject('finn_attack', 0.9, 0.9)
    setProperty('finn_attack.offset.x', 80)
    setProperty('finn_attack.offset.y', 144)
    setProperty('finn_attack.visible', false)
end

function onCreatePost()
    addLuaSprite('finn_attack', false)
    syncSlashPos()

    setProperty('gfGroup.zIndex', 11)
    setProperty('boyfriendGroup.zIndex', 12)
    setProperty('dadGroup.zIndex', 13)
    setProperty('finn_attack.zIndex', 14)
end

function goodNoteHit(id, direction, noteType)
    if noteType == 'Sword Note' then
        runSlash(false)
    end
end

function noteMiss(id, direction, noteType)
    if noteType == 'Sword Note' then
        runSlash(true)
        setProperty('health', getProperty('health') - 0.3)
    end
end

function onEvent(n, v1, v2)
    if n == 'GBG' then
        if v1 == 'on' then
            gbgActive = true
            applySlashColor()
        elseif v1 == 'off' then
            gbgActive = false
            applySlashColor()
        end
    end
end

function onTimerCompleted(t, loops, loopsLeft)
    if t == 'endanim' then
        setProperty('finn_attack.visible', false)
        setProperty(getFinnSprite() .. '.visible', true)
    end
end