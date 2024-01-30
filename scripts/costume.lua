---@class Costume キャラクターのコスチュームを管理し、円滑に切り替えられるようにするクラス
---@field CostumeList string[] 利用可能なコスチューム一覧。BlueArchiveCharacterクラスから動的に生成される。
---@field CurrentCostume integer 現在のコスチューム
Costume = {
	--変数
	CostumeList = {},
	CurrentCostume = Config.loadConfig("costume", 1),

	--関数
	---設定言語を考慮した、衣装の名前を返す。
	---@param costumeId integer ローカル名を取得する衣装のID
	---@return string localCostumeName 衣装のローカル名
	getCostumeLocalName = function(costumeId)
		return Language:getTranslate("costume__"..Costume.CostumeList[costumeId])
	end,

	---メインモデルのテクスチャのオフセット値を設定する。
	---@param offset integer オフセット値
	setCostumeTextureOffset = function(offset)
		for _, modelPart in ipairs(ModelUtils:getPlayerModels({"UpperBody.Body.Body", "UpperBody.Body.BodyLayer", "UpperBody.Arms.RightArm.RightArm", "UpperBody.Arms.RightArm.RightArmLayer", "UpperBody.Arms.RightArm.RightArmBottom.RightArmBottom", "UpperBody.Arms.RightArm.RightArmBottom.RightArmBottomLayer", "UpperBody.Arms.LeftArm.LeftArm", "UpperBody.Arms.LeftArm.LeftArmLayer", "UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottom", "UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer", "LowerBody.Legs.RightLeg.RightLeg", "LowerBody.Legs.RightLeg.RightLegLayer", "LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottom", "LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottomLayer", "LowerBody.Legs.LeftLeg.LeftLeg", "LowerBody.Legs.LeftLeg.LeftLegLayer", "LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottom", "LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottomLayer"})) do
			modelPart:setUVPixels(0, offset * 48)
		end
	end,

	---コスチュームを設定する。
	---@param costume integer 設定するコスチューム
	setCostume = function(self, costume)
		self:resetCostume()
		for index, name in ipairs(self.CostumeList) do
			models.models["skull_"..name].Skull:setVisible(index == costume)
		end
		BlueArchiveCharacter.COSTUME.callbacks.change(costume)
		self.CurrentCostume = costume
	end,

	---コスチュームをリセットし、デフォルトのコスチュームにする。
	resetCostume = function(self)
		if ExSkill ~= nil then
			ExSkill:forceStop()
		end
		self.setCostumeTextureOffset(0)
		BlueArchiveCharacter.COSTUME.callbacks.reset()
		models.models["skull_"..self.CostumeList[self.CurrentCostume]].Skull:setVisible(false)
		models.models.skull_default.Skull:setVisible(true)
		self.CurrentCostume = 1
	end
}

for name, _ in pairs(BlueArchiveCharacter.COSTUME.costumes) do
	table.insert(Costume.CostumeList, name)
end

if Costume.CurrentCostume >= 2 then
	Costume:setCostume(Costume.CurrentCostume)
end

return Costume