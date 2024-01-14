events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	BlueArchiveCharacter = require("scripts.blue_archive_character")
	Language = require("scripts.language")
	Config = require("scripts.config")
	KeyManager = require("scripts.key_manager")

	--ユーティリティクラス
	PlayerUtils = require("scripts.utils.player_utils")
	ModelUtils = require("scripts.utils.model_utils")
	RaycastUtils = require("scripts.utils.raycast_utils")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Skirt = require("scripts.skirt")
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	HeadRing = require("scripts.head_ring")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")
	Nameplate = require("scripts.nameplate")

	--機能別クラス
	Costume = require("scripts.costume")
	CameraManager = require("scripts.camera_manager")
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill")
	PlacementObject = require("scripts.placement_object.placement_object")
	PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	Bubble = require("scripts.bubble")
	Barrier = require("scripts.barrier")
	DeathAnimation = require("scripts.death_animation")

	--require("scripts.hypixel_zombies")
end)