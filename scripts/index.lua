events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	Config = require("scripts.config")
	Language = require("scripts.language")

	--抽象クラス

	--ユーティリティクラス
	RaycastUtils = require("scripts.utils.raycast_utils")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")

	--機能別クラス
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill")
end)