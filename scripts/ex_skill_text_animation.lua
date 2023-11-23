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
        instance.SecondaryTextTask = models.models.main.CameraAnchor:newText(taskName.."_2"):setVisible(false):setText("§d"..text):setPos(textPos):setRot(0, 180, 0):setScale(0.45, 0.45, 0.45):setOutline(true)

        ---このテキストアニメーションの名前
        ---@type string
        instance.AnimationName = taskName

        ---テキストレンダータスクの初期位置
        ---@type Vector3
        instance.TextTaskPos = textPos

        ---このレンダーで処理を終えたかどうか
        ---@type boolean
        instance.IsRenderProcessed = false

        ---テキストアニメーションのタイミングを図るカウンター
        ---@type number
        instance.AnimationCount = 0

        ---テキストレンダータスクの大きさを設定する。
        ---@param task ExSkillTextAnimation.TextTask 大きさを変更するテキストレンダータスク
        ---@param newScale number 設定する大きさの倍率。基準はこのテキストレンダータスク。
        instance.setScale = function (self, task, newScale)
            local targetTask = task == "PRIMARY" and self.PrimaryTextTask or self.SecondaryTextTask
            local scale = newScale * 0.4
            local offset = (-newScale + 1) * 2.25
            ---@diagnostic disable-next-line: undefined-field
            targetTask:setPos(instance.TextTaskPos:copy():add(offset, -offset, 0)):setScale(scale, scale, scale)
        end

        ---テキストアニメーションを再生する。
        instance.play = function (self)
            for _, textTask in ipairs({self.PrimaryTextTask, self.SecondaryTextTask}) do
                textTask:setVisible(true)
            end
            if events.RENDER:getRegisteredCount(taskName.."_render") == 0 then
                events.RENDER:register(function ()
                    self.IsRenderProcessed = false
                end, taskName.."_render")
            end
            if events.WORLD_RENDER:getRegisteredCount(taskName.."_world_render") == 0 then
                events.WORLD_RENDER:register(function ()
                    if not self.IsRenderProcessed then
                        self.IsRenderProcessed = true
                    end
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
        end

        return instance
    end
}

return ExSkillTextAnimation