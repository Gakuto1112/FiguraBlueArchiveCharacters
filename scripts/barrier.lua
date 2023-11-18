---@class Barrier バリアの視覚効果を管理するクラス
Barrier = {
    ---バリアのアニメーションのカウンター
    ---@type number[]
    AnimationCounters = {},

    ---レンダーイベントを処理したかどうか
    IsRenderProcessed = false,

    ---バリア機能を有効化する。
    enable = function (self)
        models.models.barrier:setVisible(true)

        for i = 1, 32 do
            self.AnimationCounters[i] = math.random()
        end

        if events.RENDER:getRegisteredCount("barrier_render") == 0 then
            events.RENDER:register(function ()
                if not self.IsRenderProcessed and not client:isPaused() then
                    local renderCount = 0.5 / client:getFPS()
                    for index, modelPart in ipairs(models.models.barrier.Barrier:getChildren()) do
                        self.AnimationCounters[index] = self.AnimationCounters[index] + renderCount
                        if self.AnimationCounters[index] > 1 then
                            self.AnimationCounters[index] = self.AnimationCounters[index] - 1
                        end
                        local opacity = math.sin(self.AnimationCounters[index] * 2 * math.pi) / 2 + 0.5
                        modelPart:setColor(opacity, opacity, 1)
                        modelPart:setOpacity(opacity)
                    end
                    self.IsRenderProcessed = true
                end
            end, "barrier_render")
        end

        if events.WORLD_RENDER:getRegisteredCount("barrier_world_render") == 0 then
            events.WORLD_RENDER:register(function ()
                self.IsRenderProcessed = false
            end, "barrier_world_render")
        end
    end,

    ---バリア機能を無効化する。
    disable = function ()
        models.models.barrier:setVisible(false)

        events.RENDER:remove("barrier_render")
        events.WORLD_RENDER:remove("barrier_world_render")
    end
}

---前ティックぶ衝撃吸収のハートを持っていたかどうか
---@type boolean
local hadAbsorptionPrev = false

models.models.barrier:setLight(15)

events.TICK:register(function ()
    local hasabsorption = player:getAbsorptionAmount() > 0
    if hasabsorption and not hadAbsorptionPrev then
        Barrier:enable()
    elseif not hasabsorption and hadAbsorptionPrev then
        Barrier.disable()
    end
    hadAbsorptionPrev = hasabsorption
end)

return Barrier