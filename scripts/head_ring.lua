---@class HeadRing 頭の輪っかを制御するクラス
HeadRing = {
    ---頭の角度のデータ
    ---@type number[]
	HeadRotData = {},

    ---頭の角度の移動平均値
    ---@type number
	HeadRotAverage = 0,

    ---頭の輪っかが上下するアニメーションのカウンター
    ---@type number
    FloatCount = 0,

    ---このレンダーで処理済みかどうか
    ---@type boolean
    IsRenderProcessed = false,

    init = function (self)
        events.RENDER:register(function()
            if not self.IsRenderProcessed then
                --移動平均値の算出
                local headRot = ExSkill.AnimationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
                self.HeadRotAverage = (#self.HeadRotData * self.HeadRotAverage + headRot) / (#self.HeadRotData + 1)
                table.insert(self.HeadRotData, headRot)
                --古いデータの切り捨て
                local fps = client:getFPS()
                while #self.HeadRotData > fps * 0.25 do
                    if #self.HeadRotData >= 2 then
                        self.HeadRotAverage = (#self.HeadRotData * self.HeadRotAverage - self.HeadRotData[1]) / (#self.HeadRotData - 1)
                    end
                    table.remove(self.HeadRotData, 1)
                end

                --頭の輪っかの浮遊アニメーション
                if not client:isPaused() then
                    self.FloatCount = self.FloatCount + 0.25 / fps
                    self.FloatCount = self.FloatCount > 1 and self.FloatCount - 1 or self.FloatCount
                end
                local floatingOffset = math.sin(self.FloatCount * 2 * math.pi) * 0.25

                --頭の輪っかの位置・角度を設定
                local playerPose = player:getPose()
                if playerPose == "SWIMMING" or playerPose == "FALL_FLYING" then
                    models.models.main.Avatar.Head.HeadRing:setPos(Physics.VelocityAverage[3] * 3, math.cos(math.rad(headRot)) * Physics.VelocityAverage[1] * -1 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[2] * -1 + floatingOffset, math.cos(math.rad(headRot)) * Physics.VelocityAverage[2] * -3 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[1])
                else
                    models.models.main.Avatar.Head.HeadRing:setPos(Physics.VelocityAverage[3] * -3, math.cos(math.rad(headRot)) * Physics.VelocityAverage[2] * -1 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[1] + floatingOffset, math.cos(math.rad(headRot)) * Physics.VelocityAverage[1] * 3 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[2])
                end
                if models.script_head_block.Head ~= nil then
                    models.script_head_block.Head.HeadRing:setPos(0, floatingOffset, 0)
                end
                if DeathAnimation.AnimationCount > 0 then
                    DeathAnimation.DummyAvatarRoot["Head"]["HeadRing"]:setPos(0, floatingOffset, 0)
                end
                models.models.main.Avatar.Head.HeadRing:setRot(self.HeadRotAverage - headRot, 0, 0)

                self.IsRenderProcessed = true
            end
        end)

        events.WORLD_RENDER:register(function()
            self.IsRenderProcessed = false
        end)

        models.models.main.Avatar.Head.HeadRing:setLight(15)
    end
}

HeadRing:init()

return HeadRing