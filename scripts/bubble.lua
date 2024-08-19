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

    ---吹き出しの絵文字
    ---@type Bubble.BubbleType
    Emoji = "GOOD",

    ---吹き出しを表示する時間。-1は時間無制限を示す。
    ---@type integer
    Duration = 0,

    ---吹き出しエモートが自動で出たものかどうか
    ---@type boolean
    IsAutoBubble = false,

    ---一人称用にHUDに吹き出しを表示するかどうか
    ---@type boolean
    ShouldShowInHUD = false,

    ---絵文字のアニメーションのタイミングを測るカウンター
    ---@type number
    EmojiAnimationCounter = 0,

    ---吹き出しエモートが強制停止させられたかどうか
    ---@type boolean
    IsForcedStop = false,

    ---チャットを開けているかどうか
    ---@type boolean
    IsChatOpened = false,

    ---前ティックにチャットを開けていたかどうか
    ---@type boolean
    IsChatOpenedPrev = false,

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---吹き出しエモートを再生する。
    ---@param self Bubble
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    ---@param duration integer 吹き出しを表示している時間。-1にすると停止するまでずっと表示する。
    ---@param offsetPos number アバターと吹き出しの距離のオフセット値
    ---@param offsetRot number アバター周回上の、吹き出しが表示される位置のオフセット値
    ---@param shouldShowInHUD boolean 一人称用にHUDに吹き出しを表示するかどうか
    play = function (self, type, duration, offsetPos, offsetRot, shouldShowInHUD)
        self.Emoji = type
        self.Duration = duration
        self.ShouldShowInHUD = shouldShowInHUD
        self.BubbleCounter = 1
        self.EmojiAnimationCounter = 0
        models.models.bubble.Camera.AvatarBubble.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis."..self.Emoji:lower()])
        models.models.bubble.Camera.AvatarBubble.Bullets:setVisible(self.Emoji == "RELOAD")
        models.models.bubble.Camera.AvatarBubble.Dots:setVisible(self.Emoji == "DOTS")
        if self.ShouldShowInHUD then
            models.models.bubble.Gui.FirstPersonBubble.Emoji:setPrimaryTexture("CUSTOM", textures["textures.emojis."..self.Emoji:lower()])
            sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.item.pickup"), ModelUtils.getModelWorldPos(models.models.main.Avatar))
        end

        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                models.models.bubble.Gui.FirstPersonBubble:setVisible(self.ShouldShowInHUD and renderer:isFirstPerson())
                if not client:isPaused() then
                    self.BubbleCounter = self.BubbleCounter + 1
                    if self.BubbleCounter == 0 then
                        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble, models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
                            modelPart:setVisible(false)
                        end
                        events.TICK:remove("bubble_tick")
                        events.RENDER:remove("bubble_render")
                        if BlueArchiveCharacter.BUBBLE ~= nil and BlueArchiveCharacter.BUBBLE.callbacks ~= nil and BlueArchiveCharacter.BUBBLE.callbacks.onStop ~= nil then
                            BlueArchiveCharacter.BUBBLE.callbacks.onStop(type, self.IsForcedStop)
                        end
                    elseif self.Duration >= 0 and self.BubbleCounter == self.Duration + 2 then
                        self:stop()
                    end
                    if self.Emoji == "RELOAD" or self.Emoji == "DOTS" then
                        self.EmojiAnimationCounter = self.EmojiAnimationCounter + 1
                        self.EmojiAnimationCounter = self.EmojiAnimationCounter == 25 and 0 or self.EmojiAnimationCounter
                        if self.Emoji == "DOTS" then
                            for i = 1, 3 do
                                models.models.bubble.Camera.AvatarBubble.Dots["Dot"..i]:setVisible(self.EmojiAnimationCounter >= 6 * i)
                            end
                        end
                    end
                end
            end, "bubble_tick")
        end

        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not client:isPaused() then
                    local bubbleScale = math.min(math.abs(0.5 * (self.BubbleCounter + delta)), 1)
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(bubbleScale))
                    local playerPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
                    local avatarBubblePos = playerPos:copy():sub(player:getPos(delta)):scale(17.067):add(0, 32, 0)
                    if not renderer:isFirstPerson() then
                        local cameraPos = client:getCameraPos()
                        avatarBubblePos:add(vectors.rotateAroundAxis(math.deg(math.atan2(cameraPos.z - playerPos.z, cameraPos.x - playerPos.x) - math.pi / 2) % 360 - (player:getBodyYaw(delta) + offsetRot) % 360, 12 + offsetPos, 0, 0, 0, -1, 0))
                    else
                        avatarBubblePos:add(12 + offsetPos, 0, 0)
                    end
                    models.models.bubble.Camera:setOffsetPivot(avatarBubblePos)
                    models.models.bubble.Camera.AvatarBubble:setPos(avatarBubblePos)
                    if host:isHost() and self.ShouldShowInHUD then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 10, -windowSize.y + (action_wheel:isEnabled() and 125 or 10), 0)
                        models.models.bubble.Gui.FirstPersonBubble:setScale(vectors.vec3(1, 1, 1):scale(bubbleScale * 4))
                    end
                    if self.Emoji == "RELOAD" then
                        local bullet1Counter = math.clamp((self.EmojiAnimationCounter + delta) * 0.2 - 1, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet1:setPos(0, 1 - bullet1Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet1:setOpacity(bullet1Counter)
                        local bullet2Counter = math.clamp((self.EmojiAnimationCounter + delta) * 0.2 - 2, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet2:setPos(0, 1 - bullet2Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet2:setOpacity(bullet2Counter)
                        local bullet3Counter = math.clamp((self.EmojiAnimationCounter + delta) * 0.2 - 3, 0, 1)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet3:setPos(0, 1 - bullet3Counter, 0)
                        models.models.bubble.Camera.AvatarBubble.Bullets.Bullet3:setOpacity(bullet3Counter)
                    end
                end
            end, "bubble_render")
        end
        if BlueArchiveCharacter.BUBBLE ~= nil and BlueArchiveCharacter.BUBBLE.callbacks ~= nil and BlueArchiveCharacter.BUBBLE.callbacks.onPlay ~= nil then
            BlueArchiveCharacter.BUBBLE.callbacks.onPlay(type, duration, shouldShowInHUD)
        end
    end,

    ---吹き出しエモートを停止する。
    ---@param self Bubble
    stop = function (self)
        self.IsForcedStop = self.Duration == -1 or self.BubbleCounter < self.Duration + 2
        self.BubbleCounter = -2
    end,

    ---初期化関数
    ---@param self Bubble
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
                if ExSkill.AnimationCount == -1 and (self.BubbleCounter == 0 or self.IsAutoBubble) then
                    pings.showBubbleEmote("GOOD")
                end
            end)
            KeyManager:register("bubble_2", Config.loadConfig("keybind.bubble_2", "key.keyboard.k"), function ()
                if ExSkill.AnimationCount == -1 and (self.BubbleCounter == 0 or self.IsAutoBubble) then
                    pings.showBubbleEmote("HEART")
                end
            end)
            KeyManager:register("bubble_3", Config.loadConfig("keybind.bubble_3", "key.keyboard.n"), function ()
                if ExSkill.AnimationCount == -1 and (self.BubbleCounter == 0 or self.IsAutoBubble) then
                    pings.showBubbleEmote("NOTE")
                end
            end)
            KeyManager:register("bubble_4", Config.loadConfig("keybind.bubble_4", "key.keyboard.m"), function ()
                if ExSkill.AnimationCount == -1 and (self.BubbleCounter == 0 or self.IsAutoBubble) then
                    pings.showBubbleEmote("QUESTION")
                end
            end)
            KeyManager:register("bubble_5", Config.loadConfig("keybind.bubble_5", "key.keyboard.comma"), function ()
                if ExSkill.AnimationCount == -1 and (self.BubbleCounter == 0 or self.IsAutoBubble) then
                    pings.showBubbleEmote("SWEAT")
                end
            end)
        end

        events.TICK:register(function ()
            if host:isHost() then
                local isChatOpened = host:isChatOpen()
                if isChatOpened ~= self.IsChatOpenedPrev then
                    pings.setChatOpen(isChatOpened)
                end
                self.IsChatOpenedPrev = isChatOpened
            end

            if player:getActiveItem().id == "minecraft:crossbow" then
                if self.BubbleCounter == 0 or (self.IsAutoBubble and self.Emoji ~= "RELOAD") then
                    self:play("RELOAD", -1, 0, 0, false)
                    self.IsAutoBubble = true
                end
            elseif self.IsChatOpened and ExSkill.TransitionCount == 0 then
                if self.BubbleCounter == 0 or (self.IsAutoBubble and self.Emoji ~= "DOTS") then
                    self:play("DOTS", -1, 0, 0, false)
                    self.IsAutoBubble = true
                end
            elseif self.IsAutoBubble then
                self:stop()
                self.IsAutoBubble = false
            end
        end)
    end
}

--ping関数

---吹き出しエモートを表示する。
---@param type Bubble.BubbleType 表示する絵文字の種類
function pings.showBubbleEmote(type)
    Bubble:play(type, 50, 0, 0, true)
    Bubble.IsAutoBubble = false
end

---Bubbleのチャットを開けているフラグを更新する。
---@param value boolean 新しい値
function pings.setChatOpen(value)
    Bubble.IsChatOpened = value
end

Bubble:init()

local a = 0
events.TICK:register(function ()
end)

return Bubble