---@class Barrier バリアの視覚効果を管理するクラス
Barrier = {
    ---バリアのアニメーションのカウンター
    ---@type number[]
    AnimationCounters = {},

    ---前ティックの衝撃吸収のハートを持っていたかどうか
    ---@type boolean
    HadAbsorptionPrev = false,

    ---バリアの色の係数
    ---@type number
    ColorFactor = 1,

    ---バリア機能を有効化する。
    ---@param self Barrier
    enable = function (self)
        for i = 1, 32 do
            self.AnimationCounters[i] = math.random(0, 39)
        end

        events.TICK:register(function ()
            for i = 1, 32 do
                self.AnimationCounters[i] = self.AnimationCounters[i] + 1
                if self.AnimationCounters[i] == 40 then
                    self.AnimationCounters[i] = 0
                end
            end
            self.ColorFactor = client:hasShaderPack() and 0.5 or 1
        end, "barrier_tick")
        events.RENDER:register(function (delta, context)
            if context == "FIRST_PERSON" or context == "RENDER" then
                models.models.barrier:setVisible(true)
                for i = 1, 32 do
                    local opacity = math.abs(-0.025 * (self.AnimationCounters[i] + delta) + 0.5) + 0.5
                    models.models.barrier.Barrier["Barrier"..i]:setOpacity(opacity)
                    models.models.barrier.Barrier["Barrier"..i]:setColor(opacity * self.ColorFactor, opacity * self.ColorFactor, 1)
                end
            else
                models.models.barrier:setVisible(false)
            end
        end, "barrier_render")
    end,

    ---バリア機能を無効化する。
    disable = function ()
        models.models.barrier:setVisible(false)
        events.TICK:remove("barrier_tick")
        events.RENDER:remove("barrier_render")
    end,

    ---初期化関数
    ---@param self Barrier
    init = function (self)
        models.models.barrier:setLight(15)

        events.TICK:register(function ()
            local hasAbsorption = player:getAbsorptionAmount() > 0 and player:getHealth() > 0
            if hasAbsorption and not self.HadAbsorptionPrev then
                Barrier:enable()
            elseif not hasAbsorption and self.HadAbsorptionPrev then
                Barrier.disable()
            end
            self.HadAbsorptionPrev = hasAbsorption
        end)
    end
}

Barrier:init()

return Barrier