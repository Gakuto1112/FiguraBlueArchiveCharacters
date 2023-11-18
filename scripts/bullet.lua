---自分が発射した矢のテーブル
---@type table<string, integer>
local arrowTable = {}

---このレンダー内で既に銃の発射音を再生したかどうか。音が重複しない為の仕様。
local gunSoundPlayed = false

events.TICK:register(function()
    for arrowUUID, arrowEntry in pairs(arrowTable) do
        if arrowEntry > 0 then
            arrowTable[arrowUUID] = arrowTable[arrowUUID] - 1
        elseif world.getEntity(arrowUUID) ~= nil then
            arrowTable[arrowUUID] = 20
        else
            arrowTable[arrowUUID] = nil
        end
    end
end)

events.ARROW_RENDER:register(function(_, arrow)
    local arrowUUID = arrow:getUUID()
    if arrowTable[arrowUUID] == nil and not gunSoundPlayed then
        local arrowPos = arrow:getPos()
        sounds:playSound(BlueArchiveCharacter.GUN.sound.name, arrowPos, 1, BlueArchiveCharacter.GUN.sound.pitch)
        for _ = 1, 5 do
            particles:newParticle("smoke", arrowPos:copy():applyFunc(function(pos)
                return pos + (math.random() * 0.4 - 0.2)
            end))
        end
        gunSoundPlayed = true
    end
    arrowTable[arrowUUID] = 20
end)

events.POST_RENDER:register(function ()
    gunSoundPlayed = false
end)