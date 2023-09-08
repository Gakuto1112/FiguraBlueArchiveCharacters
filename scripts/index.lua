events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	Language = require("scripts.language")

	--ユーティリティクラス
	CameraUtils = require("scripts.utils.camera_utils")
	RaycastUtils = require("scripts.utils.raycast_utils")
	CollisionUtils = require("scripts.utils.collision_utils")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	HeadRing = require("scripts.headRing")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")

	--機能別クラス
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill")
	PlacementObject = require("scripts.placement_object")
end)