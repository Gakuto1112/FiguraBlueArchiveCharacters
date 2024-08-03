events.ENTITY_INIT:register(function ()
	--クラスのインスタンス化
	Language = require("scripts.language")
	Config = require("scripts.config")
	KeyManager = require("scripts.key_manager")

	--パーツ別クラス
	require("scripts.vanilla_model")
	Arms = require("scripts.arms")
	Skirt = require("scripts.skirt")
	Armor = require("scripts.armor")
	FaceParts = require("scripts.face_parts")
	Physics = require("scripts.physics")
	Gun = require("scripts.gun")
	Nameplate = require("scripts.nameplate")
	Portrait = require("scripts.portrait")

	--機能別クラス
	DeathAnimation = require("scripts.death_animation")
	Costume = require("scripts.costume")
	CameraManager = require("scripts.camera_manager")
	ExSkill = require("scripts.ex_skill.ex_skill")
	ExSkillTextAnimation = require("scripts.ex_skill.ex_skill_text_animation")
	ExSkill2TextAnimation = require("scripts.ex_skill.ex_skill_2_text_animation")
	ActionWheel = require("scripts.action_wheel.action_wheel")
	ActionWheelGui = require("scripts.action_wheel.action_wheel_gui")
	FrameParticle = require("scripts.ex_skill.frame_particle")
	FrameParticleManager = require("scripts.ex_skill.frame_particle_manager")
	PlacementObjectManager = require("scripts.placement_object.placement_object_manager")
	Bubble = require("scripts.bubble")
	Barrier = require("scripts.barrier")

	--HypixelZombies = require("scripts.hypixel_zombies")
end)

--ENTITY_INITを待たず読み込むクラス
PlayerUtils = require("scripts.utils.player_utils")
ModelUtils = require("scripts.utils.model_utils")
BlueArchiveCharacter = require("scripts.blue_archive_character")
HeadRing = require("scripts.head_ring")
HeadBlock = require("scripts.head_block")