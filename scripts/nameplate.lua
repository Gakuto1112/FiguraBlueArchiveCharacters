---@class Nameplate プレイヤーの表示名を制御するクラス
Nameplate = {
    ---現在の表示名: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@type integer
    CurrentName = Config.loadConfig("name", 1),

    ---部活名を表示するかどうか
    ---@type boolean
    ClubShown = Config.loadConfig("showClubName", false),

    ---指定されたtypeIdでの表示名を返す。
    ---@param typeId integer 表示名の種類: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@return string displayName 指定されたtypeIdでの表示名
    getName = function(self, typeId)
        local displayName = typeId == 1 and player:getName() or ((typeId == 2 or typeId == 4) and BlueArchiveCharacter.BASIC.firstName.en_us or (typeId == 5 and BlueArchiveCharacter.BASIC.lastName.en_us or (typeId == 3 and BlueArchiveCharacter.BASIC.firstName.ja_jp or BlueArchiveCharacter.BASIC.lastName.ja_jp)))
        if typeId >= 4 then
            displayName = displayName.." "..(typeId == 4 and BlueArchiveCharacter.BASIC.lastName.en_us or (typeId == 5 and BlueArchiveCharacter.BASIC.firstName.en_us or BlueArchiveCharacter.BASIC.firstName.ja_jp))
        end
        return displayName
    end,

    ---入力された設定で表示名を設定する。
    ---@param typeId integer 表示名の種類: 1. プレイヤー名, 2. 名のみ（英語）, 3. 名のみ（日本語）, 4. 名性（英語）, 5. 性名（英語）, 6. 性名（日本語）
    ---@param showClubName boolean 部活名を表示するかどうか
    setName = function(self, typeId, showClubName)
        local date = client:getDate()
        local displayName = self:getName(typeId)..((typeId >= 2 and date.month == BlueArchiveCharacter.BASIC.birth.month and date.day == BlueArchiveCharacter.BASIC.birth.day) and " :cake:" or "")
        nameplate.ALL:setText(displayName)
        if typeId >= 2 and showClubName then
            nameplate.ENTITY:setText(displayName.."\n§7"..Language:getTranslate("namepalte__club_name"))
        end
        self.CurrentName = typeId
        self.ClubShown = showClubName
    end,

    ---初期化処理
    init = function(self)
        if self.CurrentName >= 2 then
            self:setName(self.CurrentName, self.ClubShown)
        end
        events.RENDER:register(function (delta)
            nameplate.ENTITY:setPivot(ModelUtils.getModelWorldPos(models.models.main.NameplateAnchor):sub(player:getPos(delta)))
        end)
    end
}

Nameplate:init()

return Nameplate