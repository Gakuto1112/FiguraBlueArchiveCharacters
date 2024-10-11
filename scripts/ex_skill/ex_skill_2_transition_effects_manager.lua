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
                    if sprite.count == 14 then
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
            end, "ex_skill_2_transition_render")
        end
    end,

    ---トランジションを再生する
    ---@param self ExSkill2TransitionEffectsManager
    play = function (self)
        local spriteDimension = client:getScaledWindowSize():scale(1 / 50):ceil()
        local linesPerTick = (spriteDimension.x + spriteDimension.y - 1) / 10
        local targetLine = 0
        local currentLine = 0
        events.TICK:register(function ()
            while currentLine <= targetLine do
                for i = 0, math.max(math.min(currentLine, spriteDimension.x - currentLine - 1), spriteDimension.y - 1) do
                    if currentLine - i >= 0 and currentLine - i <= spriteDimension.x - 1 then
                        self:spawn(vectors.vec2(currentLine - i, i))
                    end
                end
                currentLine = currentLine + 1
                if currentLine == spriteDimension.x + spriteDimension.y - 1 then
                    events.TICK:remove("ex_skill_2_transition_manager_tick")
                    break
                end
            end
            targetLine = targetLine + linesPerTick
        end, "ex_skill_2_transition_manager_tick")
    end,

    ---トランジションを停止する。
    ---@param self ExSkill2TransitionEffectsManager
    stop = function(self)
        for _, eventName in ipairs({"ex_skill_2_transition_manager_tick", "ex_skill_2_transition_tick"}) do
            events.TICK:remove(eventName)
        end
        events.RENDER:remove("ex_skill_2_transition_render")
        while #self.Sprites > 0 do
            self.Sprites[1].onDeinit()
            table.remove(self.Sprites, 1)
        end
    end
}

return ExSkill2TransitionEffectsManager