---@class ModelUtils モデルに関するユーティリティ関数群
ModelUtils = {
    ---モデルが見つからない場合の警告メッセージを表示する。デバッグ用。
    ---@type boolean
    SHOW_WARN_MESSAGES = false,

    ---指定したモデルのワールド位置を返す。
    ---@param model ModelPart ワールド位置を取得するモデルパーツ
    ---@return Vector3 worldPos モデルのワールド位置
    getModelWorldPos = function(model)
        local modelMatrix = model:partToWorldMatrix()
        return vectors.vec3(modelMatrix[4][1], modelMatrix[4][2], modelMatrix[4][3])
    end,

    ---プレイヤーアバターとダミーアバターから指定されたモデルパスのモデルパーツの配列を返す。
    ---@param modelPaths string[] 取得対象のモデルパスの配列（"models.models.main.Avatar."に続く部分）
    ---@return ModelPart[] modelParts 取得したモデルパーツの配列
    getPlayerModels = function (self, modelPaths)
        local result = {}
        for index, rootModelPart in ipairs({models.models.main.Avatar, models.models.death_animation.DummyAvatar}) do
            for _, modelPath in ipairs(modelPaths) do
                local modelPart = rootModelPart
                local modelPathChunks = {}
                for chunk in modelPath:gmatch("([^%.]+)") do
                    table.insert(modelPathChunks, chunk)
                end

                while(#modelPathChunks > 0) do
                    if modelPart[modelPathChunks[1]] ~= nil then
                        modelPart = modelPart[modelPathChunks[1]]
                        table.remove(modelPathChunks, 1)
                    else
                        if self.SHOW_WARN_MESSAGES then
                            print("Warning! \""..(index == 1 and "models.models.main.Avatar" or "models.models.death_animation.DummyAvatar").."."..modelPath.."\" does not exist!")
                        end
                        modelPart = nil
                        break
                    end
                end

                if modelPart ~= nil then
                    table.insert(result, modelPart)
                end
            end
        end
        return result
    end,
}

return ModelUtils