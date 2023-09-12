---@alias PlayerUtils.DamageStatus
---| "NONE" ダメージなし
---| "DAMAGE" ダメージを受けた
---| "DIED" 死亡した

---@class PlayerUtils プレイヤーの状態に関するユーティリティ関数群
---@field HealthPrev integer 前ティックのHP
---@field DamageStatus PlayerUtils.DamageStatus 現在のティックのダメージステータス
PlayerUtils = {
    --変数
    HealthPrev = 20,
    DamageStatus = "NONE",

    --関数
    ---現在のティックのダメージステータスを返す。
    ---@return PlayerUtils.DamageStatus damageStatus 現在のティックのダメージステータス
    getDamageStatus = function(self)
        return self.DamageStatus
    end,

    ---指定したモデルのワールド位置を返す。
    ---@param model ModelPart ワールド位置を取得するモデルパーツ
    ---@return Vector3 worldPos モデルのワールド位置
    getModelWorldPos = function(self, model)
        local modelMatrix = model:partToWorldMatrix()
        return vectors.vec3(modelMatrix[4][1], modelMatrix[4][2], modelMatrix[4][3])
    end
}

events.TICK:register(function()
    local health = player:getHealth() + player:getAbsorptionAmount()
    PlayerUtils.DamageStatus = health < PlayerUtils.HealthPrev and (health == 0 and "DIED" or "DAMAGE") or "NONE"
    PlayerUtils.HealthPrev = health
end)

return PlayerUtils