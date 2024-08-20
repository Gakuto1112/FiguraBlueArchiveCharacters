---@class Arms アバターの腕を制御するクラス
Arms = {
    ---腕の角度のオフセット値。銃を構えているときには適用されない。
    ---@type Vector3[]
    ArmOffsetRot = {vectors.vec3(), vectors.vec3()},

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

    ---このレンダーフレームでレンダー処理を終わらせたかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---腕の角度を更新する。`self:setRightArmOffsetRot()`と`self:setLeftArmOffsetRot()`用。
    ---@param self Arms
    updateArmRot = function (self)
        if not self.BowPoseEnabled then
            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(self.ArmOffsetRot[1])
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(self.ArmOffsetRot[2])
        end
    end,

    ---右腕の角度のオフセット値を設定する。銃を構えているときには適用されない。
    ---@param self Arms
    ---@param offsetRot Vector3 新しい右腕の角度のオフセット値
    setRightArmOffsetRot = function (self, offsetRot)
        self.ArmOffsetRot[1] = offsetRot:copy()
        self:updateArmRot()
    end,

    ---左腕の角度のオフセット値を設定する。銃を構えているときには適用されない。
    ---@param self Arms
    ---@param offsetRot Vector3 新しい右腕の角度のオフセット値
    setLeftArmOffsetRot = function (self, offsetRot)
        self.ArmOffsetRot[2] = offsetRot:copy()
        self:updateArmRot()
    end,

    ---弓の構えを行う。実際に弓を構えていなくても有効。
    ---@param self Arms
    ---@param enabled boolean 弓の構えの開始/終了
    ---@param leftHanded boolean 左手で構えているかどうか
    setBowPose = function(self, enabled, leftHanded)
        ---弓の構えを止める。
        local function stopBowPose()
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(self.ArmOffsetRot[1])
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(self.ArmOffsetRot[2])
            events.RENDER:remove("bow_pose_render")
            events.WORLD_RENDER:remove("bow_pose_world_render")
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
                                if not self.IsRenderProcessed then
                                    if not client:isPaused() then
                                        self.ArmSwingCounter = self.ArmSwingCounter + 0.2 / client:getFPS()
                                        if self.ArmSwingCounter > 1 then
                                            self.ArmSwingCounter = self.ArmSwingCounter - 1
                                        end
                                    end
                                    local headRot = vanilla_model.HEAD:getOriginRot()
                                    local armSwingOffset = math.sin(self.ArmSwingCounter * math.pi * 2) * 2.5
                                    if self.BowPoseLeftHanded then
                                        models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(BlueArchiveCharacter.DronePosition == "LEFT" and vectors.vec3() or vectors.vec3(headRot.x + armSwingOffset + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0))
                                        models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + armSwingOffset * -1 + 90, headRot.y, 0)
                                    else
                                        models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + armSwingOffset + 90, headRot.y, 0)
                                        models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(BlueArchiveCharacter.DronePosition == "RIGHT" and vectors.vec3() or vectors.vec3(headRot.x + armSwingOffset * -1 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0))
                                    end
                                    self.IsRenderProcessed = true
                                end
                            end, "bow_pose_render")
                        end
                        if events.WORLD_RENDER:getRegisteredCount("bow_pose_world_render") == 0 then
                            events.WORLD_RENDER:register(function ()
                                self.IsRenderProcessed = false
                            end, "bow_pose_world_render")
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