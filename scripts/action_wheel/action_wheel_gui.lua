---@class ActionWheelGui アクションホイールに表示する追加のGUIを管理するクラス
ActionWheelGui = {
    ---リロード絵文字のアニメーションのタイミングを測るカウンター
    ---@type number
    ReloadAnimationCounters = 0,

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---初期化関数
    init = function (self)
        if host:isHost() then
            models.models.action_wheel_gui.Gui.BubbleGuide:setScale(2, 2, 2)
            local bubbleGuideTitle = models.models.action_wheel_gui.Gui.BubbleGuide:newText("bubble_guide.title")
            bubbleGuideTitle:setScale(0.5, 0.5, 0.5)
            bubbleGuideTitle:setText(Language:getTranslate("bubble_guide__title"))
            bubbleGuideTitle:setAlignment("CENTER")
            local bubbleKeyNames = {models.models.action_wheel_gui.Gui.BubbleGuide.GoodEmoji:newText("bubble_guide.bubble_up.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.HeartEmoji:newText("bubble_guide.bubble_right.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.ReloadEmoji:newText("bubble_guide.bubble_down.key_name"), models.models.action_wheel_gui.Gui.BubbleGuide.QuestionEmoji:newText("bubble_guide.bubble_left.key_name")}
            for _, keyNameText in ipairs(bubbleKeyNames) do
                keyNameText:setPos(-15, 1.5, 0)
                keyNameText:setScale(0.5, 0.5, 0.5)
                keyNameText:setWidth(60)
                keyNameText:setAlignment("CENTER")
            end
            local isActionWheelEnabledPrev = false
            events.TICK:register(function ()
                local isActionWheelEnabled = action_wheel:isEnabled() and ExSkill.AnimationCount == -1
                if isActionWheelEnabled then
                    if not isActionWheelEnabledPrev then
                        models.models.action_wheel_gui.Gui.BubbleGuide:setVisible(true)
                        for keyName, keybind in pairs(keybinds:getKeybinds()) do
                            if keyName == Language:getTranslate("key_name__bubble_up") then
                                bubbleKeyNames[1]:setText("§0"..keybind:getKeyName())
                            elseif keyName == Language:getTranslate("key_name__bubble_right") then
                                bubbleKeyNames[2]:setText("§0"..keybind:getKeyName())
                            elseif keyName == Language:getTranslate("key_name__bubble_down") then
                                bubbleKeyNames[3]:setText("§0"..keybind:getKeyName())
                            elseif keyName == Language:getTranslate("key_name__bubble_left") then
                                bubbleKeyNames[4]:setText("§0"..keybind:getKeyName())
                            end
                        end
                        if events.RENDER:getRegisteredCount("bubble_guide_render") == 0 then
                            events.RENDER:register(function ()
                                if not self.IsRenderProcessed then
                                    local bulletCounters = {math.clamp(self.ReloadAnimationCounters * 2 - 2, 0, 1), math.clamp(self.ReloadAnimationCounters * 2 - 4, 0, 1), math.clamp(self.ReloadAnimationCounters * 2 - 6, 0, 1)}
                                    for index, bulletModel in ipairs(models.models.action_wheel_gui.Gui.BubbleGuide.ReloadEmoji.GuideBullets:getChildren()) do
                                        bulletModel:setPos(0, 1 - bulletCounters[index], 0)
                                        bulletModel:setOpacity(bulletCounters[index])
                                    end
                                    self.ReloadAnimationCounters = self.ReloadAnimationCounters + 4 / client:getFPS()
                                    self.ReloadAnimationCounters = self.ReloadAnimationCounters >= 5 and self.ReloadAnimationCounters - 5 or self.ReloadAnimationCounters
                                    self.IsRenderProcessed = true
                                end
                            end, "bubble_guide_render")
                        end
                    end
                    local windowSize = client:getScaledWindowSize()
                    models.models.action_wheel_gui.Gui.BubbleGuide:setPos(-windowSize.x + 76, -windowSize.y + 51, 0)
                elseif not isActionWheelEnabled and isActionWheelEnabledPrev then
                    models.models.action_wheel_gui.Gui.BubbleGuide:setVisible(false)
                    events.RENDER:remove("bubble_guide_render")
                    self.ReloadAnimationCounters = 0
                end
                isActionWheelEnabledPrev = isActionWheelEnabled
            end)
        end

        events.WORLD_RENDER:register(function ()
            self.IsRenderProcessed = false
        end)
    end
}

ActionWheelGui:init()

return ActionWheelGui