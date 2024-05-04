---@class HeadBlock 頭ブロックのモデルを制御するクラス
HeadBlock = {
    ---頭ブロックのモデルを生成する。
    generateHeadBlockModel = function ()
        --既存の頭ブロックのモデルを削除する。
        if models.script_head_block.Head ~= nil then
            models.script_head_block.Head:remove()
        end

        --頭ブロックから除外するモデルパーツを予め非表示にする。
        local excludeModelsVisibleList = {}
        for index, modelPart in ipairs(BlueArchiveCharacter.HEAD_BLOCK.excludeModels) do
            excludeModelsVisibleList[index] = modelPart:getVisible()
            modelPart:setVisible(false)
        end
        Physics:disable()

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        local copiedPart = ModelUtils:copyModel(models.models.main.Avatar.Head)
        if copiedPart ~= nil then
            models.script_head_block:addChild(copiedPart)
            models.script_head_block.Head:setParentType("Skull")
            models.script_head_block.Head:setPos(0, -24, 0)
            models.script_head_block.Head.HeadRing:setRot()
            models.script_head_block.Head.HeadRing:setLight(15)
            for _, modelPart in ipairs({models.script_head_block.Head.FaceParts.EyeRight, models.script_head_block.Head.FaceParts.EyeLeft}) do
                modelPart:setUVPixels()
            end
            models.script_head_block.Head.FaceParts.Mouth:remove()
            for _, modelPart in ipairs(BlueArchiveCharacter.HEAD_BLOCK.includeModels) do
                local copiedIncludePart = ModelUtils:copyModel(modelPart)
                if copiedIncludePart ~= nil and copiedIncludePart:getVisible() then
                    models.script_head_block.Head:addChild(copiedIncludePart)
                end
            end
        end

        --非表示にしたモデルを元に戻す。
        for index, modelPart in ipairs(BlueArchiveCharacter.HEAD_BLOCK.excludeModels) do
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(true)
            end
        end
        Physics:enable()
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_head_block", "None")
    end
}

HeadBlock:init()

return HeadBlock