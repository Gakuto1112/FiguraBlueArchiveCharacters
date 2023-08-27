---@class RaycastUtils レイキャストのユーティリティ関数群
---@field RAYCAST_FINESS integer レイキャストの判断を行う細かさ（1ブロックの長さにつき何回処理を行うか）。当然細かくすれば精度が向上するが、その分処理の負荷も増大する。
---@field MAXIMUM_LENGTH number レイキャストを行う最大距離（ブロック）
RaycastUtils = {
    --定数
    RAYCAST_FINESS = 16,
    MAXIMUM_LENGTH = 4,

    --関数
    ---指定された点から当たり判定までの距離を返す。
    ---@param worldPos Vector3 測定開始地点のワールド座標
    ---@param worldDir Vector3 測定する向きを示すワールド回転
    getLengthBetweenPointAndCollision = function (self, worldPos, worldDir)
        local currentPos = worldPos:copy() --現在の測定位置
        for i = 1, self.RAYCAST_FINESS * self.MAXIMUM_LENGTH do
            local currentBlock = world.getBlockState(currentPos)
            if currentBlock:hasCollision() and not currentBlock.id:find("glass") and currentBlock.id ~= "minecraft:iron_bars" then
                local blockOffset = currentPos:copy():applyFunc(function (value)
                    return value % 1
                end)
                for _, collisionShape in ipairs(currentBlock:getCollisionShape()) do
                    if collisionShape[1][1] <= blockOffset.x and collisionShape[2][1] >= blockOffset.x and collisionShape[1][2] <= blockOffset.y and collisionShape[2][2] >= blockOffset.y and collisionShape[1][3] <= blockOffset.z and collisionShape[2][3] >= blockOffset.z then
                        return 1 / self.RAYCAST_FINESS * i
                    end
                end
            end
            currentPos:add(worldDir:copy():scale(1 / self.RAYCAST_FINESS))
        end
        return self.MAXIMUM_LENGTH
    end
}

return RaycastUtils