---@alias ExSkill.TransitionPhase
---| "PRE"
---| "POST"

---@class ExSkill Exスキルのアニメーションを管理するクラス
ExSkill = {
    ---アバター読み込み時に自動的にExスキルが再生される。デバッグ用。
    ---@type boolean
    AUTO_PLAY = false,

    ---そのレンダーで既にレンダー処理したかどうか
    ---@type boolean
    RenderProcessed = false,

    ---Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
    ---@type integer
    AnimationCount = -1,

    ---Exスキルのアニメーションの長さ。スクリプトで自動で代入する。
    ---@type number
    AnimationLength = 0,

    ---Exスキルのアニメーション前後のカメラのトランジションの進捗を示すカウンター
    ---@type number
    TransitionCount = 0,

    ---プレイヤーの体の回転
    ---@type number[]
    BodyYaw = {},

    ---Exスキルフレームのパーティクルの量
    --- 1. 標準
    --- 2. 少なめ
    --- 3. なし
    ---@type number
    FrameParticleAmount = Config.loadConfig("exSkillFrameParticleAmount", 1),

    ---アニメーションが再生可能かどうかを返す。
    ---@return boolean animationPlayable Exスキルアニメーションが再生可能かどうか
    canPlayAnimation = function (self)
        return player:getPose() == "STANDING" and player:getVelocity():length() < 0.01 and self.BodyYaw[1] == self.BodyYaw[2] and player:isOnGround() and not player:isInWater() and not player:isInLava() and not renderer:isFirstPerson() and PlayerUtils:getDamageStatus() == "NONE" and  player:getActiveItem().id == "minecraft:air"
    end,

    ---Exスキルのアニメーションの前後のカメラのトランジションを行う関数
    ---@param direction ExSkill.TransitionPhase カメラのトランジションの向き
    ---@param callback function トランジション終了時に呼び出されるコールバック関数
    transition = function (self, direction, callback)
        if host:isHost() then
            events.TICK:register(function ()
                if not client:isPaused() then
                    local barPos = models.models.ex_skill_frame.Gui.FrameBar:getPos().x * -1
                    local windowSizeY = client:getScaledWindowSize().y
                    if self.FrameParticleAmount < 3 then
                        for _ = 1, windowSizeY / (self.FrameParticleAmount == 1 and 20 or 100) do
                            local particleOffset = math.random() * windowSizeY
                            FrameParticleManager:spawn(vectors.vec2(barPos - particleOffset - math.random() * 50, particleOffset), vectors.vec2(500, 0))
                        end
                    end
                end
            end, "ex_skill_transition_tick")
        end
        events.RENDER:register(function ()
            --カメラのトランジション
            local isPaused = client:isPaused()
            if host:isHost() and not isPaused then
                local lookDir = player:getLookDir()
                local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
                local targetCameraPos = vectors.vec3()
                local targetCameraRot = vectors.vec3()
                if direction == "PRE" then
                    targetCameraPos = vectors.rotateAroundAxis(self.BodyYaw[2] * -1 + 180, BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].camera.start.pos, 0, 1):add(0, -1.62)
                    targetCameraRot = BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].camera.start.rot:copy():add(0, self.BodyYaw[2], 0)
                else
                    targetCameraPos = vectors.rotateAroundAxis(self.BodyYaw[2] * -1 + 180, BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].camera.fin.pos, 0, 1):add(0, -1.62)
                    targetCameraRot = BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].camera.fin.rot:copy():add(0, self.BodyYaw[2], 0)
                end
                if math.abs(cameraRot.y - targetCameraRot.y) >= 180 then
                    if cameraRot.y < targetCameraRot.y then
                        cameraRot.y = cameraRot.y + 360
                    else
                        targetCameraRot.y = targetCameraRot.y + 360
                    end
                end
                CameraManager.setCameraPivot(targetCameraPos:scale(self.TransitionCount))
                CameraManager.setCameraRot(targetCameraRot:copy():sub(cameraRot):scale(self.TransitionCount):add(cameraRot))
                CameraManager:setThirdPersonCameraDistance(4 - self.TransitionCount * 4)

                --フレーム演出
                local windowSize = client:getScaledWindowSize()
                local barPos = (windowSize.x + windowSize.y + math.sqrt(2) * 16) * (direction == "PRE" and self.TransitionCount or (1 - self.TransitionCount))
                models.models.ex_skill_frame.Gui.FrameBar:setPos(-barPos, 0, 0)

                local frameTopLength = math.clamp(barPos, 32, windowSize.x)
                local frameLeftLength = math.clamp(barPos, 32, windowSize.y)
                local frameBottomLength = math.clamp(barPos - windowSize.y + 16, 32, windowSize.x)
                local frameRightLength = math.clamp(barPos - windowSize.x + 16, 32, windowSize.y)

                models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setPos(-16, -16)
                models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setPos(-windowSize.x, -16)
                models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setPos(-16, -windowSize.y)
                models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setPos(-windowSize.x, -windowSize.y)
                if direction == "PRE" then
                    models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setVisible(barPos >= 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setVisible(barPos >= windowSize.x + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setVisible(barPos >= windowSize.y + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setVisible(barPos >= windowSize.x + windowSize.y)
                    models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-frameTopLength + 16, -16)
                    models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale(frameTopLength / 16 - 2, 1, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -frameLeftLength + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, frameLeftLength / 16 - 2, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-frameBottomLength + 16, -windowSize.y)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale(frameBottomLength / 16 - 2, 1, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -frameRightLength + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, frameRightLength / 16 - 2, 1)
                else
                    models.models.ex_skill_frame.Gui.Frame.FrameTopLeft:setVisible(barPos < 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameTopRight:setVisible(barPos < windowSize.x + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft:setVisible(barPos < windowSize.y + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottomRight:setVisible(barPos < windowSize.x + windowSize.y)
                    models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-windowSize.x + 16, -16)
                    models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale((windowSize.x - frameTopLength) / 16, 1, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -windowSize.y + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, (windowSize.y - frameLeftLength) / 16, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-windowSize.x + 16, -windowSize.y)
                    models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale((windowSize.x - frameBottomLength) / 16, 1, 1)
                    models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -windowSize.y + 16)
                    models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, (windowSize.y - frameRightLength) / 16, 1)
                end
            end

            --カウンター更新
            if not (isPaused or self.RenderProcessed) then
                self.TransitionCount = direction == "PRE" and math.min(self.TransitionCount + 2 / client:getFPS(), 1) or math.max(self.TransitionCount - 2 / client:getFPS(), 0)
                if (direction == "PRE" and self.TransitionCount == 1) or (direction == "POST" and self.TransitionCount == 0) then
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.ex_skill_frame.Gui.FrameBar:setPos(0, 0, 0)
                        if direction == "PRE" then
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                                modelPart:setVisible(true)
                            end
                            models.models.ex_skill_frame.Gui.Frame.FrameTop:setPos(-windowSize.x + 16, -16)
                            models.models.ex_skill_frame.Gui.Frame.FrameTop:setScale(windowSize.x / 16 - 2, 1, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameLeft:setPos(-16, -windowSize.y + 16)
                            models.models.ex_skill_frame.Gui.Frame.FrameLeft:setScale(1, windowSize.y / 16 - 2, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameBottom:setPos(-windowSize.x + 16, -windowSize.y)
                            models.models.ex_skill_frame.Gui.Frame.FrameBottom:setScale(windowSize.x / 16 - 2, 1, 1)
                            models.models.ex_skill_frame.Gui.Frame.FrameRight:setPos(-windowSize.x, -windowSize.y + 16)
                            models.models.ex_skill_frame.Gui.Frame.FrameRight:setScale(1, windowSize.y / 16 - 2, 1)
                        else
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
                                modelPart:setVisible(false)
                            end
                            for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
                                modelPart:setScale(0, 0, 0)
                            end
                        end
                        events.TICK:remove("ex_skill_transition_tick")
                    end
                    callback()
                    events.RENDER:remove("ex_skill_transition_render")
                end
            end
            self.RenderProcessed = true
        end, "ex_skill_transition_render")
    end,

    ---アニメーションを再生する。
    play = function (self)
        PlacementObjectManager:removeAll()
        Bubble:stop()
        renderer:setFOV(70 / client:getFOV())
        renderer:setRenderHUD(false)
        CameraManager:setCameraCollisionDenial(true)
        models.models.ex_skill_frame.Gui:setColor(BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].formationType == "STRIKER" and vectors.vec3(1, 0.75, 0.75) or vectors.vec3(0.75, 1, 1))
        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2)
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.preTransition ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.preTransition()
        end
        models.models.ex_skill_frame.Gui.FrameBar:setScale(1, client:getScaledWindowSize().y * math.sqrt(2) / 16 + 1, 1)
        events.TICK:register(function ()
            if not self:canPlayAnimation() then
                self:forceStop()
            end
        end, "ex_skill_tick")
        self:transition("PRE", function ()
            Physics.disable()
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(false)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].models) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].animations) do
                animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill]:play()
            end
            if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.preAnimation ~= nil then
                BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.preAnimation()
            end
            CameraManager:setThirdPersonCameraDistance(0)
            events.TICK:register(function ()
                if not client:isPaused() then
                    if self.AnimationCount == self.AnimationLength - 1 then
                        self:stop()
                    elseif self:canPlayAnimation() and animations["models.main"]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill]:isPlaying() then
                        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.animationTick ~= nil then
                            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.animationTick(self.AnimationCount)
                        end
                        self.AnimationCount = self.AnimationCount > -1 and self.AnimationCount + 1 or self.AnimationCount
                    end
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        local windowCenter = windowSize:copy():scale(0.5)
                        if self.FrameParticleAmount < 3 then
                            for _ = 1, (windowSize.x * 2 + windowSize.y * 2) / (self.FrameParticleAmount == 1 and 100 or 500) do
                                local particlePos = vectors.vec2(math.random() * (windowSize.x * 2 + windowSize.y * 2), math.random() * 16)
                                particlePos = particlePos.x <= windowSize.x and particlePos or (particlePos.x <= windowSize.x + windowSize.y and vectors.vec2(windowSize.x - particlePos.y, particlePos.x - windowSize.x) or (particlePos.x <= windowSize.x * 2 + windowSize.y and vectors.vec2(particlePos.x - (windowSize.x + windowSize.y), windowSize.y - particlePos.y) or vectors.vec2(particlePos.y, particlePos.x - (windowSize.x * 2 + windowSize.y))))
                                FrameParticleManager:spawn(particlePos, windowCenter:copy():sub(particlePos):scale(0.25))
                            end
                        end
                    end
                end
            end, "ex_skill_animation_tick")
            if host:isHost() then
                events.RENDER:register(function ()
                    if not client:isPaused() then
                        CameraManager.setCameraPivot(vectors.rotateAroundAxis(self.BodyYaw[2] * -1 + 180, models.models.main.CameraAnchor:getAnimPos():scale(1 / 16), 0, 1, 0):add(0, -1.62, 0))
                        CameraManager.setCameraRot(models.models.main.CameraAnchor:getAnimRot():scale(-1):add(0, self.BodyYaw[2], 0))
                    end
                end, "ex_skill_animation_render")
            end
            self.AnimationCount = 0
            self.AnimationLength = math.round(animations["models.main"]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill]:getLength() * 20)
        end)
    end,

    ---アニメーションを停止する。
    stop = function (self)
        if host:isHost() then
            sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].animations) do
            animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill]:stop()
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postAnimation ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postAnimation(false)
        end
        events.TICK:remove("ex_skill_animation_tick")
        if host:isHost() then
            events.RENDER:remove("ex_skill_animation_render")
        end
        self.AnimationCount = -1
        Physics:enable()
        renderer:setFOV()
        self:transition("POST", function ()
            if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postTransition ~= nil then
                BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postTransition(false)
            end
            CameraManager.setCameraPivot()
            CameraManager.setCameraRot()
            CameraManager:setThirdPersonCameraDistance(4)
            CameraManager:setCameraCollisionDenial(false)
            renderer:setRenderHUD(true)
            events.TICK:remove("ex_skill_tick")
        end)
    end,

    ---アニメーションを停止させる。終了時のトランジションも無効
    forceStop = function (self)
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].animations) do
            animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill]:stop()
        end
        for _, eventName in ipairs({"ex_skill_tick", "ex_skill_animation_tick"}) do
            events.TICK:remove(eventName)
        end
        events.RENDER:remove("ex_skill_transition_render")
        if host:isHost() then
            events.TICK:remove("ex_skill_transition_tick")
            events.RENDER:remove("ex_skill_animation_render")
        end
        Physics:enable()
        models.models.ex_skill_frame.Gui.FrameBar:setPos()
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
            modelPart:setScale(0, 0, 0)
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postAnimation ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postAnimation(true)
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postTransition ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill].callbacks.postTransition(true)
        end
        FaceParts:resetEmotion()
        CameraManager.setCameraPivot()
        CameraManager.setCameraRot()
        CameraManager:setThirdPersonCameraDistance(4)
        CameraManager:setCameraCollisionDenial(false)
        renderer:setRenderHUD(true)
        renderer:setFOV()
        self.AnimationCount = -1
        self.TransitionCount = 0
    end,

    ---Exスキルスクリプトの初期化関数
    init = function (self)
        for _, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
            exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16)
            exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16)
        end
        if host:isHost() then
            KeyManager:register("ex_skill", Config.loadConfig("keybind.ex_skill", "key.keyboard.v"), function ()
                if ExSkill:canPlayAnimation() and ExSkill.AnimationCount == -1 and ExSkill.TransitionCount == 0 then
                    pings.ex_skill()
                else
                    print(Language:getTranslate("key_bind__ex_skill__unavailable"..(renderer:isFirstPerson() and "_firstperson" or "")))
                    sounds:playSound("minecraft:block.note_block.bass", player:getPos(), 1, 0.5)
                end
            end)
        end
        if self.AUTO_PLAY then
            local init = true
            events.TICK:register(function ()
                if init then
                    self:play()
                    init = false
                end
            end)
        end
        table.insert(self.BodyYaw, player:getBodyYaw() % 360)
        events.TICK:register(function ()
            if not renderer:isFirstPerson() then
                table.insert(self.BodyYaw, player:getBodyYaw() % 360)
                if #self.BodyYaw == 3 then
                    table.remove(self.BodyYaw, 1)
                end
            end
        end)
        events.WORLD_RENDER:register(function ()
            self.RenderProcessed = false
        end)
    end
}

function pings.ex_skill()
    ExSkill:play()
end

ExSkill:init()

return ExSkill