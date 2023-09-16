---@class HeadRing 頭の輪っかを制御するクラス
---@field HeadRotData table<number> 頭の角度のデータ
---@field HeadRotAverage number 頭の角度の移動平均値
---@field FloatCount number 頭の輪っかが上下するアニメーションのカウンター
HeadRing = {
    --変数
	HeadRotData = {},
	HeadRotAverage = 0,
    FloatCount = 0,
}

---このレンダーで処理済みかどうか
---@type boolean
local renderProcessed = false

events.RENDER:register(function()
    if not renderProcessed then
        --移動平均値の算出
        local headRot = ExSkill.AnimationCount > -1 and models.models.main.Avatar.Head:getAnimRot().x or math.deg(math.asin(player:getLookDir().y))
        HeadRing.HeadRotAverage = (#HeadRing.HeadRotData * HeadRing.HeadRotAverage + headRot) / (#HeadRing.HeadRotData + 1)
        table.insert(HeadRing.HeadRotData, headRot)
        --古いデータの切り捨て
        local fps = client:getFPS()
        while #HeadRing.HeadRotData > fps * 0.25 do
            if #HeadRing.HeadRotData >= 2 then
                HeadRing.HeadRotAverage = (#HeadRing.HeadRotData * HeadRing.HeadRotAverage - HeadRing.HeadRotData[1]) / (#HeadRing.HeadRotData - 1)
            end
            table.remove(HeadRing.HeadRotData, 1)
        end
        --頭の輪っかの角度を設定
        models.models.main.Avatar.Head.HeadRing:setRot(HeadRing.HeadRotAverage - headRot + BlueArchiveCharacter.HEAD_RING.neutralRot)

        --頭の輪っかの浮遊アニメーション
        if not client:isPaused() then
            HeadRing.FloatCount = HeadRing.FloatCount + 0.25 / fps
            HeadRing.FloatCount = HeadRing.FloatCount > 1 and HeadRing.FloatCount - 1 or HeadRing.FloatCount
            models.models.main.Avatar.Head.HeadRing:setPos(0, math.sin(HeadRing.FloatCount * 2 * math.pi) * 0.25)
        end
        renderProcessed = true
    end
end)

events.WORLD_RENDER:register(function()
    renderProcessed = false
end)

events.SKULL_RENDER:register(function()
    models.models["skull_"..Costume.CostumeList[Costume.CurrentCostume]].Skull.HeadRing:setPos(0, math.sin(HeadRing.FloatCount * 2 * math.pi) * 0.25)
end)

for _, modelPart in ipairs({models.models.main.Avatar.Head.HeadRing, models.models.skull_default.Skull.HeadRing, models.models.skull_swimsuit.Skull.HeadRing}) do
    modelPart:setLight(15)
end

return HeadRing