---吹き出しエモートの絵文字の種類
---@alias Bubble.BubbleType
---| "GOOD" 👍
---| "HEART" 💗
---| "QUESTION" ❓
---| "RELOAD" 弾薬をリロードする絵文字

---@class Bubble 吹き出しエモートを管理するクラス
Bubble = {
    ---吹き出しの表示時間を測るカウンター
    ---@type number
    Counter = 0,

    ---吹き出しのトランジションを測るカウンター
    ---@type number
    TransitionCounter = 0,

    ---一人称用にGUIに吹き出しを表示するかどうか
    ---@type boolean
    ShowInGui = false,

    ---吹き出しの絵文字
    ---@type Bubble.BubbleType
    Emoji = "GOOD",

    ---リロード絵文字のアニメーションのタイミングを測るカウンター
    ---[1]. 吹き出し用, [2]. アクションホイールのエモートガイド用
    ---@type number[]
    ReloadAnimationCounters = {0, 0},

    ---吹き出しエモートが強制停止させられたかどうか
    ---@type boolean
    IsForcedStop = false,

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---[1]. 吹き出し用, [2]. アクションホイールのエモートガイド用
    ---@type boolean[]
    IsRenderProcessed = {false, false},

    ---リロード絵文字アニメーションの処理を行う。
    ---@param counterIndex number アニメーションカウンターのインデクス番号
    ---@param rootModels ModelPart[] 弾薬のイラストモデルのルートモデルのテーブル
    processReloadAnimation = function (self, counterIndex, rootModels)
        local bulletCounters = {math.clamp(self.ReloadAnimationCounters[counterIndex] * 2 - 2, 0, 1), math.clamp(self.ReloadAnimationCounters[counterIndex] * 2 - 4, 0, 1), math.clamp(self.ReloadAnimationCounters[counterIndex] * 2 - 6, 0, 1)}
        for _, rootModel in ipairs(rootModels) do
            for index, bulletModel in ipairs(rootModel:getChildren()) do
                bulletModel:setPos(0, 1 - bulletCounters[index], 0)
                bulletModel:setOpacity(bulletCounters[index])
            end
        end
        self.ReloadAnimationCounters[counterIndex] = self.ReloadAnimationCounters[counterIndex] + 4 / client:getFPS()
        self.ReloadAnimationCounters[counterIndex] = self.ReloadAnimationCounters[counterIndex] >= 5 and self.ReloadAnimationCounters[counterIndex] - 5 or self.ReloadAnimationCounters[counterIndex]
    end,

    ---吹き出しエモートを再生する。
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    ---@param duration integer 吹き出しを表示している時間。-1にすると停止するまでずっと表示する。
    ---@param showInGui boolean 一人称用にGUIに吹き出しを表示するかどうか
    play = function (self, type, duration, showInGui)
        self.Emoji = type
        self.ShowInGui = showInGui
        self.Counter = duration
        self.TransitionCounter = 0
        self.ReloadAnimationCounters[1] = 0
        local emojiTexture = textures["textures.emojis."..self.Emoji:lower()]
        models.models.bubble.Camera.AvatarBubble.Emoji:setPrimaryTexture("CUSTOM", emojiTexture)
        models.models.bubble.Camera.AvatarBubble.Bullets:setVisible(self.Emoji == "RELOAD")
        if self.ShowInGui then
            models.models.bubble.Gui.FirstPersonBubble.Emoji:setPrimaryTexture("CUSTOM", emojiTexture)
            models.models.bubble.Gui.FirstPersonBubble.Bullets:setVisible(self.Emoji == "RELOAD")
            sounds:playSound("minecraft:entity.item.pickup", player:getPos())
        end
        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                models.models.bubble.Gui.FirstPersonBubble:setVisible(self.ShowInGui and renderer:isFirstPerson())
                if not client:isPaused() and self.Counter >= 0 then
                    self.Counter = math.max(self.Counter - 1, 0)
                end
            end, "bubble_tick")
        end
        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not self.IsRenderProcessed[1] then
                    if not client:isPaused() then
                        if self.Counter ~= 0 then
                            self.TransitionCounter = math.min(self.TransitionCounter + 32 / client:getFPS(), 1)
                        else
                            self.TransitionCounter = math.max(self.TransitionCounter - 32 / client:getFPS(), 0)
                            if self.TransitionCounter == 0 then
                                for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble, models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
                                    modelPart:setVisible(false)
                                end
                                events.TICK:remove("bubble_tick")
                                events.RENDER:remove("bubble_render")
                                if BlueArchiveCharacter.BUBBLE ~= nil and BlueArchiveCharacter.BUBBLE.callbacks ~= nil and BlueArchiveCharacter.BUBBLE.callbacks.onStop ~= nil then
                                    BlueArchiveCharacter.BUBBLE.callbacks.onStop(type, self.IsForcedStop)
                                end
                                self.IsForcedStop = false
                            end
                        end
                        if self.Emoji == "RELOAD" then
                            self:processReloadAnimation(1, self.ShowInGui and {models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets} or {models.models.bubble.Camera.AvatarBubble.Bullets})
                        end
                    end
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCounter))
                    if host:isHost() and self.ShowInGui then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 10, -windowSize.y + (action_wheel:isEnabled() and 105 or 10), 0)
                        models.models.bubble.Gui.FirstPersonBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCounter * 4))
                    end
                    local avatarBubblePos = vectors.vec3(0, 32, 0)
                    if not renderer:isFirstPerson() then
                        local playerPos = player:getPos()
                        local cameraPos = client:getCameraPos()
                        avatarBubblePos:add(vectors.rotateAroundAxis(math.deg(math.atan2(cameraPos.z - playerPos.z, cameraPos.x - playerPos.x) - math.pi / 2) % 360 - player:getBodyYaw(delta) % 360, 12, 0, 0, 0, -1, 0))
                    else
                        avatarBubblePos:add(12, 0, 0)
                    end
                    models.models.bubble.Camera:setOffsetPivot(avatarBubblePos)
                    models.models.bubble.Camera.AvatarBubble:setPos(avatarBubblePos)
                    self.IsRenderProcessed[1] = true
                end
            end, "bubble_render")
        end
        if BlueArchiveCharacter.BUBBLE ~= nil and BlueArchiveCharacter.BUBBLE.callbacks ~= nil and BlueArchiveCharacter.BUBBLE.callbacks.onPlay ~= nil then
            BlueArchiveCharacter.BUBBLE.callbacks.onPlay(type, duration, showInGui)
        end
    end,

    ---吹き出しエモートを停止する。
    stop = function (self)
        if self.Counter >= 2 then
            self.IsForcedStop = true
        end
        self.Counter = 0
    end,

    ---初期化関数
    init = function (self)
        ---@diagnostic disable-next-line: redundant-parameter
        models.models.bubble.Gui:addChild(models.models.bubble.Camera.AvatarBubble:copy("FirstPersonBubble"))
        models.models.bubble.Gui.FirstPersonBubble:setVisible(false)
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble}) do
            modelPart:setScale(0, 0, 0)
        end

        --キーバインドに登録
        KeyManager:register("bubble_up", Config.loadConfig("keybind.bubble_up", "key.keyboard.up"), function ()
            if ExSkill.AnimationCount == -1 then
                pings.bubble_up()
            end
        end)
        KeyManager:register("bubble_right", Config.loadConfig("keybind.bubble_right", "key.keyboard.right"), function ()
            if ExSkill.AnimationCount == -1 then
                pings.bubble_right()
            end
        end)
        KeyManager:register("bubble_down", Config.loadConfig("keybind.bubble_down", "key.keyboard.down"), function ()
            if ExSkill.AnimationCount == -1 then
                pings.bubble_down()
            end
        end)
        KeyManager:register("bubble_left", Config.loadConfig("keybind.bubble_left", "key.keyboard.left"), function ()
            if ExSkill.AnimationCount == -1 then
                pings.bubble_left()
            end
        end)

        --エモートガイド
        if host:isHost() then
            models.models.bubble.Gui.BubbleGuide:setScale(2, 2, 2)
            local bubbleGuideTitle = models.models.bubble.Gui.BubbleGuide:newText("bubble_guide.title")
            bubbleGuideTitle:setScale(0.5, 0.5, 0.5)
            bubbleGuideTitle:setText(Language:getTranslate("bubble_guide__title"))
            bubbleGuideTitle:setAlignment("CENTER")
            local bubbleKeyNames = {models.models.bubble.Gui.BubbleGuide.GoodEmoji:newText("bubble_guide.bubble_up.key_name"), models.models.bubble.Gui.BubbleGuide.HeartEmoji:newText("bubble_guide.bubble_right.key_name"), models.models.bubble.Gui.BubbleGuide.ReloadEmoji:newText("bubble_guide.bubble_down.key_name"), models.models.bubble.Gui.BubbleGuide.QuestionEmoji:newText("bubble_guide.bubble_left.key_name")}
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
                        models.models.bubble.Gui.BubbleGuide:setVisible(true)
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
                                if not self.IsRenderProcessed[2] then
                                    self:processReloadAnimation(2, {models.models.bubble.Gui.BubbleGuide.ReloadEmoji.GuideBullets})
                                    self.IsRenderProcessed[2] = true
                                end
                            end, "bubble_guide_render")
                        end
                    end
                    local windowSize = client:getScaledWindowSize()
                    models.models.bubble.Gui.BubbleGuide:setPos(-windowSize.x + 76, -windowSize.y + 51, 0)
                elseif not isActionWheelEnabled and isActionWheelEnabledPrev then
                    models.models.bubble.Gui.BubbleGuide:setVisible(false)
                    events.RENDER:remove("bubble_guide_render")
                    self.ReloadAnimationCounters[2] = 0
                end
                isActionWheelEnabledPrev = isActionWheelEnabled
            end)
        end

        events.WORLD_RENDER:register(function ()
            for i = 1, 2 do
                self.IsRenderProcessed[i] = false
            end
        end)
    end
}

--ping関数
function pings.bubble_up()
    Bubble:play("GOOD", 50, true)
end

function pings.bubble_right()
    Bubble:play("HEART", 50, true)
end

function pings.bubble_down()
    Bubble:play("RELOAD", 50, true)
end

function pings.bubble_left()
    Bubble:play("QUESTION", 50, true)
end

---リロードの吹き出しエモートがクロスボウによって再生されたかどうか
---@type boolean
local reloadByCrossbow = false

---前ティックの体力
---@type integer
local healthPrev = player:getHealth()

events.TICK:register(function ()
    local isCrossbowActive = player:getActiveItem().id == "minecraft:crossbow"
    if isCrossbowActive and Bubble.Counter == 0 then
        Bubble:play("RELOAD", -1, false)
        reloadByCrossbow = true
    elseif not isCrossbowActive and reloadByCrossbow then
        Bubble:stop()
        reloadByCrossbow = false
    end

    local health = player:getHealth()
    if health > healthPrev and PvUtils.getIsInBattle() and not PvUtils:getIsDied() then
        Bubble:play("GOOD", 50, true)
    end
    healthPrev = health
end)

Bubble:init()

return Bubble