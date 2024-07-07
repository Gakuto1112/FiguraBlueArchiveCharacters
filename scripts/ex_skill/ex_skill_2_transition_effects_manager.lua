---@class ExSkill2TransitionEffectsManager Exスキル2のトランジションで使用するスプライトを管理するクラス
ExSkill2TransitionEffectsManager = {
    ---トランジションスプライトのクラス
    ---@type ExSkill2TransitionEffects
    TransitionClass = require("scripts.ex_skill.ex_skill_2_transition_effects"),

    ---スプライトのインスタンスを保持するテーブル
    ---@type table[]
    Sprites = {},

    ---トランジションを1つ作成する。
    ---@param self ExSkill2TransitionEffectsManager
    ---@param pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
    spawn = function (self, pos)
        table.insert(self.Sprites, self.TransitionClass.spawn(pos))
        if #self.Sprites == 1 then
            events.TICK:register(function ()
                for index, sprite in ipairs(self.Sprites) do
                    sprite:onTick()
                    if sprite.count == 13 then
                        sprite:onDeinit()
                        table.remove(self.Sprites, index)
                        if #self.Sprites == 0 then
                            events.TICK:remove("ex_skill_2_transition_tick")
                            events.RENDER:remove("ex_skill_2_transition_render")
                        end
                    end
                end
            end, "ex_skill_2_transition_tick")
            events.RENDER:register(function (delta)
                for _, sprite in ipairs(self.Sprites) do
                    sprite:onRender(delta)
                end
            end, "ex_skill_2_transition_delta")
        end
    end,

    ---トランジションを再生する
    ---@param self ExSkill2TransitionEffectsManager
    play = function (self)
        local spriteDimension = client:getScaledWindowSize():scale(1 / 50):ceil()
        local count = 0
        events.TICK:register(function ()
            for i = 0, math.max(math.min(count, spriteDimension.x - count - 1), spriteDimension.y - 1) do
                if count - i >= 0 and count - i <= spriteDimension.x - 1 then
                    self:spawn(vectors.vec2(count - i, i))
                end
            end
            count = count + 1
            if count == spriteDimension.x + spriteDimension.y - 1 then
                events.TICK:remove("ex_skill_2_transition_manager_tick")
            end
        end, "ex_skill_2_transition_manager_tick")
    end
}

return ExSkill2TransitionEffectsManager