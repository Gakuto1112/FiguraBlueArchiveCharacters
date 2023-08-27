---@alias ExSkill.TransitionPhase
---| "PRE"
---| "POST"

---@class ExSkill Exスキルのアニメーションを管理するクラス
---@field SHOWN_MODELS table<ModelPart> Exスキルのアニメーション時に表示するモデルのテーブル
---@field ANIMATION_MODELS table<string> Exスキルのアニメーションが含まれるモデルファイルの名前のテーブル
---@field CAMERA_ANCHOR ModelPart Exスキルのアニメーション時にカメラの追従基準となるモデルパーツ
---@field CAMERA_START_POS Vector3 Exスキルのアニメーション開始時のカメラの位置。BlockBenchの値をそのまま入力する。
---@field CAMERA_START_ROT Vector3 Exスキルのアニメーション開始時のカメラの向き。BlockBenchの値をそのまま入力する。
---@field CAMERA_END_POS Vector3 Exスキルのアニメーション終了時のカメラの位置。BlockBenchの値をそのまま入力する。
---@field CAMERA_END_ROT Vector3 Exスキルのアニメーション終了時のカメラの向き。BlockBenchの値をそのまま入力する。
---@field ExclamationText TextTask Exスキルのアニメーション中に表示する「！！」のテキストタスク
---@field AnimationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
---@field AnimationLength integer Exスキルのアニメーションの長さ。スクリプトで自動で代入する。
---@field TransitionCount number Exスキルのアニメーション前後のカメラのトランジションの進捗を示すカウンター
ExSkill = {
    --定数
    SHOWN_MODELS = {models.models.placement_object.PlacementObject, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet},
    ANIMATION_MODELS = {"main", "placement_object", "tea_set"},
    CAMERA_ANCHOR = models.models.main.CameraAnchor,
    CAMERA_START_POS = vectors.vec3(-2, 24, -18),
    CAMERA_START_ROT = vectors.vec3(0, 160, 0),
    CAMERA_END_POS = vectors.vec3(-146, 25, -33),
    CAMERA_END_ROT = vectors.vec3(0, 250, 0),

    --変数
    ExclamationText = models.models.main.CameraAnchor:newText("ex_skill_text"):setVisible(false):setText("§c! !"):setRot(0, 180, 5):setScale(0.8, 0.8, 0.8):setOutline(true):setOutlineColor(1, 1, 1),
    AnimationCount = -1,
    AnimationLength = 0,
    TransitionCount = 0,

    --関数
    ---アニメーション再生中のみ実行されるティック関数
    animationTick = function()
        if ExSkill.AnimationCount == ExSkill.AnimationLength - 1 then
            ExSkill:stop()
            ExSkill.AnimationCount = -1
        else
            if ExSkill.AnimationCount >= 24 and ExSkill.AnimationCount < 36 then
                if ExSkill.AnimationCount == 24 then
                    ExSkill.ExclamationText:setVisible(true)
                    FaceParts:setEmotion("INVERSED", "NORMAL", "CLOSED", 5, true)
                elseif ExSkill.AnimationCount == 29 then
                    FaceParts:setEmotion("INVERSED", "NORMAL", "TRIANGLE", 8, true)
                end
                ExSkill.ExclamationText:setPos(vectors.vec3(-7, 6, -6):add(math.random() * 0.2 - 0.05, math.random() * 0.2 - 0.05))
            elseif ExSkill.AnimationCount == 36 then
                ExSkill.ExclamationText:setVisible(false)
            elseif ExSkill.AnimationCount == 37 then
                FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 2, true)
            elseif ExSkill.AnimationCount == 39 then
                FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
            elseif ExSkill.AnimationCount == 46 then
                FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 9, true)
            elseif ExSkill.AnimationCount == 57 then
                FaceParts:setEmotion("SURPLISED", "SURPLISED", "TRIANGLE", 43, true)
            end
            ExSkill.AnimationCount = ExSkill.AnimationCount + 1
        end
    end,

    ---アニメーション再生中のみ実行されるレンダー関数
    animationRender = function(delta)
        local bodyYaw = player:getBodyYaw(delta)
        local cameraPos = vectors.rotateAroundAxis(-bodyYaw % 360 + 180, ExSkill.CAMERA_ANCHOR:getTruePos():scale(1 / 16), 0, 1, 0):add(0, -1.62, 0)
        local cameraRot = ExSkill.CAMERA_ANCHOR:getTrueRot():mul(-1, -1, -1):add(0, player:getBodyYaw(delta) % 360)
        renderer:setOffsetCameraPivot(cameraPos)
        renderer:setCameraPos(0, 0, RaycastUtils:getLengthBetweenPointAndCollision(cameraPos:copy():add(player:getPos(delta)):add(0, 1.62, 0), CameraUtils:cameraRotToRotationVector(cameraRot):scale(-1)) * -1)
        renderer:setCameraRot(cameraRot)
    end,

    ---Exスキルのアニメーションの前後のカメラのトランジションを行う関数
    ---@param direction ExSkill.TransitionPhase カメラのトランジションの向き
    ---@param callback function トランジション終了時に呼び出されるコールバック関数
    transition = function(self, direction, callback)
        events.RENDER:register(function (delta)
            --カメラのトランジション
            local bodyYaw = -player:getBodyYaw(delta) % 360
            local lookDir = player:getLookDir()
            local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
            local targetCameraPos = vectors.vec3()
            local targetCameraRot = vectors.vec3()
            if direction == "PRE" then
                targetCameraPos = vectors.rotateAroundAxis(bodyYaw + 180, self.CAMERA_START_POS, 0, 1):add(0, -1.62)
                targetCameraRot = self.CAMERA_START_ROT:copy():add(0, -bodyYaw, 0)
            else
                targetCameraPos = vectors.rotateAroundAxis(bodyYaw + 180, self.CAMERA_END_POS, 0, 1):add(0, -1.62)
                targetCameraRot = self.CAMERA_END_ROT:copy():add(0, -bodyYaw, 0)
            end
            if cameraRot.y * targetCameraRot.y < 0 then
                if cameraRot.y < 0 then
                    cameraRot.y = cameraRot.y + 360
                else
                    targetCameraRot.y = targetCameraRot.y + 360
                end
            end
            renderer:setOffsetCameraPivot(targetCameraPos:scale(self.TransitionCount))
            renderer:setCameraPos(0, 0, RaycastUtils:getLengthBetweenPointAndCollision(player:getPos(delta):add(targetCameraPos):add(0, 1.62), CameraUtils:cameraRotToRotationVector(targetCameraRot):scale(-1)) * -1 * self.TransitionCount)
            renderer:setCameraRot(targetCameraRot:copy():sub(cameraRot):scale(self.TransitionCount):add(cameraRot))

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
            self.TransitionCount = direction == "PRE" and math.min(self.TransitionCount + 4 / client:getFPS(), 1) or math.max(self.TransitionCount - 4 / client:getFPS(), 0)
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
        end, "ex_skill_transition")
    end,

    ---アニメーションを再生する。
    play = function(self)
        renderer:setRenderHUD(false)
        self:transition("PRE", function()
            for _, modelPart in ipairs(self.SHOWN_MODELS) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(self.ANIMATION_MODELS) do
                animations["models."..modelPart]["ex_skill"]:play()
            end
            events.TICK:register(self.animationTick, "ex_skill_tick")
            events.RENDER:register(self.animationRender, "ex_skill_render")
            FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 24, true)
            self.AnimationCount = 0
            self.AnimationLength = animations["models.main"]["ex_skill"]:getLength() * 20
        end)
    end,

    ---アニメーションを停止する。
    stop = function(self)
        for _, modelPart in ipairs(self.SHOWN_MODELS) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(self.ANIMATION_MODELS) do
            animations["models."..modelPart]["ex_skill"]:stop()
        end
        events.TICK:remove("ex_skill_tick")
        events.RENDER:remove("ex_skill_render")
        self:transition("POST", function()
            renderer:setCameraPos()
            renderer:setOffsetCameraPivot()
            renderer:setCameraRot()
            renderer:setRenderHUD(true)
        end)
    end,

    ---アニメーションを停止させる。終了時のトランジションも無効
    forceStop = function(self)
        self:stop()
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTopLeft, models.models.ex_skill_frame.Gui.Frame.FrameTopRight, models.models.ex_skill_frame.Gui.Frame.FrameBottomLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottomRight}) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs({models.models.ex_skill_frame.Gui.Frame.FrameTop, models.models.ex_skill_frame.Gui.Frame.FrameLeft, models.models.ex_skill_frame.Gui.Frame.FrameBottom, models.models.ex_skill_frame.Gui.Frame.FrameRight}) do
            modelPart:setScale(0, 0, 0)
        end
        renderer:setCameraPos()
        renderer:setOffsetCameraPivot()
        renderer:setCameraRot()
        renderer:setRenderHUD(false)
        self.TransitionCount = 0
    end
}

events.TICK:register(function()
    models.models.ex_skill_frame.Gui.FrameBar:setScale(1, client:getScaledWindowSize().y * math.sqrt(2) / 16 + 1, 1)
end)

models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setPos(5.5, 12, 0)
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setRot(180, 0, 0)

ExSkill.CAMERA_START_POS:mul(-1, 1, 1):scale(1 / 16)
ExSkill.CAMERA_END_POS:mul(-1, 1, 1):scale(1 / 16)

return ExSkill