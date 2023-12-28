---@class CameraManager カメラ制御全般を管理するクラス
CameraManager = {
    ---三人称視点でのカメラと回転軸の距離
    ---@class number
    ThirdPersonCameraDistance = 4,

    ---三人称視点でのカメラの当たり判定打ち消し機能が有効かどうか
    ---@class boolean
    IsCameraCollisionDenialEnabled = false,

    ---CameraManagerのレンダー関数を設定する。
    ---@param enabled boolean CameraManagerのレンダー関数を有効化するかどうか
    setCameraManagerRender = function (self, enabled)
        if enabled and events.RENDER:getRegisteredCount("camera_manager_render") == 0 then
            events.RENDER:register(function (delta)
                if renderer:isFirstPerson() then
                    renderer:setCameraPos()
                else
                    local rawOffsetCameraPivot = renderer:getCameraOffsetPivot()
                    rawOffsetCameraPivot = rawOffsetCameraPivot == nil and vectors.vec3() or rawOffsetCameraPivot
                    local cameraRot = client:getCameraDir()
                    local cameraPivot = player:getPos():add(0, 1.62, 0):add(rawOffsetCameraPivot)

                    ---デバッグコード
                    --[[
                    particles:newParticle("minecraft:electric_spark", cameraPivot):setScale(0.5):setColor(1, 0, 0):setLifetime(1)
                    local currentPos = cameraPivot:copy()
                    for _ = 1, 16 do
                        currentPos:add(cameraRot:copy():scale(1 / 16 * -1))
                        particles:newParticle("minecraft:electric_spark", currentPos):setScale(0.5):setColor(0, 1, 1):setLifetime(1)
                    end
                    ]]
                end
            end, "camera_manager_render")
        elseif not enabled then
            events.RENDER:remove("camera_manager_render")
        end
    end,

    ---カメラの回転軸のオフセット位置を変更する。
    ---@param newPivot? Vector3 設定する新しいカメラ回転軸のオフセット位置。nilの場合は設定値がリセットされる。
    setCameraPivot = function (newPivot)
        if host:isHost() then
            renderer:setOffsetCameraPivot(newPivot)
        end
    end,

    ---カメラ方向を変更する。
    ---@param newRot? Vector3 設定する新しいカメラのオフセット方向。nilの場合は設定値がリセットされる。
    setCameraRot = function (newRot)
        if host:isHost() then
            renderer:setCameraRot(newRot)
        end
    end,

    ---三人称視点でのカメラと回転軸の距離を設定する。
    ---@param distance number 設定する新しい距離（ブロック単位）。デフォルトは4ブロック。
    setThirdPersonCameraDistance = function (self, distance)
        if host:isHost() then
            if distance ~= 4 then
                self:setCameraManagerRender(true)
            elseif not self.IsCameraCollisionDenialEnabled then
                self:setCameraManagerRender(false)
            end
            self.ThirdPersonCameraDistance = distance
        end
    end,

    ---カメラの当たり判定打ち消し機能を設定する。
    ---@param enabled boolean カメラの当たり判定打ち消し機能を有効にするかどうか。有効にするとカメラがブロックの中にめり込むようになる。
    setCameraCollisionDenial = function (self, enabled)
        if host:isHost() then
            if enabled then
                self:setCameraManagerRender(true)
            elseif self.ThirdPersonCameraDistance == 4 then
                self:setCameraManagerRender(false)
            end
            self.IsCameraCollisionDenialEnabled = enabled
        end
    end
}

CameraManager:setCameraCollisionDenial(true)

return CameraManager