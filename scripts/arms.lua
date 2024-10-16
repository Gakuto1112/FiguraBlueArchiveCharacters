---@class Arms アバターの腕を制御するクラス
Arms = {
    ---腕の状態
    ---0. バニラ状態, 1. 銃を構えている際の、銃を構えている方の腕, 2. 銃を構えている際の、銃を構えていない方の腕, 3. クロスボウ装填中
    ---@type {right: integer, left: integer}
    ArmState = {
        right = 0,
        left = 0
    },

    ---前ティックの腕の状態
    ---@type {right: integer, left: integer}
    ArmStatePrev = {
        right = 0,
        left = 0
    },

    ---腕をプラプラさせるカウンター
    ---@type integer
    ArmSwingCount = 0,

    ---腕プラプラカウンターを処理したかどうか
    ---@type boolean
    IsSwingCountProcessed = false,

    ---腕プラプラカウンターを処理する。
    ---@param self Arms
    processArmWingCount = function (self)
        if not client:isPaused() and not self.IsSwingCountProcessed then
            self.ArmSwingCount = self.ArmSwingCount == 99 and 0 or self.ArmSwingCount + 1
            self.IsSwingCountProcessed = true
        end
    end,

    ---腕の状態を設定する。
    ---@param self Arms
    ---@param right? integer 右腕の状態
    ---@param left? integer 左腕の状態
    setArmState = function (self, right, left)
        if right ~= nil then
            self.ArmState.right = right
        end
        if left ~= nil then
            self.ArmState.left = left
        end
        if (self.ArmState.right == 1 or self.ArmState.left == 1) and player:getActiveItem().id == "minecraft:crossbow" then
            self:setArmState(3, 3)
            return
        end
        if BlueArchiveCharacter.ARMS.callbacks.onArmStateChanged ~= nil then
            local result = BlueArchiveCharacter.ARMS.callbacks.onArmStateChanged(self.ArmState.right, self.ArmState.left)
            if result ~= nil then
                if result.right ~= nil then
                    self.ArmState.right = result.right
                end
                if result.left ~= nil then
                    self.ArmState.left = result.left
                end
            end
        end

        --右腕の操作
        if self.ArmState.right ~= self.ArmStatePrev.right then
            --腕の状態をリセット
            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
            events.TICK:remove("right_arm_tick")
            events.RENDER:remove("right_arm_render")
            if self.ArmState.right == 1 then
                --銃を構えている際の、銃を構えている方の腕
                events.TICK:register(function ()
                    if self.ArmState.right == 1 then
                        self:processArmWingCount()
                        if player:isSwingingArm() and not player:isLeftHanded() then
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("RightArm")
                        else
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType("Body")
                        end
                        if player:getActiveItem().id == "minecraft:crossbow" then
                            self:setArmState(3, 3)
                        end
                    end
                end, "right_arm_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(player:isSwingingArm() and not player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, headRot.y, 0))
                end, "right_arm_render")
            elseif self.ArmState.right == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                events.TICK:register(function ()
                    self:processArmWingCount()
                end, "right_arm_tick")
                events.RENDER:register(function (delta, context)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
                    models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * 2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -21, 78), 0))
                end, "right_arm_render")
            elseif self.ArmState.right == 3 then
                --クロスボウ装填中
                events.TICK:register(function ()
                    if player:getActiveItem().id ~= "minecraft:crossbow" and self.ArmState.right == 3 then
                        if Gun.CurrentGunPosition == "RIGHT" then
                            self:setArmState(1, 2)
                        elseif Gun.CurrentGunPosition == "LEFT" then
                            self:setArmState(2, 1)
                        end
                    end
                end, "right_arm_tick")
            end
            if BlueArchiveCharacter.ARMS.callbacks.onAddtionalRightArmProcess ~= nil then
                BlueArchiveCharacter.ARMS.callbacks.onAddtionalRightArmProcess(self.ArmState.right)
            end
            self.ArmStatePrev.right = self.ArmState.right
        end
        --左腕の操作
        if self.ArmState.left ~= self.ArmStatePrev.left then
            --腕の状態をリセット
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot()
            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
            events.TICK:remove("left_arm_tick")
            events.RENDER:remove("left_arm_render")
            if self.ArmState.left == 1 then
                --銃を構えている際の、銃を構えている方の腕
                events.TICK:register(function ()
                    if self.ArmState.left == 1 then
                        self:processArmWingCount()
                        if player:isSwingingArm() and player:isLeftHanded() then
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("LeftArm")
                        else
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                        end
                        if player:getActiveItem().id == "minecraft:crossbow" then
                            self:setArmState(3, 3)
                        end
                    end
                end, "left_arm_tick")
                events.RENDER:register(function (delta)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(player:isSwingingArm() and player:isLeftHanded() and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, headRot.y, 0))
                end, "left_arm_render")
            elseif self.ArmState.left == 2 then
                --銃を構えている際の、銃を構えていない方の腕
                models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType("Body")
                events.TICK:register(function ()
                    self:processArmWingCount()
                end, "left_arm_tick")
                events.RENDER:register(function (delta, context)
                    local headRot = vanilla_model.HEAD:getOriginRot()
                    local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
                    models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(headRot.x + math.sin((self.ArmSwingCount + delta) / 100 * math.pi * 2) * -2.5 + 90, math.map((headRot.y + 180) % 360 - 180, -50, 50, -78, 21), 0))
                end, "left_arm_render")
            elseif self.ArmState.left == 3 then
                --クロスボウ装填中
                events.TICK:register(function ()
                    if player:getActiveItem().id ~= "minecraft:crossbow" and self.ArmState.left == 3 then
                        if Gun.CurrentGunPosition == "RIGHT" then
                            self:setArmState(1, 2)
                        elseif Gun.CurrentGunPosition == "LEFT" then
                            self:setArmState(2, 1)
                        end
                    end
                end, "left_arm_tick")
            end
            if BlueArchiveCharacter.ARMS.callbacks.onAddtionalLeftArmProcess ~= nil then
                BlueArchiveCharacter.ARMS.callbacks.onAddtionalLeftArmProcess(self.ArmState.left)
            end
            self.ArmStatePrev.left = self.ArmState.left
        end
    end,

    ---初期化関数
    ---@param self Arms
    init = function (self)
        events.TICK:register(function ()
            self.IsSwingCountProcessed = false
        end)
    end
}

Arms:init()

return Arms