---@class MissileManager 視覚的なミサイルを出現させるクラス
MissileManager = {
    ---花火インスタンスを生成するクラス
    ---@type Missile
    MissileInstance = require("scripts.missile.missile"),

    ---花火インスタンスを保持するテーブル
    ---@type table
    Missiles = {},

    ---ロケット花火を1つ出現させる。
    ---@param self MissileManager
    ---@param startPos Vector3 ロケット花火の出現位置
    ---@param rot Vector3 ロケット花火が飛んでいく方向
    spawn = function (self, startPos, rot)
        local instance = self.MissileInstance.new(startPos, rot)
        instance.onInit()
        table.insert(self.Missiles, instance)
        if #self.Missiles == 1 then
            events.TICK:register(function ()
                if not client:isPaused() then
                    for index, missile in ipairs(self.Missiles) do
                        missile.onTick()
                        if missile.deinitRequired then
                            missile.onDeinit()
                            table.remove(self.Missiles, index)
                            if #self.Missiles == 0 then
                                events.TICK:remove("missile_tick")
                                events.RENDER:remove("missile_render")
                            end
                        end
                    end
                end
            end, "missile_tick")
            events.RENDER:register(function (delta, context, matrix)
                if not client:isPaused() then
                    for _, missile in ipairs(self.Missiles) do
                        missile.onRender(delta, context, matrix)
                    end
                end
            end, "missile_render")
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_missile", "World")
    end

}

MissileManager.init()

return MissileManager