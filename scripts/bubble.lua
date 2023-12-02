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
    Count = 0,

    ---吹き出しのトランジションを測るカウンター
    ---@type number
    TransitionCount = 0,

    ---このワールドレンダーでレンダー処理を行ったかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---吹き出しエモートを再生する。
    ---@param type Bubble.BubbleType 再生する絵文字の種類
    play = function (self, type)
        self.Count = 40
        self.TransitionCount = 0
        local emojiTexture = textures["textures.emojis."..type:lower()]
        for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble.Emoji, models.models.bubble.Gui.FirstPersonBubble.Emoji}) do
            modelPart:setPrimaryTexture("CUSTOM", emojiTexture)
        end
        models.models.bubble.Camera.AvatarBubble:setVisible(true)
        if events.TICK:getRegisteredCount("bubble_tick") == 0 then
            events.TICK:register(function ()
                models.models.bubble.Gui.FirstPersonBubble:setVisible(renderer:isFirstPerson())
                if not client:isPaused() then
                    self.Count = math.max(self.Count - 1, 0)
                end
            end, "bubble_tick")
        end
        if events.RENDER:getRegisteredCount("bubble_render") == 0 then
            events.RENDER:register(function (_, context)
                models.models.bubble.Camera.AvatarBubble:setVisible(context ~= "OTHER")
                if not self.IsRenderProcessed then
                    if not client:isPaused() then
                        if self.Count > 0 then
                            self.TransitionCount = math.min(self.TransitionCount + 32 / client:getFPS(), 1)
                        else
                            self.TransitionCount = math.max(self.TransitionCount - 32 / client:getFPS(), 0)
                            if self.TransitionCount == 0 then
                                for _, modelPart in ipairs({models.models.bubble.Camera.AvatarBubble, models.models.bubble.Gui.FirstPersonBubble}) do
                                    modelPart:setVisible(false)
                                end
                                events.TICK:remove("bubble_tick")
                                events.RENDER:remove("bubble_render")
                                events.WORLD_RENDER:remove("bubble_world_render")
                            end
                        end
                    end
                    models.models.bubble.Camera.AvatarBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCount))
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.bubble.Gui.FirstPersonBubble:setPos(-windowSize.x + 15, -windowSize.y + 15, 0)
                        models.models.bubble.Gui.FirstPersonBubble:setScale(vectors.vec3(1, 1, 1):scale(self.TransitionCount * 4))
                    end
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
        self.Count = 0
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