---@class PlacementObject 単一の設置物を管理するクラス
PlacementObject = {
    ---設置物のインスタンスを新しく生成する。
    ---@param objectData table 設置物のデータ
    new = function (objectData)
        local instance = {}

        ---設置物として生成したモデルパーツ
        ---@type ModelPart
        ---@diagnostic disable-next-line: undefined-field
        instance.object = objectData.model:copy(client.intUUIDToString(client:generateUUID()))

        ---設置物の当たり判定の大きさ
        ---@type Vector3
        instance.boundingBox = objectData.boundingBox

        ---設置物のワールド位置
        ---@type Vector3
        instance.objectPos = vectors.vec3()

        ---前ティックのワールド位置
        ---@type Vector3
        instance.objectPosPrev = vectors.vec3()

        ---設置物の落下速度
        ---@type number
        instance.fallSpeed = 0

        ---直方体（立方体）と重なっているブロックの座標のリストを返す。
        ---@param cubeStart Vector3 調べる直方体（立方体）の始点の頂点のワールド座標。xyzの値をcubeEndのものよりも小さくすること。
        ---@param cubeEnd Vector3 調べる直方体（立方体）の終点の頂点のワールド座標。xyzの値をcubeStartのものよりも大きくすること。
        ---@return Vector3[] collisionBlocks 設置物が重なっているブロックの座標のリスト
        instance.getCollisionBlocks = function (self, cubeStart, cubeEnd)
            local collisionBlocks = {}
            local boudingBoxSize = cubeEnd:copy():sub(cubeStart)
            local halfBoundingBoxSize = boudingBoxSize:copy():scale(1 / 2)
            local objectPos = cubeStart:copy():add(halfBoundingBoxSize.x, 0, halfBoundingBoxSize.z)
            for z = math.floor(objectPos.z - halfBoundingBoxSize.z), math.floor(objectPos.z + halfBoundingBoxSize.z) do
                for y = math.floor(objectPos.y), math.floor(objectPos.y + boudingBoxSize.y) do
                    for x = math.floor(objectPos.x - halfBoundingBoxSize.x), math.floor(objectPos.x + halfBoundingBoxSize.x) do
                        table.insert(collisionBlocks, vectors.vec3(x, y, z))
                    end
                end
            end
            return collisionBlocks
        end

        ---直方体（立方体）が当たり判定のあるブロックと重なっているかどうかを返す。
        ---@param cubeStart Vector3 調べる直方体（立方体）の始点の頂点のワールド座標。xyzの値をcubeEndのものよりも小さくすること。
        ---@param cubeEnd Vector3 調べる直方体（立方体）の終点の頂点のワールド座標。xyzの値をcubeStartのものよりも大きくすること。
        instance.isCubeOverlapped = function (self, cubeStart, cubeEnd)
            --設置物と重なるブロックを取得する。

            for _, block in ipairs(self:getCollisionBlocks(cubeStart, cubeEnd)) do
                --デバッグ用重なっているブロック表示を作成
                local collisionBlockModel = nil
                if PlacementObjectManager.DEBUG_MODE then
                    local collisionBlocksGroup = models.script_placement_object[self.object:getName()].Debug.CollisionBlocks
                    ---@diagnostic disable-next-line: redundant-parameter
                    collisionBlockModel = models.models.bounding_box.BoundingBox:copy("CollisionBlock_"..(#collisionBlocksGroup:getChildren() + 1))
                    collisionBlocksGroup:addChild(collisionBlockModel)
                    collisionBlockModel:setPos(block:copy():add(0.5, 0, 0.5):scale(16))
                    collisionBlockModel:setScale(16, 16, 16)
                    collisionBlockModel:setVisible(true)
                end

                --重なるブロックの当たり判定を調査
                local blockState = world.getBlockState(block)
                if blockState:hasCollision() then
                    if PlacementObjectManager.DEBUG_MODE then
                        collisionBlockModel:setColor(1, 0, 0)
                    end
                    for _, boundingBox in ipairs(blockState:getCollisionShape()) do
                        local boundingBoxCenter = vectors.vec3(boundingBox[1].x + ((boundingBox[2].x - boundingBox[1].x) / 2), boundingBox[1].y + ((boundingBox[2].y - boundingBox[1].y) / 2), boundingBox[1].z + ((boundingBox[2].z - boundingBox[1].z) / 2))
                        local boundingBoxModel = nil
                        if PlacementObjectManager.DEBUG_MODE then
                            local collisionBlocksGroup = models.script_placement_object[self.object:getName()].Debug.CollisionBlocks
                            ---@diagnostic disable-next-line: redundant-parameter
                            boundingBoxModel = models.models.bounding_box.BoundingBox:copy("CollisionBlock_"..(#collisionBlocksGroup:getChildren() + 1))
                            collisionBlocksGroup:addChild(boundingBoxModel)
                            boundingBoxModel:setPos(block:copy():add(boundingBoxCenter.x, boundingBox[1].y, boundingBoxCenter.z):scale(16))
                            boundingBoxModel:setScale((boundingBox[2].x - boundingBox[1].x) * 16, (boundingBox[2].y - boundingBox[1].y) * 16, (boundingBox[2].z - boundingBox[1].z) * 16)
                            boundingBoxModel:setVisible(true)
                        end
                        local worldObjectBoundingBoxCenter = cubeStart:copy():add(cubeEnd:copy():sub(cubeStart):scale(1 / 2))
                        local worldBoundingBoxCenter = boundingBoxCenter:copy():add(block)
                        if math.abs(worldObjectBoundingBoxCenter.x - worldBoundingBoxCenter.x) < ((cubeEnd.x - cubeStart.x) + (boundingBox[2].x - boundingBox[1].x)) / 2 and math.abs(worldObjectBoundingBoxCenter.y - worldBoundingBoxCenter.y) < ((cubeEnd.y - cubeStart.y) + (boundingBox[2].y - boundingBox[1].y)) / 2 and math.abs(worldObjectBoundingBoxCenter.z - worldBoundingBoxCenter.z) < ((cubeEnd.z - cubeStart.z) + (boundingBox[2].z - boundingBox[1].z)) / 2 then
                            --重なりを検出
                            if PlacementObjectManager.DEBUG_MODE then
                                boundingBoxModel:setColor(1, 0, 0)
                                models.script_placement_object[self.object:getName()].Debug.BoundingBox:setColor(1, 0, 0)
                            end
                            return true
                        end
                    end
                end
            end
            return false
        end

        ---設置物を削除する。設置物削除後はこの設置物のインスタンスを削除すること。
        instance.remove = function (self)
            if PlacementObjectManager.DEBUG_MODE then
                local objectName = self.object:getName()
                models.script_placement_object[objectName].Debug.BoundingBox:remove()
                while #models.script_placement_object[objectName].Debug.CollisionBlocks:getChildren() > 0 do
                    models.script_placement_object[objectName].Debug.CollisionBlocks:getChildren()[1]:remove()
                end
            end
            self.object:remove()
        end

        ---設置物のワールド座標を返す。
        ---@return Vector3 objectPos 設置物のワールド座標。設置物の底面の中央が基準。
        instance.getWorldPos = function (self)
            return self.objectPos
        end

        ---設置物の位置をワールド座標で変更する。
        ---@param newWorldPos Vector3 移動先のワールド座標
        ---@param updateObjectPos boolean "instance.objectPos"や"instance.objectPosPrev"を更新するかどうか
        instance.setWorldPos = function (self, newWorldPos, updateObjectPos)
            if updateObjectPos then
                self.objectPos = newWorldPos:copy()
                self.objectPosPrev = newWorldPos:copy()
            end
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

        ---設置物とブロックの当たり判定が重なっているかどうかを返す。
        ---@return boolean isObjectOverlapped 設置物とブロックの当たり判定が重なっているかどうか
        instance.getIsObjectOverlapped = function (self)
            --前ティックのブロック表示をリセット
            if PlacementObjectManager.DEBUG_MODE then
                local objectName = self.object:getName()
                models.script_placement_object[objectName].Debug.BoundingBox:setColor()
                while #models.script_placement_object[objectName].Debug.CollisionBlocks:getChildren() > 0 do
                    models.script_placement_object[objectName].Debug.CollisionBlocks:getChildren()[1]:remove()
                end
            end

            local worldPos = self.object:getPos():scale(1 / 16)
            local halfBoundingBoxSize = self.boundingBox:copy():scale(1 / 32)
            return self:isCubeOverlapped(vectors.vec3(worldPos.x - halfBoundingBoxSize.x, worldPos.y, worldPos.z - halfBoundingBoxSize.z), vectors.vec3(worldPos.x + halfBoundingBoxSize.x, worldPos.y + self.boundingBox.y / 16, worldPos.z + halfBoundingBoxSize.z))
        end

        ---設置物の落下処理。ティック関数内で処理する。
        instance.fallTickProcess = function (self)
            --設置物の位置を強制的に更新
            self:setWorldPos(self.objectPos, false)
            self.objectPosPrev = self.objectPos

            --落下速度を更新
            self.fallSpeed = world.getBlockState(self.objectPos).id == "minecraft:water" and math.max(self.fallSpeed - 0.1, 0.1) or math.min(self.fallSpeed + 0.035, 3.575)

            --落下先の判定
            local fallDistance = 0
            local worldPos = self.object:getPos():scale(1 / 16)
            local halfBoundingBoxSize = self.boundingBox:copy():scale(1 / 32)
            local boundingBoxStart = worldPos:copy():sub(halfBoundingBoxSize.x, 0, halfBoundingBoxSize.z)
            local boundingBoxEnd = worldPos:copy():add(halfBoundingBoxSize.x, self.boundingBox.y / 16, halfBoundingBoxSize.z)
            for i = 0, self.fallSpeed - 1 / 16, 1 / 16 do
                if self:isCubeOverlapped(vectors.vec3(boundingBoxStart.x, boundingBoxStart.y - i - 1 / 16, boundingBoxStart.z), vectors.vec3(boundingBoxEnd.x, boundingBoxStart.y - i, boundingBoxEnd.z)) then
                    if i == 0 then
                        self.fallSpeed = 0
                    end
                    break
                else
                    fallDistance = fallDistance + 1 / 16
                end
            end
            self.objectPos = self.objectPos:copy():sub(0, fallDistance, 0)
        end

        ---設置物の落下処理。レンダー関数内で処理する。
        instance.fallRenderProcess = function (self, delta)
            if self.objectPos ~= self.objectPosPrev then
                self:setWorldPos(self.objectPosPrev:copy():add(self.objectPos:copy():sub(self.objectPosPrev):scale(delta)), false)
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