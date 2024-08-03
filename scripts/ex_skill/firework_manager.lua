---@class FireworkManager 視覚的なロケット花火を出現させるクラス
FireworkManager = {
    ---花火インスタンスを生成するクラス
    ---@type Firework
    FireworkInstance = require("scripts.ex_skill.firework"),

    ---花火インスタンスを保持するテーブル
    ---@type table
    Fireworks = {},

    ---ロケット花火を1つ出現させる。
    ---@param self FireworkManager
    ---@param startPos Vector3 ロケット花火の出現位置
    ---@param rot Vector3 ロケット花火が飛んでいく方向
    spawn = function (self, startPos, rot)
        local instance = self.FireworkInstance.new(startPos, rot)
        instance.onInit()
        table.insert(self.Fireworks, instance)
        if #self.Fireworks == 1 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, firework in ipairs(self.Fireworks) do
                        firework.onTick()
                        if firework.deinitRequired then
                            firework.onDeinit()
                            table.remove(self.Fireworks, index)
                            if #self.Fireworks == 0 then
                                events.TICK:remove("firework_tick")
                                events.RENDER:remove("firework_render")
                            end
                        end
                    end
                end
            end, "firework_tick")
            events.RENDER:register(function (delta, context, matrix)
                if not client:isPaused() then
                    for _, firework in ipairs(self.Fireworks) do
                        firework.onRender(delta, context, matrix)
                    end
                end
            end, "firework_render")
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_firework", "World")
    end

}

FireworkManager.init()

return FireworkManager