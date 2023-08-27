---@class CameaUtils カメラ操作に関するユーティリティ関数群
CameraUtils = {
    ---カメラの向きを示すベクトルを回転ベクトルに変換する。
    ---@param cameraRot Vector3 カメラの向きを示すベクトル
    ---@return Vector3 rotVector カメラ回転ベクトル
    cameraRotToRotationVector = function(self, cameraRot)
        return vectors.rotateAroundAxis(cameraRot.z, vectors.rotateAroundAxis(-cameraRot.y, vectors.rotateAroundAxis(cameraRot.x, vectors.vec3(0, 0, 1), 1), 0, 1), 0, 0, 1)
    end
}

return CameraUtils