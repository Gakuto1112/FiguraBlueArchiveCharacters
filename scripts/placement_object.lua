---@class PalcementObject
---@field PLACEMENT_OBJECTS ModelPart 設置物として扱うモデル。指定したモデルをここでコピーして設置物とする。
---@field HITBOXES table<table<Vector3>> 設置物の当たり判定。直方体（立方体）のxyz座標がそれぞれ最小の頂点を指定し、そこからのxyz軸での長さを指定する。
---@field COLLISION_FINESS integer 当たり判定の細かさ（1ブロックの長さにつき何回処理を行うか）。当然細かくすれば精度が向上するが、その分処理の負荷も増大する。
PlacementObject = {
    --定数
    PLACEMENT_OBJECTS = models.models.placement_object.PlacementObject,
    HITBOXES = {{vectors.vec3(-5, 0, -10), vectors.vec3(20, 38, 20)}},
    COLLISION_FINESS = 1,

    --関数
    ---指定した場所に指定した向きで設置物を置く。
    ---@param worldPos Vector3 設置する場所を示すワールド座標
    ---@param worldRot number 設置物の向き
    place = function(self, worldPos, worldRot)
        local placedObjectsCount = #models.models.placement_object.WorldObjects:getChildren()
        local newObject = self.PLACEMENT_OBJECTS:copy("Object"..(placedObjectsCount + 1))
        models.models.placement_object.WorldObjects:addChild(newObject)
        newObject:setVisible(true)
        newObject:setPos(worldPos:scale(16))
        newObject:setRot(0, -worldRot, 0)
        if placedObjectsCount == 0 then
            events.TICK:register(self.tick, "placement_object_tick")
        end
    end,

    ---設置済みの設置物から指定したものを削除する。
    ---@param targetModel ModelPart 削除対象の設置物
    remove = function(self, targetModel)
        models.models.placement_object.WorldObjects:removeChild(targetModel)
        if #models.models.placement_object.WorldObjects:getChildren() == 0 then
            events.TICK:remove("placement_object_tick")
        end
    end,

    ---設置済みの設置物を全て削除する。
    removeAll = function(self)
        events.TICK:remove("placement_object_tick")
        while true do
            local children = models.models.placement_object.WorldObjects:getChildren()
            if #children > 0 then
                models.models.placement_object.WorldObjects:removeChild(children[1])
            else
                break
            end
        end
    end,

    ---ティック関数
    tick = function()
        for _, modelPart in ipairs(models.models.placement_object.WorldObjects:getChildren()) do
            --現在の位置でのコリジョン判定
            local isCollision = false
            local modelPos = modelPart:getPos():scale(1 / 16)
            for _, hitBox in ipairs(PlacementObject.HITBOXES) do
                for _, pos in ipairs(CollisionUtils:getCollisionBlocks(modelPart:getPos():scale(1 / 16):add(hitBox[1]), hitBox[2])) do
                    local block = world.getBlockState(pos)
                    if block:hasCollision() then
                        for _, collision in ipairs(block:getCollisionShape()) do
                            local hitBoxStartPos = modelPos:copy():add(hitBox[1])
                            if CollisionUtils:isCubeOverrapped(hitBoxStartPos, hitBoxStartPos:copy():add(hitBox[2]), pos:copy():add(collision[1]), pos:copy():add(collision[2])) then
                                PlacementObject:remove(modelPart)
                                isCollision = true
                                break
                            end
                        end
                    end
                    if isCollision then
                        break
                    end
                end
                if isCollision then
                    break
                end
            end
        end
    end
}

for _, hitBox in ipairs(PlacementObject.HITBOXES) do
    for _ , chunk in ipairs(hitBox) do
        chunk:scale(1 / 16)
    end
end

return PlacementObject