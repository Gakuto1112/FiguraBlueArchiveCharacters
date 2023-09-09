---@class Costume キャラクターのコスチュームを管理し、円滑に切り替えられるようにするクラス
---@field COSTUME_LIST table<string> 利用可能なコスチュームのリスト
---@field CurrentCostume integer 現在のコスチューム
Costume = {
	--定数
	COSTUME_LIST = {"default"},

	--変数
	CurrentCostume = Config:loadConfig("costume", 1),

	--関数
	---設定言語を考慮した、衣装の名前を返す。
	---@param costumeId integer ローカル名を取得する衣装のID
	---@return string localCostumeName 衣装のローカル名
	getCostumeLocalName = function(self, costumeId)
		return Language:getTranslate("costume__"..self.COSTUME_LIST[costumeId])
	end,

	---メインモデルのテクスチャのオフセット値を設定する。
	---@param offset integer オフセット値
	setCostumeTextureOffset = function(self, offset)
		for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Body, models.models.main.Avatar.UpperBody.Body.BodyLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArm, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmLayer, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottom, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightArmBottomLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArm, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmLayer, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftArmBottomLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLeg, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegLayer, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottom, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.RightLegBottomLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegLayer, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.LeftLegBottomLayer}) do
			modelPart:setUVPixels(0, offset * 48)
		end
	end,

	---コスチュームを設定する。
	---@param costume integer 設定するコスチューム
	setCostume = function(self, costume)
		self:resetCostume()
		self.CurrentCostume = costume
	end,

	---コスチュームをリセットし、デフォルトのコスチュームにする。
	resetCostume = function(self)
		self:setCostumeTextureOffset(0)
		Costume.CurrentCostume = 1
	end,

	---防具が更新された時にArmorから呼び出される関数
	---@param armorIndex integer 防具のインデックス: 1. ヘルメット, 2. チェストプレート, 3. レギンス, 4. ブーツ
	onArmorChenge = function(self, armorIndex)
		if armorIndex == 1 then
			if Armor.ArmorVisible[1] then
				for _, modelPart in ipairs({models.models.main.Avatar.Head.Brim, models.models.main.Avatar.Head.HairTails}) do
					modelPart:setVisible(false)
				end
			else
				for _, modelPart in ipairs({models.models.main.Avatar.Head.Brim, models.models.main.Avatar.Head.HairTails}) do
					modelPart:setVisible(true)
				end
			end
		elseif armorIndex == 2 then
			if Armor.ArmorVisible[2] then
				models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(false)
				models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -1)
				models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 1)
				Physics.PHYSICS_DATA[1].x.vertical.neutral = 0
				Physics.PHYSICS_DATA[1].x.vertical.max = 0
				Physics.PHYSICS_DATA[1].x.vertical.bodyX.max = 0
				Physics.PHYSICS_DATA[1].x.vertical.bodyY.max = 0
				Physics.PHYSICS_DATA[1].x.vertical.bodyRot.max = 0
				Physics.PHYSICS_DATA[1].x.horizontal.neutral = 0
				Physics.PHYSICS_DATA[1].x.horizontal.max = 0
			else
				models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(true)
				for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair, models.models.main.Avatar.UpperBody.Body.Hairs.BackHair}) do
					modelPart:setPos()
				end
				Physics.PHYSICS_DATA[1].x.vertical.neutral = -10
				Physics.PHYSICS_DATA[1].x.vertical.max = -10
				Physics.PHYSICS_DATA[1].x.vertical.bodyX.max = -10
				Physics.PHYSICS_DATA[1].x.vertical.bodyY.max = -10
				Physics.PHYSICS_DATA[1].x.vertical.bodyRot.max = -10
				Physics.PHYSICS_DATA[1].x.horizontal.neutral = -10
				Physics.PHYSICS_DATA[1].x.horizontal.max = -10
			end
		end
	end
}

if Costume.CurrentCostume >= 2 then
	Costume:setCostume(Costume.CurrentCostume)
end

return Costume