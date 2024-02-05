---テキストアニメーションで使用されるテキストレンダータスクを指定する列挙子
---@alias ExSkillTextAnimation.TextTask
---| "PRIMARY" ---メインのテキストレンダータスク
---| "SECONDARY" ---サブのテキストレンダータスク

---@class Exスキル1で使用するテキストアニメーションのクラス
ExSkillTextAnimation = {
    ---設置物のインスタンスを新しく生成する。
    ---@param taskName string 作成するテキストレンダータスクの名前
    ---@param textPos Vector3 テキストの初期位置
    ---@param text string 表示するテキスト
    new = function (taskName, textPos, text)
        local instance = {}

        ---メインのテキストレンダータスク
        ---@type TextTask
        ---@diagnostic disable-next-line: undefined-field
        instance.PrimaryTextTask = models.models.main.CameraAnchor:newText(taskName.."_1"):setVisible(false):setText("§d"..text):setPos(textPos):setRot(0, 180, 0):setScale(0.45, 0.45, 0.45):setOutline(true)

        ---サブのテキストレンダータスク
        ---@type TextTask
        ---@diagnostic disable-next-line: undefined-field
        instance.SecondaryTextTask = models.models.main.CameraAnchor:newText(taskName.."_2"):setVisible(false):setText("§d"..text):setPos(textPos):setRot(0, 180, 0):setScale(0.45, 0.45, 0.45)

        ---このテキストアニメーションの名前
        ---@type string
        instance.AnimationName = taskName

        ---このテキストアニメーションが持つテキスト
        ---@type string
        instance.Text = text

        ---テキストレンダータスクの初期位置
        ---@type Vector3
        instance.TextTaskPos = textPos

        ---このレンダーで処理を終えたかどうか
        ---@type boolean
        instance.IsRenderProcessed = false

        ---テキストアニメーションのタイミングを図るカウンター
        ---@type number
        instance.AnimationCount = 0

        ---文字がポンって置かれる部分に到達したかどうか
        ---@type boolean
        instance.PonPointPassed = false

        ---テキストレンダータスクの大きさを設定する。
        ---@param task ExSkillTextAnimation.TextTask 大きさを変更するテキストレンダータスク
        ---@param newScale number 設定する大きさの倍率。基準はこのテキストレンダータスク。
        instance.setScale = function (self, task, newScale)
            local targetTask = task == "PRIMARY" and self.PrimaryTextTask or self.SecondaryTextTask
            local scale = newScale * 0.4
            local offset = (newScale - 1) * 3 / 2
            targetTask:setPos(instance.TextTaskPos:copy():add(-offset, offset, 0))
            targetTask:setScale(scale, scale, scale)
        end

        ---テキストを真っ黒にする
        ---@param black boolean テキストを真っ黒にするかどうか
        instance.setBlack = function (self, black)
            instance.PrimaryTextTask:setText("§"..(black and "0" or "d")..self.Text)
        end

        ---テキストアニメーションを再生する。
        instance.play = function (self)
            self.SecondaryTextTask:setVisible(true)
            self.SecondaryTextTask:setOpacity(0.25)
            self:setScale("SECONDARY", 2)
            if events.RENDER:getRegisteredCount(taskName.."_render") == 0 then
                events.RENDER:register(function ()
                    if not self.IsRenderProcessed then
                        if self.AnimationCount <= 0.1 then
                            self:setScale("SECONDARY", self.AnimationCount * -10 + 2)
                            self.SecondaryTextTask:setOpacity(self.AnimationCount * 5 + 0.5)
                        elseif self.AnimationCount <= 0.2 then
                            self:setScale("SECONDARY", self.AnimationCount * 10)
                            self.SecondaryTextTask:setOpacity(self.AnimationCount * -5 + 1.5)
                        else
                            self.SecondaryTextTask:setVisible(false)
                        end
                        if self.AnimationCount >= 0.05 then
                            self.PrimaryTextTask:setVisible(true)
                            if self.AnimationCount <= 0.083 then
                                self:setScale("PRIMARY", self.AnimationCount * -12.12 + 1.8)
                            elseif self.AnimationCount <= 0.1 then
                                self:setScale("PRIMARY", self.AnimationCount * 12.12 - 0.2)
                            else
                                self:setScale("PRIMARY", 1)
                            end
                        end
                        if self.AnimationCount >= 0.1 and not self.PonPointPassed then
                            sounds:playSound("minecraft:block.bone_block.place", player:getPos())
                            self.PonPointPassed = true
                        end
                        self.AnimationCount = self.AnimationCount + 1 / client:getFPS()
                        self.IsRenderProcessed = true
                    end
                end, taskName.."_render")
            end
            if events.WORLD_RENDER:getRegisteredCount(taskName.."_world_render") == 0 then
                events.WORLD_RENDER:register(function ()
                    self.IsRenderProcessed = false
                end, taskName.."_world_render")
            end
        end

        ---テキストアニメーションを停止する。
        instance.stop = function (self)
            for _, textTask in ipairs({self.PrimaryTextTask, self.SecondaryTextTask}) do
                textTask:setVisible(false)
            end
            events.RENDER:remove(taskName.."_render")
            events.WORLD_RENDER:remove(taskName.."_world_render")
            self.AnimationCount = 0
            self.PonPointPassed = false
        end

        return instance
    end
}

return ExSkillTextAnimation