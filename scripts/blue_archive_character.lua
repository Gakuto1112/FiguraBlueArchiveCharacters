---@class BlueArchiveCharacter （今後別のキャラを作る時に備えて、）キャラクター変数を保持するクラス。別のキャラクターに対してもここを変更するだけで対応できるようにする。
---@field FIRST_NAME_EN string 生徒の名前（英語）
---@field LAST_NAME_EN string 生徒の苗字（英語）
---@field FIRST_NAME_JP string 生徒の名前（日本語）
---@field LAST_NAME_JP string 生徒の苗字（日本語）
---@field BIRTH_MONTH integer 生徒の誕生月
---@field BIRTH_DAY integer 生徒の誕生日
---@field HEAD_RING_NEUTRAL_ROT number 通常時の輪っかの角度
---@field COSTUME table 衣装のデータ: name. 衣装の内部名, ex_skill. 衣装に対応するExスキルのインデックス番号
---@field PHYSICS table 物理演算で動かすモデルパーツのテーブル
---@field EX_SKILL table Exスキルのデータ: nameEN. 英語でのExスキル名, nameJP. 日本語でのExスキル名, models. アニメーションの前後で表示/非表示にするモデルのテーブル, animations. Exスキルのアニメーションが含まれるbbmodelファイル名, cameraStartPos. アニメーション開始時のカメラの位置, cameraStartRot. アニメーション開始時のカメラの向き, cameraEndPos. アニメーション終了時のカメラの位置, cameraEndRot. アニメーション終了時のカメラの向き, preAnimationCallback. , animationTick. アニメーション再生時のみ呼び出されるティック関数, postAnimationCallback. アニメーション終了後に呼び出されるコールバック関数
---@field EX_SKILL_1_TEXT_1 TextTask Exスキル1で使用するテキストタスク
BlueArchiveCharacter = {
	--基本
    FIRST_NAME_EN = "Shizuko",
    LAST_NAME_EN = "Kawawa",
    FIRST_NAME_JP = "シズコ",
    LAST_NAME_JP = "河和",
    BIRTH_MONTH = 7,
    BIRTH_DAY = 7,

    --頭の輪っか
    HEAD_RING_NEUTRAL_ROT = 30,

	--コスチューム
	COSTUME = {
		{
			name = "default",
			ex_skill = 1
		},
		{
			name = "swimsuit",
			ex_skill = 2
		}
	},
    COSTUME_CHANGE_CALLBACK = function(self, costumeId)
        if costumeId == 2 then
			--水着
			Costume:setCostumeTextureOffset(1)
			for _, modelPart in ipairs({models.models.main.Avatar.Head.Brim, models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Body.Hairs, models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeveTop, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightSleeveBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeveTop, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftSleeveBottom}) do
				modelPart:setVisible(false)
			end
			models.models.main.Avatar.Head.CSwimsuitH:setVisible(true)
			for _, modelPart in ipairs({models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
				modelPart:setVisible(not Armor.ArmorVisible[1])
			end
		end
    end,
    COSTUME_RESET_CALLBACK = function(self)
		models.models.main.Avatar.Head.Brim:setVisible(not Armor.ArmorVisible[1])
		models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[2])
		for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs, models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeveTop, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightSleeveBottom, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeveTop, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftSleeveBottom}) do
			modelPart:setVisible()
		end
		models.models.main.Avatar.Head.CSwimsuitH:setVisible(false)
    end,
    ARMOR_CHANGE_CALLBACK = function(self, armorIndex)
        if armorIndex == 1 then
			if Armor.ArmorVisible[1] then
				for _, modelPart in ipairs({models.models.main.Avatar.Head.Brim, models.models.main.Avatar.Head.HairTails, models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
					modelPart:setVisible(false)
				end
			else
				models.models.main.Avatar.Head.HairTails:setVisible(true)
				if self.CurrentCostume == 1 then
					models.models.main.Avatar.Head.Brim:setVisible(true)
				elseif self.CurrentCostume == 2 then
					for _, modelPart in ipairs({models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
						modelPart:setVisible(true)
					end
				end
			end
		elseif armorIndex == 2 then
			if Armor.ArmorVisible[2] then
				models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(false)
				models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -1)
				models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 1)
				self.PHYSICS[1].x.vertical.neutral = 0
				self.PHYSICS[1].x.vertical.max = 0
				self.PHYSICS[1].x.vertical.bodyX.max = 0
				self.PHYSICS[1].x.vertical.bodyY.max = 0
				self.PHYSICS[1].x.vertical.bodyRot.max = 0
				self.PHYSICS[1].x.horizontal.neutral = 0
				self.PHYSICS[1].x.horizontal.max = 0
			else
				models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(self.CurrentCostume == 1)
				for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair, models.models.main.Avatar.UpperBody.Body.Hairs.BackHair}) do
					modelPart:setPos()
				end
				self.PHYSICS[1].x.vertical.neutral = -10
				self.PHYSICS[1].x.vertical.max = -10
				self.PHYSICS[1].x.vertical.bodyX.max = -10
				self.PHYSICS[1].x.vertical.bodyY.max = -10
				self.PHYSICS[1].x.vertical.bodyRot.max = -10
				self.PHYSICS[1].x.horizontal.neutral = -10
				self.PHYSICS[1].x.horizontal.max = -10
			end
		end
    end,

	--Exスキル
	EX_SKILL = {
		{
			nameEN = "Momoyado on-site service!",
			nameJP = "百夜堂出張サービス！",
			models = {models.models.placement_object.PlacementObject, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet},
			animations = {"main", "placement_object", "ex_skill_1"},
			cameraStartPos = vectors.vec3(-2, 24, -18),
			cameraStartRot = vectors.vec3(0, 160, 0),
			cameraEndPos = vectors.vec3(-146, 25, -33),
			cameraEndRot = vectors.vec3(0, 250, 0),
            preAnimationCallback = function()
                FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 24, true)
            end,
			animationTick = function(tick)
				if tick <= 76 then
                    if tick >= 24 and tick < 36 then
                        if tick == 24 then
                            BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setVisible(true)
                            FaceParts:setEmotion("INVERSED", "NORMAL", "CLOSED", 5, true)
                        elseif tick == 29 then
                            FaceParts:setEmotion("INVERSED", "NORMAL", "TRIANGLE", 8, true)
                        end
                        if (tick - 24) % 2 == 0 then
                            sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 5, 2)
                        end
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setPos(vectors.vec3(-7, 6, -6):add(math.random() * 0.2 - 0.05, math.random() * 0.2 - 0.05))
                    elseif tick == 36 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setVisible(false)
                    elseif tick == 37 then
                        FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 2, true)
                    elseif tick == 39 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
                    elseif tick == 46 then
                        FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 9, true)
                    elseif tick == 57 then
                        FaceParts:setEmotion("SURPLISED", "SURPLISED", "TRIANGLE", 19, true)
                    elseif tick == 76 then
                        FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 24, true)
                        local playerPos = player:getPos()
                        sounds:playSound("minecraft:entity.generic.small_fall", playerPos, 5, 1)
                        sounds:playSound("minecraft:block.glass.break", playerPos, 5, 0.5)
                        local particleAnchor1Matrix = models.models.main.Avatar.Head.ExSkillAnimParticleAnchor1:partToWorldMatrix()
                        for i = 0, 5 do
                            local particleRot = math.rad(i * 60)
                            particles:newParticle("minecraft:wax_off", particleAnchor1Matrix[4][1], particleAnchor1Matrix[4][2], particleAnchor1Matrix[4][3]):setColor(1, 1, 0):setLifetime(12):setVelocity(math.cos(particleRot) * 0.05, 0.1, math.sin(particleRot) * 0.05):setGravity(0.5)
                        end
                        local particleAnchor4Matrix = models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.WaterSpill.ExSkillAnimParticleAnchor4:partToWorldMatrix()
                        for i = 0, 5 do
                            local particleRot = i * (math.pi / 3)
                            particles:newParticle("minecraft:splash", particleAnchor4Matrix[4][1] + math.cos(particleRot) * 0.25, particleAnchor4Matrix[4][2], particleAnchor4Matrix[4][3] + math.sin(particleRot) * 0.25):setScale(1.5):setLifetime(10)
                        end
                    end
                    if tick % 4 == 0 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.Yunomi1.ExSkillAnimParticleAnchor2, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.Yunomi2.ExSkillAnimParticleAnchor3}) do
                            local particleAnchorMatrix = modelPart:partToWorldMatrix()
                            particles:newParticle("poof", particleAnchorMatrix[4][1], particleAnchorMatrix[4][2], particleAnchorMatrix[4][3]):setScale(0.2):setVelocity():setLifetime(15)
                        end
                    end
                end
                if tick % 2 == 0 and tick >= 70 then
                    local particleAnchor5Matrix = models.models.placement_object.PlacementObject.ExSkillAnimParticleAnchor5:partToWorldMatrix()
                    for i = 0, 11 do
                        local particleRot = i * (math.pi / 6)
                        particles:newParticle("minecraft:block minecraft:dirt", particleAnchor5Matrix[4][1] + math.cos(particleRot) * 0.6, particleAnchor5Matrix[4][2], particleAnchor5Matrix[4][3] + math.sin(particleRot) * 0.6)
                    end
                end
                if tick % math.ceil((ExSkill.AnimationLength - tick) / 20) == 0 then
                    sounds:playSound("minecraft:entity.boat.paddle_land", player:getPos():add(models.models.placement_object.PlacementObject:getAnimPos():scale(1 / 16)), 5, 1)
                end
			end,
			postAnimationCallback = function(forcedStop)
                if not forcedStop then
                    local objectRot = vectors.vec3(0.11417, 14.97985, 0.45019)
                    local bodyYaw = player:getBodyYaw() % 360
                    PlacementObject:place(vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(objectRot.z, vectors.rotateAroundAxis(objectRot.y, vectors.rotateAroundAxis(objectRot.x, vectors.vec3(-126.95374, 1, -8.99059):scale(1 / 16), 1), 0, 1), 0, 0, 1), 0, 1):add(player:getPos()), -objectRot.y + bodyYaw + 180)
                end
			end
		},
        {
            nameEN = "On-site, summer Momoyado stall!",
			nameJP = "出張、夏の百夜堂出店！",
			models = {models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate},
			animations = {"main", "costume_swimsuit", "ex_skill_2"},
			cameraStartPos = vectors.vec3(33, 26, 9.5),
			cameraStartRot = vectors.vec3(0, 210),
			cameraEndPos = vectors.vec3(6, 26, -18.5),
			cameraEndRot = vectors.vec3(0, 197.5),
			preTransitionCallback = function()
                for _, modelPart in ipairs({models.models.ex_skill_2.Stall, models.models.ex_skill_2.SoftCream}) do
                    modelPart:setVisible(true)
                end
			end,
            preAnimationCallback = function()
                models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(false)
                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                    modelPart:setUVPixels(1)
                end
            end,
			animationTick = function(tick)
                if tick == 16 then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels(2)
                    end
                elseif tick == 19 then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels(3)
                    end
                elseif tick == 22 then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels(4)
                    end
                elseif tick == 25 then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels(5)
                    end
                elseif tick == 28 then
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels()
                    end
                    models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(8)
                    models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(true)
                elseif tick == 30 then
                    models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(math.random() > 0.95 and 16 or 0)
                end
			end,
			postAnimationCallback = function()
                for _, modelPart in ipairs({models.models.ex_skill_2.Stall, models.models.ex_skill_2.SoftCream}) do
                    modelPart:setVisible(false)
                end
			end
        }
	},

    --[[
        PHYSICS_DATAのデータフォーマット

        PHYSICS_DATA = {
            --1つのモデルパーツ毎に1つのデータエントリーを作成する。
            ---@type physic_data_entry
            {},
            ---@type physic_data_entry
            {},
            ---@type physic_data_entry
            {}
        }

        ---@typedef physic_data_entry
        {
            ---物理演算を適用するモデルパーツ。テーブル指定で複数のモデルパーツにおいて設定可能。
            ---@type ModelPart|table
            modelPart = path.to.modelPart,

            ---X軸の物理演算データ
            ---@type axis_data?
            x = {},

            ---Y軸の物理演算データ
            ---@type axis_data?
            y = {},

            ---Z軸の物理演算データ
            ---@type axis_data?
            z = {}
        }

        ---@typedef axis_data
        {
            ---体が垂直方向である時（通常時）の物理演算
            ---@type body_state_data?
            vertical = {},

            ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算
            ---@type body_state_data?
            horizontal = {},
        }

        ---@typedef body_state_data
        {
            ---このモデルパーツの絶対的な回転の最小値（度）
            ---@type number
            min = 0,

            ---このモデルパーツの通常時の回転位置（度）
            ---@type number
            neutral = 0,

            ---このモデルパーツの絶対的な回転の最大値（度）
            ---@type number
            max = 90,

            ---スニーク時にこのモデルパーツの回転に加えられるオフセット値
            ---@type number?
            sneakOffset = 30,

            ---頭の回転と共にこのモデルパーツの回転に加えられる値の倍率
            ---@type number?
            headRotMultiplayer = -1,

            ---頭の前後方向の回転データ
            ---@type rotation_data?
            headX = {},

            ---頭の左右方向の回転データ
            ---@type rotation_data?
            headZ = {},

            ---頭の角速度基準の回転データ
            ---@type rotation_data?
            headRot = {},

            ---体の前後方向の回転データ
            ---@type rotation_data?
            bodyX = {},

            ---体の上下方向の回転データ
            ---@type rotation_data?
            bodyY = {},

            ---体の左右方向の回転データ
            ---@type rotation_data?
            bodyZ = {},

            ---体の角速度基準の回転データ
            ---@type rotation_data?
            bodyRot = {}
        }

        ---@typedef rotation_data
        {
            ---この回転事象がモデルパーツに与える回転の倍率
            ---@type number
            multiplayer = 80,

            ---この回転事象がモデルパーツに与える回転の最小値
            ---@type number
            min = 0,

            ---この回転事象がモデルパーツに与える回転の最大値
            ---@type number
            max = 45
        }
    ]]
    --物理演算データ
    PHYSICS = {
        {
            modelPart = models.models.main.Avatar.UpperBody.Body.Hairs.BackHair,
            x = {
                vertical = {
                    min = -150,
                    neutral = -10,
                    max = -10,
                    bodyX = {
                        multiplayer = -80,
                        min = -90,
                        max = -10
                    },
                    bodyY = {
                        multiplayer = 80,
                        min = -150,
                        max = -10
                    },
                    bodyRot = {
                        multiplayer = 0.05,
                        min = -90,
                        max = -10
                    }
                },
                horizontal = {
                    min = -90,
                    neutral = -10,
                    max = -10
                }
            }
        },
        {
            modelPart = models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair,
            x = {
                vertical = {
                    min = 0,
                    neutral = 0,
                    max = 150,
                    sneakOffset = 30,
                    bodyX = {
                        multiplayer = -80,
                        min = 0,
                        max = 90
                    },
                    bodyY = {
                        multiplayer = -80,
                        min = 0,
                        max = 150
                    },
                    bodyRot = {
                        multiplayer = -0.05,
                        min = 0,
                        max = 90
                    }
                },
                horizontal = {
                    min = 0,
                    neutral = 90,
                    max = 150,
                    bodyX = {
                        multiplayer = -80,
                        min = 0,
                        max = 150
                    }
                }
            }
        },
        {
            modelPart = models.models.main.Avatar.Head.HairTails.HairTailLeft,
            z = {
                vertical = {
                    min = 20,
                    neutral = 30,
                    max = 140,
                    bodyY = {
                        multiplayer = -80,
                        min = 20,
                        max = 140
                    },
                },
                horizontal = {
                    min = 20,
                    neutral = 30,
                    max = 140,
                    bodyX = {
                        multiplayer = -80,
                        min = 20,
                        max = 140
                    }
                }
            }
        },
        {
            modelPart = models.models.main.Avatar.Head.HairTails.HairTailRight,
            z = {
                vertical = {
                    min = -140,
                    neutral = -30,
                    max = -20,
                    bodyY = {
                        multiplayer = 80,
                        min = -140,
                        max = -20
                    },
                },
                horizontal = {
                    min = -140,
                    neutral = -30,
                    max = -20,
                    bodyX = {
                        multiplayer = 80,
                        min = -140,
                        max = -20
                    }
                }
            }
        },
        {
            modelPart = {models.models.main.Avatar.Head.Brim.BrimRibbon.BrimLines.BrimLineLeft, models.models.main.Avatar.Head.Brim.BrimRibbon.BrimLines.BrimLineRight, models.models.main.Avatar.Head.CSwimsuitH.Brim.BrimRibbonRight.BrimLines.BrimLineLeft, models.models.main.Avatar.Head.CSwimsuitH.Brim.BrimRibbonRight.BrimLines.BrimLineRight},
            x = {
                vertical = {
                    min = 0,
                    neutral = 0,
                    max = 150,
                    headRotMultiplayer = -1,
                    headX = {
                        multiplayer = -160,
                        min = 0,
                        max = 90
                    },
                    bodyY = {
                        multiplayer = -160,
                        min = 0,
                        max = 150
                    },
                    headRot = {
                        multiplayer = -0.1,
                        min = 0,
                        max = 90
                    }
                },
                horizontal = {
                    min = 0,
                    neutral = 45,
                    max = 150,
                    headX = {
                        multiplayer = -160,
                        min = 0,
                        max = 150
                    }
                }
            },
            z = {
                vertical = {
                    min = -60,
                    neutral = 0,
                    max = 0,
                    headZ = {
                        multiplayer = -160,
                        min = -60,
                        max = 0
                    }
                },
                horizontal = {
                    min = -60,
                    neutral = 0,
                    max = 0
                }
            }
        },
        {
            modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTailsBottom.HairTailBottomLeft,
            x = {
                vertical = {
                    min = -150,
                    neutral = -7.5,
                    max = 70,
                    headRotMultiplayer = -1,
                    headX = {
                        multiplayer = -80,
                        min = -90,
                        max = 70
                    },
                    headRot = {
                        multiplayer = 0.05,
                        min = -90,
                        max = -7.5
                    },
                    bodyY = {
                        multiplayer = 80,
                        min = -150,
                        max = -7.5
                    }
                },
                horizontal = {
                    min = -150,
                    neutral = 45,
                    max = 70,
                    headX = {
                        multiplayer = -80,
                        min = -45,
                        max = 70
                    },
                }
            },
            z = {
                vertical = {
                    min = -70,
                    neutral = 5,
                    max = 70,
                    headZ = {
                        multiplayer = -80,
                        min = -70,
                        max = 70
                    },
                },
                horizontal = {
                    min = -150,
                    neutral = 20,
                    max = 70,
                }
            }
        },
        {
            modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTailsBottom.HairTailBottomRight,
            x = {
                vertical = {
                    min = -150,
                    neutral = -7.5,
                    max = 70,
                    headRotMultiplayer = -1,
                    headX = {
                        multiplayer = -80,
                        min = -90,
                        max = 70
                    },
                    headRot = {
                        multiplayer = 0.05,
                        min = -90,
                        max = -7.5
                    },
                    bodyY = {
                        multiplayer = 80,
                        min = -150,
                        max = -7.5
                    }
                },
                horizontal = {
                    min = -150,
                    neutral = 45,
                    max = 70,
                    headX = {
                        multiplayer = -80,
                        min = -45,
                        max = 70
                    },
                }
            },
            z = {
                vertical = {
                    min = -70,
                    neutral = -5,
                    max = 70,
                    headZ = {
                        multiplayer = -80,
                        min = -70,
                        max = 70
                    },
                },
                horizontal = {
                    min = -150,
                    neutral = -20,
                    max = 70,
                }
            }
        }
    },

    --その他定数・変数
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_TEXT_1 = models.models.main.CameraAnchor:newText("ex_skill_1_text_1"):setVisible(false):setText("§c! !"):setRot(0, 180, 5):setScale(0.8, 0.8, 0.8):setOutline(true):setOutlineColor(1, 1, 1),
}

for _, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
	exSkill.cameraStartPos:mul(-1, 1, 1):scale(1 / 16)
	exSkill.cameraEndPos:mul(-1, 1, 1):scale(1 / 16)
end

return BlueArchiveCharacter