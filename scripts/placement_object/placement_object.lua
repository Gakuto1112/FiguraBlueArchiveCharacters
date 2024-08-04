---@class PlacementObject 単一の設置物を管理するクラス
PlacementObject = {
    ---設置物のインスタンスを新しく生成する。
    ---@param objectModel ModelPart 設置物としてこのインスタンスで操作するモデルパーツ
    ---@param objectIndex integer 設置物データのインデックス番号。設置物のデータを参照するときに使用する。
    ---@param objectData table 設置物データ
    ---@param pos Vector3 設置物を設置するワールド座標
    ---@param rot number 設置物のワールド方向
    new = function (objectModel, objectIndex, objectData, pos, rot)
        local instance = {}

        ---設置物の見かけのオフセット位置
        ---@type Vector3
        instance.modelOffsetPos = vectors.vec3()

        ---設置物としてこのインスタンスで操作するモデルパーツ
        ---@type ModelPart
        instance.objectModel = objectModel

        ---設置物データのインデックス番号。設置物のデータを参照するときに使用する。
        ---@type integer
        instance.objectIndex = objectIndex

        ---設置物の当たり判定
        ---@type Vector3
        instance.boundingBox = objectData.boundingBox.size:copy():scale(0.0625)

        ---この設置物に働く重力の大きさ
        ---@type number
        instance.gravity = 1

        ---この設置物に炎耐性を付けるかどうか。
        ---@type boolean
        instance.hasFireResistance = false

        ---この設置物インスタンスの破棄を要求するかどうか。trueにした次のティックにインスタンスは破棄される。
        ---@type boolean
        instance.deinitRequired = false

        ---この設置物のインスタンスが破棄される理由
        ---@type PlacementObjectManager.RemoveReason
        instance.removeReason = "REMOVED_BY_SCRIPTS"

        ---設置物の現在の位置
        ---@type Vector3
        instance.currentPos = pos

        ---設置物の次ティックの位置
        instance.nextPos = pos

        ---設置物の落下速度
        ---@type number
        instance.fallingSpeed = 0

        ---設置物が接地しているかどうか
        ---@type boolean
        instance.isOnGround = false

        ---このインスタンスが生成された直後に呼ばれる関数
        instance.onInit = function ()
            if objectData.gravity ~= nil then
                instance.gravity = objectData.gravity
            end
            local objectOffset = vectors.vec3()
            if objectData.boundingBox.offsetPos ~= nil then
                objectOffset = objectData.boundingBox.offsetPos:copy():scale(-0.0625)
            end
            if instance.gravity >= 0 then
                instance.modelOffsetPos = objectOffset:copy():add(0, 0.075, 0)
            else
                instance.modelOffsetPos = objectOffset:copy():add(0, -0.075, 0)
            end
            if objectData.hasFireResistance ~= nil then
                instance.hasFireResistance = objectData.hasFireResistance
            end
            instance.objectModel:setPos(instance.currentPos:copy():add(instance.modelOffsetPos):scale(16))
            instance.objectModel:setRot(0, rot, 0)
            instance.objectModel:setVisible(true)
            if objectData.callbacks.onInit ~= nil then
                objectData.callbacks.onInit(instance)
            end
        end

        ---このインスタンスが破棄される直前に呼ばれる関数
        instance.onDeinit = function ()
            if objectData.placementMode == "COPY" then
                instance.objectModel:remove()
            else
                instance.objectModel:setVisible(false)
            end
            if objectData.callbacks.onDeinit ~= nil then
                objectData.callbacks.onDeinit(instance)
            end
        end

        ---各ティック毎に呼ばれる関数
        instance.onTick = function ()
            --設置物の位置を強制更新
            instance.currentPos = instance.nextPos
            instance.objectModel:setPos(instance.currentPos:copy():add(instance.modelOffsetPos):scale(16))

            --当たり判定同士が重複しているか確認
            local boundingBoxStartPos = vectors.vec3(instance.currentPos.x - instance.boundingBox.x / 2, instance.currentPos.y, instance.currentPos.z - instance.boundingBox.z / 2)
            local boundingBoxEndPos = vectors.vec3(instance.currentPos.x + instance.boundingBox.x / 2, instance.currentPos.y + instance.boundingBox.y, instance.currentPos.z + instance.boundingBox.z / 2)
            local boundingBoxCenter = boundingBoxEndPos:copy():sub(boundingBoxStartPos):scale(0.5):add(boundingBoxStartPos)
            for z = math.floor(boundingBoxStartPos.z), math.floor(boundingBoxEndPos.z) do
                for y = math.floor(boundingBoxStartPos.y), math.floor(boundingBoxEndPos.y) do
                    for x = math.floor(boundingBoxStartPos.x), math.floor(boundingBoxEndPos.x) do
                        for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                            local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                            local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                            local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                            if math.abs(collisionBoxCenter.x - boundingBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (boundingBoxEndPos.x - boundingBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - boundingBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (boundingBoxEndPos.y - boundingBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - boundingBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (boundingBoxEndPos.z - boundingBoxStartPos.z)) / 2 then
                                instance.removeReason = "OVERLAPPED"
                                instance.deinitRequired = true
                                return
                            end
                        end
                    end
                end
            end

            --落下速度を更新
            local fluidTags = world.getBlockState(instance.currentPos):getFluidTags()
            if fluidTags[2] == "c:water" then
                if instance.gravity >= 0 then
                    instance.fallingSpeed = math.max(instance.fallingSpeed - 0.1 * instance.gravity, 0.1 * instance.gravity)
                else
                    instance.fallingSpeed = math.min(instance.fallingSpeed - 0.1 * instance.gravity, 0.1 * instance.gravity)
                end
            elseif fluidTags[2] == "c:lava" then
                if instance.gravity >= 0 then
                    instance.fallingSpeed = math.max(instance.fallingSpeed - 0.1 * instance.gravity, 0.02 * instance.gravity)
                else
                    instance.fallingSpeed = math.min(instance.fallingSpeed - 0.1 * instance.gravity, 0.02 * instance.gravity)
                end
            else
                if instance.gravity >= 0 then
                    instance.fallingSpeed = math.min(instance.fallingSpeed + 0.035 * instance.gravity, 3.575 * instance.gravity)
                else
                    instance.fallingSpeed = math.max(instance.fallingSpeed + 0.035 * instance.gravity, 3.575 * instance.gravity)
                end
            end
            instance.nextPos = instance.currentPos:copy():add(0, instance.fallingSpeed * -1, 0)

            --現ティックと次ティックから直方体を算出
            local nextBoxStartPos = vectors.vec3()
            local nextBoxEndPos = vectors.vec3()
            if instance.gravity >= 0 then
                nextBoxStartPos = vectors.vec3(instance.currentPos.x - instance.boundingBox.x / 2, math.min(instance.currentPos.y, instance.currentPos.y - instance.fallingSpeed), instance.currentPos.z - instance.boundingBox.z / 2)
                nextBoxEndPos = vectors.vec3(instance.currentPos.x + instance.boundingBox.x / 2, math.max(instance.currentPos.y, instance.currentPos.y - instance.fallingSpeed), instance.currentPos.z + instance.boundingBox.z / 2)
            else
                nextBoxStartPos = vectors.vec3(instance.currentPos.x - instance.boundingBox.x / 2, math.min(instance.currentPos.y, instance.currentPos.y - instance.fallingSpeed) + instance.boundingBox.y, instance.currentPos.z - instance.boundingBox.z / 2)
                nextBoxEndPos = vectors.vec3(instance.currentPos.x + instance.boundingBox.x / 2, math.max(instance.currentPos.y, instance.currentPos.y - instance.fallingSpeed) + instance.boundingBox.y, instance.currentPos.z + instance.boundingBox.z / 2)
            end
            local nextBoxCenter = nextBoxStartPos:copy():add(nextBoxEndPos:copy():sub(nextBoxStartPos):scale(0.5))

            --直方体と重なるブロック座標を全て算出
            local collisionDetected = false
            if instance.gravity >= 0 then
                local collisionYPos = math.floor(nextBoxStartPos.y)
                for y = math.floor(nextBoxEndPos.y), math.floor(nextBoxStartPos.y) - 1, -1 do
                    for z = math.floor(nextBoxStartPos.z), math.floor(nextBoxEndPos.z) do
                        for x = math.floor(nextBoxStartPos.x), math.floor(nextBoxEndPos.x) do
                            for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                                local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                                local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                                local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                                if math.abs(collisionBoxCenter.x - nextBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (nextBoxEndPos.x - nextBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - nextBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (nextBoxEndPos.y - nextBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - nextBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (nextBoxEndPos.z - nextBoxStartPos.z)) / 2 then
                                    if collisionEndPos.y > instance.nextPos.y then
                                        instance.nextPos.y = collisionEndPos.y
                                        collisionYPos = y
                                        instance.fallingSpeed = 0
                                        collisionDetected = true
                                    end
                                end
                            end
                        end
                    end
                    if y == collisionYPos - 1 then
                        break
                    end
                end
            else
                local collisionYPos = math.floor(nextBoxEndPos.y)
                for y = math.floor(nextBoxStartPos.y), math.floor(nextBoxEndPos.y), 1 do
                    for z = math.floor(nextBoxStartPos.z), math.floor(nextBoxEndPos.z) do
                        for x = math.floor(nextBoxStartPos.x), math.floor(nextBoxEndPos.x) do
                            for _, collisionBox in ipairs( world.getBlockState(x, y, z):getCollisionShape()) do
                                local collisionStartPos = collisionBox[1]:copy():add(x, y, z)
                                local collisionEndPos = collisionBox[2]:copy():add(x, y, z)
                                local collisionBoxCenter = collisionStartPos:copy():add(collisionEndPos:copy():sub(collisionStartPos):scale(0.5))
                                if math.abs(collisionBoxCenter.x - nextBoxCenter.x) < ((collisionEndPos.x - collisionStartPos.x) + (nextBoxEndPos.x - nextBoxStartPos.x)) / 2 and math.abs(collisionBoxCenter.y - nextBoxCenter.y) < ((collisionEndPos.y - collisionStartPos.y) + (nextBoxEndPos.y - nextBoxStartPos.y)) / 2 and math.abs(collisionBoxCenter.z - nextBoxCenter.z) < ((collisionEndPos.z - collisionStartPos.z) + (nextBoxEndPos.z - nextBoxStartPos.z)) / 2 then
                                    if collisionStartPos.y < instance.nextPos.y + instance.boundingBox.y then
                                        instance.nextPos.y = collisionStartPos.y - instance.boundingBox.y
                                        collisionYPos = y
                                        instance.fallingSpeed = 0
                                        collisionDetected = true
                                    end
                                end
                            end
                        end
                    end
                    if y == collisionYPos + 1 then
                        break
                    end
                end
            end
            if collisionDetected and not instance.isOnGround and objectData.callbacks.onGround ~= nil then
                objectData.callbacks.onGround(instance)
            end
            instance.isOnGround = collisionDetected
            local nextBlock = world.getBlockState(instance.nextPos)
            local isNextBlockFire = false
            for _, tag in ipairs(nextBlock:getTags()) do
                if tag == "minecraft:fire" then
                    isNextBlockFire = true
                    break
                end
            end
            if instance.nextPos.y < -128 then
                instance.removeReason = "TOO_LOW"
                instance.deinitRequired = true
            elseif instance.nextPos.y > 384 then
                instance.removeReason = "TOO_HIGH"
                instance.deinitRequired = true
            elseif not instance.hasFireResistance and (nextBlock:getFluidTags()[2] == "c:lava" or isNextBlockFire) then
                sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.fire.extinguish"), instance.nextPos)
                for _ = 0, instance.boundingBox.x * instance.boundingBox.y * instance.boundingBox.z * 8 do
                    particles:newParticle(CompatibilityUtils:checkParticle("minecraft:smoke"), vectors.vec3(instance.nextPos.x + math.random() * instance.boundingBox.x - instance.boundingBox.x / 2, instance.nextPos.y + math.random() * instance.boundingBox.y, instance.nextPos.z + math.random() * instance.boundingBox.z - instance.boundingBox.z / 2))
                end
                instance.removeReason = "BURNT"
                instance.deinitRequired = true
            end
            if objectData.callbacks.onTick ~= nil then
                objectData.callbacks.onTick(instance)
            end
        end

        ---各レンダーティック毎に呼ばれる関数
        ---@param delta number デルタ値
        instance.onRender = function (delta, context, matrix)
            instance.objectModel:setPos(instance.nextPos:copy():sub(instance.currentPos):scale(delta):add(instance.currentPos):add(instance.modelOffsetPos):scale(16))
            if objectData.callbacks.onRender ~= nil then
                objectData.callbacks.onRender(delta, context, matrix, instance)
            end
        end

        ---この設置物インスタンスを削除する。コールバック関数から削除したい場合はこの関数を呼ぶ。
        instance.remove = function ()
            instance.deinitRequired = true
        end

        return instance
    end
}

return PlacementObject