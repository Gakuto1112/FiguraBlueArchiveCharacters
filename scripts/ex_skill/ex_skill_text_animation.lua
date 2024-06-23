---@class ExSkillTextAnimation Exスキルアニメーション中のテキストのアニメーションを管理するクラス
ExSkillTextAnimation = {
    ---新しくインスタンスを作成する。
    ---@param name string 生成するテキストアニメーションで使用するテキストタスクの名前
    ---@param text string 生成するテキストアニメーションで表示されるテキスト
    ---@return table instance テキストアニメーションのインスタンス
    new = function (name, text)
        local instance = {}

        ---テキストアニメーション中に使用するテキストタスク
        ---@type TextTask
        instance.TextTask = models.models.main:newText(name):setText("§6"..text):setAlignment("CENTER"):setShadow(true):setSeeThrough(true):setVisible(false)

        ---テキストアニメーションの基準となる位置
        ---@type Vector3
        instance.OriginPos = vectors.vec3()

        ---テキストアニメーションのタイミングを計るカウンター
        ---@type number
        instance.AnimationCount = 0

        ---テキストが飛んでいく方向
        ---@type number
        instance.LaunchDir = 0

        ---このレンダー内で既にレンダー処理を行ったかどうか。
        ---@type boolean
        instance.IsRenderProcessed = false

        ---テキストアニメーションを再生する。
        instance.play = function (self)
            self.OriginPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1):sub(player:getPos()), 0, 1, 0):scale(16)
            self.LaunchDir = math.map(math.random(), 0, 1, 0, 360)
            self.TextTask:setScale(0.25, 0.25, 0.25)
            self.TextTask:setPos(self.OriginPos)
            if events.RENDER:getRegisteredCount("ex_skill_text_animation_"..name.."_render_1") == 0 then
                events.RENDER:register(function (delta, context)
                    if context ~= "OTHER" then
                        local bodyYaw = player:getBodyYaw(delta)
                        local textPos = vectors.rotateAroundAxis(bodyYaw * -1 + 180, self.TextTask:getPos():scale(1 / 16), 0, 1, 0):add(player:getPos(delta))
                        local cameraPos = client:getCameraPos()
                        self.TextTask:setRot(0, (math.deg(math.atan2(textPos.z - cameraPos.z, textPos.x - cameraPos.x) + math.pi / 2) % 360 - bodyYaw % 360) * -1, 0)
                        self.TextTask:setVisible(true)
                    else
                        self.TextTask:setVisible(false)
                    end
                end, "ex_skill_text_animation_"..name.."_render_1")
            end
            if events.RENDER:getRegisteredCount("ex_skill_text_animation_"..name.."_render_2") == 0 then
                events.RENDER:register(function ()
                    if not self.IsRenderProcessed then
                        self.TextTask:setPos(self.OriginPos:copy():add(vectors.rotateAroundAxis(self.LaunchDir, 0, -32 * self.AnimationCount ^ 2 + 24 * self.AnimationCount, 4 * self.AnimationCount, 0, 1, 0)))
                        self.TextTask:setScale(vectors.vec3(1, 1, 1):scale((1 - self.AnimationCount / 2) * 0.25))
                        self.AnimationCount = self.AnimationCount + 1 / client:getFPS()
                        if self.AnimationCount >= 1 then
                            self:stop()
                        end
                        self.IsRenderProcessed = true
                    end
                end, "ex_skill_text_animation_"..name.."_render_2")
            end
            if events.WORLD_RENDER:getRegisteredCount("ex_skill_text_animation_"..name.."_world_render") == 0 then
                events.WORLD_RENDER:register(function ()
                    self.IsRenderProcessed = false
                end, "ex_skill_text_animation_"..name.."_world_render")
            end
        end

        ---テキストアニメーションを停止する。
        instance.stop = function (self)
            self.TextTask:setVisible(false)
            for i = 1, 2 do
                events.RENDER:remove("ex_skill_text_animation_"..name.."_render_"..i)
            end
            events.WORLD_RENDER:remove("ex_skill_text_animation_"..name.."_world_render")
            self.AnimationCount = 0
            self.IsRenderProcessed = false
        end

        return instance
    end
}

return ExSkillTextAnimation