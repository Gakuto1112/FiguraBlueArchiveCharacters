events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	BlueArchiveCharacter = require("scripts.blue_archive_character")
	Language = require("scripts.language")
	Config = require("scripts.config")

	--ユーティリティクラス
	PlayerUtils = require("scripts.utils.player_utils")
	ModelUtils = require("scripts.utils.model_utils")
	CameraUtils = require("scripts.utils.camera_utils")
	RaycastUtils = require("scripts.utils.raycast_utils")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	HeadRing = require("scripts.head_ring")
	require("scripts.skirt")
	Gun = require("scripts.gun")
	Bullet = require("scripts.bullet")
	Nameplate = require("scripts.nameplate")

	--機能別クラス
	Costume = require("scripts.costume")
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill")
	PlacementObject = require("scripts.placement_object.placement_object")
	PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	Barrier = require("scripts.barrier")
	DeathAnimation = require("scripts.death_animation")

	--require("scripts.hypixel_zombies")
end)