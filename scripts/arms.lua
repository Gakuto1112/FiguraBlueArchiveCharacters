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

    ---弓の構え時の微妙な手の揺れを再現するカウンター
    ---@type number
    ArmSwingCounter = 0,

    ---弓の構えを行う。実際に弓を構えていなくても有効。
    ---@param self Arms
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
            events.TICK:remove("bow_pose_tick_2")
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
                        if events.TICK:getRegisteredCount("bow_pose_tick_2") == 0 then
                            events.TICK:register(function ()
                                self.ArmSwingCounter = self.ArmSwingCounter + 1
                                self.ArmSwingCounter = self.ArmSwingCounter == 100 and 0 or self.ArmSwingCounter
                            end, "bow_pose_tick_2")
                            events.RENDER:register(function (delta)
                                local headRot = vanilla_model.HEAD:getOriginRot()
                                local armSwingOffset = math.sin((self.ArmSwingCounter + delta) / 100 * math.pi * 2) * 2.5
                                if self.BowPoseLeftHanded then
                                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + armSwingOffset + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0)
                                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + armSwingOffset * -1 + 90, headRot.y, 0)
                                else
                                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + armSwingOffset + 90, headRot.y, 0)
                                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + armSwingOffset * -1 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0)
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