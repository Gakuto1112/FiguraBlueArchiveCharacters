---@class CameraManager カメラ制御全般を管理するクラス
CameraManager = {
    ---カメラの当たり判定打ち消し機能を無効にする。撮影用。
    ---@type boolean
    COLLISION_DENIAL_DISABLE = false,

    ---三人称視点でのカメラと回転軸の距離
    ---@type number
    ThirdPersonCameraDistance = 4,

    ---三人称視点でのカメラの当たり判定打ち消し機能が有効かどうか
    ---@type boolean
    IsCameraCollisionDenialEnabled = false,

    ---カメラの当たり判定検出の精度
    ---@type integer
    CameraAccuracy = Config.loadConfig("camera_accuracy", 4),

    ---CameraManagerのレンダー関数を設定する。
    ---@param enabled boolean CameraManagerのレンダー関数を有効化するかどうか
    setCameraManagerRender = function (self, enabled)
        if enabled and events.RENDER:getRegisteredCount("camera_manager_render") == 0 then
            events.RENDER:register(function ()
                if renderer:isFirstPerson() then
                    renderer:setCameraPos()
                else
                    local rawOffsetCameraPivot = renderer:getCameraOffsetPivot()
                    rawOffsetCameraPivot = rawOffsetCameraPivot == nil and vectors.vec3() or rawOffsetCameraPivot
                    local cameraPivot = player:getPos():add(0, 1.62, 0):add(rawOffsetCameraPivot)
                    local cameraDir = client:getCameraDir()
                    local baseVector = vectors.rotateAroundAxis(math.deg(math.asin(cameraDir.y)), 0, 0.21, 0, vectors.rotateAroundAxis(math.deg(math.atan2(cameraDir.z, cameraDir.x)) * -1 - 90, 1, 0, 0, 0, 1, 0))
                    local minDistance = math.max(self.ThirdPersonCameraDistance, 4)
                    if not self.COLLISION_DENIAL_DISABLE then
                        for i = 0, 3 do
                            minDistance = math.min(RaycastUtils:getLengthBetweenPointAndCollision(vectors.rotateAroundAxis(i * 90 + 45, baseVector:copy(), cameraDir):add(cameraPivot), cameraDir:copy():scale(-1), math.max(self.ThirdPersonCameraDistance, 4), 2 ^ (self.CameraAccuracy + 3)), minDistance)
                        end
                    end
                    renderer:setCameraPos(0, 0, (minDistance > self.ThirdPersonCameraDistance or self.IsCameraCollisionDenialEnabled) and self.ThirdPersonCameraDistance - minDistance or 0)
                end
            end, "camera_manager_render")
        elseif not enabled then
            events.RENDER:remove("camera_manager_render")
            renderer:setCameraPos()
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

return CameraManager