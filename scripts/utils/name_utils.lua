---レジストリの種類を示す列挙型
---@alias NameManager.RegistoryType
---| "BLOCK" ブロック名
---| "ITEM" アイテム名
---| "PARTICLE" パーティクル名
---| "SOUND" サウンド名

---@class NameManager ゲーム内の各種名称（ブロック、アイテム、パーティクル、サウンド）を安全に使用するためのラッパークラス
NameManager = {
    ---ゲームから取得した全アイテム名を保持するテーブル
    Registries = {
        block = {},
        item = {},
        particle = {},
        sound = {}
    },

    ---指定されたターゲットがレジストリに登録されているかどうかを返す。
    ---@param self NameManager
    ---@param registoryType NameManager.RegistoryType 検索をかける対象のレジストリ
    ---@param target string 検索対象名。"minecraft:"を抜かないこと。
    find = function (self, registoryType, target)
        ---リスト内の中央の要素（偶数の場合は中央から1つ左の要素）と指定されたターゲットのUnicode順を比較する。
        ---@param from integer リストの検索開始のインデックス番号
        ---@param to integer リストの検索終了のインスタンス番号（指定したインデックス番号の要素も検索に含む）
        ---@return integer compareResult 比較結果。0は同じ文字列、1はターゲットの方が大きい、-1はターゲットの方が小さいことを表す。
        local function compareToCenterElement(from, to)
            local centerIndex = math.floor((to - from) / 2) + from
            if self.Registries[registoryType:lower()][centerIndex] < target then
                return 1
            elseif self.Registries[registoryType:lower()][centerIndex] > target then
                return -1
            else
                return 0
            end
        end

        local startIndex = 1
        local endIndex = #self.Registries[registoryType:lower()]
        while startIndex < endIndex do
            local compareResult = compareToCenterElement(startIndex, endIndex)
            if compareResult == 1 then
                startIndex = math.floor((endIndex - startIndex) / 2) + startIndex + 1
            elseif compareResult == -1 then
                endIndex = math.floor((endIndex - startIndex) / 2) + startIndex
            else
                break
            end
        end
        print(startIndex, endIndex)
        if startIndex == endIndex then
            return compareToCenterElement(startIndex, endIndex) == 0
        else
            return true
        end
    end,

    ---初期化関数
    ---@param self NameManager
    init = function (self)
        self.Registries.block = client.getRegistry("minecraft:block")
        self.Registries.item = client.getRegistry("minecraft:item")
        self.Registries.particle = client.getRegistry("minecraft:particle_type")
        self.Registries.sound = client.getRegistry("minecraft:sound_event")
        for name, _ in pairs(self.Registries) do
            table.sort(self.Registries[name])
        end
    end
}

NameManager:init()

return NameManager