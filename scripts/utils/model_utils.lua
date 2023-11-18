---@class ModelUtils モデルに関するユーティリティ関数群
ModelUtils = {
    ---指定したモデルのワールド位置を返す。
    ---@param model ModelPart ワールド位置を取得するモデルパーツ
    ---@return Vector3 worldPos モデルのワールド位置
    getModelWorldPos = function(self, model)
        local modelMatrix = model:partToWorldMatrix()
        return vectors.vec3(modelMatrix[4][1], modelMatrix[4][2], modelMatrix[4][3])
    end
}

return ModelUtils