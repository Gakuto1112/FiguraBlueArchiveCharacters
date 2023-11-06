---@class PlacementObjectManager 設置物を管理するマネージャークラス
PlacementObjectManager = {
    ---設置物のインスタンスを保持するテーブル
    ---@type table<table>
    Objects = {},

    ---初期化関数
    init = function (self)
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_placement_object", "World")
    end,

    ---指定した場所に指定した向きで設置物を置く。
    ---@param objectData table 設置するオブジェクトのデータ
    ---@param worldPos Vector3 設置する場所を示すワールド座標
    ---@param worldRot number 設置物の向き
    place = function (self, objectData, worldPos, worldRot)
        local instance = PlacementObject.new(objectData)
        instance:setWorldPos(worldPos)
        instance:setWorldRot(vectors.vec3(0, worldRot))
        table.insert(self.Objects, instance)
    end
}

PlacementObjectManager:init()

keybinds:newKeybind("debug_place_object", "key.keyboard.z"):onPress(function ()
    local lookDir = player:getLookDir()
    PlacementObjectManager:place({
        model = models.models.placement_object.PlacementObject
    }, player:getPos(), -math.deg(math.atan2(lookDir.z, lookDir.x)) - 90)
end)

return PlacementObjectManager