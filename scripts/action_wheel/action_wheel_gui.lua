---@class ActionWheelGui アクションホイールに表示する追加のGUIを管理するクラス
ActionWheelGui = {
    ---初期化関数
    init = function (self)
        if host:isHost() then
            models.models.action_wheel_gui.Gui:setScale(2, 2, 2)
            local bubbleGuideTitle = models.models.action_wheel_gui.Gui.BubbleGuide:newText("action_wheel_gui.bubble_guide.title")
            bubbleGuideTitle:setScale(0.5, 0.5, 0.5)
            bubbleGuideTitle:setText(Language:getTranslate("action_wheel_gui__bubble_guide__title"))
            bubbleGuideTitle:setAlignment("CENTER")

            local bubbleKeyNames = {models.models.action_wheel_gui.Gui.BubbleGuide.GoodEmoji:newText("bubble_guide.bubble_1.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.HeartEmoji:newText("bubble_guide.bubble_2.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.NoteEmoji:newText("bubble_guide.bubble_3.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.QuestionEmoji:newText("bubble_guide.bubble_4.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.SweatEmoji:newText("bubble_guide.bubble_5.key_name")}
            for _, keyNameText in ipairs(bubbleKeyNames) do
                keyNameText:setPos(-15, 1.5, 0)
                keyNameText:setScale(0.5, 0.5, 0.5)
                keyNameText:setWidth(60)
                keyNameText:setAlignment("CENTER")
            end

            local exSkillGuideTitle = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel_gui.ex_skill_guide.title")
            exSkillGuideTitle:setScale(0.5, 0.5, 0.5)
            exSkillGuideTitle:setText(Language:getTranslate("action_wheel_gui__ex_skill_guide__title"))
            exSkillGuideTitle:setAlignment("CENTER")

            local exSkillGuideBody = models.models.action_wheel_gui.Gui.ExSkillGuide:newText("action_wheel_gui.ex_skill_guide.body")
            exSkillGuideBody:setPos(0, -8, 0)
            exSkillGuideBody:setScale(0.5, 0.5, 0.5)
            exSkillGuideBody:setAlignment("CENTER")

            local isActionWheelEnabledPrev = false
            events.TICK:register(function ()
                local isActionWheelEnabled = action_wheel:isEnabled() and ExSkill.AnimationCount == -1
                if isActionWheelEnabled then
                    if not isActionWheelEnabledPrev then
                        models.models.action_wheel_gui.Gui:setVisible(true)
                        local keybindTable = keybinds:getKeybinds()
                        bubbleKeyNames[1]:setText("§0"..keybindTable[Language:getTranslate("key_name__bubble_1")]:getKeyName())
                        bubbleKeyNames[2]:setText("§0"..keybindTable[Language:getTranslate("key_name__bubble_2")]:getKeyName())
                        bubbleKeyNames[3]:setText("§0"..keybindTable[Language:getTranslate("key_name__bubble_3")]:getKeyName())
                        bubbleKeyNames[4]:setText("§0"..keybindTable[Language:getTranslate("key_name__bubble_4")]:getKeyName())
                        bubbleKeyNames[5]:setText("§0"..keybindTable[Language:getTranslate("key_name__bubble_5")]:getKeyName())
                        exSkillGuideBody:setText("§0§l\""..Language:getTranslate("action_wheel_gui__ex_skill_guide__ex_skill_"..BlueArchiveCharacter.COSTUME.costumes[Costume.CurrentCostume].exSkill.."__name").."\"§r\n§0"..Language:getTranslate("action_wheel_gui__ex_skill_guide__key_pre")..keybindTable[Language:getTranslate("key_name__ex_skill")]:getKeyName()..Language:getTranslate("action_wheel_gui__ex_skill_guide__key_post"))
                    end
                    local windowSize = client:getScaledWindowSize()
                    models.models.action_wheel_gui.Gui.BubbleGuide:setPos(windowSize.x * -0.5 + 44, windowSize.y * -0.5 + 5, 0)
                    models.models.action_wheel_gui.Gui.ExSkillGuide:setPos(windowSize.x * -0.5 + 57, -21, 0)
                elseif not isActionWheelEnabled and isActionWheelEnabledPrev then
                    models.models.action_wheel_gui.Gui:setVisible(false)
                end
                isActionWheelEnabledPrev = isActionWheelEnabled
            end)
        end
    end
}

ActionWheelGui:init()

return ActionWheelGui