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

---生徒の配置タイプ
---@alias BlueArchiveCharacter.FormationType
---| "STRIKER" ストライカー（前衛）
---| "SPECIAL" スペシャル（後方支援）

---@class BlueArchiveCharacter （今後別のキャラを作る時に備えて、）キャラクター変数を保持するクラス。別のキャラクターに対してもここを変更するだけで対応できるようにする。
BlueArchiveCharacter = {
	---生徒の基本情報（氏名、誕生日等）
    BASIC = {
        ---生徒の名前
        firstName = {
            ---英語
            ---@type string
            en_us = "Shiroko",

            ---日本語
            ---@type string
            ja_jp = "シロコ"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "Sunaookami",

            ---日本語
            ---@type string
            ja_jp = "砂狼"
        },

        ---生徒所属の部活名
        clubName = {
            ---英語
            ---@type string
            en_us = "Task force committee",

            ---日本語
            ---@type string
            ja_jp = "対策委員会",
        },

        ---生徒の誕生日
        birth = {
            ---誕生月
            ---@type integer
            month = 5,

            ---誕生日
            ---@type integer
            day = 16
        }
    },

    ---目や口
    ---パーツ名を鍵として、インデックス1に、デフォルトパーツから見て右にx番目、インデックス2に、デフォルトパーツから見て下にy番目を入力する。
    ---右目と左目については"NORMAL", "CLOSED", "SURPLISED"が必須となる。
    FACE_PARTS = {
        ---右目
        RightEye = {
            NORMAL = {0, 0},
            SURPLISED = {2, 0},
            TIRED = {4, 0},
            CLOSED = {6, 0},
            CLOSED2 = {7, 0},
            HALF = {8, 0},
            ANGRY = {0, 1},
            CENTER = {2, 1},
            NARROW_CENTER = {3, 1},
            NARROW_ANGRY_CENTER = {5, 1},
            NARROW_ANGRY = {8, 1}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {2, 0},
            TIRED = {4, 0},
            CLOSED = {5, 0},
            CLOSED2 = {6, 0},
            HALF = {8, 0},
            ANGRY = {0, 1},
            NARROW = {3, 1},
            NARROW_ANGRY = {5, 1},
            CENTER = {6, 1},
            NARROW_ANGRY_INVERTED = {8, 1},
            INVERTED = {-1, 2},
            ANGRY_INVERTED = {0, 2}
        },

        ---口
        Mouth = {
            CLOSED = {0, 0},
            NORMAL = {4, 0},
            ANGRY = {8, 0},
            CLOSED2 = {12, 0},
            CLOSED3 = {0, 4}
        }
    },

    ---銃
    GUN = {
        ---銃の大きさの倍率（省略可）
        ---@type number
        scale = 1.4,

        ---構えている時
        hold = {
            ---構え方
            ---@type BlueArchiveCharacter.GunHoldType
            type = "NORMAL",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 1, -1),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 1, -1)
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
                right = vectors.vec3(0, 2, 3),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 2, 3)
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 180, -130),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 0, 130)
            }
        },

        ---射撃音
        sound = {
            ---使用するゲームの音源名
            ---@type Minecraft.soundID
            name = "minecraft:entity.firework_rocket.blast",

            ---音源のピッチ（0.5 ~ 2）
            ---@type number
            pitch = 1
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
            model = models.models.placement_object.PlacementObject,

            ---設置物の当たり判定
            ---BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心
            ---@type Vector3
            boundingBox = vectors.vec3(8, 8, 8)
        }
        ]]
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
                    --Exスキルアニメーションを任意のティックで停止させるスニペット。デバッグ用。
                    --"<>"内を適切な値で置換すること。
                    if tick == <tick_int> then
                        for _, animation in ipairs(BlueArchiveCharacter.EX_SKILL[<ex_skill_index>].animations) do
                            animations["models."..animation]["ex_skill_"..<ex_skill_index>]:pause()
                        end
                    end
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
                en_us = "Drone summons: Fire support",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "ドローン召喚：火力支援"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "EXPLOSION",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.ex_skill_1.Drone},

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
                    pos = vectors.vec3(7, 27, -10),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 180, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-14, 7, -30),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-15, 210, 5)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 20, true)
                    ---@diagnostic disable-next-line: undefined-field
                    models.models.ex_skill_1.Drone.LauncherRight.ShineEffects:setColor(client:hasShaderPack() and vectors.vec3(0.5, 1, 1) or vectors.vec3(1, 1, 1))
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 20 then
                        FaceParts:setEmotion("HALF", "HALF", "NORMAL", 5, true)
                    elseif tick == 25 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 10, true)
                    elseif tick == 35 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "ANGRY", 10, true)
                    elseif tick == 40 then
                        FaceParts:setEmotion("ANGRY", "ANGRY", "ANGRY", 30, true)
                    elseif tick == 41 then
                        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 0.5, 1.5)
                    end
                end,
            }
		},

        {
            ---Exスキルの名前
            name = {
                ---英語
                ---日本語名を翻訳したものにする。
                ---@type string
                en_us = "It's a big catch!",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "大物だ"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "MYSTERY",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.FishingRod},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "ex_skill_2"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(13, 34, -33),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 160, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-12, 36, -61),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-10, 160, 0)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun()
                preTransition = function()
                    models.models.ex_skill_2.Stage.Ocean:setColor(world.getBiome(player:getPos()):getWaterColor())
                    models.models.ex_skill_2.Stage:setVisible(true)
                    models.models.main.Avatar:setPos(0, 8, 0)
                    if BlueArchiveCharacter.PHOTO_MODE and host:isHost() then
                        host:sendChatCommand("/weather thunder")
                    end
                end,

                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    models.models.main.Avatar:setPos()
                    FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED2", 107, true)
                    if host:isHost() then
                        local windowSize = client:getWindowSize()
                        models.models.ex_skill_2.UnderWater.ForCameraOffset.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(23))
                        local bodyYaw = player:getBodyYaw()
                        local backgroundPos = vectors.rotateAroundAxis(bodyYaw + 180, vectors.rotateAroundAxis(bodyYaw * -1 + 180, BlueArchiveCharacter.EX_SKILL[2].camera.start.pos, 0, 1, 0):add(client:getCameraDir()), 0, 1, 0):scale(16 / 0.9375)
                        models.models.ex_skill_2.UnderWater:setOffsetPivot(backgroundPos)
                        models.models.ex_skill_2.UnderWater.ForCameraOffset:setPos(backgroundPos)
                        events.RENDER:register(function (_, context)
                            models.models.ex_skill_2.UnderWater:setVisible(context == "RENDER")
                        end, "ex_skill_2_render")
                        if BlueArchiveCharacter.PHOTO_MODE then
                            host:sendChatCommand("/fill ~-2 ~3 ~-2 ~2 ~3 ~2 minecraft:barrier")
                        end
                        sounds:playSound("minecraft:block.bubble_column.upwards_inside", player:getPos(), 1, 0.5)
                    end
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick <= 28 and host:isHost() then
                        local finPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.UnderWater.ForCameraOffset.Tuna.RearBody.TailFin)
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:underwater", finPos:copy():add(math.random() * 0.1 - 0.05, math.random() * 0.1 - 0.05, 0)):setScale(0.2)
                        end
                    elseif tick >= 37 and tick < 73 and host:isHost() then
                        local headPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.UnderWater.ForCameraOffset.Tuna.FrontBody.Head)
                        local tunaRotY = models.models.ex_skill_2.UnderWater.ForCameraOffset.Tuna:getAnimRot().y
                        local cameraRotY = renderer:getCameraRot().y
                        local particleCount = math.max(tick - 52, 0)
                        for i = 0, 2 * math.pi, math.pi / 6 do
                            particles:newParticle("minecraft:dust 100 1000000000 1000000000 "..(particleCount / 27 + 1), vectors.rotateAroundAxis(tunaRotY + cameraRotY, 0, math.cos(i) * 0.3, math.sin(i) * 0.3, 0, 1, 0):add(headPos)):setVelocity(vectors.rotateAroundAxis(tunaRotY - cameraRotY - 90, 0, 0, 0.1, 0, 1, 0)):setLifetime(20)
                        end
                        sounds:playSound("minecraft:entity.squid.ambient", player:getPos(), 1, 0.75)
                    elseif tick == 78 and host:isHost() then
                        events.RENDER:remove("ex_skill_2_render")
                        models.models.ex_skill_2.UnderWater:setVisible(false)
                        if BlueArchiveCharacter.PHOTO_MODE then
                            host:sendChatCommand("/fill ~-2 ~3 ~-2 ~2 ~3 ~2 minecraft:air")
                        end
                    elseif tick == 98 and BlueArchiveCharacter.PHOTO_MODE and host:isHost() then
                        host:sendChatCommand("/summon minecraft:lightning_bolt ^-50 ^0 ^-100")
                    elseif tick == 107 then
                        FaceParts:setEmotion("NARROW_CENTER", "NARROW", "CLOSED2", 27, true)
                    elseif tick == 120 and BlueArchiveCharacter.PHOTO_MODE and host:isHost() then
                        host:sendChatCommand("/weather clear")
                    elseif tick == 134 then
                        FaceParts:setEmotion("NARROW_ANGRY_CENTER", "NARROW_ANGRY", "NORMAL", 16, true)
                    elseif tick == 139 then
                        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
                        if host:isHost() then
                            local windowSize = client:getWindowSize()
                            models.models.ex_skill_2.Flash.ForCameraOffset2.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(22.5))
                            local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy()), 0, 1, 0):scale(16 / 0.9375)
                            models.models.ex_skill_2.Flash:setOffsetPivot(backgroundPos)
                            models.models.ex_skill_2.Flash.ForCameraOffset2:setPos(backgroundPos)
                            models.models.ex_skill_2.Flash:setVisible(true)
                        end
                    elseif tick == 148 and host:isHost() then
                        models.models.ex_skill_2.Flash:setVisible(false)
                    elseif tick == 150 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "CLOSED2", 8, true)
                        if host:isHost() then
                            renderer:setPostEffect("phosphor")
                        end
                    elseif tick == 157 then
                        sounds:playSound("minecraft:entity.player.attack.sweep", player:getPos(), 0.5, 2)
                    elseif tick == 158 then
                        FaceParts:setEmotion("CENTER", "NORMAL", "CLOSED2", 48, true)
                    elseif tick >= 160 and tick <= 170 and host:isHost() then
                        local cameraPos = renderer:getCameraOffsetPivot()
                        for i = 0, 8 do
                            particles:newParticle("minecraft:dust 100 1000000000 1000000000 4", cameraPos:copy():add(player:getPos()):add((i % 3 - 1) * 0.25, 1.25, (math.floor(i / 3) - 1) * 0.25)):setLifetime(5):setVelocity(0, 0.25, 0)
                        end
                        if tick == 160 then
                            local playerPos = player:getPos()
                            sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.25)
                            sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
                        elseif tick == 170 then
                            renderer:setPostEffect()
                        end
                    elseif tick == 175 then
                        models.models.ex_skill_2.UnderWater.ForCameraOffset.Tuna:moveTo(models.models.ex_skill_2)
                        local playerPos = player:getPos()
                        sounds:playSound("minecraft:entity.generic.splash", playerPos, 1, 0.5)
                        sounds:playSound("minecraft:ambient.underwater.exit", playerPos, 0.5, 0.5)
                    elseif tick == 180 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Tuna)
                        for _ = 1, 50 do
                            particles:newParticle("minecraft:dust 100 1000000000 1000000000 3", anchorPos:copy()):setVelocity(vectors.rotateAroundAxis(player:getBodyYaw() * -1, math.random() * 0.2, math.random() * 0.25 + 0.125, math.random() * 0.2 - 0.1, 0, 1, 0)):setGravity(0.5):setLifetime(25)
                        end
                    end
                    if tick % 35 == 24 and tick <= 160 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Stage.Reef.ExSkill2ParticleAnchor)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 50 do
                            local particleOffset = math.random()
                            particles:newParticle("minecraft:dust 1000000000 1000000000 1000000000 5", anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset - 0.5, 0, 0, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset * 0.5 - 0.25, math.random() * 0.5 + 0.25, math.random() * 0.25 - 0.125, 0, 1, 0)):setGravity(1):setLifetime(40)
                        end
                        if tick >= 80 or not host:isHost() then
                            local playerPos = player:getPos()
                            sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.25)
                            sounds:playSound("minecraft:item.bucket.empty", playerPos, 1, 0.5)
                        end
                    end
                    if tick <= 139 or tick % 2 == 0 then
                        local currentFrame = models.models.ex_skill_2.Stage.Ocean:getUVPixels().y / 16
                        if currentFrame < 31 then
                            models.models.ex_skill_2.Stage.Ocean:setUVPixels(0, (currentFrame + 1) * 16)
                        else
                            models.models.ex_skill_2.Stage.Ocean:setUVPixels()
                        end
                    end
                    if (tick >= 83 and tick < 110) or (tick >= 110 and tick <= 130 and tick % 2 == 0) then
                        sounds:playSound("minecraft:block.dispenser.fail", player:getPos(), 0.5, 5)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if models.models.ex_skill_2.Tuna ~= nil then
                        models.models.ex_skill_2.Tuna:moveTo(models.models.ex_skill_2.UnderWater.ForCameraOffset)
                    end
                    if forcedStop and host:isHost() then
                        events.RENDER:remove("ex_skill_2_render")
                        for _, modelPart in ipairs({models.models.ex_skill_2.UnderWater, models.models.ex_skill_2.Flash}) do
                            modelPart:setVisible(false)
                        end
                        renderer:setPostEffect()
                    elseif not forcedStop then
                        models.models.main.Avatar:setPos(0, 8, 0)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postTransition = function(forcedStop)
                    models.models.ex_skill_2.Stage:setVisible(false)
                    models.models.main.Avatar:setPos()
                end
            }
		},

        {
            ---Exスキルの名前
            name = {
                ---英語
                ---日本語名を翻訳したものにする。
                ---@type string
                en_us = "Ride & Grenade",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "ライド＆グレネード"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "MYSTERY",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.LowerBody.Bicycle},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "ex_skill_3"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-71, 28, 0),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(60, 0, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-119, 27, -938.5),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 40, -25)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED3", 40, true)
                    BlueArchiveCharacter.EX_SKILL_3_SOUND_1 = sounds:playSound("minecraft:item.elytra.flying", player:getPos(), 0.05, 2)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 40 then
                        FaceParts:setEmotion("NORMAL", "INVERTED", "CLOSED3", 7, true)
                    elseif tick == 27 and host:isHost() then
                        sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.main.Avatar), 0.1, 0.75)
                    elseif tick == 47 then
                        FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY_INVERTED", "NORMAL", 35, true)
                    elseif tick >= 58 and tick < 80 then
                        if tick == 58 then
                            BlueArchiveCharacter.EX_SKILL_3_SOUND_1:stop()
                            BlueArchiveCharacter.EX_SKILL_3_SOUND_1 = nil
                        end
                        local bicycleYaw = models.models.main.Avatar:getAnimRot().y + player:getBodyYaw() * -1
                        local bicyclePos = ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.Bicycle)
                        local frontWheelPos = vectors.rotateAroundAxis(bicycleYaw, 0, 0, 0.5625, 0, 1, 0):add(bicyclePos)
                        local backWheelPos = vectors.rotateAroundAxis(bicycleYaw, 0, 0, -0.5625, 0, 1, 0):add(bicyclePos)
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:electric_spark", frontWheelPos):setColor(0.973, 0.714, 0.29):setScale(0.5):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.25, math.random() * 0.5 - 0.25)
                            particles:newParticle("minecraft:electric_spark", backWheelPos):setColor(0.973, 0.714, 0.29):setScale(0.5):setVelocity(math.random() * 0.5 - 0.25, math.random() * 0.25, math.random() * 0.5 - 0.25)
                            particles:newParticle("minecraft:campfire_cosy_smoke", frontWheelPos):setVelocity(math.random() * 0.2 - 0.1, 0.015, math.random() * 0.2 - 0.1)
                            particles:newParticle("minecraft:campfire_cosy_smoke", backWheelPos):setVelocity(math.random() * 0.2 - 0.1, 0.015, math.random() * 0.2 - 0.1)
                        end
                        local particleBlock = world.getBlockState(bicyclePos:copy():sub(0, 0.5, 0)).id
                        if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" then
                            for _ = 1, 5 do
                                particles:newParticle("minecraft:block "..particleBlock, frontWheelPos)
                                particles:newParticle("minecraft:block "..particleBlock, backWheelPos)
                            end
                        end
                        sounds:playSound("minecraft:block.gravel.hit", bicyclePos, 0.1, 0.5)
                        sounds:playSound("minecraft:block.grindstone.use", bicyclePos, 0.1, 3)
                    elseif tick == 82 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 15, true)
                        models.models.main.Avatar.LowerBody.Bicycle.Shaft.Shaft8.WaterBottle:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
                    elseif tick == 97 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 4, true)
                    elseif tick == 101 then
                        FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY_INVERTED", "CLOSED3", 26, true)
                    elseif tick == 109 then
                        sounds:playSound("minecraft:entity.player.attack.sweep", ModelUtils.getModelWorldPos(models.models.main.Avatar), 0.25, 0.5)
                        if host:isHost() then
                            local windowSize = client:getWindowSize()
                            models.models.ex_skill_3.CameraBackground.Background:setScale(vectors.vec3(windowSize.x / windowSize.y, 1, 1):scale(33.5))
                            local backgroundPos = vectors.rotateAroundAxis(player:getBodyYaw() + 180, renderer:getCameraOffsetPivot():copy():add(0, 1.62, 0):add(client:getCameraDir():copy():scale(1.5)), 0, 1, 0):scale(16 / 0.9375)
                            models.models.ex_skill_3.CameraBackground:setOffsetPivot(backgroundPos)
                            models.models.ex_skill_3.CameraBackground.Background:setPos(backgroundPos)
                            models.models.ex_skill_3.CameraBackground:setVisible(true)
                        end
                    end
                    if tick < 58 then
                        models.models.main.Avatar.LowerBody.Bicycle.Wheels.Chain:setUVPixels(tick % 2, 0)
                        BlueArchiveCharacter.EX_SKILL_3_SOUND_1:setVolume(math.clamp(16 - client:getCameraPos():sub(ModelUtils.getModelWorldPos(models.models.main.Avatar)):length(), 0, 8) / 160)
                    end
                    if tick < 69 then
                        local bodyYaw = player:getBodyYaw()
                        local avatarPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
                        particles:newParticle("minecraft:cloud", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 8 - 4, math.random() * 4, 10, 0, 1, 0):add(avatarPos)):setColor(1, 1, 1, 0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0))
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.WaterBottle ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.WaterBottle:moveTo(models.models.main.Avatar.LowerBody.Bicycle.Shaft.Shaft8)
                    end
                    if host:isHost() then
                        models.models.ex_skill_3.CameraBackground:setVisible(false)
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
                ---コスチュームの内部名
                ---@type string
                name = "costume_name"

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Costume",

                    ---日本語
                    ---@type string
                    ja_jp = "コスチューム"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            }
            ]]

            {
                ---コスチュームの内部名
                ---@type string
                name = "default",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Default",

                    ---日本語
                    ---@type string
                    ja_jp = "デフォルト"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            },

            {
                ---コスチュームの内部名
                ---@type string
                name = "masked",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Masked Swimsuit Group",

                    ---日本語
                    ---@type string
                    ja_jp = "覆面水着団"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            },

            {
                ---コスチュームの内部名
                ---@type string
                name = "swimsuit",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Swimsuit",

                    ---日本語
                    ---@type string
                    ja_jp = "水着"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "SPECIAL",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 2
            },

            {
                ---コスチュームの内部名
                ---@type string
                name = "riding",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Riding",

                    ---日本語
                    ---@type string
                    ja_jp = "ライディング"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 3
            }
        },

        ---コールバック関数
        callbacks = {
            ---衣装が変更された時に実行されるコールバック関数
            ---デフォルトの衣装はここに含めない。
            ---@type fun(costumeId: integer)
            ---@param costumeId integer 新たな衣装のインデックス番号
            change = function(costumeId)
                if costumeId == 4 then
                    --ライディング
                    Costume.setCostumeTextureOffset(2)
                    models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, Armor.ArmorVisible[2] and -0.75 or 0.25)
                    models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, Armor.ArmorVisible[2] and 0.75 or -0.25)
                    models.models.death_animation.DummyAvatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, 0.25)
                    models.models.death_animation.DummyAvatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, -0.25)
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"UpperBody.Body.CRidingB", "UpperBody.Arms.RightArm.CRidingRA", "UpperBody.Arms.LeftArm.CRidingLA"})) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"UpperBody.Body.Scarf", "UpperBody.Body.Skirt", "UpperBody.Body.IDCard"})) do
                        modelPart:setVisible(false)
                    end
                elseif costumeId == 2 then
                    --覆面水着団
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.CMaskedH"})) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.HairPin", "Head.HairEnds", "UpperBody.Body.Hairs"})) do
                        modelPart:setVisible(false)
                    end
                elseif costumeId == 3 then
                    --水着
                    Costume.setCostumeTextureOffset(1)
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.Head", "Head.HatLayer"})) do
                        modelPart:setUVPixels(0, 16)
                    end
                    for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.HairEnds", "UpperBody.Body.Scarf", "UpperBody.Body.Skirt", "UpperBody.Body.Hairs", "UpperBody.Body.IDCard"})) do
                        modelPart:setVisible(false)
                    end
                    models.models.main.Avatar.Head.CSwimsuitH:setVisible(not Armor.ArmorVisible[1])
                    models.models.death_animation.DummyAvatar.Head.CSwimsuitH:setVisible(true)
                end
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
                Costume.setCostumeTextureOffset(0)
                for _, modelPart in ipairs(ModelUtils:getPlayerModels({"UpperBody.Body.Hairs.FrontHair", "UpperBody.Body.Hairs.BackHair"})) do
                    modelPart:setPos()
                end
                for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.Head", "Head.HatLayer"})) do
                    modelPart:setUVPixels()
                end
                for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.CMaskedH", "Head.CSwimsuitH", "UpperBody.Body.CRidingB", "UpperBody.Arms.RightArm.CRidingRA", "UpperBody.Arms.LeftArm.CRidingLA"})) do
                    modelPart:setVisible(false)
                end
                for _, modelPart in ipairs(ModelUtils:getPlayerModels({"Head.HairPin", "Head.HairEnds", "UpperBody.Body.Hairs", "UpperBody.Body.Scarf", "UpperBody.Body.IDCard"})) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[3])
                models.models.death_animation.DummyAvatar.UpperBody.Body.Skirt:setVisible(true)
                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Scarf.Scarf2, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf3, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf4}) do
                    modelPart:setVisible(not Armor.ArmorVisible[2])
                end
                for _, modelPart in ipairs({models.models.death_animation.DummyAvatar.UpperBody.Body.Scarf.Scarf2, models.models.death_animation.DummyAvatar.UpperBody.Body.Scarf.Scarf3, models.models.death_animation.DummyAvatar.UpperBody.Body.Scarf.Scarf4}) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, Armor.ArmorVisible[2] and -0.75 or 0)
                models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, Armor.ArmorVisible[2] and 0.75 or 0)
                for _, modelPart in ipairs({models.models.death_animation.DummyAvatar.UpperBody.Body.Hairs.FrontHair, models.models.death_animation.DummyAvatar.UpperBody.Body.Hairs.BackHair}) do
                    modelPart:setPos()
                end
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
                if parts == "HELMET" then
                    if Armor.ArmorVisible[1] then
                        models.models.main.Avatar.Head.CSwimsuitH:setVisible(false)
                    elseif Costume.CurrentCostume == 4 then
                        models.models.main.Avatar.Head.CSwimsuitH:setVisible(true)
                    end
                elseif parts == "CHEST_PLATE" then
                    if Armor.ArmorVisible[2] then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Scarf.Scarf2, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf3, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf4}) do
                            modelPart:setVisible(false)
                        end
                        models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -0.75)
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 0.75)
                    else
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Scarf.Scarf2, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf3, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf4}) do
                            modelPart:setVisible(true)
                        end
                        if Costume.CurrentCostume == 2 then
                            models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -0.75)
                            models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 0.75)
                        else
                            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair, models.models.main.Avatar.UpperBody.Body.Hairs.BackHair}) do
                                modelPart:setPos()
                            end
                        end
                        models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, 0.25)
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, -0.25)
                    end
                elseif parts == "LEGGINGS" then
                    models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[3])
                end
            end
        }
	},

    ---吹き出しエモートガイド
    BUBBLE = {
        callbacks = {
            ---吹き出しエモートが再生された時に実行されるコールバック関数（任意）
            ---@type fun(type: Bubble.BubbleType)
            ---@param type Bubble.BubbleType 再生された吹き出しアニメーションの種類
            ---@param duration integer 吹き出しを再生する時間。-1は時間無制限を示す。
            ---@param showInGui boolean 一人称用にGUIに吹き出しを表示するかどうか
            onPlay = function(type, duration, showInGui)
                if duration > 0 then
                    if type == "GOOD" then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "CLOSED2", duration, true)
                    elseif type == "HEART" then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", duration, true)
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("NARROW_ANGRY", "NARROW_ANGRY", "ANGRY", duration, true)
                    end
                end
            end,

            ---吹き出しアニメーション終了時に実行されるコールバック関数（任意）
            ---@type fun(type: Bubble.BubbleType, forcedStop: boolean)
            ---@param type Bubble.BubbleType 再生された吹き出しエモートの種類
            ---@param forcedStop boolean 吹き出しエモートが途中終了した場合は"true"、吹き出しエモートが最後まで再生されて終了した場合は"false"が代入される。
            onStop = function(type, forcedStop)
                if not forcedStop then
                    FaceParts:resetEmotion()
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
                    max = 80,

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
                        max = 80
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
                        max = 80
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
                        max = 80
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 0,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 80,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 80,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 80
                    }
                }
            }
        },

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
                    min = -80,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -80,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -80,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -80,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.Scarf.Scarf2,

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
                    max = 140,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 30,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
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
                        max = 140
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
                    max = 90,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 0,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.Scarf.Scarf3,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 2,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 2,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 140,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 30,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 2,

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
                        min = 2,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 140
                    },

                    ---体の回転によるによるモデルパーツの回転データ（省略可）
                    bodyRot = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -0.05,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 2,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = 2,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 90,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 90,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = 2,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = {models.models.main.Avatar.UpperBody.Body.Scarf.Scarf2.Scarf2, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf3.Scarf3, models.models.main.Avatar.UpperBody.Body.Scarf.Scarf4.Scarf4},

             ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -90,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 90,

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    },
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.Scarf.Scarf4,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -140,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
                    },

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 160,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -140,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 0
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
                        max = 0
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.CSwimsuitH,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -140,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 0,

                    ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                    ---@type number
                    headRotMultiplayer = -1,


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
                        max = 0
                    },

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
                        max = 0
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
                        max = 0
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTail,

             ---z軸回転における物理演算データ（省略可）
            z = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -90,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 90,

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -90,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 90
                    },
                }
            }
        }
    },

    --その他定数・変数

    ---Exスキル撮影用変数。チートコマンドを用いるため、Figura設定で「チャットコマンド」を有効にすること。雷を利用するため、雷による火災には要注意！！
    ---@type boolean
    PHOTO_MODE = false,

    ---Exスキル3で使用する風切り音。
    ---@type Sound|nil
    EX_SKILL_3_SOUND_1 = nil
}

--生徒固有初期化処理
models.models.ex_skill_2.UnderWater:setLight(15)
models.models.ex_skill_2.Stage.Reef:setPrimaryTexture("RESOURCE", "textures/block/stone.png")
models.models.ex_skill_2.Stage.Ocean:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")

return BlueArchiveCharacter