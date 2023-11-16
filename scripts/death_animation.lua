---@class DeathAnimation プレイヤーが死亡した際の、キャラクターがヘリコプターで回収されるアニメーションを管理するクラス
DeathAnimation = {
    ---死亡アニメーションの再生カウンター
    ---@type number
    AnimationCount = 0,

    ---死亡アニメーションを再生する。
    play = function (self)
        models.models.death_animation:setPos(player:getPos():scale(16))
        models.models.death_animation:setVisible(true)
        animations["models.death_animation"]["death_animation"]:play()
        if events.TICK:getRegisteredCount("death_animation_tick") == 0 then
            events.TICK:register(function ()
                if self.AnimationCount == 120 then
                    models.models.death_animation.DummyAvatar:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
                elseif self.AnimationCount >= 255 then
                    self:stop()
                end
            end, "death_animation_tick")
        end
        if events.WORLD_TICK:getRegisteredCount("death_animation_world_tick") == 0 then
            events.WORLD_TICK:register(function ()
                self.AnimationCount = self.AnimationCount + 1
            end, "death_animation_world_tick")
        end
    end,

    ---死亡アニメーションを停止する。
    stop = function (self)
        models.models.death_animation:setVisible(false)
        models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.DummyAvatar:moveTo(models.models.death_animation)
        events.TICK:remove("death_animation_tick")
        events.WORLD_TICK:remove("death_animation_world_tick")
        self.AnimationCount = 0
    end
}

--デバッグ用
keybinds:newKeybind("death_animation_play", "key.keyboard.z"):onPress(function ()
    DeathAnimation:play()
end)

return DeathAnimation