---吹き出しエモートの絵文字の種類
---@alias Bubble.BubbleType
---| "GOOD" 👍
---| "HEART" 💗
---| "NOTE" 🎵
---| "QUESTION" ❓
---| "SWEAT" 💦
---| "RELOAD" 弾薬をリロードする絵文字
---| "DOTS" …

---@class Bubble 吹き出しエモートを管理するクラス
Bubble = {
    ---吹き出しの表示時間を測るカウンター
    ---@type number
    BubbleCounter = 0,

    ---吹き出しのトランジションを測るカウンター
    ---@type number
    TransitionCounter = 0,

    ---吹き出しエモートが自動で出たものかどうか
    ---@type boolean
    IsAutoBubble = false,

    ---一人称用にGUIに吹き出しを表示するかどうか
    ---@type boolean
    ShowInGui = false,

    ---吹き出しの絵文字
    ---@type Bubble.BubbleType
    Emoji = "GOOD",

    ---絵文字のアニメーションのタイミングを測るカウンター
    ---@type number
    EmojiAnimationCounter = 0,

    ---吹き出しエモートが強制停止させられたかどうか
    ---@type boolean
    IsForcedStop = false,

    ---チャットを開けているかどうか
    --- 1. 現ティック, 2. 前ティック
    ---@type boolean[]
    IsChatOpened = {false, false},

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---吹き出しエモートを再生する。
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    ---@param duration integer 吹き出しを表示している時間。-1にすると停止するまでずっと表示する。
    ---@param showInGui boolean 一人称用にGUIに吹き出しを表示するかどうか
    ---@param exSkillMode? boolean Exスキルで使用する専用モード
    play = function (self, type, duration, showInGui, exSkillMode)
        self.Emoji = type
        self.ShowInGui = showInGui
        self.BubbleCounter = duration
        self.TransitionCounter = 0
        self.EmojiAnimationCounter = 0
        local emojiTexture = textures["textures.emojis."..self.Emoji:lower()]
        models.models.bubble.Camera.AvatarBubble.Emoji:setPrimaryTexture("CUSTOM", emojiTexture)
        models.models.bubble.Camera.AvatarBubble.Bullets:setVisible(self.Emoji == "RELOAD")
        models.models.bubble.Camera.AvatarBubble.Dots:setVisible(self.Emoji == "DOTS")
        if self.ShowInGui then
            models.models.bubble.Gui.FirstPersonBubble.Emoji:setPrimaryTexture("CUSTOM", emojiTexture)
            sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.item.pickup"), player:getPos())
        end
        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                models.models.bubble.Gui.FirstPersonBubble:setVisible(self.ShowInGui and renderer:isFirstPerson())
                if not client:isPaused() and self.BubbleCounter >= 0 then
                    self.BubbleCounter = math.max(self.BubbleCounter - 1, 0)
                end
            end, "bubble_tick")
        end
        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not self.IsRenderProcessed then
                    if not client:isPaused() then
                        if self.BubbleCounter ~= 0 then
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
                        if self.Emoji == "RELOAD" or self.Emoji == "DOTS" then
                            if self.Emoji == "RELOAD" then
                                local bulletCounters = {math.clamp(self.EmojiAnimationCounter * 2 - 2, 0, 1), math.clamp(self.EmojiAnimationCounter * 2 - 4, 0, 1), math.clamp(self.EmojiAnimationCounter * 2 - 6, 0, 1)}
                                for index, bulletModel in ipairs(models.models.bubble.Camera.AvatarBubble.Bullets:getChildren()) do
                                    bulletModel:setPos(0, 1 - bulletCounters[index], 0)
                                    bulletModel:setOpacity(bulletCounters[index])
                                end
                            elseif self.Emoji == "DOTS" then
                                models.models.bubble.Camera.AvatarBubble.Dots.Dot1:setVisible(self.EmojiAnimationCounter > 1.25)
                                models.models.bubble.Camera.AvatarBubble.Dots.Dot2:setVisible(self.EmojiAnimationCounter > 2.5)
                                models.models.bubble.Camera.AvatarBubble.Dots.Dot3:setVisible(self.EmojiAnimationCounter > 3.75)
                            end
                            self.EmojiAnimationCounter = self.EmojiAnimationCounter + 4 / client:getFPS()
                            self.EmojiAnimationCounter = self.EmojiAnimationCounter >= 5 and self.EmojiAnimationCounter - 5 or self.EmojiAnimationCounter
                        end
                    end
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCounter))
                    if host:isHost() and self.ShowInGui then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 10, -windowSize.y + (action_wheel:isEnabled() and 125 or 10), 0)
                        models.models.bubble.Gui.FirstPersonBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCounter * 4))
                    end
                    local avatarBubblePos = vectors.vec3(0, 32, 0)
                    if exSkillMode then
                        avatarBubblePos:add(models.models.main.Avatar:getAnimPos()):add(0, -4, 0)
                    end
                    if not renderer:isFirstPerson() then
                        local playerPos = player:getPos()
                        local cameraPos = client:getCameraPos()
                        if exSkillMode then
                            avatarBubblePos:add(vectors.rotateAroundAxis(math.deg(math.atan2(cameraPos.z - playerPos.z, cameraPos.x - playerPos.x) - math.pi / 2) % 360 - (player:getBodyYaw(delta) - 45) % 360, 11, 4, 0, 0, -1, 0))
                        else
                            avatarBubblePos:add(vectors.rotateAroundAxis(math.deg(math.atan2(cameraPos.z - playerPos.z, cameraPos.x - playerPos.x) - math.pi / 2) % 360 - player:getBodyYaw(delta) % 360, 12, 0, 0, 0, -1, 0))
                        end
                    else
                        avatarBubblePos:add(12, 0, 0)
                    end
                    models.models.bubble.Camera:setOffsetPivot(avatarBubblePos)
                    models.models.bubble.Camera.AvatarBubble:setPos(avatarBubblePos)
                    self.IsRenderProcessed = true
                end
            end, "bubble_render")
        end
        if BlueArchiveCharacter.BUBBLE ~= nil and BlueArchiveCharacter.BUBBLE.callbacks ~= nil and BlueArchiveCharacter.BUBBLE.callbacks.onPlay ~= nil and not exSkillMode then
            BlueArchiveCharacter.BUBBLE.callbacks.onPlay(type, duration, showInGui)
        end
    end,

    ---吹き出しエモートを停止する。
    stop = function (self)
        if self.BubbleCounter >= 2 then
            self.IsForcedStop = true
        end
        self.BubbleCounter = 0
    end,

    ---初期化関数
    init = function (self)
        models.models.bubble:addChild(models:newPart("Gui", "Gui"))
        models.models.bubble.Gui:addChild(models.models.bubble.Camera.AvatarBubble:copy("FirstPersonBubble"))
        models.models.bubble.Gui.FirstPersonBubble:setVisible(false)
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble}) do
            modelPart:setScale(0, 0, 0)
        end

        --エモートガイド
        if host:isHost() then
            KeyManager:register("bubble_1", Config.loadConfig("keybind.bubble_1", "key.keyboard.j"), function ()
                if ExSkill.AnimationCount == -1 and (self.TransitionCounter == 0 or self.IsAutoBubble) then
                    pings.bubble_1()
                end
            end)
            KeyManager:register("bubble_2", Config.loadConfig("keybind.bubble_2", "key.keyboard.k"), function ()
                if ExSkill.AnimationCount == -1 and (self.TransitionCounter == 0 or self.IsAutoBubble) then
                    pings.bubble_2()
                end
            end)
            KeyManager:register("bubble_3", Config.loadConfig("keybind.bubble_3", "key.keyboard.n"), function ()
                if ExSkill.AnimationCount == -1 and (self.TransitionCounter == 0 or self.IsAutoBubble) then
                    pings.bubble_3()
                end
            end)
            KeyManager:register("bubble_4", Config.loadConfig("keybind.bubble_4", "key.keyboard.m"), function ()
                if ExSkill.AnimationCount == -1 and (self.TransitionCounter == 0 or self.IsAutoBubble) then
                    pings.bubble_4()
                end
            end)
            KeyManager:register("bubble_5", Config.loadConfig("keybind.bubble_5", "key.keyboard.comma"), function ()
                if ExSkill.AnimationCount == -1 and (self.TransitionCounter == 0 or self.IsAutoBubble) then
                    pings.bubble_5()
                end
            end)
        end

        events.TICK:register(function ()
            if host:isHost() then
                self.IsChatOpened[1] = host:isChatOpen()
                if self.IsChatOpened[1] and not self.IsChatOpened[2] then
                    pings.setChatOpen(self.IsChatOpened[1])
                elseif not self.IsChatOpened[1] and self.IsChatOpened[2] then
                    pings.setChatOpen(self.IsChatOpened[1])
                end
                self.IsChatOpened[2] = self.IsChatOpened[1]
            end

            if player:getActiveItem().id == "minecraft:crossbow" then
                if self.BubbleCounter == 0 or (self.IsAutoBubble and self.Emoji ~= "RELOAD") then
                    self:play("RELOAD", -1, false)
                    self.IsAutoBubble = true
                end
            elseif self.IsChatOpened[1] and ExSkill.TransitionCount == 0 then
                if self.BubbleCounter == 0 or (self.IsAutoBubble and self.Emoji ~= "DOTS") then
                    self:play("DOTS", -1, false)
                    self.IsAutoBubble = true
                end
            elseif self.IsAutoBubble then
                self:stop()
                self.IsAutoBubble = false
            end
        end)

        events.WORLD_RENDER:register(function ()
            self.IsRenderProcessed = false
        end)
    end
}

--ping関数
function pings.bubble_1()
    Bubble:play("GOOD", 50, true)
    Bubble.IsAutoBubble = false
end

function pings.bubble_2()
    Bubble:play("HEART", 50, true)
    Bubble.IsAutoBubble = false
end

function pings.bubble_3()
    Bubble:play("NOTE", 50, true)
    Bubble.IsAutoBubble = false
end

function pings.bubble_4()
    Bubble:play("QUESTION", 50, true)
    Bubble.IsAutoBubble = false
end

function pings.bubble_5()
    Bubble:play("SWEAT", 50, true)
    Bubble.IsAutoBubble = false
end

---Bubbleのチャットを開けているフラグを更新する。
---@param value boolean 新しい値
function pings.setChatOpen(value)
    Bubble.IsChatOpened[1] = value
end

Bubble:init()

return Bubble