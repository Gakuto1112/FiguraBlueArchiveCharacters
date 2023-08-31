---@class PalcementObject
---@field PLACEMENT_OBJECTS table<ModelPart> 設置物として扱うモデル。指定したモデルをここでコピーして設置物とする。複数指定した場合はランダムで1つ使用する。
---@field PlacedObjects table<ModelPart> 設置物として設置されたモデルのテーブル
PlacementObject = {
    --定数
    PLACEMENT_OBJECTS = {models.models.placement_object.PlacementObject},

    --変数
    placedObjects = {},

    --関数
    ---指定した場所に指定した向きで設置物を置く。
    ---@param worldPos Vector3 設置する場所を示すワールド座標
    ---@param worldRot number 設置物の向き
    place = function(self, worldPos, worldRot)
        local newObject = self.PLACEMENT_OBJECTS[math.random(1, #self.PLACEMENT_OBJECTS)]:copy("Object"..(#self.placedObjects + 1))
        models.models.placement_object.WorldObjects:addChild(newObject)
        newObject:setVisible(true)
        newObject:setPos(worldPos:scale(16))
        newObject:setRot(0, -worldRot, 0)
        table.insert(self.placedObjects, newObject)
    end,

    ---設置済みの設置物を全て削除する。
    removeAll = function(self)
        while(#self.placedObjects > 0) do
            models.models.placement_object.WorldObjects:removeChild(self.placedObjects[1])
            table.remove(self.placedObjects, 1)
        end
    end
}

return PlacementObject