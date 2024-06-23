---防具の部位
---@alias Armor.ArmorPart
---| "HELMET" ヘルメット
---| "CHEST_PLATE" チェストプレート
---| "LEGGINGS" レギンス
---| "BOOTS" ブーツ

---@class Armor 防具の表示を制御するクラス
Armor = {
	---防具を表示するかどうか
	---@type boolean
	ShowArmor = Config.loadConfig("showArmor", false),

	---前ティックの防具スロットのアイテム
	---@type ItemStack[]
	ArmorSlotItemsPrev = {world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air")},

	---各防具の部位（ヘルメット、チェストプイート、レギンス、ブーツ）が可視状態かどうか。
	---@type boolean[]
	ArmorVisible = {false, false, false, false},

	---テクスチャ処理のキュー
	--[[
		各キューデータの中身
		{
			texture: 処理するテクスチャ
			palette: 使用するパレットのテクスチャ
			iterationCount: 現在の繰り返しカウント
		}
	]]
	---@type table[]
	TextureQueue = {},

	---防具の色を取得する。
	---@param armorItem ItemStack 調べるアイテムのオブジェクト
	---@return number color 防具モデルに設定すべき色
	getArmorColor = function (armorItem)
		if armorItem.id:find("^minecraft:leather_") then
			if armorItem.tag then
				if armorItem.tag.display then
					return armorItem.tag.display.color and armorItem.tag.display.color or 10511680
				else
					return 10511680
				end
			else
				return 10511680
			end
		else
			return 16777215
		end
	end,

	---防具装飾が同じものか比較する。
	---@param trim1 table|nil 比較する防具装飾のテーブル1
	---@param trim2 table|nil 比較する防具装飾のテーブル2
	---@return boolean isTrimSame 2つの防具装飾が同じものかどうか
	compareTrims = function (trim1, trim2)
		if type(trim1) == type(trim2) then
			if trim1 then
				if trim1.pattern ~= trim2.pattern then
					return false
				elseif trim1.material ~= trim2.material then
					return false
				else
					return true
				end
			else
				return true
			end
		else
			return false
		end
	end,

	---テクスチャの処理のキューにデータを挿入する。
	---@param self Armor
	---@param texture Texture 処理を行うテクスチャ
	---@param paletteName string 使用するパレットの名前
	addTextureQueue = function (self, texture, paletteName)
		if textures["trim_palette_"..paletteName] == nil then
			textures:fromVanilla("trim_palette_"..paletteName, "minecraft:textures/trims/color_palettes/"..paletteName..".png")
		end
		table.insert(self.TextureQueue, 1, {
			texture = texture,
			palette = textures["trim_palette_"..paletteName],
			iterationCount = 0
		})
	end,


	---バニラパーツの防具装飾のテクスチャを取得する。テクスチャの処理は次のチック以降行われる。
	---@param self Armor
	---@param trimData table? 防具装飾のデータ
	---@param armorId string 防具アイテムのID。
	---@param tailArmor boolean 尻尾防具用の装飾のテクスチャを取得するならtrueにする。
	---@return Texture? trimTexture 色を付けた防具装飾のテクスチャ。防具や防具装飾が非バニラの場合はnilを返す。
	getTrimTexture = function(self, trimData, armorId, tailArmor)
		if trimData and trimData.pattern:find("^minecraft:.+$") and trimData.material:find("^minecraft:.+$") and armorId:find("^minecraft:.+_.+$") then
			local normalizedPatternName = trimData.pattern:match("^minecraft:(%a+)$")
			local normalizedArmorMaterialName = armorId:match("^minecraft:(%a+)_.+$")
			normalizedArmorMaterialName = normalizedArmorMaterialName == "golden" and "gold" or normalizedArmorMaterialName
			local normalizedMaterialName = trimData.material:match("^minecraft:(%a+)$")
			normalizedMaterialName = normalizedMaterialName..(normalizedArmorMaterialName == normalizedMaterialName and "_darker" or "")
			local isLeggings = armorId:find("^minecraft:.+_leggings$")
			local textureName = "trim_"..normalizedPatternName.."_"..normalizedMaterialName..(tailArmor and "_tail" or (isLeggings and "_leggings" or ""))
			if textures[textureName] then
				return textures[textureName]
			else
				local texture = tailArmor and textures:copy(textureName, textures["textures.armor_trims."..normalizedPatternName]) or textures:fromVanilla(textureName, "minecraft:textures/trims/models/armor/"..normalizedPatternName..(armorId:find("^minecraft:.+_leggings$") ~= nil and "_leggings" or "")..".png")
				self:addTextureQueue(texture, normalizedMaterialName)
				return texture
			end
		end
	end,

	---ヘルメットを更新する。
	---@param self Armor
	---@param helmet ItemStack ヘルメットスロットに入っているアイテムスタック
	setHelmet = function (self, helmet)
		local helmetFound = helmet.id:find("^minecraft:.+_helmet$") ~= nil
		models.models.main.Avatar.Head.ArmorH:setVisible(helmetFound)
		self.ArmorVisible[1] = helmetFound
		if helmetFound then
			local material = helmet.id:match("^minecraft:(%a+)_helmet$")
			models.models.main.Avatar.Head.ArmorH.Helmet.Helmet:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
		end
		models.models.main.Avatar.Head.ArmorH.Helmet.HelmetOverlay:setVisible(helmet.id == "minecraft:leather_helmet")
		BlueArchiveCharacter.COSTUME.callbacks.armorChange("HELMET")
	end,

	---チェストプレートを更新する。
	---@param self Armor
	---@param chestplate ItemStack チェストプレートスロットに入っているアイテムスタック
	setChestPlate = function (self, chestplate)
		local chestplateFound = chestplate.id:find("^minecraft:.+_chestplate$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB}) do
			armorPart:setVisible(chestplateFound)
		end
		self.ArmorVisible[2] = chestplateFound
		if chestplateFound then
			local material = chestplate.id:match("^minecraft:(%a+)_chestplate$")
			for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = chestplate.id == "minecraft:leather_chestplate"
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		BlueArchiveCharacter.COSTUME.callbacks.armorChange("CHEST_PLATE")
	end,

	---レギンスを更新する。
	---@param self Armor
	---@param leggings ItemStack レギンススロットに入っているアイテムスタック
	setLeggings = function (self, leggings)
		local leggingsFound = leggings.id:find("^minecraft:.+_leggings$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
			armorPart:setVisible(leggingsFound)
		end
		self.ArmorVisible[3] = leggingsFound
		if leggingsFound then
			local material = leggings.id:match("^minecraft:(%a+)_leggings$")
			for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_2.png")
			end
		end
		local overlayVisible = leggings.id == "minecraft:leather_leggings"
		for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		BlueArchiveCharacter.COSTUME.callbacks.armorChange("LEGGINGS")
	end,

	---ブーツを更新する。
	---@param self Armor
	---@param boots ItemStack ブーツスロットに入っているアイテムスタック
	setBoots = function (self, boots)
		local bootsFound = boots.id:find("^minecraft:.+_boots$") ~= nil
		for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom}) do
			armorPart:setVisible(bootsFound)
		end
		self.ArmorVisible[4] = bootsFound
		if bootsFound then
			local material = boots.id:match("^minecraft:(%a+)_boots$")
			for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
				armorPart:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/"..(material == "golden" and "gold" or material).."_layer_1.png")
			end
		end
		local overlayVisible = boots.id == "minecraft:leather_boots"
		for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			armorPart:setVisible(overlayVisible)
		end
		BlueArchiveCharacter.COSTUME.callbacks.armorChange("BOOTS")
	end,

	---初期化処理
	---@param self Armor
	init = function (self)
		events.TICK:register(function ()
			local armorSlotItems = self.ShowArmor and {player:getItem(6), player:getItem(5), player:getItem(4), player:getItem(3)} or {world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air"), world.newItem("minecraft:air")}
			if armorSlotItems[1].id ~= self.ArmorSlotItemsPrev[1].id then
				self:setHelmet(armorSlotItems[1])
			end
			if armorSlotItems[2].id ~= self.ArmorSlotItemsPrev[2].id then
				self:setChestPlate(armorSlotItems[2])
			end
			if armorSlotItems[3].id ~= self.ArmorSlotItemsPrev[3].id then
				self:setLeggings(armorSlotItems[3])
			end
			if armorSlotItems[4].id ~= self.ArmorSlotItemsPrev[4].id then
				self:setBoots(armorSlotItems[4])
			end

			for index, armorSlotItem in ipairs(armorSlotItems) do
				local glint = armorSlotItem:hasGlint()
				if glint ~= self.ArmorSlotItemsPrev[index]:hasGlint() then
					--エンチャント変更
					local renderType = glint and "GLINT" or "NONE"
					if index == 1 then
						models.models.main.Avatar.Head.ArmorH.Helmet:setSecondaryRenderType(renderType)
					elseif index == 2 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					else
						for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom}) do
							armorPart:setSecondaryRenderType(renderType)
						end
					end
				end
				local armorColor = self.getArmorColor(armorSlotItem)
				if armorColor ~= self.getArmorColor(self.ArmorSlotItemsPrev[index]) then
					--色変更
					local colorVector = vectors.intToRGB(armorColor)
					if index == 1 then
						models.models.main.Avatar.Head.ArmorH.Helmet.Helmet:setColor(colorVector)
					elseif index == 2 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.Chestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplate, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplate, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottom}) do
							armorPart:setColor(colorVector)
						end
					elseif index == 3 then
						for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.Leggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggings, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggings, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottom}) do
							armorPart:setColor(colorVector)
						end
					else
						for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBoots, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottom, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBoots, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottom}) do
							armorPart:setColor(colorVector)
						end
					end
				end
				local trim = armorSlotItems[index].tag.Trim
				if not self.compareTrims(trim, self.ArmorSlotItemsPrev[index].tag.Trim) then
					--トリム変更
					if index == 1 then
						local trimTexture = self:getTrimTexture(trim, armorSlotItems[1].id, false)
						if trimTexture then
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setVisible(true)
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setPrimaryTexture("CUSTOM", trimTexture)
						else
							models.models.main.Avatar.Head.ArmorH.Helmet.HelmetTrim:setVisible(false)
						end
					elseif index == 2 then
						local trimTexture = self:getTrimTexture(trim, armorSlotItems[2].id, false)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateTrim, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateTrim, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					elseif index == 3 then
						local trimTexture = self:getTrimTexture(trim, armorSlotItems[3].id, false)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					else
						local trimTexture = self:getTrimTexture(trim, armorSlotItems[4].id, false)
						if trimTexture then
							for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
								armorPart:setVisible(true)
								armorPart:setPrimaryTexture("CUSTOM", trimTexture)
							end
						else
							for _, armorPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsTrim, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsTrim, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomTrim}) do
								armorPart:setVisible(false)
							end
						end
					end
				end
			end
			--テクスチャの作成処理
			if #self.TextureQueue > 0 then
				local instructionsAvailable = avatar:getMaxTickCount() - 3000 --このTICKで使用出来る残りの命令数
				while #self.TextureQueue > 0 and instructionsAvailable > 0 do
					local dimension = self.TextureQueue[1].texture:getDimensions()
					for y = math.floor(self.TextureQueue[1].iterationCount / dimension.x), dimension.y - 1 do
						for x = self.TextureQueue[1].iterationCount % dimension.x, dimension.x - 1 do
							local pixel = self.TextureQueue[1].texture:getPixel(x, y)
							if pixel.w == 1 then
								self.TextureQueue[1].texture:setPixel(x, y, self.TextureQueue[1].palette:getPixel(7 - math.floor(pixel.x * 8), 0))
							end
							self.TextureQueue[1].iterationCount = self.TextureQueue[1].iterationCount + 1
							instructionsAvailable = instructionsAvailable - 45
							if instructionsAvailable <= 0 then
								break
							end
						end
						if instructionsAvailable <= 0 then
							break
						end
					end
					self.TextureQueue[1].texture:update()
					if self.TextureQueue[1].iterationCount == dimension.x * dimension.y then
						table.remove(self.TextureQueue, 1)
					end
				end
			end
			self.ArmorSlotItemsPrev = armorSlotItems
		end)
		for _, overlayPart in ipairs({models.models.main.Avatar.Head.ArmorH.Helmet.HelmetOverlay, models.models.main.Avatar.UpperBody.Body.ArmorB.Chestplate.ChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.ArmorRA.RightChestplate.RightChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ArmorRAB.RightChestplateBottom.RightChestplateBottomOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.ArmorLA.LeftChestplate.LeftChestplateOverlay, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.ArmorLAB.LeftChestplateBottom.LeftChestplateBottomOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightBoots.RightBootsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightBootsBottom.RightBootsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftBoots.LeftBootsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftBootsBottom.LeftBootsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/leather_layer_1_overlay.png")
		end
		for _, overlayPart in ipairs({models.models.main.Avatar.UpperBody.Body.ArmorB.Leggings.LeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.ArmorRL.RightLeggings.RightLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.RightLeg.RightLegBottom.ArmorRLB.RightLeggingsBottom.RightLeggingsBottomOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.ArmorLL.LeftLeggings.LeftLeggingsOverlay, models.models.main.Avatar.LowerBody.Legs.LeftLeg.LeftLegBottom.ArmorLLB.LeftLeggingsBottom.LeftLeggingsBottomOverlay}) do
			overlayPart:setPrimaryTexture("RESOURCE", "minecraft:textures/models/armor/leather_layer_2_overlay.png")
		end
	end
}

Armor:init()

return Armor