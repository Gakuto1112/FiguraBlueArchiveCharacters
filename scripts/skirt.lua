---@class Skirt スカートを制御するクラス
Skirt = {
    ---脚と丈の長いスカートの調整が有効かどうか
    ---@type boolean
    LegAdjustmentEnabled = true,

    ---前ティックに脚とスカートの調整をしたかどうか
    ---@type boolean
    LegAdjustedPrev = false,

    ---前ティックにスニークの姿勢を取っていたかどうか
    ---@type boolean
    IsCrouchingPrev = false,

    ---前ティックは脚を隠すべきだったかどうか
    ---@type boolean
    ShouldHideLegsPrev = false,

    ---初期化処理
    init = function (self)
        events.TICK:register(function ()
            local isCrouching = player:getPose() == "CROUCHING"
            if isCrouching and not self.IsCrouchingPrev then
                models.models.main.Avatar.UpperBody.Body.Robe:setRot(30, 0, 0)
            elseif not isCrouching and self.IsCrouchingPrev then
                models.models.main.Avatar.UpperBody.Body.Robe:setRot()
            end
            local shouldHideLegs = models.models.main.Avatar.UpperBody.Body.Robe:getVisible() and player:getVehicle() ~= nil
            if shouldHideLegs and not self.ShouldHideLegsPrev then
                models.models.main.Avatar.LowerBody.Legs:setVisible(false)
                models.models.main.Avatar.UpperBody.Body.Robe:setScale(1.5, 0.35, 2)
            elseif not shouldHideLegs and self.ShouldHideLegsPrev then
                models.models.main.Avatar.LowerBody.Legs:setVisible(true)
                models.models.main.Avatar.UpperBody.Body.Robe:setScale()
            end
            local shouldAdjustLegs = self.LegAdjustmentEnabled and not shouldHideLegs
            if shouldAdjustLegs and not self.LegAdjustedPrev then
                events.RENDER:register(function ()
                    local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
                    models.models.main.Avatar.LowerBody.Legs.RightLeg:setRot(rightLegRotX * -0.55, 0, 0)
                    models.models.main.Avatar.LowerBody.Legs.LeftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.55, 0, 0)
                    local rightLegRotAbs = math.abs(rightLegRotX)
                    models.models.main.Avatar.UpperBody.Body.Robe:setScale(1, 1, rightLegRotAbs * 0.0025 + 1)
                    local robeScale2 = vectors.vec3(rightLegRotAbs * -0.000625 + 1, 1, rightLegRotAbs * 0.00125 + 1)
                    models.models.main.Avatar.UpperBody.Body.Robe.Robe2:setScale(robeScale2)
                    models.models.main.Avatar.UpperBody.Body.Robe.Robe2.Robe3:setScale(robeScale2)
                end, "skirt_render")
            elseif not shouldAdjustLegs and self.LegAdjustedPrev then
                events.RENDER:remove("skirt_render")
                if not shouldHideLegs then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Robe, models.models.main.Avatar.UpperBody.Body.Robe.Robe2, models.models.main.Avatar.UpperBody.Body.Robe.Robe2.Robe3}) do
                        modelPart:setScale()
                    end
                end
            end
            self.IsCrouchingPrev = isCrouching
            self.ShouldHideLegsPrev = shouldHideLegs
            self.LegAdjustedPrev = shouldAdjustLegs
        end)
    end
}

Skirt:init()

return Skirt