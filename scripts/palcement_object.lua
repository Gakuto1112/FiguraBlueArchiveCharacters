---@class PlacementObject 設置物を管理するクラス
---@field TARGET_MODEL ModelPart 設置物として扱う対象のモデルグループ
---@field MODEL_SCALE_MULTIPLAYER number 設置物の大きさの倍率
PlacementObject = {
    --定数
    TARGET_MODEL = models.models.placement_object.PlacementObject,
    MODEL_SCALE_MULTIPLAYER = 1.2
}

PlacementObject.TARGET_MODEL:setScale(PlacementObject.MODEL_SCALE_MULTIPLAYER, PlacementObject.MODEL_SCALE_MULTIPLAYER, PlacementObject.MODEL_SCALE_MULTIPLAYER)

return PlacementObject