function onSongStart()
    -- تحديث 1.0.4: setObjectCamera -> setProperty
    setProperty('ffade.camera', instanceArg('camHUD'), false, true)
    setProperty('flash.camera', instanceArg('camHUD'), false, true)
    -- تحديث 1.0.4: setObjectOrder -> zIndex
    setProperty('ffade.zIndex', getProperty('iconP2.zIndex') + 1)
    setProperty('flash.zIndex', getProperty('iconP2.zIndex') + 2)
    for i = 0,7 do
        setProperty('strumLineNotes.members['..i..'].camera', instanceArg('camOther'), false, true)
    end
end

function onSpawnNote(id)
    setProperty('notes.members['..id..'].camera', instanceArg('camOther'), false, true)
    setProperty('notes.members['..id..'].colorTransform.redOffset',150)
    setProperty('notes.members['..id..'].colorTransform.greenOffset',150)
    setProperty('notes.members['..id..'].colorTransform.blueOffset',150)
end

function onUpdatePost()
    setProperty('camOther.zoom', getProperty('camHUD.zoom'))
end