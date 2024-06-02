---@class Physics 物理演算（もどき）を制御するクラス
---@field VelocityData table<table<number>> 速度データ：1. 頭前後, 2. 上下, 3. 頭左右, 4. 頭角速度, 5. 体前後, 6. 体左右, 7. 体角速度
---@field VelocityAverage table<number> 速度の平均値：1. 頭前後, 2. 上下, 3. 頭左右, 4. 頭角速度, 5. 体前後, 6. 体左右, 7. 体角速度
---@field DirectionPrevRender table<number> 前レンダーチックのdirectionテーブル
---@field RenderProcessed boolean このレンダーで処理済みかどうか
Physics = {
    --変数
	VelocityData = {{}, {}, {}, {}, {}, {}, {}},
	VelocityAverage = {0, 0, 0, 0, 0, 0, 0},
	DirectionPrevRender = {},
    RenderProcessed = false,

    --関数
    ---物理演算を初期化し、有効にする。
    enable = function(self)
        self.VelocityData = {{}, {}, {}, {}, {}, {}, {}}
        self.VelocityAverage = {0, 0, 0, 0, 0, 0, 0}
        self.DirectionPrevRender = {}
        self.RenderProcessed = false
        if events.RENDER:getRegisteredCount("physics_render") == 0 then
            events.RENDER:register(Physics.render, "physics_render")
            events.WORLD_RENDER:register(Physics.worldRender, "physics_world_render")
        end
    end,

    --物理演算を無効にする。物理演算で管理していたモデルの回転をリセットする。
    disable = function()
        events.RENDER:remove("physics_render")
        events.WORLD_RENDER:remove("physics_world_render")
        for _, physicData in ipairs(BlueArchiveCharacter.PHYSICS.data) do
            local initialRot = vectors.vec3()
            if physicData.x ~= nil and physicData.x.vertical ~= nil then
                initialRot.x = physicData.x.vertical.neutral
            end
            if physicData.y ~= nil and physicData.y.vertical ~= nil then
                initialRot.y = physicData.y.vertical.neutral
            end
            if physicData.z ~= nil and physicData.z.vertical ~= nil then
                initialRot.z = physicData.z.vertical.neutral
            end
            local modelParts = {}
            if type(physicData.modelPart) == "ModelPart" then
                table.insert(modelParts, physicData.modelPart)
            elseif type(physicData.modelPart) == "table" then
                modelParts = physicData.modelPart
            end
            for _, modelPart in ipairs(modelParts) do
                modelPart:setRot(initialRot)
            end
        end
    end,

    ---レンダー関数
    render = function(delta)
        local lookDir = player:getLookDir()
        if not Physics.RenderProcessed then
            local velocity = player:getVelocity()
            local FPS = client:getFPS()

            ---速度を指定された方向から見て前後方向、左右方向に分解する。
            ---@param direction number 基準にする方向
            ---@param index integer データ管理用のインデックス番号（呼び出しの度に異なるインデックス番号になるようにする）
            ---@return number velocityFront 指定された方向から見た前後方向の速度
            ---@return number velocityRight 指定された方向から見た左右方向の速度
            ---@return number velocityRot 指定された方向を基準とした角速度
            local function decomposeHorizontalVelocity(direction, index)
                if Physics.DirectionPrevRender[index] == nil then
                    Physics.DirectionPrevRender[index] = 0
                end
                local velocityRot = math.deg(math.atan2(velocity.z, velocity.x))
                velocityRot = velocityRot < 0 and 360 + velocityRot or velocityRot
                local directionAbsFront = math.abs(velocityRot - (direction) % 360)
                directionAbsFront = directionAbsFront > 180 and 360 - directionAbsFront or directionAbsFront
                local directionAbsRight = math.abs(velocityRot - (direction + 90) % 360)
                directionAbsRight = directionAbsRight > 180 and 360 - directionAbsRight or directionAbsRight
                local directionDelta = direction - Physics.DirectionPrevRender[index]
                directionDelta = directionDelta > 180 and (360 - directionDelta) * FPS or (directionDelta < -180 and (360 + directionDelta) * FPS or directionDelta * FPS)
                Physics.DirectionPrevRender[index] = direction
                return math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) * math.cos(math.rad(directionAbsFront)), math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) * math.cos(math.rad(directionAbsRight)), directionDelta
            end

            local velocityHeadFront, velocityHeadRight, velocityHeadRot = decomposeHorizontalVelocity(math.deg(math.atan2(lookDir.z, lookDir.x)), 1)
            Physics.VelocityAverage[1] = (#Physics.VelocityData[1] * Physics.VelocityAverage[1] + velocityHeadFront) / (#Physics.VelocityData[1] + 1)
            table.insert(Physics.VelocityData[1], velocityHeadFront)
            Physics.VelocityAverage[2] = (#Physics.VelocityData[2] * Physics.VelocityAverage[2] + velocity.y) / (#Physics.VelocityData[2] + 1)
            table.insert(Physics.VelocityData[2], velocity.y)
            Physics.VelocityAverage[3] = (#Physics.VelocityData[3] * Physics.VelocityAverage[3] + velocityHeadRight) / (#Physics.VelocityData[3] + 1)
            table.insert(Physics.VelocityData[3], velocityHeadRight)
            Physics.VelocityAverage[4] = (#Physics.VelocityData[4] * Physics.VelocityAverage[4] + velocityHeadRot) / (#Physics.VelocityData[4] + 1)
            table.insert(Physics.VelocityData[4], velocityHeadRot)
            local velocityBodyFront, velocityBodyRight, velocityBodyRot = decomposeHorizontalVelocity((player:getBodyYaw(delta) + models.models.main.Avatar.UpperBody:getTrueRot().y - 90) % 360 - 180, 2)
            Physics.VelocityAverage[5] = (#Physics.VelocityData[5] * Physics.VelocityAverage[5] + velocityBodyFront) / (#Physics.VelocityData[5] + 1)
            table.insert(Physics.VelocityData[5], velocityBodyFront)
            Physics.VelocityAverage[6] = (#Physics.VelocityData[6] * Physics.VelocityAverage[6] + velocityBodyRight) / (#Physics.VelocityData[6] + 1)
            table.insert(Physics.VelocityData[6], velocityBodyRight)
            Physics.VelocityAverage[7] = (#Physics.VelocityData[7] * Physics.VelocityAverage[7] + velocityBodyRot) / (#Physics.VelocityData[7] + 1)
            table.insert(Physics.VelocityData[7], velocityBodyRot)
            --古いデータの切り捨て
            for index, velocityTable in ipairs(Physics.VelocityData) do
                while #velocityTable > FPS * 0.25 do
                    if #velocityTable >= 2 then
                        Physics.VelocityAverage[index] = (#velocityTable * Physics.VelocityAverage[index] - velocityTable[1]) / (#velocityTable - 1)
                    end
                    table.remove(velocityTable, 1)
                end
            end
            Physics.RenderProcessed = true
        end

        --求めた平均速度からパーツの角度を計算
        local playerPose = player:getPose()
        local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
        local waterMultiplayer = player:isInWater() and 2 or 1
        local headRot = math.deg(math.asin(player:getLookDir().y))
        local isSneaking = player:isCrouching()
        for _, physicData in ipairs(BlueArchiveCharacter.PHYSICS.data) do
            local modelParts = {}
            if type(physicData.modelPart) == "ModelPart" then
                table.insert(modelParts, physicData.modelPart)
            elseif type(physicData.modelPart) == "table" then
                modelParts = physicData.modelPart
            end
            for _, modelPart in ipairs(modelParts) do
                if modelPart:getVisible() then
                    local rotX = 0
                    if physicData.x then
                        if isHorizontal and physicData.x.horizontal then
                            rotX = physicData.x.horizontal.neutral
                            if physicData.x.horizontal.headX then
                                rotX = math.clamp(Physics.VelocityAverage[1] * physicData.x.horizontal.headX.multiplayer * waterMultiplayer + rotX, physicData.x.horizontal.headX.min - physicData.x.horizontal.neutral, physicData.x.horizontal.headX.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.headZ then
                                rotX = math.clamp(Physics.VelocityAverage[3] * physicData.x.horizontal.headZ.multiplayer * waterMultiplayer + rotX, physicData.x.horizontal.headZ.min - physicData.x.horizontal.neutral, physicData.x.horizontal.headZ.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.headRot then
                                rotX = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.x.horizontal.headRot.multiplayer + rotX, physicData.x.horizontal.headRot.min - physicData.x.horizontal.neutral, physicData.x.horizontal.headRot.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.bodyX then
                                rotX = math.clamp(Physics.VelocityAverage[5] * physicData.x.horizontal.bodyX.multiplayer * waterMultiplayer + rotX, physicData.x.horizontal.bodyX.min - physicData.x.horizontal.neutral, physicData.x.horizontal.bodyX.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.bodyY then
                                rotX = math.clamp(Physics.VelocityAverage[2] * physicData.x.horizontal.bodyY.multiplayer * waterMultiplayer + rotX, physicData.x.horizontal.bodyY.min - physicData.x.horizontal.neutral, physicData.x.horizontal.bodyY.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.bodyZ then
                                rotX = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.x.horizontal.bodyZ.multiplayer * waterMultiplayer + rotX, physicData.x.horizontal.bodyZ.min - physicData.x.horizontal.neutral, physicData.x.horizontal.bodyZ.max - physicData.x.horizontal.neutral)
                            end
                            if physicData.x.horizontal.bodyRot then
                                rotX = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.x.horizontal.bodyRot.multiplayer + rotX, physicData.x.horizontal.bodyRot.min - physicData.x.horizontal.neutral, physicData.x.horizontal.bodyRot.max - physicData.x.horizontal.neutral)
                            end
                            rotX = math.clamp(rotX, physicData.x.horizontal.min, physicData.x.horizontal.max)
                            if physicData.x.horizontal.headRotMultiplayer then
                                rotX = rotX + headRot * physicData.x.horizontal.headRotMultiplayer
                            end
                            if isSneaking and physicData.x.horizontal.sneakOffset then
                                rotX = rotX + physicData.x.horizontal.sneakOffset
                            end
                        elseif physicData.x.vertical then
                            rotX = physicData.x.vertical.neutral
                            if physicData.x.vertical.headX then
                                rotX = math.clamp(Physics.VelocityAverage[1] * physicData.x.vertical.headX.multiplayer + rotX, physicData.x.vertical.headX.min - physicData.x.vertical.neutral, physicData.x.vertical.headX.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.headZ then
                                rotX = math.clamp(Physics.VelocityAverage[3] * physicData.x.vertical.headZ.multiplayer + rotX, physicData.x.vertical.headZ.min - physicData.x.vertical.neutral, physicData.x.vertical.headZ.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.headRot then
                                rotX = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.x.vertical.headRot.multiplayer + rotX, physicData.x.vertical.headRot.min - physicData.x.vertical.neutral, physicData.x.vertical.headRot.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.bodyX then
                                rotX = math.clamp(Physics.VelocityAverage[5] * physicData.x.vertical.bodyX.multiplayer + rotX, physicData.x.vertical.bodyX.min - physicData.x.vertical.neutral, physicData.x.vertical.bodyX.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.bodyY then
                                rotX = math.clamp(Physics.VelocityAverage[2] * physicData.x.vertical.bodyY.multiplayer + rotX, physicData.x.vertical.bodyY.min - physicData.x.vertical.neutral, physicData.x.vertical.bodyY.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.bodyZ then
                                rotX = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.x.vertical.bodyZ.multiplayer + rotX, physicData.x.vertical.bodyZ.min - physicData.x.vertical.neutral, physicData.x.vertical.bodyZ.max - physicData.x.vertical.neutral)
                            end
                            if physicData.x.vertical.bodyRot then
                                rotX = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.x.vertical.bodyRot.multiplayer + rotX, physicData.x.vertical.bodyRot.min - physicData.x.vertical.neutral, physicData.x.vertical.bodyRot.max - physicData.x.vertical.neutral)
                            end
                            rotX = math.clamp(rotX, physicData.x.vertical.min, physicData.x.vertical.max)
                            if physicData.x.vertical.headRotMultiplayer then
                                rotX = rotX + headRot * physicData.x.vertical.headRotMultiplayer
                            end
                            if isSneaking and physicData.x.vertical.sneakOffset then
                                rotX = rotX + physicData.x.vertical.sneakOffset
                            end
                        end
                    end
                    local rotY = 0
                    if physicData.y then
                        if isHorizontal and physicData.y.horizontal then
                            rotY = physicData.y.horizontal.neutral
                            if physicData.y.horizontal.headX then
                                rotY = math.clamp(Physics.VelocityAverage[1] * physicData.y.horizontal.headX.multiplayer * waterMultiplayer + rotY, physicData.y.horizontal.headX.min - physicData.y.horizontal.neutral, physicData.y.horizontal.headX.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.headZ then
                                rotY = math.clamp(Physics.VelocityAverage[3] * physicData.y.horizontal.headZ.multiplayer * waterMultiplayer + rotY, physicData.y.horizontal.headZ.min - physicData.y.horizontal.neutral, physicData.y.horizontal.headZ.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.headRot then
                                rotY = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.y.horizontal.headRot.multiplayer + rotY, physicData.y.horizontal.headRot.min - physicData.y.horizontal.neutral, physicData.y.horizontal.headRot.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.bodyX then
                                rotY = math.clamp(Physics.VelocityAverage[5] * physicData.y.horizontal.bodyX.multiplayer * waterMultiplayer + rotY, physicData.y.horizontal.bodyX.min - physicData.y.horizontal.neutral, physicData.y.horizontal.bodyX.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.bodyY then
                                rotY = math.clamp(Physics.VelocityAverage[2] * physicData.y.horizontal.bodyY.multiplayer * waterMultiplayer + rotY, physicData.y.horizontal.bodyY.min - physicData.y.horizontal.neutral, physicData.y.horizontal.bodyY.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.bodyZ then
                                rotY = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.y.horizontal.bodyZ.multiplayer * waterMultiplayer + rotY, physicData.y.horizontal.bodyZ.min - physicData.y.horizontal.neutral, physicData.y.horizontal.bodyZ.max - physicData.y.horizontal.neutral)
                            end
                            if physicData.y.horizontal.bodyRot then
                                rotY = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.y.horizontal.bodyRot.multiplayer + rotY, physicData.y.horizontal.bodyRot.min - physicData.y.horizontal.neutral, physicData.y.horizontal.bodyRot.max - physicData.y.horizontal.neutral)
                            end
                            rotY = math.clamp(rotY, physicData.y.horizontal.min, physicData.y.horizontal.max)
                            if physicData.y.horizontal.headRotMultiplayer then
                                rotY = rotY + headRot * physicData.y.horizontal.headRotMultiplayer
                            end
                            if isSneaking and physicData.y.horizontal.sneakOffset then
                                rotY = rotY + physicData.y.horizontal.sneakOffset
                            end
                        elseif physicData.y.vertical then
                            rotY = physicData.y.vertical.neutral
                            if physicData.y.vertical.headX then
                                rotY = math.clamp(Physics.VelocityAverage[1] * physicData.y.vertical.headX.multiplayer + rotY, physicData.y.vertical.headX.min - physicData.y.vertical.neutral, physicData.y.vertical.headX.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.headZ then
                                rotY = math.clamp(Physics.VelocityAverage[3] * physicData.y.vertical.headZ.multiplayer + rotY, physicData.y.vertical.headZ.min - physicData.y.vertical.neutral, physicData.y.vertical.headZ.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.headRot then
                                rotY = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.y.vertical.headRot.multiplayer + rotY, physicData.y.vertical.headRot.min - physicData.y.vertical.neutral, physicData.y.vertical.headRot.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.bodyX then
                                rotY = math.clamp(Physics.VelocityAverage[5] * physicData.y.vertical.bodyX.multiplayer + rotY, physicData.y.vertical.bodyX.min - physicData.y.vertical.neutral, physicData.y.vertical.bodyX.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.bodyY then
                                rotY = math.clamp(Physics.VelocityAverage[2] * physicData.y.vertical.bodyY.multiplayer + rotY, physicData.y.vertical.bodyY.min - physicData.y.vertical.neutral, physicData.y.vertical.bodyY.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.bodyZ then
                                rotY = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.y.vertical.bodyZ.multiplayer + rotY, physicData.y.vertical.bodyZ.min - physicData.y.vertical.neutral, physicData.y.vertical.bodyZ.max - physicData.y.vertical.neutral)
                            end
                            if physicData.y.vertical.bodyRot then
                                rotY = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.y.vertical.bodyRot.multiplayer + rotY, physicData.y.vertical.bodyRot.min - physicData.y.vertical.neutral, physicData.y.vertical.bodyRot.max - physicData.y.vertical.neutral)
                            end
                            rotY = math.clamp(rotY, physicData.y.vertical.min, physicData.y.vertical.max)
                            if physicData.y.vertical.headRotMultiplayer then
                                rotY = rotY + headRot * physicData.y.vertical.headRotMultiplayer
                            end
                            if isSneaking and physicData.y.vertical.sneakOffset then
                                rotY = rotY + physicData.y.vertical.sneakOffset
                            end
                        end
                    end
                    local rotZ = 0
                    if physicData.z then
                        if isHorizontal and physicData.z.horizontal then
                            rotZ = physicData.z.horizontal.neutral
                            if physicData.z.horizontal.headX then
                                rotZ = math.clamp(Physics.VelocityAverage[1] * physicData.z.horizontal.headX.multiplayer * waterMultiplayer + rotZ, physicData.z.horizontal.headX.min - physicData.z.horizontal.neutral, physicData.z.horizontal.headX.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.headZ then
                                rotZ = math.clamp(Physics.VelocityAverage[3] * physicData.z.horizontal.headZ.multiplayer * waterMultiplayer + rotZ, physicData.z.horizontal.headZ.min - physicData.z.horizontal.neutral, physicData.z.horizontal.headZ.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.headRot then
                                rotZ = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.z.horizontal.headRot.multiplayer + rotZ, physicData.z.horizontal.headRot.min - physicData.z.horizontal.neutral, physicData.z.horizontal.headRot.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.bodyX then
                                rotZ = math.clamp(Physics.VelocityAverage[5] * physicData.z.horizontal.bodyX.multiplayer * waterMultiplayer + rotZ, physicData.z.horizontal.bodyX.min - physicData.z.horizontal.neutral, physicData.z.horizontal.bodyX.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.bodyY then
                                rotZ = math.clamp(Physics.VelocityAverage[2] * physicData.z.horizontal.bodyY.multiplayer * waterMultiplayer + rotZ, physicData.z.horizontal.bodyY.min - physicData.z.horizontal.neutral, physicData.z.horizontal.bodyY.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.bodyZ then
                                rotZ = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.z.horizontal.bodyZ.multiplayer * waterMultiplayer + rotZ, physicData.z.horizontal.bodyZ.min - physicData.z.horizontal.neutral, physicData.z.horizontal.bodyZ.max - physicData.z.horizontal.neutral)
                            end
                            if physicData.z.horizontal.bodyRot then
                                rotZ = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.z.horizontal.bodyRot.multiplayer + rotZ, physicData.z.horizontal.bodyRot.min - physicData.z.horizontal.neutral, physicData.z.horizontal.bodyRot.max - physicData.z.horizontal.neutral)
                            end
                            rotZ = math.clamp(rotZ, physicData.z.horizontal.min, physicData.z.horizontal.max)
                            if physicData.z.horizontal.headRotMultiplayer then
                                rotZ = rotZ + headRot * physicData.z.horizontal.headRotMultiplayer
                            end
                            if isSneaking and physicData.z.horizontal.sneakOffset then
                                rotZ = rotZ + physicData.z.horizontal.sneakOffset
                            end
                        elseif physicData.z.vertical then
                            rotZ = physicData.z.vertical.neutral
                            if physicData.z.vertical.headX then
                                rotZ = math.clamp(Physics.VelocityAverage[1] * physicData.z.vertical.headX.multiplayer + rotZ, physicData.z.vertical.headX.min - physicData.z.vertical.neutral, physicData.z.vertical.headX.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.headZ then
                                rotZ = math.clamp(Physics.VelocityAverage[3] * physicData.z.vertical.headZ.multiplayer + rotZ, physicData.z.vertical.headZ.min - physicData.z.vertical.neutral, physicData.z.vertical.headZ.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.headRot then
                                rotZ = math.clamp(-math.abs(Physics.VelocityAverage[4]) * physicData.z.vertical.headRot.multiplayer + rotZ, physicData.z.vertical.headRot.min - physicData.z.vertical.neutral, physicData.z.vertical.headRot.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.bodyX then
                                rotZ = math.clamp(Physics.VelocityAverage[5] * physicData.z.vertical.bodyX.multiplayer + rotZ, physicData.z.vertical.bodyX.min - physicData.z.vertical.neutral, physicData.z.vertical.bodyX.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.bodyY then
                                rotZ = math.clamp(Physics.VelocityAverage[2] * physicData.z.vertical.bodyY.multiplayer + rotZ, physicData.z.vertical.bodyY.min - physicData.z.vertical.neutral, physicData.z.vertical.bodyY.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.bodyZ then
                                rotZ = math.clamp(Physics.VelocityAverage[player:getVehicle() == nil and 6 or 3] * physicData.z.vertical.bodyZ.multiplayer + rotZ, physicData.z.vertical.bodyZ.min - physicData.z.vertical.neutral, physicData.z.vertical.bodyZ.max - physicData.z.vertical.neutral)
                            end
                            if physicData.z.vertical.bodyRot then
                                rotZ = math.clamp(-math.abs(Physics.VelocityAverage[7]) * physicData.z.vertical.bodyRot.multiplayer + rotZ, physicData.z.vertical.bodyRot.min - physicData.z.vertical.neutral, physicData.z.vertical.bodyRot.max - physicData.z.vertical.neutral)
                            end
                            rotZ = math.clamp(rotZ, physicData.z.vertical.min, physicData.z.vertical.max)
                            if physicData.z.vertical.headRotMultiplayer then
                                rotZ = rotZ + headRot * physicData.z.vertical.headRotMultiplayer
                            end
                            if isSneaking and physicData.z.vertical.sneakOffset then
                                rotZ = rotZ + physicData.z.vertical.sneakOffset
                            end
                        end
                    end
                    modelPart:setRot(rotX, rotY, rotZ)
                    if BlueArchiveCharacter.PHYSICS.callback ~= nil then
                        BlueArchiveCharacter.PHYSICS.callback(modelPart)
                    end
                end
            end
        end
    end,

    ---ワールドレンダー関数
    worldRender = function()
        Physics.RenderProcessed = false
    end
}

Physics:enable()

return Physics