---@class Skirt スカートを制御するクラス
Skirt = {
    ---初期化関数
    init = function ()
        if #BlueArchiveCharacter.SKIRT.SkirtModels > 0 then
            events.TICK:register(function ()
                local isCrouching = player:isCrouching()
                for _, skirtModel in ipairs(BlueArchiveCharacter.SKIRT.SkirtModels) do
                    if skirtModel:getVisible() then
                        skirtModel:setRot(isCrouching and 30 or 0, 0, 0)
                    end
                end
            end)
        end
    end
}

Skirt:init()

return Skirt