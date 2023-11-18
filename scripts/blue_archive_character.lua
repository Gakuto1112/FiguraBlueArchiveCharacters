---生徒の攻撃属性。アクションホイール上のExスキルアクションの色に影響する。
---@alias BlueArchiveCharacter.SkillType
---| "EXPLOSION" 爆発
---| "PIERCE" 貫通
---| "MYSTERY" 神秘
---| "VIBRATION" 振動

---銃の構え方
---@alias BlueArchiveCharacter.GunHoldType
---| "NORMAL" バニラの弓やクロスボウの構え方と同じ
---| "CUSTOM" BBアニメーション"[models.main][gun_hold_right]"と"[models.main][gun_hold_left]"で構え方を定義する

---銃を持っていない場合の銃のモデルの扱い
---@alias BlueArchiveCharacter.GunPutType
---| "BODY" アバターのBodyに銃を移動させる
---| "HIDDEN" 銃を隠す

---@class BlueArchiveCharacter （今後別のキャラを作る時に備えて、）キャラクター変数を保持するクラス。別のキャラクターに対してもここを変更するだけで対応できるようにする。
BlueArchiveCharacter = {
	---生徒の基本情報（氏名、誕生日等）
    BASIC = {
        ---生徒の名前
        firstName = {
            ---英語
            ---@type string
            en_us = "Shizuko",

            ---日本語
            ---@type string
            ja_jp = "シズコ"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "Kawawa",

            ---日本語
            ---@type string
            ja_jp = "河和"
        },

        ---生徒所属の部活名
        clubName = {
            ---英語
            ---@type string
            en_us = "Festival Management Committee",

            ---日本語
            ---@type string
            ja_jp = "お祭り運営委員会",
        },

        ---生徒の誕生日
        birth = {
            ---誕生月
            ---@type integer
            month = 7,

            ---誕生日
            ---@type integer
            day = 7
        }
    },

    ---目や口
    ---パーツ名を鍵として、インデックス1に、デフォルトパーツから見て右にx番目、インデックス2に、デフォルトパーツから見て下にy番目を入力する。
    ---右目と左目については"NORMAL", "CLOSED", "SURPLISED"が必須となる。
    FACE_PARTS = {
        ---右目
        RightEye = {
            NORMAL = {0, 0},
            INVERSED = {2, 0},
            SURPLISED = {3, 0},
            TIRED = {4, 0},
            CLOSED = {0, 1},
            UNEQUAL = {1, 1}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {2, 0},
            TIRED = {3, 0},
            CLOSED = {-1, 1},
            UNEQUAL = {0, 1}
        },

        ---口
        Mouth = {
            CLOSED = {0, 0},
            OPENED = {1, 0},
            TRIANGLE = {2, 0}
        }
    },

    ---銃
    GUN = {
        ---銃の大きさの倍率（省略可）
        ---@type number
        scale = 1.5,

        ---構えている時
        hold = {
            ---構え方
            ---@type BlueArchiveCharacter.GunHoldType
            type = "NORMAL",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 2),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 2)
            },

            --[[
            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            }
            ]]
        },

        ---構えていない時
        put = {
            ---構えていない時の銃の扱い方
            ---@type BlueArchiveCharacter.GunPutType
            type = "BODY",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 4, 3),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 4, 3)
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 0, -45),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 180, 45)
            }
        },

        ---射撃音
        sound = {
            ---使用するゲームの音源名
            ---@type Minecraft.soundID
            name = "minecraft:entity.generic.explode",

            ---音源のピッチ（0.5 ~ 2）
            ---@type number
            pitch = 2
        }
    },

    ---設置物
    PLACEMENT_OBJECT = {
        --[[
        ======== データテンプレート ========
        {
            ---設置物として扱うモデル
            ---指定したモデルをコピーして設置物とする。
            ---@type ModelPart
            model = models.models.ex_skill_1.Stall,

            ---設置物の当たり判定
            ---BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心
            ---@type Vector3
            boundingBox = vectors.vec3(8, 8, 8)
        }
        ]]

        {
            ---設置物として扱うモデル
            ---指定したモデルをコピーして設置物とする。
            ---@type ModelPart
            model = models.models.ex_skill_1.Stall,

            ---設置物の当たり判定
            ---BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心
            ---@type Vector3
            boundingBox = vectors.vec3(20, 38, 20)
        }
    },

	---Exスキル
	EX_SKILL = {
        --[[
        ======== データテンプレート ========
		{
            ---Exスキルの名前
            name = {
                ---英語
                ---日本語名を翻訳したものにする。
                ---@type string
                en_us = "Ex Skill",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "Exスキル"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "EXPLOSION",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3()
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3()
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun()
                preTransition = function()
                end,

                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                end,

                ---Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postTransition = function(forcedStop)
                end
            }
		}
        ]]

		{
            ---Exスキルの名前
            name = {
                ---英語
                ---日本語名を翻訳したものにする。
                ---@type string
                en_us = "Momoyado on-site service!",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "百夜堂出張サービス！"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "MYSTERY",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.ex_skill_1.Stall, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "ex_skill_1"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-2, 24, -18),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 160)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-146, 25, -33),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 250)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 24, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick <= 76 then
                        if tick >= 24 and tick < 36 then
                            if tick == 24 then
                                BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setVisible(true)
                                FaceParts:setEmotion("INVERSED", "NORMAL", "CLOSED", 5, true)
                            elseif tick == 29 then
                                FaceParts:setEmotion("INVERSED", "NORMAL", "TRIANGLE", 8, true)
                            end
                            if (tick - 24) % 2 == 0 then
                                sounds:playSound("minecraft:entity.experience_orb.pickup", player:getPos(), 1, 2)
                            end
                            BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setPos(vectors.vec3(-7, 6, -6):add(math.random() * 0.2 - 0.05, math.random() * 0.2 - 0.05))
                        elseif tick == 36 then
                            BlueArchiveCharacter.EX_SKILL_1_TEXT_1:setVisible(false)
                        elseif tick == 37 then
                            FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 2, true)
                        elseif tick == 39 then
                            FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
                        elseif tick == 46 then
                            FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 9, true)
                        elseif tick == 57 then
                            FaceParts:setEmotion("SURPLISED", "SURPLISED", "TRIANGLE", 19, true)
                        elseif tick == 76 then
                            FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "CLOSED", 24, true)
                            sounds:playSound("minecraft:entity.generic.small_fall", player:getPos(), 1)
                            sounds:playSound("minecraft:block.glass.break", ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.ExSkill1SoundAnchor2), 1, 0.5)
                            local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.main.Avatar.Head.ExSkill1ParticleAnchor1)
                            for i = 0, 5 do
                                local particleRot = math.rad(i * 60)
                                particles:newParticle("minecraft:wax_off", particleAnchor1Pos):setColor(1, 1, 0):setLifetime(12):setVelocity(math.cos(particleRot) * 0.05, 0.1, math.sin(particleRot) * 0.05):setGravity(0.5)
                            end
                            local particleAnchor4Pos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.WaterSpill.ExSkill1ParticleAnchor4)
                            for i = 0, 5 do
                                local particleRot = i * (math.pi / 3)
                                particles:newParticle("minecraft:splash", particleAnchor4Pos:copy():add(math.cos(particleRot) * 0.25, 0, math.sin(particleRot) * 0.25)):setScale(1.5):setLifetime(10)
                            end
                        end
                        if tick % 4 == 0 then
                            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.Yunomi1.ExSkill1ParticleAnchor2, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.Yunomi2.ExSkill1ParticleAnchor3}) do
                                local particleAnchorPos = ModelUtils.getModelWorldPos(modelPart)
                                particles:newParticle("poof", particleAnchorPos):setScale(0.2):setVelocity():setLifetime(15)
                            end
                        end
                    end
                    if tick % 2 == 0 and tick >= 70 then
                        local particleAnchor5Pos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.ExSkill1ParticleAnchor5)
                        for i = 0, 11 do
                            local particleRot = i * (math.pi / 6)
                            particles:newParticle("minecraft:block minecraft:dirt", particleAnchor5Pos:copy():add(math.cos(particleRot) * 0.6, 0, math.sin(particleRot) * 0.6))
                        end
                    end
                    if tick % math.ceil((ExSkill.AnimationLength - tick) / 20) == 0 then
                        sounds:playSound("minecraft:entity.boat.paddle_land", ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stall.Wheels.ExSkill1SoundAnchor1))
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if not forcedStop then
                        local objectRot = vectors.vec3(0.11417, 14.97985, 0.45019)
                        local bodyYaw = player:getBodyYaw() % 360
                        PlacementObjectManager:place(BlueArchiveCharacter.PLACEMENT_OBJECT[1], vectors.rotateAroundAxis(-bodyYaw, vectors.rotateAroundAxis(objectRot.z, vectors.rotateAroundAxis(objectRot.y, vectors.rotateAroundAxis(objectRot.x, vectors.vec3(-126.95374, 1, -8.99059):scale(1 / 16), 1), 0, 1), 0, 0, 1), 0, 1):add(player:getPos()), -objectRot.y + bodyYaw + 180)
                    end
                end
            }
		},

        {
            ---Exスキルの名前
            name = {
                ---英語
                ---日本語名を翻訳したものにする。
                ---@type string
                en_us = "On-site, summer Momoyado stall!",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "出張、夏の百夜堂出店！"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "MYSTERY",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "costume_swimsuit", "ex_skill_2"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(33, 26, 9.5),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 210)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(6, 26, -18.5),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 197.5)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun()
                preTransition = function()
                    for _, modelPart in ipairs({models.models.ex_skill_2.Stall, models.models.ex_skill_2.SoftCream}) do
                        modelPart:setVisible(true)
                    end
                end,

                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(false)
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                        modelPart:setUVPixels(1)
                    end
                    FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 75, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick <= 25 then
                        local particleAnchor1Pos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ExSkill2ParticleAnchor1)
                        if tick <= 16 then
                            for _ = 1, 2 do
                                particles:newParticle("minecraft:block minecraft:snow", particleAnchor1Pos):setPower(0.25):setLifetime(10)
                            end
                        end
                        if tick >= 16 then
                            for _ = 1, 4 do
                                particles:newParticle("minecraft:block minecraft:light_blue_concrete", particleAnchor1Pos):setPower(0):setLifetime(10)
                            end
                            if tick == 16 then
                                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                                    modelPart:setUVPixels(2)
                                end
                            elseif tick == 19 then
                                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                                    modelPart:setUVPixels(3)
                                end
                            elseif tick == 22 then
                                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                                    modelPart:setUVPixels(4)
                                end
                            elseif tick == 25 then
                                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                                    modelPart:setUVPixels(5)
                                end
                            end
                        end
                    elseif tick == 28 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce1, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce2, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce3, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce4, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIce5, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarLeft, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceEars.ShavedIceEarRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(8)
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setVisible(true)
                    elseif tick == 30 then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ShavedIceFace:setUVPixels(math.random() > 0.95 and 16 or 0)
                        local particleAnchor2Pos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ExSkill2ParticleAnchor2)
                        local bodyYaw = player:getBodyYaw()
                        for i = 1, 4 do
                            particles:newParticle("minecraft:electric_spark", particleAnchor2Pos):setColor(0.99, 0.6, 0.73):setVelocity(vectors.rotateAroundAxis(-bodyYaw - 30, vectors.vec3(i <= 2 and 0.2 or -0.2, i % 2 == 0 and 0 or 0.1), 0, 1)):setGravity(0.5):setLifetime(4)
                        end
                        sounds:playSound("minecraft:entity.item.pickup", ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.ShavedIce2.ExSkill2SoundAnchor1), 1, 0.75)
                    elseif tick >= 34 and tick <= 69 then
                        sounds:playSound("minecraft:item.bucket.empty", ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Plate.ShavedIce.Wave.ExSkill2SoundAnchor2), math.clamp(tick <= 43 and (tick * 0.056 - 1.904) or (tick >= 60 and (tick * -0.056 + 3.86) or 0.5), 0, 0.5), 0.75)
                    elseif tick == 75 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 13, true)
                    elseif tick == 88 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 4, true)
                    elseif tick == 92 then
                        FaceParts:setEmotion("NORMAL", "CLOSED", "OPENED", 18, true)
                        local bodyYaw = player:getBodyYaw()
                        particles:newParticle("minecraft:electric_spark", ModelUtils.getModelWorldPos(models.models.main.Avatar.Head.FaceParts.Eyes.ExSkill2ParticleAnchor3)):setColor(1, 1, 0.68):setVelocity(vectors.rotateAroundAxis(-bodyYaw - 5, vectors.vec3(0.2, 0.2), 0, 1)):setGravity(1):setLifetime(18)
                        sounds:playSound("minecraft:entity.experience_orb.pickup", ModelUtils.getModelWorldPos(models.models.main.Avatar.Head.FaceParts.Eyes.ExSkill2SoundAnchor3), 1, 2)
                        local particleAnchor4Pos = ModelUtils.getModelWorldPos(models.models.main.ExSkill2ParticleAnchor4)
                        for i = 0, 31 do
                            local particleRot = i / 8 * math.pi + 0.2
                            particles:newParticle("minecraft:electric_spark", particleAnchor4Pos):setColor(0.87, 0.71, 0.99, 0.5):setVelocity(vectors.rotateAroundAxis(-bodyYaw - 17.5, vectors.vec3(math.cos(particleRot), math.sin(particleRot)), 0, 1):scale(i < 16 and 0.15 or 0.2)):setScale(1.5) :setLifetime(18)
                        end
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    for _, modelPart in ipairs({models.models.ex_skill_2.Stall, models.models.ex_skill_2.SoftCream}) do
                        modelPart:setVisible(false)
                    end
                end
            }
        }
	},


	---コスチューム
	COSTUME = {
        ---コスチュームのデータ
        ---コスチュームの内部名をインデックスとする。
        costumes = {
            --[[
            ======== データテンプレート ========
            costume_name = {
                ---コスチュームの表示名
                name = {
                    ---英語
                    ---@type string
                    en_us = "Costume",

                    ---日本語
                    ---@type string
                    ja_jp = "コスチューム"
                },

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            }
            ]]

            default = {
                ---コスチュームの表示名
                name = {
                    ---英語
                    ---@type string
                    en_us = "Default",

                    ---日本語
                    ---@type string
                    ja_jp = "デフォルト"
                },

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            },

            swimsuit = {
                ---コスチュームの表示名
                name = {
                    ---英語
                    ---@type string
                    en_us = "Swimsuit",

                    ---日本語
                    ---@type string
                    ja_jp = "水着"
                },

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 2
            }
        },

        ---コールバック関数
        callbacks = {
            ---衣装が変更された時に実行されるコールバック関数
            ---デフォルトの衣装はここに含めない。
            ---@type fun(costumeId: integer)
            ---@param costumeId integer 新たな衣装のインデックス番号
            change = function(costumeId)
                if costumeId == 2 then
                    --水着
                    Costume.setCostumeTextureOffset(1)
                    for _, modelPart in ipairs(ModelUtils.getPlayerModels({"Head.Brim", "UpperBody.Body.Skirt", "UpperBody.Body.Hairs", "UpperBody.Arms.RightArm.RightSleeveTop", "UpperBody.Arms.RightArm.RightArmBottom.RightSleeveBottom", "UpperBody.Arms.LeftArm.LeftSleeveTop", "UpperBody.Arms.LeftArm.LeftArmBottom.LeftSleeveBottom"})) do
                        modelPart:setVisible(false)
                    end

                    for _, modelPart in ipairs(ModelUtils.getPlayerModels({"Head.CSwimsuitH", "UpperBody.Body.CSwimsuitB"})) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
                        modelPart:setVisible(not Armor.ArmorVisible[1])
                    end
                    for _, modelPart in ipairs({models.models.death_animation.DummyAvatar.Head.CSwimsuitH.Brim, models.models.death_animation.DummyAvatar.Head.CSwimsuitH.EarAccessories}) do
                        modelPart:setVisible(true)
                    end
                end
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
                for _, modelPart in ipairs(ModelUtils.getPlayerModels({"UpperBody.Body.Hairs", "UpperBody.Arms.RightArm.RightSleeveTop", "UpperBody.Arms.RightArm.RightArmBottom.RightSleeveBottom", "UpperBody.Arms.LeftArm.LeftSleeveTop", "UpperBody.Arms.LeftArm.LeftArmBottom.LeftSleeveBottom"})) do
                    modelPart:setVisible(true)
                end
                for _, modelPart in ipairs(ModelUtils.getPlayerModels({"Head.CSwimsuitH", "UpperBody.Body.CSwimsuitB"})) do
                    modelPart:setVisible(false)
                end
                models.models.main.Avatar.Head.Brim:setVisible(not Armor.ArmorVisible[1])
                models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[2])
                for _, modelPart in ipairs({models.models.death_animation.DummyAvatar.Head.Brim, models.models.death_animation.DummyAvatar.UpperBody.Body.Skirt}) do
                    modelPart:setVisible(true)
                end
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
                if parts == "HELMET" then
                    if Armor.ArmorVisible[1] then
                        for _, modelPart in ipairs({models.models.main.Avatar.Head.Brim, models.models.main.Avatar.Head.HairTails, models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
                            modelPart:setVisible(false)
                        end
                    else
                        models.models.main.Avatar.Head.HairTails:setVisible(true)
                        if Costume.CurrentCostume == 1 then
                            models.models.main.Avatar.Head.Brim:setVisible(true)
                        elseif Costume.CurrentCostume == 2 then
                            for _, modelPart in ipairs({models.models.main.Avatar.Head.CSwimsuitH.Brim, models.models.main.Avatar.Head.CSwimsuitH.EarAccessories}) do
                                modelPart:setVisible(true)
                            end
                        end
                    end
                elseif parts == "CHEST_PLATE" then
                    if Armor.ArmorVisible[2] then
                        models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(false)
                        models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -1)
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 1)
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.neutral = 0
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.max = 0
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyX.max = 0
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyY.max = 0
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyRot.max = 0
                        BlueArchiveCharacter.PHYSICS[1].x.horizontal.neutral = 0
                        BlueArchiveCharacter.PHYSICS[1].x.horizontal.max = 0
                    else
                        models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(Costume.CurrentCostume == 1)
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair, models.models.main.Avatar.UpperBody.Body.Hairs.BackHair}) do
                            modelPart:setPos()
                        end
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.neutral = -10
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.max = -10
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyX.max = -10
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyY.max = -10
                        BlueArchiveCharacter.PHYSICS[1].x.vertical.bodyRot.max = -10
                        BlueArchiveCharacter.PHYSICS[1].x.horizontal.neutral = -10
                        BlueArchiveCharacter.PHYSICS[1].x.horizontal.max = -10
                    end
                end
            end
        }
	},

    ---物理演算データ
    PHYSICS = {
        --[[
        ======== データテンプレート ========
        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                }
            },

            ---y軸回転における物理演算データ（省略可）
            y = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                }
            },

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = 0,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                }
            }
        }
        ]]

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.Hairs.BackHair,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -10,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = -10,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -10
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -150,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -10
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -10
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -90,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -10,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = -10
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 150,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 30,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 150
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 90,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 150,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 150
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.HairTails.HairTailLeft,

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 20,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 30,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 140,

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 20,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 140
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 20,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 30,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 140,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 20,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 140
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.HairTails.HairTailRight,

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -140,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -30,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = -20,

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -140,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -20
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -140,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -30,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = -20,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -140,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -20
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = {models.models.main.Avatar.Head.Brim.BrimRibbon.BrimLines.BrimLineLeft, models.models.main.Avatar.Head.Brim.BrimRibbon.BrimLines.BrimLineRight, models.models.main.Avatar.Head.CSwimsuitH.Brim.BrimRibbonRight.BrimLines.BrimLineLeft, models.models.main.Avatar.Head.CSwimsuitH.Brim.BrimRibbonRight.BrimLines.BrimLineRight},

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 150,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = -1,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -0.1,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 150
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 45,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 150,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -16,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 150
                    }
                }
            },

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -60,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -60,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -60,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTailsBottom.HairTailBottomLeft,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -7.5,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = -1,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -7.5
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -150,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -7.5
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 45,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -45,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    }
                }
            },

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -70,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 5,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -70,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 20,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTailsBottom.HairTailBottomRight,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -7.5,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = -1,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    },

                    ---頭の回転によるによるモデルパーツの回転データ（省略可）
                    headRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -7.5
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -150,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = -7.5
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 45,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    headX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -45,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    }
                }
            },

            ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -70,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -5,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70,

                    ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    headZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -70,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 70
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -150,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = -20,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 70
                }
            }
        }
    },

    --その他定数・変数

    ---Exスキル1で使用するテキストタスク
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_TEXT_1 = models.models.main.CameraAnchor:newText("ex_skill_1_text_1"):setVisible(false):setText("§c! !"):setRot(0, 180, 5):setScale(0.8, 0.8, 0.8):setOutline(true):setOutlineColor(1, 1, 1),
}

for _, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
	exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16)
	exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16)
end

--生徒固有初期化処理
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setPos(5.5, 12, 0)
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet:setRot(180, 0, 0)
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.WaterSpill:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.TeaSet.WaterSpill:setColor(0.25, 0.39, 0.67)

for _, modelPart in ipairs({models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb1.LightBulb1, models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb2.LightBulb2, models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb3.LightBulb3, models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb4.LightBulb4, models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb5.LightBulb5, models.models.ex_skill_1.Stall.Roof.RoofTop.LightBulbs.LightBulb6.LightBulb6}) do
    modelPart:setLight(15)
end

return BlueArchiveCharacter