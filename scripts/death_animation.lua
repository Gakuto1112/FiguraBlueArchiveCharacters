---@class DeathAnimation プレイヤーが死亡した際の、キャラクターがヘリコプターで回収されるアニメーションを管理するクラス
DeathAnimation = {
    ---死亡アニメーションに使用されるダミーのアバターのルート
    ---@type ModelPart
    DummyAvatarRoot = models.models.death_animation.DummyAvatar,

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
        local hasShield = BlueArchiveCharacter.HasShield
        if hasShield then
            BlueArchiveCharacter:setShield(false, false)
        end
        Physics:disable()
        if BlueArchiveCharacter.DEATH_ANIMATION.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onBeforeModelCopy()
        end

        ---指定されたモデルパーツの子パーツをすべて削除した上でコピー元のモデルからディープコピーする。
        ---@param destination ModelPart コピー先のモデルパーツ
        ---@param targetModel ModelPart コピー元となるモデルパーツ
        ---@param filter function? コピー処理の対象をフィルタリングする関数。第一引数にモデルパーツが代入される。戻り値をtrueにするとフィルタで弾くことができる。
        local function removeAndCopyModels(destination, targetModel, filter)
            for _, modelPart in ipairs(destination:getChildren()) do
                if filter == nil or not filter(modelPart) then
                    modelPart:remove()
                end
            end
            for _, modelPart in ipairs(targetModel:getChildren()) do
                if filter == nil or not filter(modelPart) then
                    local copiedPart = ModelUtils:copyModel(modelPart)
                    if copiedPart ~= nil then
                        destination:addChild(copiedPart)
                    end
                end
            end
        end

        ---存在しないかもしれないモデルパーツを安全に削除する。
        ---@param target ModelPart 削除対象のモデルパーツ（nilでも可）
        local function removeUnsafeModel(target)
            if target ~= nil then
                target:remove()
            end
        end

        --頭
        removeAndCopyModels(models.models.death_animation.DummyAvatar.Head, models.models.main.Avatar.Head)
        models.models.death_animation.DummyAvatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[2] * 6)
        models.models.death_animation.DummyAvatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[2] * 6)
        models.models.death_animation.DummyAvatar.Head.FaceParts.Mouth:remove()
        models.models.death_animation.DummyAvatar.Head.HeadRing:setRot()
        removeUnsafeModel(models.models.death_animation.DummyAvatar.Head.ArmorH)


        --体
        removeAndCopyModels(models.models.death_animation.DummyAvatar.UpperBody.Body, models.models.main.Avatar.UpperBody.Body, function (modelPart)
            return modelPart:getName() == "Gun"
        end)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.UpperBody.Body.ArmorB)

        --右腕
        removeAndCopyModels(models.models.death_animation.DummyAvatar.UpperBody.Arms.RightArm, models.models.main.Avatar.UpperBody.Arms.RightArm)
        models.models.death_animation.DummyAvatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot:remove()
        removeUnsafeModel(models.models.death_animation.DummyAvatar.UpperBody.Arms.RightArm.ArmorRA)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB)

        --左腕
        removeAndCopyModels(models.models.death_animation.DummyAvatar.UpperBody.Arms.LeftArm, models.models.main.Avatar.UpperBody.Arms.LeftArm)
        models.models.death_animation.DummyAvatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftItemPivot:remove()
        removeUnsafeModel(models.models.death_animation.DummyAvatar.UpperBody.Arms.LeftArm.ArmorLA)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB)

        --右脚上部
        removeAndCopyModels(models.models.death_animation.DummyAvatar.LowerBody.Legs.RightLeg, models.models.main.Avatar.LowerBody.Legs.RightLeg, function (modelPart)
            return modelPart:getName() == "RightLegBottom"
        end)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.LowerBody.Legs.RightLeg.ArmorRL)

        --右脚下部
        removeAndCopyModels(models.models.death_animation.DummyAvatar.LowerBody.Legs.RightLeg.RightLegBottom, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB)

        --左脚
        removeAndCopyModels(models.models.death_animation.DummyAvatar.LowerBody.Legs.LeftLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.LowerBody.Legs.LeftLeg.ArmorLL)
        removeUnsafeModel(models.models.death_animation.DummyAvatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB)

        --武器
        if BlueArchiveCharacter.GUN.put.type == "BODY" then
            if models.models.death_animation.DummyAvatar.UpperBody.Body.Gun ~= nil then
                models.models.death_animation.DummyAvatar.UpperBody.Body.Gun:remove()
            end
            models.models.death_animation.DummyAvatar.UpperBody.Body:addChild(ModelUtils:copyModel(models.models.main.Avatar.UpperBody.Body.Gun))
            local leftHanded = player:isLeftHanded()
            models.models.death_animation.DummyAvatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.GUN.put.pos[leftHanded and "left" or "right"]))
            models.models.death_animation.DummyAvatar.UpperBody.Body.Gun:setRot(BlueArchiveCharacter.GUN.put.rot[leftHanded and "left" or "right"])
        end

        for index, modelPart in ipairs(BlueArchiveCharacter.DEATH_ANIMATION.excludeModels) do
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(true)
            end
        end
        if hasShield then
            BlueArchiveCharacter:setShield(true, false)
        end
        Physics:enable()
        if BlueArchiveCharacter.DEATH_ANIMATION.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onAfterModelCopy()
        end

        --死亡アニメーションを生成する。
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
                    models.models.death_animation.DummyAvatar:setLight(world.getLightLevel(self.AnimationPos))
                end
                if self.AnimationCount == 1 then
                    self:spawnHelicopterParticles()
                elseif self.AnimationCount == 10 then
                    sounds:playSound("minecraft:block.iron_door.open", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.DeathAnimationSoundAnchor1), 1, 0.5)
                elseif self.AnimationCount >= 57 and self.AnimationCount < 76 then
                    sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14), 0.25, -0.056 * (self.AnimationCount - 57) + 2)
                elseif self.AnimationCount == 120 then
                    models.models.death_animation.DummyAvatar:setLight()
                    self.DummyAvatarRoot = models.models.death_animation.DummyAvatar:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
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
        if BlueArchiveCharacter.GUN.put.type == "BODY" then
            models.models.death_animation.DummyAvatar.UpperBody.Body:addChild(models:newPart("Gun"))
        end
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