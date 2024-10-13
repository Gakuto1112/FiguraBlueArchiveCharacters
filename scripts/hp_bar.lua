---@class HpBar HPバーの動作を制御するクラス
HpBar = {
    ---HPゲージの長さを変更する。
    ---@param scale number HPゲージの長さ。0-1の間で指定する。
    setHpGage = function (scale)
        local targetLength = 15.225 * scale - 0.3
        models.models.hp_bar.Camera.HpGage.BarHp.Bar:setScale(math.clamp(targetLength / 14.925, 0, 1), 1, 1)
        models.models.hp_bar.Camera.HpGage.BarHp.BarTipRight:setPos(math.min(14.925 - targetLength, 14.925), 0, 0)
    end,

    ---初期化関数
    ---@param self HpBar
    init = function (self)
        models.models.hp_bar.Camera.HpGage.BarHp:setColor(0.773, 0.953, 0.047)
        --models.models.hp_bar.Camera.HpGage.BarHp:setScale(0.5, 1, 1)
        events.TICK:register(function ()
            self.setHpGage(player:getHealth() / player:getMaxHealth())
        end)
        --self.setHpGage(0)
    end
}

HpBar:init()

return HpBar