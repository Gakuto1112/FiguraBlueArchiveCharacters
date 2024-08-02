---@alias PlacementObjectManager.PlecementMode
---| "COPY" コピーモード。BBアニメーションは使えないが、複数の設置物を設置可能。
---| "MOVE" 移動モード。同時に1つしか設置物を設置できないが、BBアニメーションが使える。

---@class PlacementObjectManager 設置物を管理するマネージャークラス
PlacementObjectManager = {
    ---デバッグモード
    ---@type boolean
    DEBUG_MODE = false,

    ---設置物インスタンスを生成するクラス
    ---@type PlacementObject
    PlacementObjectInstance = require("scripts.placement_object.placement_object"),

    ---設置物のインスタンスを保持するテーブル
    ---@type table[]
    PlacementObjects = {},

    ---設置物を設置する。
    ---@param self PlacementObjectManager
    ---@param objectIndex integer 設置物データのインデックス番号
    ---@param worldPos Vector3 設置物を設置するワールド座標
    ---@param worldRot number 設置物を設置するワールド方向（Y軸のみ）
    place = function (self, objectIndex, worldPos, worldRot)
        if BlueArchiveCharacter.PLACEMENT_OBJECT[objectIndex].placementMode == "COPY" then
            local instance = self.PlacementObjectInstance.new(BlueArchiveCharacter.PLACEMENT_OBJECT[objectIndex].placementModel:copy("PlacementObject_"..client.intUUIDToString(client:generateUUID())):moveTo(models.script_placement_object), objectIndex, BlueArchiveCharacter.PLACEMENT_OBJECT[objectIndex], worldPos, worldRot)
            table.insert(self.PlacementObjects, instance)
            instance:onInit()
        else
            for index, placementObject in ipairs(self.PlacementObjects) do
                if placementObject.objectIndex == objectIndex then
                    placementObject.onDeinit()
                    table.remove(self.PlacementObjects, index)
                    break
                end
            end
            local instance = self.PlacementObjectInstance.new(BlueArchiveCharacter.PLACEMENT_OBJECT[objectIndex].placementModel, objectIndex, BlueArchiveCharacter.PLACEMENT_OBJECT[objectIndex], worldPos, worldRot)
            table.insert(self.PlacementObjects, instance)
            instance:onInit()
        end
        if events.TICK:getRegisteredCount("placement_object_tick") == 0 then
            events.TICK:register(function ()
                for index, placementObject in ipairs(self.PlacementObjects) do
                    placementObject.onTick()
                    if placementObject.deinitRequired then
                        placementObject.onDeinit()
                        table.remove(self.PlacementObjects, index)
                        if #self.PlacementObjects == 0 then
                            events.TICK:remove("placement_object_tick")
                            events.RENDER:remove("placement_object_render")
                        end
                    end
                end
            end, "placement_object_tick")
            events.RENDER:register(function (delta, context, matrix)
                for _, placementObject in ipairs(self.PlacementObjects) do
                    placementObject.onRender(delta, context, matrix)
                end
            end, "placement_object_render")
        end
    end,

    ---設置済みの設置物を1つ削除する。
    ---@param self PlacementObjectManager
    ---@param index integer 削除対象の設置物のインデックス番号（PlacementObjectManager.PlacementObjectsでの番号）
    remove = function (self, index)
        self.PlacementObjects[index].onDeinit()
        table.remove(self.PlacementObjects, index)
        if #self.PlacementObjects == 0 then
            events.TICK:remove("placement_object_tick")
            events.RENDER:remove("placement_object_render")
        end
    end,

    ---設置済みの設置物を全て削除する。
    ---@param self PlacementObjectManager
    removeAll = function (self)
        while #self.PlacementObjects > 0 do
            self:remove(1)
        end
    end,

    ---設置済み設置物の、指定した設置物データのインデックス番号のみに関数を適用する。
    ---@param self PlacementObjectManager
    ---@param objectIndex integer 関数実行対象の設置物データのインデックス番号
    ---@param func fun(objectData: table, index: integer)
    applyFunc = function (self, objectIndex, func)
        for index, placementObject in ipairs(self.PlacementObjects) do
            if placementObject.objectIndex == objectIndex then
                func(placementObject, index)
            end
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_placement_object", "World")
        for _, placementObjectData in ipairs(BlueArchiveCharacter.PLACEMENT_OBJECT) do
            if placementObjectData.placementMode == "MOVE" then
                placementObjectData.placementModel = placementObjectData.placementModel:moveTo(models.script_placement_object)
                placementObjectData.placementModel:setVisible(false)
            end
        end
    end
}

PlacementObjectManager.init()

return PlacementObjectManager