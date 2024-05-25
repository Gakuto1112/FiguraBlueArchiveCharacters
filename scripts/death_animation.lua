---@class DeathAnimation プレイヤーが死亡した際の、キャラクターがヘリコプターで回収されるアニメーションを管理するクラス
DeathAnimation = {
    ---デバッグモードを有効にするかどうか。デバッグモードモードではxキーでフェーズ1のモデルを、cキーでフェーズ2のモデルを表示できる。
    ---@type boolean
    DEBUG_MODE = false,

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
    ---@param self DeathAnimation
    spawnHelicopterParticles = function (self)
        local helicopterPos = ModelUtils.getModelWorldPos(models.models.death_animation.Helicopter)
        for _ = 1, 100 do
            particles:newParticle("minecraft:poof", helicopterPos:copy():add(vectors.rotateAroundAxis(self.AnimationRot, math.random() * 9.375 - 4.6875, math.random() * 11.125 - 5.5625, math.random() * 23.875 - 11.9375, 0, math.abs(helicopterPos.y), 0)))
        end
    end,

    ---存在しないかもしれないモデルパーツを安全に削除する。
    ---@param target ModelPart 削除対象のモデルパーツ（nilでも可）
    removeUnsafeModel = function (target)
        if target ~= nil then
            target:remove()
        end
    end,

    ---死亡アニメーション用のダミーアバターを生成する。
    ---@param self DeathAnimation
    ---@param parent ModelPart ダミーアバターをアタッチする親のモデルパーツ
    generateDummyAvatar = function (self, parent)
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

        parent:addChild(ModelUtils:copyModel(models.models.main.Avatar))
        parent.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.LeftEye.TIRED[2] * 6)
        parent.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[1] * 6, BlueArchiveCharacter.FACE_PARTS.RightEye.TIRED[2] * 6)
        parent.Avatar.Head.HeadRing:setRot()
        for _, modelPart in ipairs({parent.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot, parent.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftItemPivot}) do
            modelPart:remove()
        end
        local unsafeModels = {parent.Avatar.Head.FaceParts.Mouth, parent.Avatar.Head.ArmorH, parent.Avatar.UpperBody.Body.ArmorB, parent.Avatar.UpperBody.Arms.RightArm.ArmorRA, parent.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB, parent.Avatar.UpperBody.Arms.LeftArm.ArmorLA, parent.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB, parent.Avatar.LowerBody.Legs.RightLeg.ArmorRL, parent.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB, parent.Avatar.LowerBody.Legs.LeftLeg.ArmorLL, parent.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB}
        for i = 1, 11 do
            self.removeUnsafeModel(unsafeModels[i])
        end
        if parent.Avatar.UpperBody.Body.Gun ~= nil then
            if BlueArchiveCharacter.GUN.put.type == "BODY" then
                local leftHanded = player:isLeftHanded()
                parent.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.GUN.put.pos[leftHanded and "left" or "right"]))
                parent.Avatar.UpperBody.Body.Gun:setRot(BlueArchiveCharacter.GUN.put.rot[leftHanded and "left" or "right"])
            else
                parent.Avatar.UpperBody.Body.Gun:remove()
            end
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
    end,

    ---ダミーアバター状態をリセットする。
    ---@param avatarRoot ModelPart ダミーアバターのルート
    resetDummyAvatar = function (avatarRoot)
        for _, modelPart in ipairs({avatarRoot, avatarRoot.Head, avatarRoot.UpperBody, avatarRoot.UpperBody.Body, avatarRoot.UpperBody.Arms, avatarRoot.UpperBody.Arms.RightArm, avatarRoot.UpperBody.Arms.RightArm.RightArmBottom, avatarRoot.UpperBody.Arms.LeftArm, avatarRoot.UpperBody.Arms.LeftArm.LeftArmBottom, avatarRoot.LowerBody, avatarRoot.LowerBody.Legs, avatarRoot.LowerBody.Legs.RightLeg, avatarRoot.LowerBody.Legs.RightLeg.RightLegBottom, avatarRoot.LowerBody.Legs.LeftLeg, avatarRoot.LowerBody.Legs.LeftLeg.LeftLegBottom}) do
            modelPart:setPos()
            modelPart:setRot()
            modelPart:setScale()
        end
    end,

    ---ダミーアバターをフェーズ1のポーズにする。
    ---@param avatarRoot ModelPart ダミーアバターのルート
    setPhase1Pose = function (avatarRoot)
        avatarRoot:setPos(0, -12, 0)
        avatarRoot.Head:setRot(-30, 0, 0)
        avatarRoot.UpperBody.Arms.RightArm:setRot(35, 0, -20)
        avatarRoot.UpperBody.Arms.LeftArm:setRot(35, 0, 20)
        avatarRoot.LowerBody.Legs.RightLeg:setRot(90, -10, 0)
        avatarRoot.LowerBody.Legs.LeftLeg:setRot(90, 10, 0)
    end,

    ---ダミーアバターをフェーズ2のポーズにする。
    ---@param avatarRoot ModelPart ダミーアバターのルート
    setPhase2Pose = function (avatarRoot)
        avatarRoot:setPos(3, -210, 2)
        avatarRoot:setRot(105, 75, 90)
        avatarRoot.Head:setRot(0, -40, 0)
        avatarRoot.UpperBody.Arms.RightArm:setRot(47.5, 0, 20)
        avatarRoot.UpperBody.Arms.LeftArm:setRot(-30, 0, -15)
        avatarRoot.LowerBody.Legs.RightLeg:setRot(80, 0, 0)
        avatarRoot.LowerBody.Legs.RightLeg.RightLegBottom:setRot(-75, 0, 0)
        avatarRoot.LowerBody.Legs.LeftLeg:setRot(10, 0, 0)
        avatarRoot:setLight()
    end,

    ---死亡アニメーションを再生する。
    ---@param self DeathAnimation
    play = function (self)
        self:stop()
        self.CostumeIndex = Costume.CurrentCostume

        --ダミーアバターを生成する。
        local unsafeModels = {models.models.death_animation.Avatar, models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.Avatar}
        for i = 1, 2 do
            self.removeUnsafeModel(unsafeModels[i])
        end
        self:generateDummyAvatar(models.models.death_animation)

        --死亡アニメーションを生成する。
        self.resetDummyAvatar(models.models.death_animation.Avatar)
        self.setPhase1Pose(models.models.death_animation.Avatar)
        self.AnimationPos = player:getPos()
        models.models.death_animation:setPos(self.AnimationPos:copy():scale(16))
        self.AnimationRot = (-player:getBodyYaw() + 180) % 360
        models.models.death_animation:setRot(0, self.AnimationRot)
        models.models.death_animation:setVisible(true)
        animations["models.death_animation"]["death_animation"]:play()
        if BlueArchiveCharacter.DEATH_ANIMATION.onPhase1 ~= nil then
            BlueArchiveCharacter.DEATH_ANIMATION.onPhase1(models.models.death_animation.Avatar, self.CostumeIndex)
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
                    self.DummyAvatarRoot = models.models.death_animation.Avatar:moveTo(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14)
                    self.setPhase2Pose(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.Avatar)
                    if BlueArchiveCharacter.DEATH_ANIMATION.onPhase2 ~= nil then
                        BlueArchiveCharacter.DEATH_ANIMATION.onPhase2(models.models.death_animation.Helicopter.RopeLadder.RopeLadder2.RopeLadder3.RopeLadder4.RopeLadder5.RopeLadder6.RopeLadder7.RopeLadder8.RopeLadder9.RopeLadder10.RopeLadder11.RopeLadder12.RopeLadder13.RopeLadder14.Avatar, self.CostumeIndex)
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
    ---@param self DeathAnimation
    stop = function (self)
        models.models.death_animation:setVisible(false)
        animations["models.death_animation"]["death_animation"]:stop()
        events.TICK:remove("death_animation_tick")
        events.WORLD_TICK:remove("death_animation_world_tick")
        self.DummyAvatarRoot = nil
        self.AnimationCount = 0
    end,

    ---初期化関数
    ---@param self DeathAnimation
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
        if self.DEBUG_MODE then
            models:addChild(models:newPart("script_death_animation_debug", "World"))
            keybinds:newKeybind("[DEBUG] Spawn death animation phase1 model", "key.keyboard.x"):onPress(function ()
                self.removeUnsafeModel(models.script_death_animation_debug.Avatar)
                self:generateDummyAvatar(models.script_death_animation_debug)
                self.resetDummyAvatar(models.script_death_animation_debug.Avatar)
                self.setPhase1Pose(models.script_death_animation_debug.Avatar)
                models.script_death_animation_debug.Avatar:setPos(player:getPos():add(0, -0.75, 0):scale(16))
                if BlueArchiveCharacter.DEATH_ANIMATION.onPhase1 ~= nil then
                    BlueArchiveCharacter.DEATH_ANIMATION.onPhase1(models.script_death_animation_debug.Avatar, Costume.CurrentCostume)
                end
            end)
            keybinds:newKeybind("[DEBUG] Spawn death animation phase2 model", "key.keyboard.c"):onPress(function ()
                self.removeUnsafeModel(models.script_death_animation_debug.Avatar)
                self:generateDummyAvatar(models.script_death_animation_debug)
                self.resetDummyAvatar(models.script_death_animation_debug.Avatar)
                self.setPhase2Pose(models.script_death_animation_debug.Avatar)
                models.script_death_animation_debug.Avatar:setPos(player:getPos():scale(16))
                if BlueArchiveCharacter.DEATH_ANIMATION.onPhase2 ~= nil then
                    BlueArchiveCharacter.DEATH_ANIMATION.onPhase2(models.script_death_animation_debug.Avatar, Costume.CurrentCostume)
                end
            end)
        end
    end
}

DeathAnimation:init()

return DeathAnimation