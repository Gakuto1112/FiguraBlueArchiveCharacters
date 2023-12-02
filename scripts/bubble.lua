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

    ---吹き出しの絵文字
    ---@type Bubble.BubbleType
    Emoji = "GOOD",

    ---リロード絵文字のアニメーションのタイミングを測るカウンター
    ---[1]. 吹き出し用, [2]. アクションホイールのエモートガイド用
    ---@type number[]
    ReloadAnimationCounters = {0, 0},

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---吹き出しエモートを再生する。
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    play = function (self, type)
        self.Emoji = type
        self.Counter = 50
        self.TransitionCounter = 0
        self.ReloadAnimationCounters[1] = 0
        local emojiTexture = textures["textures.emojis."..self.Emoji:lower()]
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Emoji, models.models.bubble.Gui.FirstPersonBubble.Emoji}) do
            modelPart:setPrimaryTexture("CUSTOM", emojiTexture)
        end
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
            modelPart:setVisible(self.Emoji == "RELOAD")
        end
        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                models.models.bubble.Gui.FirstPersonBubble:setVisible(renderer:isFirstPerson())
                if not client:isPaused() then
                    self.Counter = math.max(self.Counter - 1, 0)
                end
            end, "bubble_tick")
        end
        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (delta, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not self.IsRenderProcessed then
                    if not client:isPaused() then
                        if self.Counter > 0 then
                            self.TransitionCounter = math.min(self.TransitionCounter + 32 / client:getFPS(), 1)
                        else
                            self.TransitionCounter = math.max(self.TransitionCounter - 32 / client:getFPS(), 0)
                            if self.TransitionCounter == 0 then
                                for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble, models.models.bubble.Camera.AvatarBubble.Bullets, models.models.bubble.Gui.FirstPersonBubble.Bullets}) do
                                    modelPart:setVisible(false)
                                end
                                events.TICK:remove("bubble_tick")
                                events.RENDER:remove("bubble_render")
                                events.WORLD_RENDER:remove("bubble_world_render")
                            end
                        end
                        if self.Emoji == "RELOAD" then
                            for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Bullets.Bullet1, models.models.bubble.Gui.FirstPersonBubble.Bullets.Bullet1}) do
                                local ammoCounter = math.clamp(self.ReloadAnimationCounters[1] * 2 - 2, 0, 1)
                                modelPart:setPos(0, 1 - ammoCounter, 0)
                                modelPart:setOpacity(ammoCounter)
                            end
                            for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Bullets.Bullet2, models.models.bubble.Gui.FirstPersonBubble.Bullets.Bullet2}) do
                                local ammoCounter = math.clamp(self.ReloadAnimationCounters[1] * 2 - 4, 0, 1)
                                modelPart:setPos(0, 1 - ammoCounter, 0)
                                modelPart:setOpacity(ammoCounter)
                            end
                            for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Bullets.Bullet3, models.models.bubble.Gui.FirstPersonBubble.Bullets.Bullet3}) do
                                local ammoCounter = math.clamp(self.ReloadAnimationCounters[1] * 2 - 6, 0, 1)
                                modelPart:setPos(0, 1 - ammoCounter, 0)
                                modelPart:setOpacity(ammoCounter)
                            end
                            self.ReloadAnimationCounters[1] = self.ReloadAnimationCounters[1] + 4 / client:getFPS()
                            self.ReloadAnimationCounters[1] = self.ReloadAnimationCounters[1] >= 5 and self.ReloadAnimationCounters[1] - 5 or self.ReloadAnimationCounters[1]
                        end
                    end
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCounter))
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 15, -windowSize.y + 15, 0)
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
                    self.IsRenderProcessed = true
                end
            end, "bubble_render")
        end
        if events.WORLD_RENDER:getRegisteredCount("bubble_world_render") == 0 then
            events.WORLD_RENDER:register(function ()
                self.IsRenderProcessed = false
            end, "bubble_world_render")
        end
    end,

    ---吹き出しエモートを停止する。
    stop = function (self)
        self.Counter = 0
    end,

    ---初期化関数
    init = function (self)
        models.models.bubble:addChild(models:newPart("Gui", "Gui"))
        ---@diagnostic disable-next-line: redundant-parameter
        models.models.bubble.Gui:addChild(models.models.bubble.Camera.AvatarBubble:copy("FirstPersonBubble"))
        models.models.bubble.Gui.FirstPersonBubble:setVisible(false)
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble}) do
            modelPart:setScale(0, 0, 0)
        end

        --キーバインドに登録
        KeyManager:register("bubble_up", Config.loadConfig("keybind.bubble_up", "key.keyboard.up"), function ()
            pings.bubble_up()
        end)
        KeyManager:register("bubble_right", Config.loadConfig("keybind.bubble_right", "key.keyboard.right"), function ()
            pings.bubble_right()
        end)
        KeyManager:register("bubble_down", Config.loadConfig("keybind.bubble_down", "key.keyboard.down"), function ()
            pings.bubble_down()
        end)
        KeyManager:register("bubble_left", Config.loadConfig("keybind.bubble_left", "key.keyboard.left"), function ()
            pings.bubble_left()
        end)
    end
}

--ping関数
function pings.bubble_up()
    Bubble:play("GOOD")
end

function pings.bubble_right()
    Bubble:play("HEART")
end

function pings.bubble_down()
    Bubble:play("RELOAD")
end

function pings.bubble_left()
    Bubble:play("QUESTION")
end

Bubble:init()

return Bubble