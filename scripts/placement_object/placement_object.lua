---@class PlacementObject 単一の設置物を管理するクラス
PlacementObject = {
    ---設置物のインスタンスを新しく生成する。
    ---@param objectModel ModelPart 設置物としてこのインスタンスで操作するモデルパーツ
    ---@param objectIndex integer 設置物データのインデックス番号。設置物のデータを参照するときに使用する。
    ---@param objectData table 設置物データ
    ---@param pos Vector3 設置物を設置するワールド座標
    ---@param rot number 設置物のワールド方向
    new = function (objectModel, objectIndex, objectData, pos, rot)
        local instance = {}

        ---設置物としてこのインスタンスで操作するモデルパーツ
        ---@type ModelPart
        instance.objectModel = objectModel

        ---設置物データのインデックス番号。設置物のデータを参照するときに使用する。
        ---@type integer
        instance.objectIndex = objectIndex

        ---この設置物に働く重力の大きさ
        ---@type number
        instance.gravity = 1

        ---この設置物に炎耐性を付けるかどうか。
        ---@type boolean
        instance.hasFireResistance = false

        ---設置物の現在の位置
        ---@type Vector3
        instance.currentPos = pos

        ---設置物の次ティックの位置
        instance.nextPos = pos

        ---各ティック毎に呼ばれる関数
        instance.onTick = function ()
        end

        ---各レンダーティック毎に呼ばれる関数
        instance.onRender = function ()
        end

        ---このインスタンスが破棄される直前に呼ばれる関数
        instance.onDeinit = function ()
        end

        if objectData.gravity ~= nil then
            instance.gravity = objectData.gravity
        end
        if objectData.hasFireResistance ~= nil then
            instance.hasFireResistance = objectData.hasFireResistance
        end
        instance.objectModel:setPos(instance.currentPos:copy():scale(16))
        instance.objectModel:setRot(0, rot, 0)
        instance.objectModel:setVisible(true)

        return instance
    end
}

return PlacementObject