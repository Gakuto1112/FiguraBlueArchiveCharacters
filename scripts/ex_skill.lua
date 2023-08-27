---@class ExSkill Exスキルのアニメーションを管理するクラス
---@field SHOWN_MODELS table<ModelPart> Exスキルのアニメーション時に表示するモデルのテーブル
---@field ANIMATION_MODELS table<string> Exスキルのアニメーションが含まれるモデルファイルの名前のテーブル
---@field CAMERA_ANCHOR ModelPart Exスキルのアニメーション時にカメラの追従基準となるモデルパーツ
---@field CAMERA_START_POS Vector3 Exスキルのアニメーション開始時のカメラの位置。BlockBenchの値をそのまま入力する。
---@field CAMERA_START_ROT Vector3 Exスキルのアニメーション開始時のカメラの向き。BlockBenchの値をそのまま入力する。
---@field AnimationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
---@field TransitionCount number Exスキルのアニメーション前後のカメラのトランジションの進捗を示すカウンター
ExSkill = {
    --定数
    SHOWN_MODELS = {models.models.placement_object.PlacementObject, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet},
    ANIMATION_MODELS = {"main", "placement_object", "tea_set"},
    CAMERA_ANCHOR = models.models.main.CameraAnchor,
    CAMERA_START_POS = vectors.vec3(-2, 24, -18),
    CAMERA_START_ROT = vectors.vec3(0, 160, 0),

    --変数
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
            if ExSkill.AnimationCount == 24 then
                FaceParts:setEmotion("INVERSED", "NORMAL", "CLOSED", 5, true)
            elseif ExSkill.AnimationCount == 29 then
                FaceParts:setEmotion("INVERSED", "NORMAL", "TRIANGLE", 8, true)
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

    ---アニメーション前のみ実行されるレンダー関数
    preAnimationRender = function(delta)
        local bodyYaw = -player:getBodyYaw(delta) % 360
        local lookDir = player:getLookDir()
        local cameraRot = renderer:isCameraBackwards() and vectors.vec3(math.deg(math.asin(lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) + math.pi / 2)) or vectors.vec3(math.deg(math.asin(-lookDir.y)), math.deg(math.atan2(lookDir.z, lookDir.x) - math.pi / 2))
        local targetCameraPos = vectors.rotateAroundAxis(bodyYaw + 180, ExSkill.CAMERA_START_POS, 0, 1):add(0, -1.62)
        local targetCameraRot = ExSkill.CAMERA_START_ROT:copy():add(0, -bodyYaw, 0)

        renderer:setOffsetCameraPivot(targetCameraPos:scale(ExSkill.TransitionCount))
        renderer:setCameraPos(0, 0, RaycastUtils:getLengthBetweenPointAndCollision(player:getPos(delta):add(targetCameraPos):add(0, 1.62), CameraUtils:cameraRotToRotationVector(targetCameraRot:copy():mul(1, -1, 1))) * -1 * ExSkill.TransitionCount)
        renderer:setCameraRot(targetCameraRot:copy():sub(cameraRot):scale(ExSkill.TransitionCount):add(cameraRot))
        ExSkill.TransitionCount = math.min(ExSkill.TransitionCount + 4 / client:getFPS(), 1)
        if ExSkill.TransitionCount == 1 then
            for _, modelPart in ipairs(ExSkill.SHOWN_MODELS) do
                modelPart:setVisible(true)
            end
            for _, modelPart in ipairs(ExSkill.ANIMATION_MODELS) do
                animations["models."..modelPart]["ex_skill"]:play()
            end
            events.TICK:register(ExSkill.animationTick, "ex_skill_tick")
            events.RENDER:register(ExSkill.animationRender, "ex_skill_render")
            FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 24, true)
            events.RENDER:remove("ex_skill_prerender")
            ExSkill.AnimationCount = 0
            ExSkill.AnimationLength = animations["models.main"]["ex_skill"]:getLength() * 20
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

    ---アニメーションを再生する。
    play = function(self)
        self.TransitionCount = 0
        events.RENDER:register(self.preAnimationRender, "ex_skill_prerender")
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
        renderer:setCameraPos()
        renderer:setOffsetCameraPivot()
        renderer:setCameraRot()
    end
}

models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setPos(5.5, 12, 0)
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setRot(180, 0, 0)

ExSkill.CAMERA_START_POS:mul(-1, 1, 1):scale(1 / 16)

return ExSkill