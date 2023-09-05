---@class CollisionUtils 当たり判定を行う際のユーティリティ関数群
CollisionUtils = {
    ---ヒットボックスを重なっているブロック座標のテーブルを返す。
    ---@param hitboxPos Vector3 ヒットボックスの開始ワールド座標
    ---@param hitboxSize Vector3 ヒットボックスの大きさxyz
    ---@return table<Vector3> collisionBlocks ヒットボックスと重なっているブロック座標
    getCollisionBlocks = function(self, hitboxPos, hitboxSize)
        local collisionBlocks = {}
        for z = hitboxPos.z, math.ceil(hitboxPos.z + hitboxSize.z) do
            for y = math.floor(hitboxPos.y), math.floor(hitboxPos.y + hitboxSize.y) do
                for x = hitboxPos.x, math.ceil(hitboxPos.x + hitboxSize.x) do
                    table.insert(collisionBlocks, vectors.vec3(x, y, z):floor())
                end
            end
        end
        return collisionBlocks
    end,

    ---指定された2つの直方体（立方体）が重なっているかどうかを返す。
    ---@param cube1StartPos Vector3 1つ目のキューブの開始座標
    ---@param cube1EndPos Vector3 1つ目のキューブの終了座標
    ---@param cube2StartPos Vector3 2つ目のキューブの開始座標
    ---@param cube2EndPos Vector3 2つ目のキューブの終了座標
    ---@return boolean cubeOverlapped 2つのキューブが重なっているかどうか
    isCubeOverrapped = function(self, cube1StartPos, cube1EndPos, cube2StartPos, cube2EndPos)
        local cube1Size = cube1EndPos:copy():sub(cube1StartPos)
        local cube2Size = cube2EndPos:copy():sub(cube2StartPos)
        local cube1Center = cube1StartPos:copy():add(cube1Size:copy():scale(0.5))
        local cube2Center = cube2StartPos:copy():add(cube2Size:copy():scale(0.5))
        return cube2Center.x - cube1Center.x < cube1Size.x + cube2Size.x or cube2Center.y - cube1Center.y < cube1Size.y + cube2Size.y or cube2Center.z - cube1Center.z < cube1Size.z + cube2Size.z
    end
}

return CollisionUtils