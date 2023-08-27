---@class Language アバターの表示言語を管理するクラス
---@field LanguageData { [string]: { [string]: string } } 言語データ
Language = {
	LanguageData = {
		en_us = {
			action_wheel__main__title = "Ex skill"
		},
		ja_jp = {
			action_wheel__main__title = "Exスキル"
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