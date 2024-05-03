---@class Arms アバターの腕を制御するクラス
Arms = {
    ---弓の構えを行うかどうか
    ---@type boolean
    BowPoseEnabled = false,

    ---弓の構えを左手基準で行うかどうか
    ---@type boolean
    BowPoseLeftHanded = false,

    --前ティックで弓の構えのポーズを取っていたかどうか
    ---@type boolean
    BowPosePrev = false,

    ---弓の構えを行う。実際に弓を構えていなくても有効。
    ---@param enabled boolean 弓の構えの開始/終了
    ---@param leftHanded boolean 左手で構えているかどうか
    setBowPose = function(self, enabled, leftHanded)
        ---弓の構えを止める。
        local function stopBowPose()
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm, models.models.main.Avatar.UpperBody.Arms.LeftArm}) do
                modelPart:setRot()
            end
            events.RENDER:remove("bow_pose_render")
        end

        self.BowPoseEnabled = enabled
        if self.BowPoseEnabled then
            if events.TICK:getRegisteredCount("bow_pose_tick") == 0 then
                events.TICK:register(function ()
                    local shouldBowPose = player:getActiveItem().id ~= "minecraft:crossbow" and self.BowPoseEnabled
                    if shouldBowPose and not self.BowPosePrev then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm, models.models.main.Avatar.UpperBody.Arms.LeftArm}) do
                            modelPart:setParentType("Body")
                        end
                        if events.RENDER:getRegisteredCount("bow_pose_render") == 0 then
                            events.RENDER:register(function ()
                                local headRot = vanilla_model.HEAD:getOriginRot()
                                if self.BowPoseLeftHanded then
                                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78))
                                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + 90, headRot.y)
                                else
                                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + 90, headRot.y)
                                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21))
                                end
                            end, "bow_pose_render")
                        end
                    elseif not shouldBowPose and self.BowPosePrev then
                        stopBowPose()
                    end
                    self.BowPosePrev = shouldBowPose
                end, "bow_pose_tick")
            end
            self.BowPoseLeftHanded = leftHanded
        else
            events.tick:remove("bow_pose_tick")
            stopBowPose()
            self.BowPosePrev = false
        end
    end
}

return Arms