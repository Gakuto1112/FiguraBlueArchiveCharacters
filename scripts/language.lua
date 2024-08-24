---@class Language アバターの表示言語を管理するクラス
---@field LanguageData { [string]: { [string]: string } } 言語データ
Language = {
	LanguageData = {
		en_us = {
			avatar__old_version_warning = "For the best experience, playing with 1.20.1 or higher is recommended!",
			action_wheel__toggle_off = "off",
			action_wheel__toggle_on = "on",
			action_wheel__main__action_1__title = "Change costume: ",
			action_wheel__main__action_1__unavailable = "There is no costume available.",
			action_wheel__main__action_1__done_first = "Changed costume to §b",
			action_wheel__main__action_1__done_last = "§r.",
			action_wheel__main__action_2__title = "Change display name: ",
			action_wheel__main__action_2__title_2 = "Show club name: ",
			action_wheel__main__action_2__done_first = "Changed display name to §b",
			action_wheel__main__action_2__done_last = "§r.",
			action_wheel__main__action_3__title = "Show armors: ",
			action_wheel__main__action_4__title = "Show weapon models in first person: ",
			action_wheel__main__action_5__title = "Amount of particles in Ex skill frame: ",
			action_wheel__main__action_5__option_1 = "Standard",
			action_wheel__main__action_5__option_2 = "Minimum",
			action_wheel__main__action_5__option_3 = "None",
			action_wheel__main__action_5__option_4 = "Hide Ex skill frame",
			action_wheel__main__action_5__done_first = "Changed amount of particles in Ex skill frame to§b",
			action_wheel__main__action_5__done_last = "§r.",
			action_wheel__main__action_6__title = "Replace vehicle models: ",
			action_wheel__main__action_6__unavailable = "This option is unavailable for this character.",
			action_wheel_gui__bubble_guide__title = "§0Bubble emote guide",
			action_wheel_gui__ex_skill_guide__title = "§0Ex skill guide",
			action_wheel_gui__ex_skill_guide__key_pre = "Press \"",
			action_wheel_gui__ex_skill_guide__key_post = "\"key to play",
			key_name__ex_skill = "Ex skill",
			key_name__bubble_1 = "Bubble: Good",
			key_name__bubble_2 = "Bubble: Heart",
			key_name__bubble_3 = "Bubble: Note",
			key_name__bubble_4 = "Bubble: Question",
			key_name__bubble_5 = "Bubble: Sweat",
			key_bind__ex_skill__unavailable = "You cannot do this now.",
			key_bind__ex_skill__unavailable_firstperson = "You cannot do this in first person.",
		},
		ja_jp = {
			avatar__old_version_warning = "生徒さんとより良い時間を過ごすためにバージョン1.20.1以上でのプレイをおすすめします！",
			action_wheel__toggle_off = "オフ",
			action_wheel__toggle_on = "オン",
			action_wheel__main__action_1__title = "衣装を変更：",
			action_wheel__main__action_1__unavailable = "利用可能な衣装はありません。",
			action_wheel__main__action_1__done_first = "衣装を§b",
			action_wheel__main__action_1__done_last = "§rに変更しました。",
			action_wheel__main__action_2__title = "表示名を変更：",
			action_wheel__main__action_2__title_2 = "部活名を表示：",
			action_wheel__main__action_2__done_first = "表示名を§b",
			action_wheel__main__action_2__done_last = "§rに変更しました。",
			action_wheel__main__action_3__title = "防具を表示：",
			action_wheel__main__action_4__title = "一人称視点で武器モデルを表示：",
			action_wheel__main__action_5__title = "Exスキルフレームのパーティクルの量：",
			action_wheel__main__action_5__option_1 = "標準",
			action_wheel__main__action_5__option_2 = "少なめ",
			action_wheel__main__action_5__option_3 = "なし",
			action_wheel__main__action_5__option_4 = "スキルフレーム非表示",
			action_wheel__main__action_5__done_first = "Exスキルフレームのパーティクルの量を§b",
			action_wheel__main__action_5__done_last = "§rに変更しました。",
			action_wheel__main__action_6__title = "乗り物のモデルを置き換え：",
			action_wheel__main__action_6__unavailable = "この生徒さんでは利用できません。",
			action_wheel_gui__bubble_guide__title = "§0吹き出しエモートガイド",
			action_wheel_gui__ex_skill_guide__title = "§0Exスキルガイド",
			action_wheel_gui__ex_skill_guide__key_pre = "\"",
			action_wheel_gui__ex_skill_guide__key_post = "\"キーで再生",
			key_name__ex_skill = "Exスキル",
			key_name__bubble_1 = "吹き出し：いいね",
			key_name__bubble_2 = "吹き出し：ハート",
			key_name__bubble_3 = "吹き出し：音符",
			key_name__bubble_4 = "吹き出し：はてな",
			key_name__bubble_5 = "吹き出し：汗",
			key_bind__ex_skill__unavailable = "今は再生できません。",
			key_bind__ex_skill__unavailable_firstperson = "一人称視点では再生できません。",
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

Language.LanguageData.en_us["namepalte__club_name"] = BlueArchiveCharacter.BASIC.clubName.en_us
Language.LanguageData.ja_jp["namepalte__club_name"] = BlueArchiveCharacter.BASIC.clubName.ja_jp
if host:isHost() then
	for index, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
		Language.LanguageData.en_us["action_wheel_gui__ex_skill_guide__ex_skill_"..index.."__name"] = exSkill.name.en_us
		Language.LanguageData.ja_jp["action_wheel_gui__ex_skill_guide__ex_skill_"..index.."__name"] = exSkill.name.ja_jp
	end
	for _, costume in ipairs(BlueArchiveCharacter.COSTUME.costumes) do
		Language.LanguageData.en_us["costume__"..costume.name] = costume.display_name.en_us
		Language.LanguageData.ja_jp["costume__"..costume.name] = costume.display_name.ja_jp
	end
end

return Language