---@class Arms アバターの腕を制御するクラス
Arms = {
    ---腕の状態
    ---0. バニラ状態, 1. 銃を構えている際の、銃を構えている方の腕, 2. 銃を構えている際の、銃を構えていない方の腕
    ---@type {right: integer, left: integer}
    ArmState = {
        right = 0,
        left = 0
    },

    ---腕をプラプラさせるカウンター
    ---@type integer
    ArmSwingCount = 0,

    ---腕をプラプラさせるカウンターを処理する。
    ---@param self Arms
    processArmSwingCount = function (self)
        self.ArmSwingCount = self.ArmSwingCount == 99 and 0 or self.ArmSwingCount + 1
    end,

    ---腕の状態を設定する。
    ---@param self Arms
    ---@param right? integer 右腕の状態
    ---@param left? integer 左腕の状態
    setArmState = function (self, right, left)
        local rightArmState = right ~= nil and right or self.ArmState.right
        local leftArmState = left ~= nil and left or self.ArmState.left
        if BlueArchiveCharacter.ARMS.callbacks.onArmStateChanged ~= nil then
            local result = BlueArchiveCharacter.ARMS.callbacks.onArmStateChanged(rightArmState, leftArmState)
            if result ~= nil then
                if result.right ~= nil then
                    rightArmState = result.right
                end
                if result.left ~= nil then
                    leftArmState = result.left
                end
            end
        end

        --右腕の操作
        if rightArmState ~= self.ArmState.right then
            --腕の状態をリセット
            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            events.TICK:remove("arm_swing_tick")
            events.RENDER:remove("right_arm_render")
            if rightArmState == 1 then
                --銃を構えている際の、銃を構えている方の腕
                models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmSwingCount()
                end, "arm_swing_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, headRot.y, 0)
                end, "right_arm_render")
            elseif rightArmState == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmSwingCount()
                end, "arm_swing_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0)
                end, "right_arm_render")
            end
            if BlueArchiveCharacter.ARMS.callbacks.onAddtionalRightArmProcess ~= nil then
                BlueArchiveCharacter.ARMS.callbacks.onAddtionalRightArmProcess(rightArmState)
            end
            self.ArmState.right = rightArmState
        end
        --左腕の操作
        if leftArmState ~= self.ArmState.left then
            --腕の状態をリセット
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            events.TICK:remove("arm_swing_tick")
            events.RENDER:remove("left_arm_render")
            if leftArmState == 1 then
                --銃を構えている際の、銃を構えている方の腕
                models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmSwingCount()
                end, "arm_swing_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, headRot.y, 0)
                end, "left_arm_render")
            elseif leftArmState == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmSwingCount()
                end, "arm_swing_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0)
                end, "left_arm_render")
            end
            if BlueArchiveCharacter.ARMS.callbacks.onAddtionalLeftArmProcess ~= nil then
                BlueArchiveCharacter.ARMS.callbacks.onAddtionalLeftArmProcess(leftArmState)
            end
            self.ArmState.left = leftArmState
        end
    end
}

return Arms