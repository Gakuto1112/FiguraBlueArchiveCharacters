---@class ExSkill2Particles Exスキル2のクリア演出で使用するパーティクルのインスタンスクラス
ExSkill2Particles = {
    ---パーティクルを1つスポーンさせる。
    ---@return table instance パーティクルのインスタンス
    spawn = function()
        local instance = {}

        ---このパーティクルのUUID
        ---@type string
        instance.uuid = client.intUUIDToString(client:generateUUID())

        ---このパーティクルを描画するスプライト
        ---@type SpriteTask
        instance.sprite = models.models.ex_skill_2.Gui.UI.ClearEffect:newSprite("ex_skill_2_clear_effect_particle_"..instance.uuid)

        ---このパーティクルの初期位置のオフセット値
        ---@type Vector2
        instance.posOffset = vectors.vec2(math.random() * 200 - 100, math.random() * 70 - 35)

        ---このパーティクルのテクスチャのオフセット値
        ---@type integer
        instance.textureOffset = math.random(0, 1)

        ---このパーティクルの出現時間
        ---@type integer
        instance.count = 0

        ---このパーティクルの現在位置
        ---@type Vector2
        instance.currentPos = instance.posOffset:copy()

        ---このパーティクルの次の位置
        ---@type Vector2
        instance.nextPos = instance.currentPos:copy()

        instance.sprite:setTexture(textures["textures.ex_skill_2"])
        instance.sprite:setDimensions(textures["textures.ex_skill_2"]:getDimensions())
        instance.sprite:setRegion(3, 3)
        instance.sprite:setSize(10, 10)
        instance.sprite:setUVPixels(47 + instance.textureOffset, 115)
        instance.sprite:setPos(instance.posOffset.x + 5, instance.posOffset.y + 5, -1)

        events.TICK:register(function ()
            instance.currentPos = instance.nextPos:copy()
            instance.nextPos = instance.currentPos:copy():add(instance.posOffset:copy():normalize():scale(1.5))
            instance.count = instance.count + 1
            if instance.count == 12 then
                instance.sprite:setUVPixels(47 + 1 - instance.textureOffset, 115)
            elseif instance.count == 24 then
                events.TICK:remove("ex_skill_2_clear_effect_particle_tick_"..instance.uuid)
                events.RENDER:remove("ex_skill_2_clear_effect_particle_render_"..instance.uuid)
                models.models.ex_skill_2.Gui.UI.ClearEffect:removeTask("ex_skill_2_clear_effect_particle_"..instance.uuid)
            end
        end, "ex_skill_2_clear_effect_particle_tick_"..instance.uuid)

        events.RENDER:register(function (delta)
            instance.sprite:setPos(instance.nextPos:copy():sub(instance.currentPos):scale(delta):add(instance.currentPos):augmented(0))
        end, "ex_skill_2_clear_effect_particle_render_"..instance.uuid)

        return instance
    end
}

return ExSkill2Particles