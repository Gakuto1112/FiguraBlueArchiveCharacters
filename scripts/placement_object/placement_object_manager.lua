---@class PlacementObjectManager 設置物を管理するマネージャークラス
PlacementObjectManager = {
    ---デバッグモード
    ---@type boolean
    DEBUG_MODE = true,

    ---設置物のインスタンスを保持するテーブル
    ---@type table<table>
    Objects = {},

    ---レンダーイベントを処理したかどうか
    IsRenderProcessed = false,

    ---今ある全ての設置物を削除する。
    removeAll = function (self)
        while #self.Objects > 0 do
            self.Objects[1]:remove()
            table.remove(self.Objects, 1)
        end
    end,

    ---初期化関数
    init = function (self)
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_placement_object", "World")

        events.TICK:register(function ()
            local index = 1
            while index <= #self.Objects do
                if self.Objects[index]:getIsObjectOverlapped() then
                    self.Objects[index]:remove()
                    table.remove(self.Objects, index)
                else
                    local objectRemoved = false
                    local objectPos = self.Objects[index]:getWorldPos()
                    local worldBoungingBoxSize = self.Objects[index].boundingBox:copy():scale(1 / 16)
                    local halfWorldBoungingBoxSize = worldBoungingBoxSize:copy():scale(1 / 2)
                    for _, block in ipairs(self.Objects[index]:getCollisionBlocks(vectors.vec3(objectPos.x - halfWorldBoungingBoxSize.x, objectPos.y, objectPos.z - halfWorldBoungingBoxSize.z), vectors.vec3(objectPos.x + halfWorldBoungingBoxSize.x, objectPos.y + worldBoungingBoxSize.y, objectPos.z + halfWorldBoungingBoxSize.z))) do
                        local objectBlockId = world.getBlockState(block).id
                        if objectBlockId == "minecraft:lava" or objectBlockId == "minecraft:fire" or objectBlockId == "minecraft:soul_fire" then
                            self.Objects[index]:remove()
                            table.remove(self.Objects, index)
                            sounds:playSound("minecraft:block.fire.extinguish", objectPos)
                            for _ = 0, worldBoungingBoxSize.x * worldBoungingBoxSize.y * worldBoungingBoxSize.z * 8 do
                                particles:newParticle("minecraft:smoke", vectors.vec3(objectPos.x + math.random() * worldBoungingBoxSize.x - halfWorldBoungingBoxSize.x, objectPos.y + math.random() * worldBoungingBoxSize.y, objectPos.z + math.random() * worldBoungingBoxSize.z - halfWorldBoungingBoxSize.z))
                            end
                            objectRemoved = true
                            break
                        end
                    end
                    if not objectRemoved then
                        self.Objects[index]:fallTickProcess()
                        index = index + 1
                    end
                end

            end
        end)

        events.RENDER:register(function (delta)
            if not self.IsRenderProcessed then
                for _, placementObject in ipairs(self.Objects) do
                    placementObject:fallRenderProcess(delta)
                end
                self.IsRenderProcessed = true
            end
        end)

        events.WORLD_RENDER:register(function ()
            self.IsRenderProcessed = false
        end)
    end,

    ---指定した場所に指定した向きで設置物を置く。
    ---@param objectData table 設置するオブジェクトのデータ
    ---@param worldPos Vector3 設置する場所を示すワールド座標
    ---@param worldRot number 設置物の向き
    place = function (self, objectData, worldPos, worldRot)
        local instance = PlacementObject.new(objectData)
        instance:setWorldPos(worldPos, true)
        instance:setWorldRot(vectors.vec3(0, worldRot))
        table.insert(self.Objects, instance)
    end
}

PlacementObjectManager:init()

keybinds:newKeybind("debug_place_object", "key.keyboard.z"):onPress(function ()
    local lookDir = player:getLookDir()
    PlacementObjectManager:place(BlueArchiveCharacter.PLACEMENT_OBJECT[1], player:getPos(), -math.deg(math.atan2(lookDir.z, lookDir.x)) - 90)
end)

keybinds:newKeybind("debug_remove_all_objects", "key.keyboard.x"):onPress(function ()
    PlacementObjectManager:removeAll()
end)

return PlacementObjectManager