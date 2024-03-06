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
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	HeadRing = require("scripts.head_ring")
	Gun = require("scripts.gun")
	Nameplate = require("scripts.nameplate")
	require("scripts.skirt")

	--機能別クラス
	DeathAnimation = require("scripts.death_animation")
	Costume = require("scripts.costume")
	CameraManager = require("scripts.camera_manager")
	ActionWheel = require("scripts.action_wheel")
	ExSkill = require("scripts.ex_skill.ex_skill")
	FrameParticle = require("scripts.ex_skill.frame_particle")
	FrameParticleManager = require("scripts.ex_skill.frame_particle_manager")
	PlacementObject = require("scripts.placement_object.placement_object")
	PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	Bubble = require("scripts.bubble")
	Barrier = require("scripts.barrier")

	--require("scripts.hypixel_zombies")
end)