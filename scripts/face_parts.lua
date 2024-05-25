---@class FaceParts 目と口の状態を管理するクラス
---@field EmotionCount integer エモートの時間を計るカウンター
FaceParts = {
	--変数
	EmotionCount = 0,

	---表情を設定する。
	---@param rightEye string 設定する右目の名前（"HOLD"にすると以前の設定を維持する）
	---@param leftEye string 設定する左目の名前（"HOLD"にすると以前の設定を維持する）
	---@param mouth string 設定する口の名前（"HOLD"にすると以前の設定を維持する）
	---@param duration integer この表情を有効にする時間
	---@param force boolean trueにすると以前のエモーションが再生中でも強制的に現在のエモーションを適用させる。
	setEmotion = function (self, rightEye, leftEye, mouth, duration, force)
		if self.EmotionCount == 0 or force then
			--右目
			if rightEye ~= "HOLD" then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(BlueArchiveCharacter.FACE_PARTS.RightEye[rightEye][1] * 6, BlueArchiveCharacter.FACE_PARTS.RightEye[rightEye][2] * 6)
			end

			--左目
			if leftEye ~= "HOLD" then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(BlueArchiveCharacter.FACE_PARTS.LeftEye[leftEye][1] * 6, BlueArchiveCharacter.FACE_PARTS.LeftEye[leftEye][2] * 6)
			end

			--口
			if mouth ~= "HOLD" then
				if mouth ~= "CLOSED" then
					models.models.main.Avatar.Head.FaceParts.Mouth:setVisible(true)
					models.models.main.Avatar.Head.FaceParts.Mouth:setUVPixels(BlueArchiveCharacter.FACE_PARTS.Mouth[mouth][1] * 4, BlueArchiveCharacter.FACE_PARTS.Mouth[mouth][2] * 2)
				else
					models.models.main.Avatar.Head.FaceParts.Mouth:setVisible(false)
				end
			end

			self.EmotionCount = duration
		end
	end,

	---表情をリセットする。
	resetEmotion = function (self)
		self.EmotionCount = 0
	end
}

---瞬きのタイミングを計るカウンター
---@type integer
local blinkCount = 200

events.TICK:register(function ()
	local isPaused = client:isPaused()
	if blinkCount == 0 then
		FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", 2, false)
		blinkCount = 200
	elseif not isPaused then
		blinkCount = blinkCount - 1
	end
	local damageStatus = PlayerUtils:getDamageStatus()
	if damageStatus == "DAMAGE" then
		if BlueArchiveCharacter.FACE_PARTS.FacePartsSets ~= nil and BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onDamage ~= nil then
			FaceParts:setEmotion(BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onDamage.LeftEye, BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onDamage.RightEye, BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onDamage.Mouth, 8, true)
		else
			FaceParts:setEmotion("SURPLISED", "SURPLISED", "CLOSED", 8, true)
		end
	elseif player:getPose() == "SLEEPING" then
		if BlueArchiveCharacter.FACE_PARTS.FacePartsSets ~= nil and BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onSleep ~= nil then
			FaceParts:setEmotion(BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onSleep.LeftEye, BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onSleep.RightEye, BlueArchiveCharacter.FACE_PARTS.FacePartsSets.onSleep.Mouth, 8, true)
		else
			FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", 1, true)
		end
	elseif FaceParts.EmotionCount == 0 then
		FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 0, false)
	end
	FaceParts.EmotionCount = (FaceParts.EmotionCount > 0 and not isPaused) and FaceParts.EmotionCount - 1 or FaceParts.EmotionCount
end)

return FaceParts