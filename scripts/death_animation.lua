---@class DeathAnimation プレイヤーが死亡した際の、キャラクターがヘリコプターで回収されるアニメーションを管理するクラス
DeathAnimation = {
    ---死亡アニメーションに使用されるダミーのアバターのルート。アバターが未生成の場合はnilが入っている。
    ---@type ModelPart?
    DummyAvatarRoot = models.models.death_animation.Avatar,

    ---死亡アニメーションの再生カウンター
    ---@type number
    AnimationCount = 0,

    ---アニメーションを再生している場所の座標
    ---@type Vector3
    AnimationPos = vectors.vec3(),

    ---アニメーションを再生している向き（度数法で示す）
    ---@type number
    AnimationRot = 0,

    ---プレイヤーモデルが不可視かどうか
    ---@type boolean
    PlayerInvisible = false,

    ---死亡アニメーションのコスチュームのインデックス
    ---@type integer
    CostumeIndex = 1,

    ---ヘリコプターの出現/消滅パーティクルを生成する。
    spawnHelicopterParticles = function (self)
        local helicopterPos = ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter)
        for _ = 1, 100 do
            particles:newParticle("minecraft:poof", helicopterPos:copy():add(vectors.rotateAroundAxis(self.AnimationRot, math.random() * 9.375 - 4.6875, math.random() * 11.125 - 5.5625, math.random() * 23.875 - 11.9375, 0, math.abs(helicopterPos.y), 0)))
        end
    end,

    ---死亡アニメーションを再生する。
    play = function (self)
        self:stop()
        self.CostumeIndex = Costume.CurrentCostume

        --ダミーアバターを生成する。
        local excludeModelsVisibleList = {}
        for index, modelPart in ipairs(BlueArchiveCharacter.DEATH_ANIMATION.excludeModels) do
            excludeModelsVisibleList[index] = modelPart:getVisible()
            modelPart:setVisible(false)
        end
        Physics:disable()
        if BlueArchiveCharacter.DEATH_ANIMATION.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onBeforeModelCopy()
        end

        ---存在しないかもしれないモデルパーツを安全に削除する。
        ---@param target ModelPart 削除対象のモデルパーツ（nilでも可）
        local function removeUnsafeModel(target)
            if target ~= nil then
                target:remove()
            end
        end

        local unsafeModels = {models.models.death_animation.Avatar, models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.Avatar}
        for i = 1, 2 do
            removeUnsafeModel(unsafeModels[i])
        end

        models.models.death_animation:addChild(ModelUtils:copyModel(models.models.main.Avatar))
        models.models.death_animation.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[2] * 6)
        models.models.death_animation.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[2] * 6)
        models.models.death_animation.Avatar.Head.HeadRing:setRot()
        for _, modelPart in ipairs({models.models.death_animation.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot, models.models.death_animation.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftItemPivot}) do
            modelPart:remove()
        end
        unsafeModels = {models.models.death_animation.Avatar.Head.FaceParts.Mouth, models.models.death_animation.Avatar.Head.ArmorH, models.models.death_animation.Avatar.UpperBody.Body.ArmorB, models.models.death_animation.Avatar.UpperBody.Arms.RightArm.ArmorRA, models.models.death_animation.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB, models.models.death_animation.Avatar.UpperBody.Arms.LeftArm.ArmorLA, models.models.death_animation.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB, models.models.death_animation.Avatar.LowerBody.Legs.RightLeg.ArmorRL, models.models.death_animation.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB, models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg.ArmorLL, models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB}
        for i = 1, 11 do
            removeUnsafeModel(unsafeModels[i])
        end
        if models.models.death_animation.Avatar.UpperBody.Body.Gun ~= nil then
            if BlueArchiveCharacter.GUN.put.type == "BODY" then
                local leftHanded = player:isLeftHanded()
                models.models.death_animation.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.GUN.put.pos[leftHanded and "left" or "right"]))
                models.models.death_animation.Avatar.UpperBody.Body.Gun:setRot(BlueArchiveCharacter.GUN.put.rot[leftHanded and "left" or "right"])
            else
                models.models.death_animation.Avatar.UpperBody.Body.Gun:remove()
            end
        end

        for index, modelPart in ipairs(BlueArchiveCharacter.DEATH_ANIMATION.excludeModels) do
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(true)
            end
        end
        Physics:enable()
        if BlueArchiveCharacter.DEATH_ANIMATION.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onAfterModelCopy()
        end

        --死亡アニメーションを生成する。
        for _, modelPart in ipairs({models.models.death_animation.Avatar, models.models.death_animation.Avatar.Head, models.models.death_animation.Avatar.UpperBody, models.models.death_animation.Avatar.UpperBody.Body, models.models.death_animation.Avatar.UpperBody.Arms, models.models.death_animation.Avatar.UpperBody.Arms.RightArm, models.models.death_animation.Avatar.UpperBody.Arms.RightArm.RightArmBottom, models.models.death_animation.Avatar.UpperBody.Arms.LeftArm, models.models.death_animation.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom, models.models.death_animation.Avatar.LowerBody, models.models.death_animation.Avatar.LowerBody.Legs, models.models.death_animation.Avatar.LowerBody.Legs.RightLeg, models.models.death_animation.Avatar.LowerBody.Legs.RightLeg.RightLegBottom, models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg, models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom}) do
            modelPart:setPos()
            modelPart:setRot()
            modelPart:setScale()
        end
        models.models.death_animation.Avatar:setPos(0, -12, 0)
        models.models.death_animation.Avatar.Head:setRot(-30, 0, 0)
        models.models.death_animation.Avatar.UpperBody.Arms.RightArm:setRot(35, 0, -20)
        models.models.death_animation.Avatar.UpperBody.Arms.LeftArm:setRot(35, 0, 20)
        models.models.death_animation.Avatar.LowerBody.Legs.RightLeg:setRot(90, -10, 0)
        models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg:setRot(90, 10, 0)
        self.AnimationPos = player:getPos()
        models.models.death_animation:setPos(self.AnimationPos:copy():scale(16))
        self.AnimationRot = (-player:getBodyYaw() + 180) % 360
        models.models.death_animation:setRot(0, self.AnimationRot)
        models.models.death_animation:setVisible(true)
        animations["models.death_animation"]["death_animation"]:play()
        if BlueArchiveCharacter.DEATH_ANIMATION.onPhase1 ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onPhase1(self.CostumeIndex)
        end
        if events.TICK:getRegisteredCount("death_animation_tick") == 0 then
            events.TICK:register(function ()
                local particleAnchorPos = ModelUtils.getModelWorldPos(models.models.death_animation.DeathAnimationParticleAnchor)
                for _ = 1, 3 do
                    local particleRot = math.random() * math.pi * 2
                    local particleOffset = math.random() * 3
                    particles:newParticle("minecraft:poof", particleAnchorPos:copy():add(math.cos(particleRot) * particleOffset, 0, math.sin(particleRot) * particleOffset)):setVelocity(math.cos(particleRot), 0, math.sin(particleRot))

                end
                if self.AnimationCount % 2 == 1 then
                    sounds:playSound("minecraft:block.bamboo_wood_door.close", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                end
                if self.AnimationCount < 120 then
                    models.models.death_animation.Avatar:setLight(world.getLightLevel(self.AnimationPos))
                end
                if self.AnimationCount == 1 then
                    self:spawnHelicopterParticles()
                elseif self.AnimationCount == 10 then
                    sounds:playSound("minecraft:block.iron_door.open", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                elseif self.AnimationCount >= 57 and self.AnimationCount < 76 then
                    sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14), 0.25, -0.056 * (self.AnimationCount - 57) + 2)
                elseif self.AnimationCount == 120 then
                    models.models.death_animation.Avatar:setPos(3, -210, 2)
                    models.models.death_animation.Avatar:setRot(105, 75, 90)
                    models.models.death_animation.Avatar.Head:setRot(0, -40, 0)
                    models.models.death_animation.Avatar.UpperBody.Arms.RightArm:setRot(47.5, 0, 20)
                    models.models.death_animation.Avatar.UpperBody.Arms.LeftArm:setRot(-30, 0, -15)
                    models.models.death_animation.Avatar.LowerBody.Legs.RightLeg:setRot(80, 0, 0)
                    models.models.death_animation.Avatar.LowerBody.Legs.RightLeg.RightLegBottom:setRot(-75, 0, 0)
                    models.models.death_animation.Avatar.LowerBody.Legs.LeftLeg:setRot(10, 0, 0)
                    models.models.death_animation.Avatar:setLight()
                    self.DummyAvatarRoot = models.models.death_animation.Avatar:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
                    if BlueArchiveCharacter.DEATH_ANIMATION.onPhase2 ~= nil then
                        BlueArchiveCharacter.DEATH_ANIMATION.onPhase2(self.CostumeIndex)
                    end
                elseif self.AnimationCount == 230 then
                    sounds:playSound("minecraft:block.iron_door.close", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                elseif self.AnimationCount == 255 then
                    self:spawnHelicopterParticles()
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
        if models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.DummyAvatar ~= nil then
            self.DummyAvatarRoot = models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.DummyAvatar:moveTo(models.models.death_animation)
        end
        animations["models.death_animation"]["death_animation"]:stop()
        events.TICK:remove("death_animation_tick")
        events.WORLD_TICK:remove("death_animation_world_tick")
        self.AnimationCount = 0
    end,

    ---初期化関数
    init = function (self)
        events.TICK:register(function ()
            if PlayerUtils:getDamageStatus() == "DIED" then
                self:play()
                models.models.main:setVisible(false)
                for _, vanillaModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM, vanilla_model.ELYTRA}) do
                    vanillaModel:setVisible(false)
                end
                self.PlayerInvisible = true
            end
            if self.PlayerInvisible and player:getHealth() > 0 then
                models.models.main:setVisible(true)
                for _, vanillaModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM, vanilla_model.ELYTRA}) do
                    vanillaModel:setVisible(true)
                end
                self.PlayerInvisible = false
            end
        end)
    end
}

DeathAnimation:init()

return DeathAnimation