---@class ExSkill Exスキルのアニメーションを管理するクラス
---@field SHOWN_MODELS table<ModelPart> Exスキルのアニメーション時に表示するモデルのテーブル
---@field ANIMATION_MODELS table<string> Exスキルのアニメーションが含まれるモデルファイルの名前のテーブル
---@field CAMERA_ANCHOR ModelPart Exスキルのアニメーション時にカメラの追従基準となるモデルパーツ
---@field AnimationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
ExSkill = {
    --定数
    SHOWN_MODELS = {models.models.placement_object.PlacementObject, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet},
    ANIMATION_MODELS = {"main", "placement_object", "tea_set"},
    CAMERA_ANCHOR = models.models.main.CameraAnchor,

    --変数
    AnimationCount = -1,
    AnimationLength = 0,

    --関数
    ---アニメーション再生中のみ実行されるティック関数
    animationTick = function()
        if ExSkill.AnimationCount == ExSkill.AnimationLength - 1 then
            ExSkill.stop()
            ExSkill.AnimationCount = -1
        else
            if ExSkill.AnimationCount == 24 then
                FaceParts.setEmotion("INVERSED", "NORMAL", "CLOSED", 5, true)
            elseif ExSkill.AnimationCount == 29 then
                FaceParts.setEmotion("INVERSED", "NORMAL", "TRIANGLE", 8, true)
            elseif ExSkill.AnimationCount == 37 then
                FaceParts.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 2, true)
            elseif ExSkill.AnimationCount == 39 then
                FaceParts.setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
            elseif ExSkill.AnimationCount == 46 then
                FaceParts.setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 9, true)
            elseif ExSkill.AnimationCount == 57 then
                FaceParts.setEmotion("SURPLISED", "SURPLISED", "TRIANGLE", 43, true)
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
        renderer:setCameraPos(0, 0, RaycastUtils.getLengthBetweenPointAndCollision(cameraPos:copy():add(player:getPos(delta)):add(0, 1.62, 0), vectors.rotateAroundAxis(0, vectors.rotateAroundAxis(cameraRot.z, vectors.rotateAroundAxis(-cameraRot.y, vectors.rotateAroundAxis(cameraRot.x, vectors.vec3(0, 0, 1), 1, 0, 0), 0, 1, 0), 0, 0, 1), 0, 1, 0):scale(-1)) * -1)
        renderer:setCameraRot(cameraRot)
end,

    ---アニメーションを再生する。
    play = function()
        for _, modelPart in ipairs(ExSkill.SHOWN_MODELS) do
            modelPart:setVisible(true)
        end
        for _, modelPart in ipairs(ExSkill.ANIMATION_MODELS) do
            animations["models."..modelPart]["ex_skill"]:play()
        end
        events.TICK:register(ExSkill.animationTick, "ex_skill_tick")
        events.RENDER:register(ExSkill.animationRender, "ex_skill_render")
        FaceParts.setEmotion("NORMAL", "NORMAL", "OPENED", 24, true)
        ExSkill.AnimationCount = 0
        ExSkill.AnimationLength = animations["models.main"]["ex_skill"]:getLength() * 20
        end,

    ---アニメーションを停止する。
    stop = function()
        for _, modelPart in ipairs(ExSkill.SHOWN_MODELS) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(ExSkill.ANIMATION_MODELS) do
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

return ExSkill