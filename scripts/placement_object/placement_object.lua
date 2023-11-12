---@class 単一の設置物を管理するクラス
PlacementObject = {
    ---設置物のインスタンスを新しく生成する。
    ---@param objectData table 設置物のデータ
    new = function (objectData)
        local instance = {}

        ---設置物として生成したモデルパーツ
        ---@type ModelPart
        instance.object = objectData.model:copy("PlacementObject_"..client:getSystemTime())

        ---設置物の当たり判定の大きさ
        ---@type Vector3
        instance.boundingBox = objectData.boundingBox

        ---設置物の位置をワールド座標で変更する。
        ---@param newWorldPos Vector3 移動先のワールド座標
        instance.setWorldPos = function (self, newWorldPos)
            local newPos = newWorldPos:copy():scale(16)
            self.object:setPos(newPos)
            if PlacementObjectManager.DEBUG_MODE then
                models.script_placement_object[self.object:getName()].Debug.BoundingBox:setPos(newPos)
            end
        end

        ---設置物の向きを変更する。度数法で入力する。
        ---@param newWorldRot Vector3 移動先のワールド方向
        instance.setWorldRot = function (self, newWorldRot)
            self.object:setRot(newWorldRot)
        end

        ---毎ティック実行する関数
        instance.onTick = function (self)
            --前ティックのデバッグ用重なっているブロック表示を削除する。
            if PlacementObjectManager.DEBUG_MODE then
                local collisionBlocksGroup = models.script_placement_object[self.object:getName()].Debug.CollisionBlocks
                while #collisionBlocksGroup:getChildren() > 0 do
                    collisionBlocksGroup:removeChild(collisionBlocksGroup:getChildren()[1])
                end
            end

            --設置物と重なるブロックを取得する。
            local collisionBlocks = {}
            local objectPos = self.object:getPos():scale(1 / 16)
            local worldBoundingBox = self.boundingBox:copy():scale(1 / 16)
            local halfWorldBoundingBox = worldBoundingBox:copy():scale(1 / 2)
            for z = math.floor(objectPos.z - halfWorldBoundingBox.z), math.floor(objectPos.z + halfWorldBoundingBox.z) do
                for y = math.floor(objectPos.y), math.floor(objectPos.y + worldBoundingBox.y) do
                    for x = math.floor(objectPos.x - halfWorldBoundingBox.x), math.floor(objectPos.x + halfWorldBoundingBox.x) do
                        table.insert(collisionBlocks, vectors.vec3(x, y, z))
                    end
                end
            end

            for _, block in ipairs(collisionBlocks) do
                --デバッグ用重なっているブロック表示を作成
                if PlacementObjectManager.DEBUG_MODE then
                    local collisionBlocksGroup = models.script_placement_object[self.object:getName()].Debug.CollisionBlocks
                    ---@diagnostic disable-next-line: redundant-parameter
                    local collisionBlockModel = models.models.bounding_box.BoundingBox:copy("CollisionBlock_"..(#collisionBlocksGroup:getChildren() + 1))
                    collisionBlocksGroup:addChild(collisionBlockModel)
                    collisionBlockModel:setPos(block:copy():add(0.5, 0, 0.5):scale(16))
                    collisionBlockModel:setScale(16, 16, 16)
                    collisionBlockModel:setColor(1, 0 , 1)
                    collisionBlockModel:setVisible(true)
                end
            end
        end

        models.script_placement_object:addChild(instance.object)
        instance.object:setVisible(true)

        --当たり判定の表示を作成
        if PlacementObjectManager.DEBUG_MODE then
            local objectName = instance.object:getName()
            models.script_placement_object[objectName]:newPart("Debug", "World")
            ---@diagnostic disable-next-line: redundant-parameter
            models.script_placement_object[objectName].Debug:addChild(models.models.bounding_box.BoundingBox:copy("BoundingBox"))
            models.script_placement_object[objectName].Debug.BoundingBox:setScale(instance.boundingBox)
            models.script_placement_object[objectName].Debug.BoundingBox:setVisible(true)
            models.script_placement_object[objectName].Debug:newPart("CollisionBlocks")
        end

        return instance
    end
}

return PlacementObject