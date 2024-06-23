---@class ExSkill2TextAnimation Exスキル2の「MISS」表示アニメーションを行うインスタンスクラス
ExSkill2TextAnimation = {
    ---ExSkill2TextAnimationのインスタンスを新しく作り、返す。
    ---@param parentModel ModelPart テキストタスクをアタッチする親モデルパーツ
    ---@return table instance 生成されたインスタンスを示すテーブル
    new = function (parentModel)
        local instance = {}

        ---このインスタンスのUUID
        ---@type string
        instance.TaskUUID = client.intUUIDToString(client:generateUUID())

        ---再生時間を計測するカウンター
        ---@type integer
        instance.TickCount = 0

        ---メインのテキストタスク
        ---@type TextTask
        instance.TextTask_1 = parentModel:newText("ex_skill_2_miss_text_"..instance.TaskUUID.."_1"):setAlignment("CENTER"):setVisible(false)

        ---サブのテキストタスク
        ---@type TextTask
        instance.TextTask_2 = parentModel:newText("ex_skill_2_miss_text_"..instance.TaskUUID.."_2"):setText("§4§lMISS"):setAlignment("CENTER"):setVisible(false)

        ---テキストアニメーションを再生する。
        instance.play = function (self)
            for _, textTask in ipairs({self.TextTask_1, self.TextTask_2}) do
                textTask:setVisible(true)
            end
            self.TextTask_1:setText("§0§lMISS")
            events.TICK:register(function ()
                self.TextTask_1:setPos(0, instance.TickCount * 0.5 + 3.5, 0)
                self.TickCount = self.TickCount + 1
                if self.TickCount == 1 then
                    self.TextTask_1:setText("§e§lMISS")
                    self.TextTask_2:setVisible(false)
                elseif self.TickCount == 6 or self.TickCount == 10 then
                    self.TextTask_1:setOpacity(0.5)
                elseif self.TickCount == 8 or self.TickCount == 12 then
                    self.TextTask_1:setOpacity(1)
                elseif self.TickCount == 14 then
                    events.TICK:remove("ex_skill_2_miss_text_"..self.TaskUUID.."_tick")
                    events.RENDER:remove("ex_skill_2_miss_text_"..self.TaskUUID.."_render")
                    for _, textTask in ipairs({self.TextTask_1, self.TextTask_2}) do
                        textTask:setVisible(false)
                    end
                    self.TickCount = 0
                end
            end, "ex_skill_2_miss_text_"..self.TaskUUID.."_tick")

            events.RENDER:register(function (delta, ctx, matrix)
                self.TextTask_1:setPos(0, (instance.TickCount + delta) * 0.5 + 3.5, 0)
                if self.TickCount == 0 then
                    self.TextTask_2:setPos(0, 3.5 + delta * 3.5, 0)
                    self.TextTask_2:setScale(vectors.vec3(1, 1, 1):scale(1 + delta))
                    self.TextTask_2:setOpacity(1 - delta)
                end
            end, "ex_skill_2_miss_text_"..self.TaskUUID.."_render")
        end

        return instance
    end
}

return ExSkill2TextAnimation