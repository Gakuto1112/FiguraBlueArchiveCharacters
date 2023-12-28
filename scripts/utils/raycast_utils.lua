---@class RaycastUtils レイキャストのユーティリティ関数群
RaycastUtils = {
    ---レイキャストの判断を行う細かさ（1ブロックの長さにつき何回処理を行うか）。当然細かくすれば精度が向上するが、その分処理の負荷も増大する。
    ---@type integer
    RAYCAST_FINESS = 16,

    ---デバッグモードを有効にするかどうか。デバッグモードでは測定基準点（赤）と測定方向（水色）をパーティクルで表示する。
    ---@type boolean
    DEBUG_MODE = false,

    ---指定された点から当たり判定までの距離を返す。
    ---@param worldPos Vector3 測定開始地点のワールド座標
    ---@param worldDir Vector3 測定する向きを示すワールド回転
    ---@param maxLength number 測定を行う最大距離。単位はブロック。あまり長すぎると負荷が大きくなるので非推奨。
    getLengthBetweenPointAndCollision = function (self, worldPos, worldDir, maxLength)
        local currentPos = worldPos:copy() --現在の測定位置
        local debug = self.DEBUG_MODE and host:isHost()
        if debug then
            particles:newParticle("electric_spark", currentPos):setScale(0.25):setColor(1, 0, 0):setLifetime(1)
        end
        for i = 1, self.RAYCAST_FINESS * maxLength do
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
            if debug then
                particles:newParticle("electric_spark", currentPos):setScale(0.25):setColor(0, 1, 1):setLifetime(1)
            end
        end
        return maxLength
    end
}

return RaycastUtils