---@class ActionWheel アクションホイールを管理するクラス

---メインページのインスタンス
---@type Page
local mainPage = action_wheel:newPage()

---前ティックにアクションホイールを開けていたかどうか
local actionWheelOpenedPrev = false

---現在選択中の衣装
---@type integer
local selectingCostume = Costume.CurrentCostume

---現在選択中の表示名
---@type integer
local selectingNameState = Nameplate.CurrentName

---現在選択中の「部活名を表示するかどうか」
---@type boolean
local selectingShowClubName = Nameplate.ClubShown

---現在選択中のExスキルフレームのパーティクル量
---@type integer
local selectingExSkillFrameParticleAmount = ExSkill.FrameParticleAmount

---衣装変更アクションのタイトルを更新する。
local function refreshCostumeChangeActionTitle()
    if #Costume.CostumeList >= 2 then
        mainPage:getAction(1):title(Language:getTranslate("action_wheel__main__action_1__title").."§b"..Costume.getCostumeLocalName(selectingCostume))
    else
        mainPage:getAction(1):title("§7"..Language:getTranslate("action_wheel__main__action_1__title")..Costume.getCostumeLocalName(selectingCostume))
    end
end

---名前変更アクションのタイトルを更新する。
local function refreshNameChangeActionTitle()
    if selectingNameState >= 2 then
        if selectingShowClubName then
            mainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(selectingNameState).."\n§r"..Language:getTranslate("action_wheel__main__action_2__title_2").."§a"..Language:getTranslate("action_wheel__toggle_on"))
        else
            mainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(selectingNameState).."\n§r"..Language:getTranslate("action_wheel__main__action_2__title_2").."§c"..Language:getTranslate("action_wheel__toggle_off"))
        end
    else
        mainPage:getAction(2):title(Language:getTranslate("action_wheel__main__action_2__title").."§b"..Nameplate:getName(selectingNameState).."\n§7"..Language:getTranslate("action_wheel__main__action_2__title_2")..Language:getTranslate("action_wheel__toggle_"..(selectingShowClubName and "on" or "off")))
    end
end

---Exスキルアニメーションのパーティクル量調整アクションのタイトルを更新する。
local function refreshExSkillParticleActionTitle()
    mainPage:getAction(5):title(Language:getTranslate("action_wheel__main__action_5__title").."§b"..Language:getTranslate("action_wheel__main__action_5__option_"..selectingExSkillFrameParticleAmount))
end

--ping関数
function pings.action_wheel_main_action1_changeCostume(costumeId)
    if costumeId >= 2 then
        Costume:setCostume(costumeId)
    else
        Costume:resetCostume()
    end
end

function pings.action_wheel_main_action2_changeName(typeId, showClubName)
    Nameplate:setName(typeId, showClubName)
end

function pings.action_wheel_main_action3(toggled)
    Armor.ShowArmor = toggled
end

