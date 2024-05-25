---@class HeadBlock 頭ブロックのモデルを制御するクラス
HeadBlock = {
    ---強制的に頭ブロックを生成するまでのカウンター。これが発火するのはアバタープレイヤーがオフラインの時のみ。
    ---@type integer
    ForceGenerateCount = 2,

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
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(false)
            end
        end
        if player:isLoaded() then
            Physics:disable()
        end
        if BlueArchiveCharacter.HEAD_BLOCK.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.HEAD_BLOCK.onBeforeModelCopy()
        end

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        local copiedPart = ModelUtils:copyModel(models.models.main.Avatar.Head)
        if copiedPart ~= nil then
            models.script_head_block:addChild(copiedPart)
            models.script_head_block.Head:setParentType("Skull")
            models.script_head_block.Head:setPos(0, -24, 0)
            if models.script_head_block.Head.ArmorH ~= nil then
                models.script_head_block.Head.ArmorH:remove()
            end
            models.script_head_block.Head.HeadRing:setRot()
            models.script_head_block.Head.HeadRing:setLight(15)
            for _, modelPart in ipairs({models.script_head_block.Head.FaceParts.Eyes.EyeRight, models.script_head_block.Head.FaceParts.Eyes.EyeLeft}) do
                modelPart:setUVPixels()
            end
            if models.script_head_block.Head.FaceParts.Mouth ~= nil then
                models.script_head_block.Head.FaceParts.Mouth:remove()
            end
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
        if player:isLoaded() then
            Physics:enable()
        end
        if BlueArchiveCharacter.HEAD_BLOCK.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.HEAD_BLOCK.onAfterModelCopy()
        end

        events.WORLD_TICK:remove("head_block_world_tick")
    end,

    ---初期化関数
    init = function (self)
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_head_block", "None")
        self.generateHeadBlockModel()
        events.WORLD_TICK:register(function ()
            self.ForceGenerateCount = self.ForceGenerateCount - 1
            if self.ForceGenerateCount == 0 then
                self.generateHeadBlockModel()
                events.WORLD_RENDER:register(function ()
                    if not player:isLoaded() then

                    end
                end)
                events.WORLD_TICK:remove("head_block_world_tick")
            end
        end, "head_block_world_tick")
    end
}

HeadBlock:init()

return HeadBlock