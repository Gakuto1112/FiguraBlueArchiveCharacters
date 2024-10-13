---ステータスエフェクトの分類分け
---@alias HpBar.EffectType
---| "UP" ステータス上昇系
---| "DOWN" ステータス低下系
---| "CC" 行動制限系
---| "SPECIAL" 能力強化系

---@class HpBar HPバーの動作を制御するクラス
HpBar = {
    ---エフェクトの分類分けテーブル
    ---@type {[string]: HpBar.EffectType}
    EffectTable = {
        "instant_health"
    },

    ---HPゲージの長さを変更する。
    ---@param scale number HPゲージの長さ。0-1の間で指定する。
    setHpGage = function (scale)
        local targetLength = 15.225 * scale - 0.3
        models.models.hp_bar.Camera.HpGage.HpBar.Bar:setScale(math.clamp(targetLength / 14.925, 0, 1), 1, 1)
        models.models.hp_bar.Camera.HpGage.HpBar.BarTipRight:setPos(math.min(14.925 - targetLength, 14.925), 0, 0)
    end,

    ---バリアゲージの長さを変更する。
    ---@param scale number バリアゲージの長さ。0-1の間で指定する。
    setBarrierGage = function (scale)
        if scale == 0 then
            models.models.hp_bar.Camera.BarrierGage:setVisible(false)
        else
            models.models.hp_bar.Camera.BarrierGage:setVisible(true)
            local targetLength = 15.225 * scale - 0.195
            models.models.hp_bar.Camera.BarrierGage.BarrierBar.Bar:setScale(math.clamp(targetLength / 15.03, 0, 1), 1, 1)
            models.models.hp_bar.Camera.BarrierGage.BarrierBar.BarTipRight:setPos(math.min(15.03 - targetLength, 15.03), 0, 0)
        end
    end,

    ---初期化関数
    ---@param self HpBar
    init = function (self)
        events.TICK:register(function ()
            self.setHpGage(player:getHealth() / player:getMaxHealth())
            self.setBarrierGage(0.35)
            --printTable(host:getStatusEffects(), 2)
        end)
        self.setHpGage(player:getHealth() / player:getMaxHealth())
        self.setBarrierGage(0)
        printTable(client:getRegistry("mob_effect"))
    end
}

HpBar:init()

return HpBar