events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	BlueArchiveCharacter = require("scripts.blue_archive_character")
	Language = require("scripts.language")
	Config = require("scripts.config")

	--ユーティリティクラス
	PlayerUtils = require("scripts.utils.player_utils")
	CameraUtils = require("scripts.utils.camera_utils")
	RaycastUtils = require("scripts.utils.raycast_utils")
	CollisionUtils = require("scripts.utils.collision_utils")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	HeadRing = require("scripts.head_ring")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")
	Nameplate = require("scripts.nameplate")

	--機能別クラス
	Costume = require("scripts.costume")
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill")
	if BlueArchiveCharacter.PLACEMENT_OBJECT.use then
		PlacementObject = require("scripts.placement_object.placement_object")
		PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	end

	--require("scripts.hypixel_zombies")
end)