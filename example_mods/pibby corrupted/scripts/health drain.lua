function onCreate()
    if songName == 'wish-come-true' or dadName == 'FNF/corrupted-bf' then
        close(true)
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if getHealth() > 0.1 then
        addHealth(-0.012)
    end
end