---@class Nameplate プレイヤーの表示名を制御するクラス
---@field CurrentName integer 現在の表示名: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
---@field ClubShown boolean 部活名を表示するかどうか
Nameplate = {
    --変数
    CurrentName = Config:loadConfig("currentName", 1),
    ClubShown = Config:loadConfig("showClubName", false),

    --関数
    ---指定されたtypeIdでの表示名を返す。
    ---@param typeId integer 表示名の種類: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@return string displayName 指定されたtypeIdでの表示名
    getName = function(self, typeId)
        local displayName = typeId == 1 and player:getName() or ((typeId == 2 or typeId == 4) and Config.FIRST_NAME_EN or (typeId == 5 and Config.LAST_NAME_EN or (typeId == 3 and Config.FIRST_NAME_JP or Config.LAST_NAME_JP)))
        if typeId >= 4 then
            displayName = displayName.." "..(typeId == 4 and Config.LAST_NAME_EN or (typeId == 5 and Config.FIRST_NAME_EN or Config.FIRST_NAME_JP))
        end
        return displayName
    end,

    ---入力された設定で表示名を設定する。
    ---@param typeId integer 表示名の種類: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@param showClubName boolean 部活名を表示するかどうか
    setName = function(self, typeId, showClubName)
        local date = client:getDate()
        local displayName = self:getName(typeId)..((typeId >= 2 and date.month == Config.BIRTH_MONTH and date.day == Config.BIRTH_DAY) and " :cake:" or "")
        nameplate.ALL:setText(displayName)
        if typeId >= 2 and showClubName then
            nameplate.ENTITY:setText(displayName.."\n§7"..Language:getTranslate("namepalte__club_name"))
        end
        self.CurrentName = typeId
        self.ClubShown = showClubName
    end
}

return Nameplate