---@alias FaceParts.EyeType
---| "HOLD"
---| "NORMAL"
---| "INVERSED"
---| "SURPLISED"
---| "TIRED"
---| "CLOSED"
---| "UNEQUAL"

---@alias FaceParts.MouthType
---| "HOLD"
---| "CLOSED"
---| "OPENED"
---| "TRIANGLE"

---@class FaceParts 目と口の状態を管理するクラス
---@field EmotionCount integer エモートの時間を計るカウンター
FaceParts = {
	--変数
	EmotionCount = 0,

	---表情を設定する。
	---@param rightEye FaceParts.EyeType 設定する右目の名前（"HOLD"にすると以前の設定を維持する）
	---@param leftEye FaceParts.EyeType 設定する左目の名前（"HOLD"にすると以前の設定を維持する）
	---@param mouth FaceParts.MouthType 設定する口の名前（"HOLD"にすると以前の設定を維持する）
	---@param duration integer この表情を有効にする時間
	---@param force boolean trueにすると以前のエモーションが再生中でも強制的に現在のエモーションを適用させる。
	setEmotion = function (self, rightEye, leftEye, mouth, duration, force)
		if self.EmotionCount == 0 or force then
			local eyeType = {HOLD = 0, NORMAL = 1, INVERSED = 2, SURPLISED = 3, TIRED = 4, CLOSED = 5, UNEQUAL = 6}
			local mouthType = {HOLD = 0, CLOSED = 1, OPENED = 2, TRIANGLE = 3}

			--右目
			if eyeType[rightEye] >= 5 then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels((eyeType[rightEye] - 5) * 6, 6)
			elseif eyeType[rightEye] >= 2 then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels(eyeType[rightEye] * 6, 0)
			elseif eyeType[rightEye] > 0 then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeLeft:setUVPixels((eyeType[rightEye] - 1) * 6, 0)
			end

			--左目
			if eyeType[leftEye] >= 5 then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels((eyeType[leftEye] - 5) * 6, 6)
			elseif eyeType[leftEye] > 0 then
				models.models.main.Avatar.Head.FaceParts.Eyes.EyeRight:setUVPixels(eyeType[leftEye] * 6, 0)
			end

			--口
			if mouthType[mouth] > 0 then
				models.models.main.Avatar.Head.FaceParts.Mouth:setUVPixels((mouthType[mouth] - 1) * 4, 0)
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
	if blinkCount == 0 then
		FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", 2, false)
		blinkCount = 200
	else
		blinkCount = blinkCount - 1
	end
	if FaceParts.EmotionCount == 0 then
		FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED", 0, false)
	end
	FaceParts.EmotionCount = (FaceParts.EmotionCount > 0 and not client:isPaused()) and FaceParts.EmotionCount - 1 or FaceParts.EmotionCount
end)

return FaceParts