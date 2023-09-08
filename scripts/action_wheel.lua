---攻撃属性
---@alias ActionWheel.AttackType
---| "EXPLOSION" 爆発
---| "PIERCE" 貫通
---| "MYSTERY" 神秘
---| "VIBRATION" 振動

---@class ActionWheel アクションホイールを管理するクラス

---メインページのインスタンス
---@type Page
local mainPage = action_wheel:newPage()

---生徒の攻撃属性
---@type ActionWheel.AttackType
local attackType = "MYSTERY"

--ping関数
function pings.action_wheel_main_action1()
    ExSkill:play()
end

events.TICK:register(function()
    if action_wheel:isEnabled() then
        --EXスキルが再生可能か確認
        if ExSkill:canPlayAnimation() and ExSkill.AnimationCount == -1 then
            mainPage:getAction(1):title(Language:getTranslate("action_wheel__main__action_1__title").."\n§b"..Language:getTranslate("action_wheel__main__action_1__title_2")):color(attackType == "EXPLOSION" and vectors.vec3(0.55, 0, 0.03) or (attackType == "PIERCE" and vectors.vec3(0.72, 0.55, 0.2) or (attackType == "MYSTERY" and vectors.vec3(0.16, 0.43, 0.6) or vectors.vec3(0.58, 0.28, 0.64)))):hoverColor(1, 1, 1)
        else
            mainPage:getAction(1):title("§7"..Language:getTranslate("action_wheel__main__action_1__title").."\n"..Language:getTranslate("action_wheel__main__action_1__title_2")):color(0.16, 0.16, 0.16):hoverColor(1, 0.33, 0.33)
        end
    end
end)

--アクションの設定
--アクション1. Exスキル
mainPage:newAction(1):item("diamond"):onLeftClick(function ()
    if ExSkill:canPlayAnimation() and ExSkill.AnimationCount == -1 then
        pings.action_wheel_main_action1()
    elseif renderer:isFirstPerson() then
        print(Language:getTranslate("action_wheel__main__action_1__unavailable_firstperson"))
    else
        print(Language:getTranslate("action_wheel__main__action_1__unavailable"))
    end
end)

action_wheel:setPage(mainPage)