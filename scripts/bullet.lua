---自分が発射した矢のテーブル
---@type table<string, integer>
local arrowTable = {}

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

events.ARROW_RENDER:register(function(delta, arrow)
    local arrowUUID = arrow:getUUID()
    if arrowTable[arrowUUID] == nil and not gunSoundPlayed then
        local arrowPos = arrow:getPos()
        sounds:playSound("entity.generic.explode", arrowPos, 1, 2)
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