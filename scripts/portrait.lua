---@class Portrait ポートレートのモデルを管理するクラス
Portrait = {
    ---ポートレートのモデルを生成する。
    generatePortraitModel = function ()
        --既存の頭ブロックのモデルを削除する。
        if models.script_portrait.Head ~= nil then
            models.script_portrait.Head:remove()
        end

        --ヘルメットを着けている場合は外しておく。
        local isHelmetVisible = Armor.ArmorVisible[1]
        if isHelmetVisible then
            Armor:setHelmet(world.newItem(CompatibilityUtils:checkItem("minecraft:air")))
        end

        --頭ブロックから除外するモデルパーツを予め非表示にする。
        local excludeModelsVisibleList = {}
        for index, modelPart in ipairs(BlueArchiveCharacter.PORTRAIT.excludeModels) do
            excludeModelsVisibleList[index] = modelPart:getVisible()
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(false)
            end
        end
        Physics:disable()
        if BlueArchiveCharacter.PORTRAIT.onBeforeModelCopy ~= nil then
            BlueArchiveCharacter.PORTRAIT.onBeforeModelCopy()
        end

        --現在の衣装を基に新たな頭ブロックのモデルを生成する。
        local copiedPart = ModelUtils:copyModel(models.models.main.Avatar.Head)
        if copiedPart ~= nil then
            models.script_portrait:addChild(copiedPart)
            models.script_portrait.Head:setParentType("Portrait")
            models.script_portrait.Head:setPos(0, -24, 0)
            models.script_portrait.Head.HeadRing:remove()
            for _, modelPart in ipairs({models.script_portrait.Head.FaceParts.Eyes.EyeRight, models.script_portrait.Head.FaceParts.Eyes.EyeLeft}) do
                modelPart:setUVPixels()
            end
            if models.script_head_block.Head.FaceParts.Mouth ~= nil then
                models.script_head_block.Head.FaceParts.Mouth:remove()
            end
            for _, modelPart in ipairs(BlueArchiveCharacter.PORTRAIT.includeModels) do
                local copiedIncludePart = ModelUtils:copyModel(modelPart)
                if copiedIncludePart ~= nil and copiedIncludePart:getVisible() then
                    models.script_portrait.Head:addChild(copiedIncludePart)
                end
            end
        end

        --非表示にしたモデルを元に戻す。
        if isHelmetVisible then
            Armor:setHelmet(Armor.ArmorSlotItemsPrev[1])
        end
        for index, modelPart in ipairs(BlueArchiveCharacter.PORTRAIT.excludeModels) do
            if excludeModelsVisibleList[index] then
                modelPart:setVisible(true)
            end
        end
        Physics:enable()
        if BlueArchiveCharacter.PORTRAIT.onAfterModelCopy ~= nil then
            BlueArchiveCharacter.PORTRAIT.onAfterModelCopy()
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_portrait", "None")
    end
}

Portrait:init()

return Portrait