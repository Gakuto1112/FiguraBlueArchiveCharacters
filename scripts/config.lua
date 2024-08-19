---@class Config アバター設定を管理するクラス
---@field DefaultValues table<any> 読み込んだ値のデフォルト値を保持するテーブル
Config = {
	--変数
	DefaultValues = {},

	--関数
	---設定を読み出す
	---@param keyName string 読み出す設定の名前
	---@param defaultValue any 該当の設定が無い場合や、ホスト外での実行の場合はこの値が返される。
	---@return any data 読み出した値
	loadConfig = function (keyName, defaultValue)
		if host:isHost() then
			local data = config:load(keyName)
			Config.DefaultValues[keyName] = defaultValue
			if data ~= nil then
				return data
			else
				return defaultValue
			end
		else
			return defaultValue
		end
	end,

	---設定を保存する
	---@param keyName string 保存する設定の名前
	---@param value any 保存する値
	saveConfig = function (keyName, value)
		if host:isHost() then
			if Config.DefaultValues[keyName] == value then
				config:save(keyName, nil)
			else
				config:save(keyName, value)
			end
		end
	end
}

---アバターの設定がホストと同期されたかどうか
---@type boolean
local isSynced = host:isHost()

---次の同期pingまでのカウンター
---@type integer
local nextSyncCount = 0

--ping関数
---アバター設定を他Figuraクライアントと同期する。
---@param nameTypeId integer 表示名の種類ID
---@param showClubName boolean 部活名を表示するかどうか
---@param costumeId integer 現在の衣装ID
---@param isArmorShown boolean 防具が見えているかどうか
---@param isChatOpened boolean チャット欄を開いているかどうか
function pings.syncAvatarConfig(nameTypeId, showClubName, costumeId, isArmorShown, isChatOpened)
	if not isSynced then
		Nameplate:setName(nameTypeId, showClubName)
		Armor.ShowArmor = isArmorShown
		Bubble.IsChatOpened = isChatOpened
		if costumeId >= 2 then
			Costume:setCostume(costumeId)
		end
		isSynced = true
	end
end

if host:isHost() then
	config:setName("BlueArchive_"..BlueArchiveCharacter.BASIC.firstName.en_us..BlueArchiveCharacter.BASIC.lastName.en_us)
	events.TICK:register(function ()
		if nextSyncCount == 0 then
			pings.syncAvatarConfig(Nameplate.CurrentName, Nameplate.ClubShown, Costume.CurrentCostume, Armor.ShowArmor, Bubble.IsChatOpened)
			nextSyncCount = 300
		else
			nextSyncCount = nextSyncCount - 1
		end
	end)
end

return Config