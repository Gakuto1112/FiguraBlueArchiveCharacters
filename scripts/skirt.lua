---@class Skirt スカートを制御するクラス

events.TICK:register(function()
    models.models.main.Avatar.UpperBody.Body.Skirt:setRot(player:isCrouching() and 30 or 0)
end)