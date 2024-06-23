---@class ModelUtils モデルに関するユーティリティ関数群
ModelUtils = {
    ---指定したモデルのワールド位置を返す。
    ---@param model ModelPart ワールド位置を取得するモデルパーツ
    ---@return Vector3 worldPos モデルのワールド位置
    getModelWorldPos = function(model)
        local modelMatrix = model:partToWorldMatrix()
        return vectors.vec3(modelMatrix[4][1], modelMatrix[4][2], modelMatrix[4][3])
    end,

    ---モデルパーツをディープコピーする。非表示のモデルパーツはコピーしない。
    ---@param modelPart ModelPart コピーするモデルパーツ
    ---@param name? string コピーしたモデルパーツの名前。省略した際はコピー元と同じ名前になる。
    ---@return ModelPart? copiedModelPart コピーされたモデルパーツ。入力されたモデルパーツが非表示の場合はnilが返る。
    copyModel = function (self, modelPart, name)
        if modelPart:getVisible() then
            local copy = modelPart:copy(name ~= nil and name or modelPart:getName())
            copy:setParentType("None")
            for _, child in ipairs(copy:getChildren()) do
                copy:removeChild(child)
                local childModel = self:copyModel(child)
                if childModel ~= nil then
                    copy:addChild(childModel)
                end
            end
            return copy
        end
    end
}

return ModelUtils