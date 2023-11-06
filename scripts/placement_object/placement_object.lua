---@class 単一の設置物を管理するクラス
PlacementObject = {
    ---設置物のインスタンスを新しく生成する。
    ---@param objectData table 設置物のデータ
    new = function (objectData)
        local instance = {}

        ---設置物として生成したモデルパーツ
        ---@type ModelPart
        instance.object = objectData.model:copy("PlacementObject_"..client:getSystemTime())

        ---設置物の位置をワールド座標で変更する。
        ---@param newWorldPos Vector3 移動先のワールド座標
        instance.setWorldPos = function (self, newWorldPos)
            self.object:setPos(newWorldPos:scale(16))
        end

        ---設置物の向きを変更する。度数法で入力する。
        ---@param newWorldRot Vector3 移動先のワールド方向
        instance.setWorldRot = function (self, newWorldRot)
            self.object:setRot(newWorldRot)
        end

        models.script_placement_object:addChild(instance.object)
        instance.object:setVisible(true)

        return instance
    end
}

return PlacementObject