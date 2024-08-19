---@class HeadRing 頭の輪っかを制御するクラス
HeadRing = {
    ---頭の角度のデータ
    ---@type number[]
	HeadRotData = {},

    ---頭の角度の移動平均値
    ---@type number
	HeadRotAverage = 0,

    ---頭の輪っかが上下するアニメーションのカウンター
    ---@type integer
    FloatCount = 0,

    ---このレンダーで処理済みかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---初期化関数
    init = function (self)
        events.RENDER:register(function (delta)
            local headRot = ExSkill.AnimationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
            if not self.IsRenderProcessed then
                --移動平均値の算出
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
                self.IsRenderProcessed = true
            end
            --頭の輪っかの位置・角度を設定
            local playerPose = player:getPose()
            local floatOffset = math.sin(self.FloatCount / 80 * 2 * math.pi) * 0.25
            if playerPose == "SWIMMING" or playerPose == "FALL_FLYING" then
                models.models.main.Avatar.Head.HeadRing:setPos(Physics.VelocityAverage[3] * 3, math.cos(math.rad(headRot)) * Physics.VelocityAverage[1] * -1 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[2] * -1 + floatOffset, math.cos(math.rad(headRot)) * Physics.VelocityAverage[2] * -3 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[1])
            else
                models.models.main.Avatar.Head.HeadRing:setPos(Physics.VelocityAverage[3] * -3, math.cos(math.rad(headRot)) * Physics.VelocityAverage[2] * -1 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[1] + floatOffset, math.cos(math.rad(headRot)) * Physics.VelocityAverage[1] * 3 + math.sin(math.rad(headRot)) * Physics.VelocityAverage[2])
            end
            if DeathAnimation.DummyAvatarRoot ~= nil then
                DeathAnimation.DummyAvatarRoot["Head"]["HeadRing"]:setPos(0, floatOffset, 0)
            end
            models.models.main.Avatar.Head.HeadRing:setRot(self.HeadRotAverage - headRot, 0, 0)
        end)

        events.WORLD_TICK:register(function ()
            if not client:isPaused() then
                self.FloatCount = self.FloatCount + 1
                self.FloatCount = self.FloatCount == 80 and 0 or self.FloatCount
            end
        end)

        events.WORLD_RENDER:register(function ()
            self.IsRenderProcessed = false
        end)

        events.SKULL_RENDER:register(function ()
            models.script_head_block.Head.HeadRing:setPos(0, math.sin(self.FloatCount / 80 * 2 * math.pi) * 0.25, 0)
        end)

        models.models.main.Avatar.Head.HeadRing:setLight(15)
    end
}

HeadRing:init()

return HeadRing