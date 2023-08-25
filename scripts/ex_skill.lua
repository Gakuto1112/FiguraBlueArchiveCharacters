---@class ExSkill Exスキルのアニメーションを管理するクラス
---@field SHOWN_MODELS table<ModelPart> Exスキルのアニメーション時に表示するモデルのテーブル
---@field ANIMATION_MODELS table<string> Exスキルのアニメーションが含まれるモデルファイルの名前のテーブル
---@field CAMERA_ANCHOR ModelPart Exスキルのアニメーション時にカメラの追従基準となるモデルパーツ
---@field AnimationCount integer Exスキルのアニメーション再生中に増加するカウンター。-1はアニメーション停止中を示す。
ExSkill = {
    --定数
    SHOWN_MODELS = {models.models.placement_object.PlacementObject, models.models.tea_set.TeaSet},
    ANIMATION_MODELS = {"main", "placement_object", "tea_set"},
    CAMERA_ANCHOR = models.models.main.CameraAnchor,

    --変数
    AnimationCount = -1,

    --関数
    ---アニメーション再生中のみ実行されるティック関数
    animationTick = function ()
        if ExSkill.AnimationCount == 0 then
            ExSkill.stop()
            ExSkill.AnimationCount = -1
        else
            ExSkill.AnimationCount = ExSkill.AnimationCount - 1
        end
    end,

    ---アニメーション再生中のみ実行されるレンダー関数
    animationRender = function (delta)
        renderer:setCameraPivot(player:getPos(delta))
        renderer:setCameraPos(ExSkill.CAMERA_ANCHOR:getTruePos() / 16)
        renderer:setCameraRot(ExSkill.CAMERA_ANCHOR:getTrueRot() + vectors.vec3(0, player:getBodyYaw(delta)))
    end,

    ---アニメーションを再生する。
    play = function ()
        for _, modelPart in ipairs(ExSkill.SHOWN_MODELS) do
            modelPart:setVisible(true)
        end
        for _, modelPart in ipairs(ExSkill.ANIMATION_MODELS) do
            animations["models."..modelPart]["ex_skill"]:play()
        end
        events.TICK:register(ExSkill.animationTick, "ex_skill_tick")
        events.RENDER:register(ExSkill.animationRender, "ex_skill_render")
        ExSkill.AnimationCount = animations["models.main"]["ex_skill"]:getLength() * 20
    end,

    ---アニメーションを停止する。
    stop = function ()
        for _, modelPart in ipairs(ExSkill.SHOWN_MODELS) do
            modelPart:setVisible(false)
        end
        for _, modelPart in ipairs(ExSkill.ANIMATION_MODELS) do
            animations["models."..modelPart]["ex_skill"]:stop()
        end
        events.TICK:remove("ex_skill_tick")
        events.RENDER:remove("ex_skill_render")
        renderer:setCameraPivot()
        renderer:setCameraPos()
        renderer:setCameraRot()
    end
}

return ExSkill