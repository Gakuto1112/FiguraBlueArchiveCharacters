---@class ModelUtils PV撮影用のユーティリティ関数群
PvUtils = {
    ---前ティックのプレイヤーの位置
    ---@type Vector3
    PlayerPosPrev = player:getPos(),

    ---このティックでやられたかどうか
    ---@type boolean
    IsDied = false,

    ---現在任務中かどうかを返す
    ---@return boolean getIsInBattle 現在任務中かどうか
    getIsInBattle = function ()
        local targetBlock = world.getBlockState(16, -59, -70)
        if targetBlock.id == "minecraft:lever" then
            return targetBlock.properties.powered == "true"
        else
            return false
        end
    end,

    ---やられてしまったかどうかを返す。
    ---@return boolean isDied やられたかどうか
    getIsDied = function (self)
        return self.IsDied
    end,

    ---初期化処理
    init = function (self)
        events.TICK:register(function ()
            local playerPos = player:getPos()
            self.IsDied = playerPos:copy():sub(self.PlayerPosPrev):length() - 1 > player:getVelocity():length()
            self.PlayerPosPrev = playerPos
        end)
    end
}

PvUtils:init()

return PvUtils