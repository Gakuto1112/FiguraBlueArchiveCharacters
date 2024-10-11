---@class Costume キャラクターのコスチュームを管理し、円滑に切り替えられるようにするクラス
Costume = {
	---利用可能なコスチューム一覧。BlueArchiveCharacterクラスから動的に生成される。
	---@type string[]
	CostumeList = {},

	---現在のコスチューム
	---@type integer
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
		for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Body, models.models.main.Avatar.UpperBody.Body.BodyLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArm, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottom, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottomLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArm, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLeg, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottom, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottomLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottomLayer}) do
			modelPart:setUVPixels(0, offset * 48)
		end
	end,

	---コスチュームを設定する。
	---@param costume integer 設定するコスチューム
	setCostume = function(self, costume)
		self:resetCostume()
		BlueArchiveCharacter.COSTUME.callbacks.change(costume)
		HeadBlock.generateHeadBlockModel()
		Portrait.generatePortraitModel()
		self.CurrentCostume = costume
	end,

	---コスチュームをリセットし、デフォルトのコスチュームにする。
	resetCostume = function(self)
		if ExSkill ~= nil and ExSkill.TransitionCount > 0 then
			ExSkill:forceStop()
		end
		self.setCostumeTextureOffset(0)
		BlueArchiveCharacter.COSTUME.callbacks.reset()
		HeadBlock.generateHeadBlockModel()
		Portrait.generatePortraitModel()
		self.CurrentCostume = 1
	end,

	---初期化関数
	---@param self Costume
	init = function(self)
		for _, costume in ipairs(BlueArchiveCharacter.COSTUME.costumes) do
			table.insert(self.CostumeList, costume.name)
		end
		if self.CurrentCostume >= 2 then
			if self.CostumeList[self.CurrentCostume] ~= nil then
				self:setCostume(self.CurrentCostume)
			else
				self.CurrentCostume = 1
				if host:isHost() then
					Config.saveConfig("costume", 1)
				end
				HeadBlock.generateHeadBlockModel()
				Portrait.generatePortraitModel()
			end

		else
			HeadBlock.generateHeadBlockModel()
			Portrait.generatePortraitModel()
		end
	end
}

Costume:init()

return Costume