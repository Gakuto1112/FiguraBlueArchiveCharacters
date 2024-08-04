---レジストリの種類を示す列挙型
---@alias NameUtils.RegistoryType
---| "BLOCK" ブロック名
---| "ITEM" アイテム名
---| "PARTICLE" パーティクル名
---| "SOUND" サウンド名

---@class NameUtils ゲーム内の各種名称（ブロック、アイテム、パーティクル、サウンド）を安全に使用するためのラッパークラス
NameUtils = {
    ---ゲームから取得した全アイテム名を保持するテーブル
    ---@type table[]
    Registries = {
        block = {},
        item = {},
        particle = {},
        sound = {}
    },

    ---レジストリへの確認が済んでいるIDを保持するテーブル。
    ---@type table[]
    CheckedList = {
        block = {},
        item = {},
        particle = {},
        sound = {}
    },

    ---指定されたターゲットがレジストリに登録されているかどうかを返す。
    ---@param self NameUtils
    ---@param registoryType NameUtils.RegistoryType 検索をかける対象のレジストリ
    ---@param target string 検索対象名。"minecraft:"を抜かないこと。
    ---@return boolean found 指定されたターゲットがレジストリで見つかったかどうか
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
        if startIndex == endIndex then
            return compareToCenterElement(startIndex, endIndex) == 0
        else
            return true
        end
    end,

    ---指定されたブロックIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:air"を返す。
    ---@param self NameUtils
    ---@param block Minecraft.blockID 確認対象のブロックID
    ---@return Minecraft.blockID blockID レジストリに登録してある場合は確認対象のブロックIDをそのまま返し、未登録の場合は"minecraft:air"が返す。
    checkBlock = function (self, block)
        if self.CheckedList.block[block] == nil then
            self.CheckedList.block[block] = self:find("BLOCK", block)
        end
        return self.CheckedList.block[block] and block or "minecraft:air"
    end,

    ---指定されたアイテムIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:barrier"を返す。
    ---@param self NameUtils
    ---@param item Minecraft.blockID 確認対象のアイテムID
    ---@return Minecraft.blockID blockID レジストリに登録してある場合は確認対象のアイテムIDをそのまま返し、未登録の場合は"minecraft:barrier"が返す。
    checkItem = function (self, item)
        if self.CheckedList.item[item] == nil then
            self.CheckedList.item[item] = self:find("ITEM", item)
        end
        return self.CheckedList.item[item] and item or "minecraft:barrier"
    end,

    ---指定されたパーティクルIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:poof"を返す。
    ---@param self NameUtils
    ---@param particle Minecraft.particleID 確認対象のパーティクルID
    ---@return Minecraft.particleID particleID レジストリに登録してある場合は確認対象のパーティクルIDをそのまま返し、未登録の場合は"minecraft:poof"が返す。
    checkParticle = function (self, particle)
        if self.CheckedList.particle[particle] == nil then
            self.CheckedList.particle[particle] = self:find("PARTICLE", particle)
        end
        return self.CheckedList.particle[particle] and particle or "minecraft:poof"
    end,

    ---指定されたサウンドIDがレジストリに登録されているか確認する。レジストリに未登録の場合は"minecraft:ui.button.click"を返す。
    ---@param self NameUtils
    ---@param sound Minecraft.soundID 確認対象のサウンドID
    ---@return Minecraft.soundID particleID レジストリに登録してある場合は確認対象のサウンドIDをそのまま返し、未登録の場合は"minecraft:ui.button.click"が返す。
    checkSound = function (self, sound)
        if self.CheckedList.sound[sound] == nil then
            self.CheckedList.sound[sound] = self:find("SOUND", sound)
        end
        return self.CheckedList.sound[sound] and sound or "minecraft:ui.button.click"
    end,

    ---ブロックの破片のパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。
    ---@param block Minecraft.blockID ブロックの破片パーティクルとして表示するブロックのID。レジストリへの確認は行わない。
    ---@return string particleData ブロックの破片のパーティクルを示す文字列
    getBlockParticleId = function (block)
        return client:getVersion() >= "1.20.5" and "minecraft:block{block_state:\""..block.."\"}" or "minecraft:block "..block
    end,

    ---dustパーティクルを示す文字列を返す。Minecraftのバージョン違いを吸収するための関数。
    ---@param color Vector3 dustの色
    ---@param size number dustの大きさ
    ---@return string particleData dustの破片のパーティクルを示す文字列
    getDustParticleId = function (color, size)
        return client:getVersion() >= "1.20.5" and "minecraft:dust{color:["..color.x..","..color.y..","..color.z.."],scale:"..size.."}" or "minecraft:dust "..color.x.." "..color.y.." "..color.z.." "..size
    end,

    ---初期化関数
    ---@param self NameUtils
    init = function (self)
        self.Registries.block = client.getRegistry("minecraft:block")
        self.Registries.item = client.getRegistry("minecraft:item")
        self.Registries.particle = client.getRegistry("minecraft:particle_type")
        self.Registries.sound = client.getRegistry("minecraft:sound_event")
        for name, _ in pairs(self.Registries) do
            table.sort(self.Registries[name])
        end
        self.CheckedList.block["minecraft:air"] = true
        self.CheckedList.item["minecraft:barrier"] = true
        self.CheckedList.particle["minecraft:poof"] = true
        self.CheckedList.sound["minecraft:ui.button.click"] = true
    end
}

NameUtils:init()

return NameUtils