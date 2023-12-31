---@alias PlayerUtils.DamageStatus
---| "NONE" ダメージなし
---| "DAMAGE" ダメージを受けた
---| "DIED" 死亡した

---@class PlayerUtils プレイヤーに関するユーティリティ関数群
---@field HealthPrev integer 前ティックのHP
---@field DamageStatus PlayerUtils.DamageStatus 現在のティックのダメージステータス
PlayerUtils = {
    --変数
    HealthPrev = player:getHealth(),
    DamageStatus = "NONE",

    --関数
    ---現在のティックのダメージステータスを返す。
    ---@return PlayerUtils.DamageStatus damageStatus 現在のティックのダメージステータス
    getDamageStatus = function(self)
        return self.DamageStatus
    end
}

events.TICK:register(function()
    local health = player:getHealth()
    PlayerUtils.DamageStatus = health < PlayerUtils.HealthPrev and (health == 0 and "DIED" or "DAMAGE") or "NONE"
    PlayerUtils.HealthPrev = health
end)

return PlayerUtils