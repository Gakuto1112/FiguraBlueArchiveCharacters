---@class ExSkill2TransitionEffects Exスキル2のトランジションで使用するスプライトのクラス
ExSkill2TransitionEffects = {
    ---スプライトを1つスポーンさせる。
    ---@param pos Vector2 スプライトの位置（左からx番目、上からy番目のスプライト）
    ---@return table instance スプライトのインスタンス
    spawn = function(pos)
        local instance = {}

        ---このスプライトのUUID
        ---@type string
        instance.uuid = client.intUUIDToString(client:generateUUID())

        ---このインスタンスで操作するスプライト
        ---@type SpriteTask
        instance.sprite = models.models.ex_skill_2.Gui.TransitionAnchor:newSprite("ex_skill_2_transition_sprite_"..instance.uuid)

        ---スプライトアニメーションのカウンター
        ---@type integer
        instance.count = 0

        ---ティック関数
        instance.onTick = function (self)
            if self.count == 4 then
                self.sprite:setColor(0.8, 0.7, 0.7)
            end
            self.count = self.count + 1
        end

        ---レンダー関数
        ---@param delta number デルタ値
        instance.onRender = function (self, delta)
            local actualTick = self.count + delta
            local scale = actualTick <= 2 and actualTick * 25 or (actualTick <= 10 and 50 or (actualTick <= 12 and actualTick * -25 + 300 or 0))
            local rot = actualTick <= 2 and actualTick * 45 or (actualTick <= 10 and 90 or (actualTick <= 12 and actualTick * 45 - 360 or 180))
            self.sprite:setPos(pos.x * -50 - 25 + math.cos(math.rad(rot * -1 + 45)) * scale * math.sqrt(2) / 2, pos.y * -50 - 25 + math.sin(math.rad(rot * -1 + 45)) * scale * math.sqrt(2) / 2)
            self.sprite:setRot(0, 0, rot * -1)
            self.sprite:setSize(vectors.vec2(1, 1):scale(scale))
        end

        ---インスタンスを破棄する際に呼ばれる関数
        instance.onDeinit = function (self)
            models.models.ex_skill_2.Gui.TransitionAnchor:removeTask("ex_skill_2_transition_sprite_"..instance.uuid)
        end

        instance.sprite:setTexture(textures["textures.ex_skill_2"])
        instance.sprite:setDimensions(textures["textures.ex_skill_2"]:getDimensions())
        instance.sprite:setRegion(1, 1)
        instance.sprite:setUVPixels(47, 115)

        return instance
    end
}

return ExSkill2TransitionEffects