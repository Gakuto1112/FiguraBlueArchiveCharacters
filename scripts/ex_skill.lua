---@alias ExSkill.TransitionPhase
---| "PRE"
---| "POST"

---@class ExSkill Exスキルのアニメーションを管理するクラス
ExSkill = {
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

    ---Exスキルアニメーション開始時のプレイヤーのBodyYaw
    ---@type number
    BodyYaw = 0,

    ---アニメーションが再生可能かどうかを返す。
    ---@return boolean animationPlayable Exスキルアニメーションが再生可能かどうか
    canPlayAnimation = function(self)
        local velocity = player:getVelocity()
        local bodyYawPrev = self.BodyYaw
        self.BodyYaw = player:getBodyYaw() % 360
        return player:getPose() == "STANDING" and velocity:length() < 0.01 and bodyYawPrev == self.BodyYaw and player:isOnGround() and not player:isInWater() and not player:isInLava() and not renderer:isFirstPerson() and PlayerUtils:getDamageStatus() == "NONE"
    end,

    ---アニメーション再生中のみ実行されるティック関数
    animationTick = function()
        if not client:isPaused() then
            if ExSkill.AnimationCount == ExSkill.AnimationLength - 1 then
                ExSkill:stop()
            elseif ExSkill:canPlayAnimation() then
                if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.animationTick ~= nil then
                    BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.animationTick(ExSkill.AnimationCount)
                end
                ExSkill.AnimationCount = ExSkill.AnimationCount > -1 and ExSkill.AnimationCount + 1 or ExSkill.AnimationCount
            else
                ExSkill:forceStop()
            end
        end
    end,

    ---アニメーション再生中のみ実行されるレンダー関数
    animationRender = function(self, delta)
        local bodyYaw = self.BodyYaw
        local cameraPos = vectors.rotateAroundAxis(-bodyYaw % 360 + 180, models.models.main.CameraAnchor:getAnimPos():scale(1 / 16 * 0.9375), 0, 1, 0):add(0, -1.62, 0)
        CameraManager.setCameraPivot(cameraPos)
        CameraManager.setCameraRot(models.models.main.CameraAnchor:getAnimRot():scale(-1):add(0, bodyYaw % 360, 0))
        ExSkill.RenderProcessed = true
    end,

    ---Exスキルのアニメーションの前後のカメラのトランジションを行う関数
    ---@param direction ExSkill.TransitionPhase カメラのトランジションの向き
    ---@param callback function トランジション終了時に呼び出されるコールバック関数
    transition = function(self, direction, callback)
        events.RENDER:register(function (delta)
            --カメラのトランジション
            local bodyYaw = -self.BodyYaw
            local lookDir = player:getLookDir()
            local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
            local targetCameraPos = vectors.vec3()
            local targetCameraRot = vectors.vec3()
            if direction == "PRE" then
                targetCameraPos = vectors.rotateAroundAxis(bodyYaw + 180, BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].camera.start.pos, 0, 1):add(0, -1.62)
                targetCameraRot = BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].camera.start.rot:copy():add(0, -bodyYaw, 0)
            else
                targetCameraPos = vectors.rotateAroundAxis(bodyYaw + 180, BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].camera.fin.pos, 0, 1):add(0, -1.62)
                targetCameraRot = BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].camera.fin.rot:copy():add(0, -bodyYaw, 0)
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

            --カウンター更新
            if not client:isPaused() and not ExSkill.RenderProcessed then
                self.TransitionCount = direction == "PRE" and math.min(self.TransitionCount + 4 / client:getFPS(), 1) or math.max(self.TransitionCount - 4 / client:getFPS(), 0)
            end
            if (direction == "PRE" and self.TransitionCount == 1) or (direction == "POST" and self.TransitionCount == 0) then
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
                callback()
                events.RENDER:remove("ex_skill_transition")
            end
            ExSkill.RenderProcessed = true
        end, "ex_skill_transition")
    end,

    ---アニメーションを再生する。
    play = function(self)
        PlacementObjectManager:removeAll()
        Bubble:stop()
        renderer:setFOV(70 / client:getFOV())
        renderer:setRenderHUD(false)
        CameraManager:setCameraCollisionDenial(true)
        models.models.ex_skill_frame.Gui:setColor(BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].formationType == "STRIKER" and vectors.vec3(1, 0.75, 0.75) or vectors.vec3(0.75, 1, 1))
        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2)
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.preTransition ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.preTransition()
        end
        self:transition("PRE", function()
            Physics.disable()
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(false)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].models) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].animations) do
                animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill]:play()
            end
            if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.preAnimation ~= nil then
                BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.preAnimation()
            end
            CameraManager:setThirdPersonCameraDistance(0)
            events.TICK:register(self.animationTick, "ex_skill_tick")
            events.RENDER:register(function ()
                self:animationRender()
            end, "ex_skill_render")
            self.AnimationCount = 0
            self.AnimationLength = math.round(animations["models.main"]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill]:getLength() * 20)
        end)
    end,

    ---アニメーションを停止する。
    stop = function(self)
        if host:isHost() then
            sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 5, 2)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].animations) do
            animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill]:stop()
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postAnimation ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postAnimation(false)
        end
        events.TICK:remove("ex_skill_tick")
        events.RENDER:remove("ex_skill_render")
        ExSkill.AnimationCount = -1
        Physics:enable()
        renderer:setFOV()
        self:transition("POST", function()
            if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postTransition ~= nil then
                BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postTransition(false)
            end
            CameraManager.setCameraPivot()
            CameraManager.setCameraRot()
            CameraManager:setThirdPersonCameraDistance(4)
            CameraManager:setCameraCollisionDenial(false)
            renderer:setRenderHUD(true)
        end)
    end,

    ---アニメーションを停止させる。終了時のトランジションも無効
    forceStop = function(self)
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].models) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].animations) do
            animations["models."..modelPart]["ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill]:stop()
        end
        events.TICK:remove("ex_skill_tick")
        for _, eventName in ipairs({"ex_skill_render", "ex_skill_transition"}) do
            events.RENDER:remove(eventName)
        end
        Physics:enable()
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
            modelPart:setScale(0, 0, 0)
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postAnimation ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postAnimation(true)
        end
        if BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postTransition ~= nil then
            BlueArchiveCharacter.EX_SKILL[BlueArchiveCharacter.COSTUME.costumes[Costume.CostumeList[Costume.CurrentCostume]].exSkill].callbacks.postTransition(true)
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
    end
}

events.TICK:register(function()
    models.models.ex_skill_frame.Gui.FrameBar:setScale(1, client:getScaledWindowSize().y * math.sqrt(2) / 16 + 1, 1)
end)

events.WORLD_RENDER:register(function()
    ExSkill.RenderProcessed = false
end)

for _, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
	exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16 * 0.9375)
	exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16 *  0.9375)
end

return ExSkill