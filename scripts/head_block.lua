---@class HeadBlock 頭ブロックのモデルを制御するクラス
HeadBlock = {
    ---頭ブロックのモデルを生成する。
    generateHeadBlockModel = function ()
        --既存の頭ブロックのモデルを削除する。
        if models.script_head_block.Skull ~= nil then
            models.script_head_block.Skull:remove()
        end

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        models.script_head_block:addChild(ModelUtils:copyModel(models.models.main.Avatar.Head))
        models.script_head_block.Head:setParentType("Skull")
        models.script_head_block.Head:setPos(0, -24, 0)
        models.script_head_block.Head.HeadRing:setLight(15)
        for _, modelPart in ipairs(BlueArchiveCharacter.HEAD_BLOCK.includeModels[Costume.CurrentCostume]) do
            local copiedPart = ModelUtils:copyModel(modelPart)
            models.script_head_block.Head:addChild(copiedPart)
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_head_block", "None")
    end
}

HeadBlock:init()

return HeadBlock