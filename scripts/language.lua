---@class Language アバターの表示言語を管理するクラス
---@field LanguageData { [string]: { [string]: string } } 言語データ
Language = {
	LanguageData = {
		en_us = {
			namepalte__club_name = "Festival Management Committee", --Club name
			costume__default = "Default",
			action_wheel__toggle_off = "off",
			action_wheel__toggle_on = "on",
			action_wheel__main__action_1__title = "Ex skill",
			action_wheel__main__action_1__title_2 = "Momoyado on-site service!", --Ex skill name
			action_wheel__main__action_1__unavailable = "You cannot do this now.",
			action_wheel__main__action_1__unavailable_firstperson = "You cannot do this in first person.",
			action_wheel__main__action_2__title = "Change costume: ",
			action_wheel__main__action_2__unavailable = "There is no costume available.",
			action_wheel__main__action_2__done_first = "Changed costume to§b",
			action_wheel__main__action_2__done_last = "§r.",
			action_wheel__main__action_3__title = "Change display name: ",
			action_wheel__main__action_3__title_2 = "Show club name: ",
			action_wheel__main__action_3__done_first = "Changed display name to§b",
			action_wheel__main__action_3__done_last = "§r.",
			action_wheel__main__action_4__title = "Show armors: ",
			action_wheel__main__action_5__title = "Show health bar: "
		},
		ja_jp = {
			namepalte__club_name = "お祭り運営委員会", --部活名
			costume__default = "デフォルト",
			action_wheel__toggle_off = "オフ",
			action_wheel__toggle_on = "オン",
			action_wheel__main__action_1__title = "Exスキル",
			action_wheel__main__action_1__title_2 = "百夜堂出張サービス！", --Exスキル名
			action_wheel__main__action_1__unavailable = "今は再生できません。",
			action_wheel__main__action_1__unavailable_firstperson = "一人称視点では再生できません。",
			action_wheel__main__action_2__title = "衣装を変更：",
			action_wheel__main__action_2__unavailable = "利用可能な衣装はありません。",
			action_wheel__main__action_2__done_first = "衣装を§b",
			action_wheel__main__action_2__done_last = "§rに変更しました。",
			action_wheel__main__action_3__title = "表示名を変更：",
			action_wheel__main__action_3__title_2 = "部活名を表示：",
			action_wheel__main__action_3__done_first = "表示名を§b",
			action_wheel__main__action_3__done_last = "§rに変更しました。",
			action_wheel__main__action_4__title = "防具を表示：",
			action_wheel__main__action_5__title = "HPバーを表示："
		}
	},

	---翻訳キーに対する訳文を返す。設定言語が存在しない場合は英語の文が返される。また、指定したキーの訳が無い場合は英語->キーそのままが返される。
	---@param keyName string 翻訳キー
	---@return string translatedString 翻訳キーに対する翻訳データ。設定言語での翻訳が存在しない場合は英文が返される。英文すら存在しない場合は翻訳キーがそのまま返される。
	getTranslate = function(self, keyName)
		local activeLanguage = client:getActiveLang()
		return (self.LanguageData[activeLanguage] and self.LanguageData[activeLanguage][keyName]) and self.LanguageData[activeLanguage][keyName] or (self.LanguageData["en_us"][keyName] and self.LanguageData["en_us"][keyName] or keyName)
	end
}

return Language