---@class ActionWheel アクションホイールを管理するクラス
ActionWheel = {
    ---アクションホイール - メインページ のインスタンス
    ---@type Page
    MainPage = action_wheel:newPage(),

    ---現在選択中の衣装
    ---@type integer
    SelectingCostume = Costume.CurrentCostume,

    ---現在選択中の表示名
    ---@type integer
    SelectingName = Nameplate.CurrentName,

    ---現在選択中の「部活名を表示するかどうか」
    ---@type boolean
    SelectingShouldShowClub = Nameplate.ClubShown,

    ---現在選択中のExスキルフレームのパーティクル量
    ---@type integer
    SelectingExSkillParticleAmount = ExSkill.FrameParticleAmount,

    ---乗り物のモデルを置き換えるかどうか
    ---@type boolean
    ShouldReplaceVehicleModels = Config.loadConfig("replaceVehicleModels", true),

    ---前ティックにアクションホイールを開けていたかどうか
    ---@type boolean
    IsActionWheelOpenedPrev = false,

    ---衣装変更アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshCostumeChangeActionTitle = function (self)
        if #Costume.CostumeList >= 2 then
            self.MainPage:getAction(1):title(Language:getTranslate("action_wheel__main__action_1__title").."§b"..Costume.getCostumeLocalName(self.SelectingCostume))
        else
            self.MainPage:getAction(1):title("§7"..Language:getTranslate("action_wheel__main__action_1__title")..Costume.getCostumeLocalName(self.SelectingCostume))
        end
    end,

    ---名前変更アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshNameChangeActionTitle = function (self)
        if self.SelectingCostume >= 2 then
            if self.SelectingShouldShowClub then
                self.MainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(self.SelectingName).."\n§r"..Language:getTranslate("action_wheel__main__action_2__title_2").."§a"..Language:getTranslate("action_wheel__toggle_on"))
            else
                self.MainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(self.SelectingName).."\n§r"..Language:getTranslate("action_wheel__main__action_2__title_2").."§c"..Language:getTranslate("action_wheel__toggle_off"))
            end
        else
            self.MainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(self.SelectingName).."\n§7"..Language:getTranslate("action_wheel__main__action_2__title_2")..Language:getTranslate("action_wheel__toggle_"..(self.SelectingShouldShowClub and "on" or "off")))
        end
    end,

    ---Exスキルアニメーションのパーティクル量調整アクションのタイトルを更新する。
    ---@param self ActionWheel
    refreshExSkillParticleActionTitle = function (self)
        self.MainPage:getAction(5):title(Language:getTranslate("action_wheel__main__action_5__title").."§b"..Language:getTranslate("action_wheel__main__action_5__option_"..self.SelectingExSkillParticleAmount))
    end,

    ---初期化関数
    ---@param self ActionWheel
    init = function (self)
        events.TICK:register(function()
            local isActionWheelOpened = action_wheel:isEnabled()
            if not isActionWheelOpened and self.IsActionWheelOpenedPrev then
                if self.SelectingName ~= Nameplate.CurrentName or self.SelectingShouldShowClub ~= Nameplate.ClubShown then
                    pings.actionWheelChangeName(self.SelectingName, self.SelectingShouldShowClub)
                    Config.saveConfig("name", self.SelectingName)
                    Config.saveConfig("showClubName", self.SelectingShouldShowClub)
                    sounds:playSound(CompatibilityUtils:checkSound("minecraft:ui.cartography_table.take_result"), player:getPos())
                    print(Language:getTranslate("action_wheel__main__action_2__done_first")..Nameplate:getName(self.SelectingName)..Language:getTranslate("action_wheel__main__action_2__done_last"))
                end
                if self.SelectingCostume ~= Costume.CurrentCostume then
                    pings.actionWheelChangeCostume(self.SelectingCostume)
                    Config.saveConfig("costume", self.SelectingCostume)
                    sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.armor.equip_leather"), player:getPos())
                    print(Language:getTranslate("action_wheel__main__action_1__done_first")..Costume.getCostumeLocalName(self.SelectingCostume)..Language:getTranslate("action_wheel__main__action_1__done_last"))
                end
                if self.SelectingExSkillParticleAmount ~= ExSkill.FrameParticleAmount then
                    ExSkill.FrameParticleAmount = self.SelectingExSkillParticleAmount
                    Config.saveConfig("ex_skill_frame_particle_amount", self.SelectingExSkillParticleAmount)
                    sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.item.pickup"), player:getPos(), 1, 0.5)
                    print(Language:getTranslate("action_wheel__main__action_5__done_first")..Language:getTranslate("action_wheel__main__action_5__option_"..self.SelectingExSkillParticleAmount)..Language:getTranslate("action_wheel__main__action_5__done_last"))
                end
            end
            self.IsActionWheelOpenedPrev = isActionWheelOpened
        end)

        --アクションの設定
        --アクション1. 衣装を変更
        self.MainPage:newAction(1):setItem(CompatibilityUtils:checkItem("minecraft:leather_chestplate")):setOnScroll(function(direction)
            if #Costume.CostumeList >= 2 then
                if direction < 0 then
                    self.SelectingCostume = self.SelectingCostume == #Costume.CostumeList and 1 or self.SelectingCostume + 1
                else
                    self.SelectingCostume = self.SelectingCostume == 1 and #Costume.CostumeList or self.SelectingCostume - 1
                end
                self:refreshCostumeChangeActionTitle()
            else
                print(Language:getTranslate("action_wheel__main__action_1__unavailable"))
            end
        end):setOnLeftClick(function()
            if #Costume.CostumeList >= 2 then
                self.SelectingCostume = Costume.CurrentCostume
                self:refreshCostumeChangeActionTitle()
            end
        end):setOnRightClick(function()
            if #Costume.CostumeList >= 2 then
                self.SelectingCostume = 1
                self:refreshCostumeChangeActionTitle()
            end
        end)

        if #Costume.CostumeList >= 2 then
            local action = self.MainPage:getAction(1)
            action:setColor(0.78, 0.78, 0.78)
            action:setHoverColor(1, 1, 1)
        else
            local action = self.MainPage:getAction(1)
            action:setColor(0.16, 0.16, 0.16)
            action:setHoverColor(1, 0.33, 0.33)
        end

        --アクション2. 表示名の変更
        self.MainPage:newAction(2):setItem(CompatibilityUtils:checkItem("minecraft:name_tag")):setColor(0.78, 0.78, 0.78):setHoverColor(1, 1, 1):setOnScroll(function(direction)
            if direction < 0 then
                self.SelectingName = self.SelectingName == 6 and 1 or self.SelectingName + 1
            else
                self.SelectingName = self.SelectingName == 1 and 6 or self.SelectingName - 1
            end
            self:refreshNameChangeActionTitle()
        end):setOnLeftClick(function()
            self.SelectingShouldShowClub = not self.SelectingShouldShowClub
            self:refreshNameChangeActionTitle()
        end):setOnRightClick(function()
            self.SelectingName = 1
            self.SelectingShouldShowClub = false
            self:refreshNameChangeActionTitle()
        end)

        --アクション3. 防具の表示
        self.MainPage:newAction(3):setTitle(Language:getTranslate("action_wheel__main__action_3__title").."§c"..Language:getTranslate("action_wheel__toggle_off")):setToggleTitle(Language:getTranslate("action_wheel__main__action_3__title").."§a"..Language:getTranslate("action_wheel__toggle_on")):setItem(CompatibilityUtils:checkItem("minecraft:iron_chestplate")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
            pings.actionWheelSetArmorVisible(true)
            action:setHoverColor(0.33, 1, 0.33)
            Config.saveConfig("showArmor", true)
        end):setOnUntoggle(function(_, action)
            pings.actionWheelSetArmorVisible(false)
            action:setHoverColor(1, 0.33, 0.33)
            Config.saveConfig("showArmor", false)
        end)
        if Config.loadConfig("showArmor", false) then
            local action = self.MainPage:getAction(3)
            action:setToggled(true)
            action:setHoverColor(0.33, 1, 0.33)
        end

        --アクション4. 一人称視点での武器モデルの表示
        self.MainPage:newAction(4):setTitle(Language:getTranslate("action_wheel__main__action_4__title").."§c"..Language:getTranslate("action_wheel__toggle_off")):setToggleTitle(Language:getTranslate("action_wheel__main__action_4__title").."§a"..Language:getTranslate("action_wheel__toggle_on")):item(CompatibilityUtils:checkItem("minecraft:bow")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
            Gun.ShowWeaponInFirstPerson = true
            action:setHoverColor(0.33, 1, 0.33)
            Config.saveConfig("firstPersonWeapon", true)
        end):setOnUntoggle(function (_, action)
            Gun.ShowWeaponInFirstPerson = false
            action:setHoverColor(1, 0.33, 0.33)
            Config.saveConfig("firstPersonWeapon", false)
        end)
        if Config.loadConfig("firstPersonWeapon", true) then
            local action = self.MainPage:getAction(4)
            action:setToggled(true)
            action:setHoverColor(0.33, 1, 0.33)
        end

        --アクション5. Exスキルフレームのパーティクルの量
        self.MainPage:newAction(5):setItem(CompatibilityUtils:checkItem("minecraft:glowstone_dust")):setColor(0.78, 0.78, 0.78):setHoverColor(1, 1, 1):setOnScroll(function (direction)
            if direction < 0 then
                self.SelectingExSkillParticleAmount = self.SelectingExSkillParticleAmount == 4 and 1 or self.SelectingExSkillParticleAmount + 1
            else
                self.SelectingExSkillParticleAmount = self.SelectingExSkillParticleAmount == 1 and 4 or self.SelectingExSkillParticleAmount - 1
            end
            self:refreshExSkillParticleActionTitle()
        end):setOnLeftClick(function ()
            self.SelectingExSkillParticleAmount = ExSkill.FrameParticleAmount
            self:refreshExSkillParticleActionTitle()
        end):setOnRightClick(function ()
            self.SelectingExSkillParticleAmount = 1
            self:refreshExSkillParticleActionTitle()
        end)

        --アクション6. 乗り物モデルの置き換え
        self.MainPage:newAction(6):setTitle(Language:getTranslate("action_wheel__main__action_6__title").."§c"..Language:getTranslate("action_wheel__toggle_off")):setToggleTitle(Language:getTranslate("action_wheel__main__action_6__title").."§a"..Language:getTranslate("action_wheel__toggle_on")):item(CompatibilityUtils:checkItem("minecraft:oak_boat")):setColor(0.67, 0, 0):setHoverColor(1, 0.33, 0.33):setToggleColor(0, 0.67, 0):setOnToggle(function (_, action)
            if BlueArchiveCharacter.ACTION_WHEEL.vehicleOptionEnabled then
                pings.actionWheelSetShouldReplaceVehicleModels(true)
                action:setHoverColor(0.33, 1, 0.33)
                Config.saveConfig("replaceVehicleModels", true)
            else
                print(Language:getTranslate("action_wheel__main__action_6__unavailable"))
                action:setToggled(false)
            end
        end):setOnUntoggle(function (_, action)
            pings.actionWheelSetShouldReplaceVehicleModels(false)
            action:setHoverColor(1, 0.33, 0.33)
            Config.saveConfig("replaceVehicleModels", false)
        end)
        if not BlueArchiveCharacter.ACTION_WHEEL.vehicleOptionEnabled then
            local action = self.MainPage:getAction(6)
            action:setTitle("§7"..Language:getTranslate("action_wheel__main__action_6__title")..Language:getTranslate("action_wheel__toggle_off"))
            action:setColor(0.16, 0.16, 0.16)
            action:setHoverColor(1, 0.33, 0.33)
            self.ShouldReplaceVehicleModels = false
        elseif self.ShouldReplaceVehicleModels then
            local action = self.MainPage:getAction(6)
            action:setToggled(true)
            action:setHoverColor(0.33, 1, 0.33)
        end

        --アクション7. （空欄）

        --アクション8. （空欄）

        self:refreshCostumeChangeActionTitle()
        self:refreshNameChangeActionTitle()
        self:refreshExSkillParticleActionTitle()

        action_wheel:setPage(self.MainPage)
    end
}

--ping関数

---アクションホイールから衣装を変更するトリガー関数
---@param costumeId integer 新しい衣装のインデックス番号
function pings.actionWheelChangeCostume(costumeId)
    if costumeId >= 2 then
        Costume:setCostume(costumeId)
    else
        Costume:resetCostume()
    end
end

---アクションホイールから名前を変更するトリガー関数
---@param typeId integer 新しい名前の表示形式のインデックス番号
---@param showClubName boolean 部活名を表示するかどうか
function pings.actionWheelChangeName(typeId, showClubName)
    Nameplate:setName(typeId, showClubName)
end

---アクションホイールから防具の可視性を変更するトリガー関数
---@param visible boolean 防具を表示するかどうか
function pings.actionWheelSetArmorVisible(visible)
    Armor.ShowArmor = visible
end

---アクションホイールから乗り物モデルの置き換えを変更するトリガー関数
---@param enabled boolean 乗り物モデルの置き換えを有効化するかどうか
function pings.actionWheelSetShouldReplaceVehicleModels(enabled)
    ActionWheel.ShouldReplaceVehicleModels = enabled
end

ActionWheel:init()

return ActionWheel