---@class DeathAnimation プレイヤーが死亡した際の、キャラクターがヘリコプターで回収されるアニメーションを管理するクラス
DeathAnimation = {
    ---死亡アニメーションの再生カウンター
    ---@type number
    AnimationCount = 0,

    ---アニメーションを再生している場所の座標
    ---@type Vector3
    AnimationPos = vectors.vec3(),

    ---プレイヤーモデルが不可視かどうか
    ---@type boolean
    playerInvisible = false,

    ---死亡アニメーションを再生する。
    play = function (self)
        self:stop()
        self.AnimationPos = player:getPos()
        models.models.death_animation:setPos(self.AnimationPos:copy():scale(16))
        models.models.death_animation:setRot(0, -player:getBodyYaw() + 180)
        models.models.death_animation:setVisible(true)
        animations["models.death_animation"]["death_animation"]:play()
        if events.TICK:getRegisteredCount("death_animation_tick") == 0 then
            events.TICK:register(function ()
                if self.AnimationCount < 120 then
                    models.models.death_animation.DummyAvatar:setLight(world.getLightLevel(self.AnimationPos))
                elseif self.AnimationCount >= 255 then
                    self:stop()
                elseif self.AnimationCount >= 120 and models.models.death_animation.DummyAvatar:getParent() == models.models.death_animation then
                    models.models.death_animation.DummyAvatar:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
                end
                local particleAnchorPos = PlayerUtils:getModelWorldPos(models.models.death_animation.DeathAnimationParticleAnchor)
                for _ = 1, 3 do
                    local particleRot = math.random() * math.pi * 2
                    local particleOffset = math.random() * 3
                    particles:newParticle("minecraft:poof", particleAnchorPos:copy():add(math.cos(particleRot) * particleOffset, 0, math.sin(particleRot) * particleOffset)):setVelocity(math.cos(particleRot), 0, math.sin(particleRot))

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
        if models.models.death_animation.DummyAvatar:getParent() == models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14 then
            models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.DummyAvatar:moveTo(models.models.death_animation)
        end
        animations["models.death_animation"]["death_animation"]:stop()
        events.TICK:remove("death_animation_tick")
        events.WORLD_TICK:remove("death_animation_world_tick")
        self.AnimationCount = 0
    end,

    ---毎ティック呼び出す関数
    onTick = function (self)
        if PlayerUtils:getDamageStatus() == "DIED" then
            DeathAnimation:play()
            models.models.main:setVisible(false)
            self.playerInvisible = true
        end
        if self.playerInvisible and player:getHealth() > 0 then
            models.models.main:setVisible(true)
            self.playerInvisible = false
        end
    end
}

events.TICK:register(function ()
    DeathAnimation:onTick()
end)

---@diagnostic disable-next-line: redundant-parameter
models.models.death_animation.DummyAvatar.Head:addChild(models.models.main.Avatar.Head.HeadRing:copy("HeadRing"))
if BlueArchiveCharacter.GUN.put.type == "BODY" then
    ---@diagnostic disable-next-line: redundant-parameter
    models.models.death_animation.DummyAvatar.UpperBody.Body:addChild(models.models.main.Avatar.UpperBody.Body.Gun:copy("Gun"))
end

--デバッグ用
keybinds:newKeybind("death_animation_play", "key.keyboard.z"):onPress(function ()
    DeathAnimation:play()
end)

return DeathAnimation