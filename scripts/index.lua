events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	Config = require("scripts.config")

	--抽象クラス

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")

	--機能別クラス
	PlacementObject = require("scripts.palcement_object")
end)