---@class PalcementObject
---@field COLLISION_FINESS integer 当たり判定の細かさ（1ブロックの長さにつき何回処理を行うか）。当然細かくすれば精度が向上するが、その分処理の負荷も増大する。
---@field FALL_SPEED number 空中にある設置物が落下する速度（ブロック/ティック）
---@field ObjectData table 設置物の情報テーブル
PlacementObject = {
    --定数
    COLLISION_FINESS = 16,
    FALL_SPEED = 3.5,

    --変数
    ObjectData = {},

    --関数
    ---設置物の番号を返す。番号は情報テーブルを参照するインデックスとなる。
    ---@param objectModel ModelPart 番号を取得する設置物のモデル
    ---@return integer objectNumber 設置物の番号
    getObjectNumber = function(self, objectModel)
        return tonumber(objectModel:getName():sub(7))
    end,

    ---指定した場所に指定した向きで設置物を置く。
    ---@param objectIndex integer 設置するオブジェクトのインデックス番号
    ---@param worldPos Vector3 設置する場所を示すワールド座標
    ---@param worldRot number 設置物の向き
    place = function(self, objectIndex, worldPos, worldRot)
        local objectNumber = #models.models.placement_object.WorldObjects:getChildren() + 1
        ---@diagnostic disable-next-line: redundant-parameter
        local newObject = BlueArchiveCharacter.PLACEMENT_OBJECT.objects[objectIndex]:copy("Object"..objectNumber)
        models.models.placement_object.WorldObjects:addChild(newObject)
        newObject:setVisible(true)
        newObject:setPos(worldPos:scale(16))
        newObject:setRot(0, -worldRot, 0)
        PlacementObject.ObjectData[objectNumber] = {
            index = objectIndex
        }
        if objectNumber == 1 then
            events.TICK:register(self.tick, "placement_object_tick")
            events.RENDER:register(self.render, "placement_object_render")
        end
    end,

    ---設置済みの設置物から指定したものを削除する。
    ---@param targetModel ModelPart 削除対象の設置物
    remove = function(self, targetModel)
        models.models.placement_object.WorldObjects:removeChild(targetModel)
        if #models.models.placement_object.WorldObjects:getChildren() == 0 then
            events.TICK:remove("placement_object_tick")
            events.RENDER:remove("placement_object_render")
            PlacementObject.ObjectData[PlacementObject:getObjectNumber(targetModel)] = nil
        end
    end,

    ---設置済みの設置物を全て削除する。
    removeAll = function(self)
        events.TICK:remove("placement_object_tick")
        events.RENDER:remove("placement_object_render")
        PlacementObject.ObjectData = {}
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
            local objectNumber = PlacementObject:getObjectNumber(modelPart)
            if PlacementObject.ObjectData[objectNumber].nextPos ~= nil then
                modelPart:setPos(PlacementObject.ObjectData[objectNumber].nextPos)
            end
            local modelPos = modelPart:getPos():scale(1 / 16)
            if modelPos.y <= -128 then
                PlacementObject:remove(modelPart)
                break
            end
            --現在の位置でのコリジョン判定
            local collisionDetected = false
            local inWater = false
            for _, hitBox in ipairs(BlueArchiveCharacter.PLACEMENT_OBJECT.hitBoxes[PlacementObject.ObjectData[objectNumber].index]) do
                for _, pos in ipairs(CollisionUtils:getCollisionBlocks(modelPos:copy():add(hitBox[1]), hitBox[2])) do
                    local block = world.getBlockState(pos)
                    if block.id == "minecraft:lava" or block.id == "minecraft:fire" or block.id == "minecraft:soul_fire" then
                        sounds:playSound("minecraft:block.fire.extinguish", modelPos)
                        for _ = 1, math.ceil(hitBox[2].x * hitBox[2].y * hitBox[2].z) * 10 do
                            particles:newParticle("minecraft:smoke", modelPos:copy():add(math.random() * hitBox[2].x - hitBox[2].x / 2, math.random() * hitBox[2].y, math.random() * hitBox[2].z - hitBox[2].z / 2))
                        end
                        PlacementObject:remove(modelPart)
                        collisionDetected = true
                    elseif block.id == "minecraft:water" then
                        inWater = true
                    elseif block:hasCollision() then
                        for _, collision in ipairs(block:getCollisionShape()) do
                            local hitBoxStartPos = modelPos:copy():add(hitBox[1])
                            if CollisionUtils:isCubeOverrapped(hitBoxStartPos, hitBoxStartPos:copy():add(hitBox[2]), pos:copy():add(collision[1]), pos:copy():add(collision[2])) then
                                PlacementObject:remove(modelPart)
                                collisionDetected = true
                                break
                            end
                        end
                    end
                    if collisionDetected then
                        break
                    end
                end
                if collisionDetected then
                    break
                end
            end
            --落下先の判定
            local fallDistance = 0
            if not collisionDetected then
                collisionDetected = false
                for i = 0, -(PlacementObject.FALL_SPEED * (inWater and 0.1 or 1)), -(1 / PlacementObject.COLLISION_FINESS) do
                    for _, hitBox in ipairs(BlueArchiveCharacter.PLACEMENT_OBJECT.hitBoxes[PlacementObject.ObjectData[objectNumber].index]) do
                        for _, pos in ipairs(CollisionUtils:getCollisionBlocks(modelPos:copy():add(hitBox[1]):add(0, i), hitBox[2]:copy():mul(1, 0, 1))) do
                            local block = world.getBlockState(pos)
                            if block:hasCollision() then
                                for _, collision in ipairs(block:getCollisionShape()) do
                                    local hitBoxStartPos = modelPos:copy():add(hitBox[1])
                                    if CollisionUtils:isCubeOverrapped(hitBoxStartPos, hitBoxStartPos:copy():add(hitBox[2]:copy():mul(1, 0, 1)), pos:copy():add(collision[1]), pos:copy():add(collision[2])) then
                                        collisionDetected = true
                                        break
                                    end
                                end
                            end
                            if collisionDetected then
                                break
                            end
                        end
                        if collisionDetected then
                            break
                        else
                            fallDistance = -i
                        end
                    end
                    if collisionDetected then
                        break
                    end
                end
            end
            if PlacementObject.ObjectData[objectNumber] ~= nil then
                PlacementObject.ObjectData[objectNumber].currentPos = modelPos:copy():scale(16)
                PlacementObject.ObjectData[objectNumber].nextPos = modelPos:copy():scale(16):add(0, -fallDistance * 16)
            end
        end
    end,

    ---レンダー関数
    render = function(delta)
        for _, modelPart in ipairs(models.models.placement_object.WorldObjects:getChildren()) do
            local objectNumber = PlacementObject:getObjectNumber(modelPart)
            if PlacementObject.ObjectData[objectNumber].currentPos ~= nil and PlacementObject.ObjectData[objectNumber].nectPos ~= nil then
                local currentPos = PlacementObject.ObjectData[objectNumber].currentPos
                local nextPos = PlacementObject.ObjectData[objectNumber].nextPos
                if currentPos.x ~= nextPos.x or currentPos.y ~= nextPos.y or currentPos.z ~= nextPos.z then
                    modelPart:setPos(currentPos:copy():add(nextPos:copy():sub(currentPos):scale(delta)))
                end
            end
        end
    end
}

return PlacementObject