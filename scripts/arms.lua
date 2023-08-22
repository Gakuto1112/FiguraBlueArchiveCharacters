---@class Arms アバターの腕を制御するクラス
---@field BowPoseLeftHanded boolean 弓の構えを左手基準で行うかどうか
Arms = {
    BowPoseLeftHanded = false,

    ---弓の構えを行う。実際に弓を構えていなくても有効。
    ---@param enabled boolean 弓の構えの開始/終了
    ---@param leftHanded boolean 左手で構えているかどうか
    setBowPose = function(enabled, leftHanded)
        if enabled then
            local function bowPoseRender()
                local headRot = vanilla_model.HEAD:getOriginRot()
                if Arms.BowPoseLeftHanded then
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + 90, math.map(headRot.y, -50, 50, -21, 78))
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + 90, headRot.y)
                else
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + 90, headRot.y)
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + 90, math.map(headRot.y, -50, 50, -78, 21))
                end
            end

            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm, models.models.main.Avatar.UpperBody.Arms.LeftArm}) do
                modelPart:setParentType("Body")
            end
            Arms.BowPoseLeftHanded = leftHanded
            if events.RENDER:getRegisteredCount("bow_pose_render") == 0 then
                events.RENDER:register(bowPoseRender, "bow_pose_render")
            end
        else
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm, models.models.main.Avatar.UpperBody.Arms.LeftArm}) do
                modelPart:setRot()
            end
            events.RENDER:remove("bow_pose_render")
        end
    end
}

return Arms