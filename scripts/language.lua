---@class Language アバターの表示言語を管理するクラス
---@field LanguageData { [string]: { [string]: string } } 言語データ
Language = {
	LanguageData = {
		en_us = {
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
			action_wheel__main__action_4__title = "Accuracy of camera during ex skill animations: ",
			action_wheel__main__action_4__option_1 = "Standard",
			action_wheel__main__action_4__option_2 = "High",
			action_wheel__main__action_4__option_3 = "Very high",
			action_wheel__main__action_4__option_4 = "Ultra high",
			action_wheel__main__action_4__done_first = "Changed camera accuracy during ex skill animations to §b",
			action_wheel__main__action_4__done_last = "§r.",
			action_wheel_gui__bubble_guide__title = "§0Bubble emote guide",
			action_wheel_gui__ex_skill_guide__title = "§0Ex skill guide",
			action_wheel_gui__ex_skill_guide__key_pre = "Press \"",
			action_wheel_gui__ex_skill_guide__key_post = "\"key to play",
			key_name__ex_skill = "Ex skill",
			key_name__bubble_up = "Bubble: Good",
			key_name__bubble_right = "Bubble: Heart",
			key_name__bubble_down = "Bubble: Reload ammo",
			key_name__bubble_left = "Bubble: Question",
			key_bind__ex_skill__unavailable = "You cannot do this now.",
			key_bind__ex_skill__unavailable_firstperson = "You cannot do this in first person.",
		},
		ja_jp = {
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
			action_wheel__main__action_4__title = "Exスキルアニメーション中のカメラ精度：",
			action_wheel__main__action_4__option_1 = "標準",
			action_wheel__main__action_4__option_2 = "やや高い",
			action_wheel__main__action_4__option_3 = "高い",
			action_wheel__main__action_4__option_4 = "非常に高い",
			action_wheel__main__action_4__done_first = "Exスキルアニメーション中のカメラの精度を§b",
			action_wheel__main__action_4__done_last = "§rに変更しました。",
			action_wheel_gui__bubble_guide__title = "§0吹き出しエモートガイド",
			action_wheel_gui__ex_skill_guide__title = "§0Exスキルガイド",
			action_wheel_gui__ex_skill_guide__key_pre = "\"",
			action_wheel_gui__ex_skill_guide__key_post = "\"キーで再生",
			key_name__ex_skill = "Exスキル",
			key_name__bubble_up = "吹き出し：いいね",
			key_name__bubble_right = "吹き出し：ハート",
			key_name__bubble_down = "吹き出し：弾薬補充",
			key_name__bubble_left = "吹き出し：はてな",
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
	for name, costume in pairs(BlueArchiveCharacter.COSTUME.costumes) do
		Language.LanguageData.en_us["costume__"..name] = costume.name.en_us
		Language.LanguageData.ja_jp["costume__"..name] = costume.name.ja_jp
	end
end

return Language