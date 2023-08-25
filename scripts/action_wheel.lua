---@class ActionWheel アクションホイールを管理するクラス
ActionWheel = {

}

---メインページのインスタンス
---@type Page
local mainPage = action_wheel:newPage()

action_wheel:setPage(mainPage)

--アクションの設定
--アクション1. Exスキル
mainPage:newAction(1):title(Language.getTranslate("action_wheel__main__title")):item("diamond"):onLeftClick(function ()
    ExSkill:play()
end)

return ActionWheel