if host:isHost() then
    events.TICK:register(function()
        local actionWheelOpened = action_wheel:isEnabled()
        if not actionWheelOpened and actionWheelOpenedPrev then
            if selectingNameState ~= Nameplate.CurrentName or selectingShowClubName ~= Nameplate.ClubShown then
                pings.action_wheel_main_action2_changeName(selectingNameState, selectingShowClubName)
                Config.saveConfig("name", selectingNameState)
                Config.saveConfig("showClubName", selectingShowClubName)
                sounds:playSound("minecraft:ui.cartography_table.take_result", player:getPos())
                print(Language:getTranslate("action_wheel__main__action_2__done_first")..Nameplate:getName(selectingNameState)..Language:getTranslate("action_wheel__main__action_2__done_last"))
            end
            if selectingCostume ~= Costume.CurrentCostume then
                pings.action_wheel_main_action1_changeCostume(selectingCostume)
                Config.saveConfig("costume", selectingCostume)
                sounds:playSound("minecraft:item.armor.equip_leather", player:getPos())
                print(Language:getTranslate("action_wheel__main__action_1__done_first")..Costume.getCostumeLocalName(selectingCostume)..Language:getTranslate("action_wheel__main__action_1__done_last"))
            end
            if selectingExSkillFrameParticleAmount ~= ExSkill.FrameParticleAmount then
                ExSkill.FrameParticleAmount = selectingExSkillFrameParticleAmount
                Config.saveConfig("ex_skill_frame_particle_amount", selectingExSkillFrameParticleAmount)
                sounds:playSound("minecraft:entity.item.pickup", player:getPos(), 1, 0.5)
                print(Language:getTranslate("action_wheel__main__action_5__done_first")..Language:getTranslate("action_wheel__main__action_5__option_"..selectingExSkillFrameParticleAmount)..Language:getTranslate("action_wheel__main__action_5__done_last"))
            end
        end
        actionWheelOpenedPrev = actionWheelOpened
    end)

    --アクションの設定
    --アクション1. 衣装を変更
    mainPage:newAction(1):item("minecraft:leather_chestplate"):onScroll(function(direction)
        if #Costume.CostumeList >= 2 then
            if direction < 0 then
                selectingCostume = selectingCostume == #Costume.CostumeList and 1 or selectingCostume + 1
            else
                selectingCostume = selectingCostume == 1 and #Costume.CostumeList or selectingCostume - 1
            end
            refreshCostumeChangeActionTitle()
        else
            print(Language:getTranslate("action_wheel__main__action_1__unavailable"))
        end
    end):onLeftClick(function()
        if #Costume.CostumeList >= 2 then
            selectingCostume = Costume.CurrentCostume
            refreshCostumeChangeActionTitle()
        end
    end):onRightClick(function()
        if #Costume.CostumeList >= 2 then
            selectingCostume = 1
            refreshCostumeChangeActionTitle()
        end
    end)

    if #Costume.CostumeList >= 2 then
        mainPage:getAction(1):color(0.78, 0.78, 0.78):hoverColor(1, 1, 1)
    else
        mainPage:getAction(1):color(0.16, 0.16, 0.16):hoverColor(1, 0.33, 0.33)
    end

    --アクション2. 表示名の変更
    mainPage:newAction(2):item("minecraft:name_tag"):color(0.78, 0.78, 0.78):hoverColor(1, 1, 1):onScroll(function(direction)
        if direction < 0 then
            selectingNameState = selectingNameState == 6 and 1 or selectingNameState + 1
        else
            selectingNameState = selectingNameState == 1 and 6 or selectingNameState - 1
        end
        refreshNameChangeActionTitle()
    end):onLeftClick(function()
        selectingShowClubName = not selectingShowClubName
        refreshNameChangeActionTitle()
    end):onRightClick(function()
        selectingNameState = 1
        selectingShowClubName = false
        refreshNameChangeActionTitle()
    end)

    --アクション3. 防具の表示
    mainPage:newAction(3):title(Language:getTranslate("action_wheel__main__action_3__title").."§c"..Language:getTranslate("action_wheel__toggle_off")):toggleTitle(Language:getTranslate("action_wheel__main__action_3__title").."§a"..Language:getTranslate("action_wheel__toggle_on")):item("minecraft:iron_chestplate"):color(0.67, 0, 0):hoverColor(1, 0.33, 0.33):toggleColor(0, 0.67, 0):onToggle(function (_, action)
        pings.action_wheel_main_action3(true)
        action:hoverColor(0.33, 1, 0.33)
        Config.saveConfig("showArmor", true)
    end):onUntoggle(function(_, action)
        pings.action_wheel_main_action3(false)
        action:hoverColor(1, 0.33, 0.33)
        Config.saveConfig("showArmor", false)
    end)
    if Config.loadConfig("showArmor", false) then
        local action = mainPage:getAction(3)
        action:toggled(true)
        action:hoverColor(0.33, 1, 0.33)
    end

    --アクション4. 一人称視点での武器モデルの表示
    mainPage:newAction(4):title(Language:getTranslate("action_wheel__main__action_4__title").."§c"..Language:getTranslate("action_wheel__toggle_off")):toggleTitle(Language:getTranslate("action_wheel__main__action_4__title").."§a"..Language:getTranslate("action_wheel__toggle_on")):item("minecraft:bow"):color(0.67, 0, 0):hoverColor(1, 0.33, 0.33):toggleColor(0, 0.67, 0):onToggle(function (_, action)
        Gun.ShowWeaponInFirstPerson = true
        action:hoverColor(0.33, 1, 0.33)
        Config.saveConfig("firstPersonWeapon", true)
    end):onUntoggle(function (_, action)
        Gun.ShowWeaponInFirstPerson = false
        action:hoverColor(1, 0.33, 0.33)
        Config.saveConfig("firstPersonWeapon", false)
    end)
    if Config.loadConfig("firstPersonWeapon", true) then
        local action = mainPage:getAction(4)
        action:toggled(true)
        action:hoverColor(0.33, 1, 0.33)
    end

    --アクション5. Exスキルフレームのパーティクルの量
    mainPage:newAction(5):item("minecraft:glowstone_dust"):color(0.78, 0.78, 0.78):hoverColor(1, 1, 1):onScroll(function (direction)
        if direction < 0 then
            selectingExSkillFrameParticleAmount = selectingExSkillFrameParticleAmount == 3 and 1 or selectingExSkillFrameParticleAmount + 1
        else
            selectingExSkillFrameParticleAmount = selectingExSkillFrameParticleAmount == 1 and 3 or selectingExSkillFrameParticleAmount - 1
        end
        refreshExSkillParticleActionTitle()
    end):onLeftClick(function ()
        selectingExSkillFrameParticleAmount = ExSkill.FrameParticleAmount
        refreshExSkillParticleActionTitle()
    end):onRightClick(function ()
        selectingExSkillFrameParticleAmount = 1
        refreshExSkillParticleActionTitle()
    end)

    --アクション6. （空欄）

    --アクション7. （空欄）

    --アクション8. （空欄）

    refreshCostumeChangeActionTitle()
    refreshNameChangeActionTitle()
    refreshExSkillParticleActionTitle()

    action_wheel:setPage(mainPage)
end