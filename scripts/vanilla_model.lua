---@class VanillaModel バニラーのモデルの処理クラス
VanillaModel = {
	---初期化関数
	init = function ()
		for _, vanillaModel in ipairs({vanilla_model.PLAYER, vanilla_model.CHESTPLATE_RIGHT_ARM, vanilla_model.CHESTPLATE_LEFT_ARM, vanilla_model.LEGGINGS_RIGHT_LEG, vanilla_model.LEGGINGS_LEFT_LEG, vanilla_model.BOOTS}) do
			vanillaModel:setVisible(false)
		end
	end
}

VanillaModel:init()

return VanillaModel