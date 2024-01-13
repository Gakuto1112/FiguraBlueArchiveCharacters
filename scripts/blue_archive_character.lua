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
            en_us = "Midori",

            ---日本語
            ---@type string
            ja_jp = "ミドリ"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "Saiba",

            ---日本語
            ---@type string
            ja_jp = "才羽"
        },

        ---生徒所属の部活名
        clubName = {
            ---英語
            ---@type string
            en_us = "Game development department",

            ---日本語
            ---@type string
            ja_jp = "ゲーム開発部",
        },

        ---生徒の誕生日
        birth = {
            ---誕生月
            ---@type integer
            month = 12,

            ---誕生日
            ---@type integer
            day = 8
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
            CLOSED = {3, 0},
            ANXIOUS = {5, 0},
            CLOSED2 = {0, 1},
            FRUST = {1, 1},
            STARE = {2, 1}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            TIRED = {3, 0},
            CLOSED = {2, 0},
            ANXIOUS = {5, 0},
            CLOSED2 = {-1, 1},
            STARE = {2, 1}
        },

        ---口
        Mouth = {
            CLOSED = {0, 0},
            NORMAL = {2, 0},
            FRUST = {4, 0},
            ANXIOUS = {6, 0},
            NORMAL2 = {8, 0},
            SMILE = {10, 0}
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
                right = vectors.vec3(-3.5, 12, 5),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(-2.5, 12, 5)
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
            type = "HIDDEN",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
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
                en_us = "Ex skill name",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "Exスキル名"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "EXPLOSION",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.Head.Sweat, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1, models.models.ex_skill_1.Momoi, models.models.ex_skill_1.Gui},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "ex_skill_1", "gun"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-8, 10, -30),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-10, 190, -25)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(29, 29, -8),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(20, 100, -30)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 15, true)
                    if host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator:setPos(windowSize.x * -1 + 4, 0)
                        local scale = vectors.vec3(1, 1, 0):scale(windowSize.x * 0.45 / 223):add(0, 0, 1)
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.DamageIndicators.MomoiDamageIndicator, models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator}) do
                            modelPart:setScale(scale)
                        end
                    end
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 0 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
                    elseif tick == 1 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
                    elseif tick == 2 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
                    elseif tick == 12 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels(12, 0)
                        end
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(8, 0)
                    elseif tick == 15 then
                        FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "NORMAL", 22, true)
                    elseif tick == 22 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[1]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar8:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("10/20")
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.Mouth:setUVPixels(24, -4)
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 24 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[2]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar7:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("9/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 26 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[3]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar6:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("7/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 28 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[4]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar5:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("6/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 30 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[5]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar4:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("4/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 32 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[6]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar3:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("3/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 34 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[7]:play()
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar2:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("1/20")
                            sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        end
                    elseif tick == 36 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 11, true)
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[8]:play()
                        local playerPos = player:getPos()
                        sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar.HpBar1:setVisible(false)
                            BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("0/20")
                            BlueArchiveCharacter.EX_SKILL_1_KO:setPos(client:getScaledWindowSize().x / 2 * -1, -20)
                            BlueArchiveCharacter.EX_SKILL_1_KO:setVisible(true)
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes:setVisible(false)
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.DeadEye:setVisible(true)
                            sounds:playSound("minecraft:entity.generic.hurt", playerPos, 0.25, 1)
                            local koAnimationCount = 0
                            events.RENDER:register(function ()
                                BlueArchiveCharacter.EX_SKILL_1_KO:setScale(vectors.vec3(1, 1, 1):scale(koAnimationCount <= 0.75 and -3.3333 * koAnimationCount + 5 or (koAnimationCount <= 1 and 2 * koAnimationCount + 1 or 3)))
                                koAnimationCount = koAnimationCount + 8 / client.getFPS()
                            end, "ex_skill_1_ko_render")
                        end
                    elseif tick == 37 then
                        models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(false)
                    elseif tick == 47 then
                        FaceParts:setEmotion("FRUST", "TIRED", "FRUST", 17, true)
                    elseif tick == 49 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels(24, 0)
                        end
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(24, 0)
                    elseif tick == 64 then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1:setVisible(false)
                        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
                        Gun.TargetModel:setPos()
                        Gun.TargetModel:setRot()
                        Gun.TargetModel:setVisible(true)
                        FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 8, true)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.DamageIndicators:setVisible(false)
                        end
                    elseif tick == 72 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "ANXIOUS", 8, true)
                    elseif tick == 75 then
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.TextAnchor:setVisible(true)
                            events.RENDER:register(function ()
                                local windowSize = client:getScaledWindowSize()
                                models.models.ex_skill_1.Gui.TextAnchor:setPos(models.models.ex_skill_1.Gui.TextAnchor:getAnimPos():scale(windowSize.y / 2 / 100):add(0, windowSize.y * -1 + 30, 0))
                            end, "ex_skill_1_text_render")
                        end
                    elseif tick == 80 then
                        FaceParts:setEmotion("STARE", "STARE", "NORMAL2", 25, true)
                    elseif tick == 81 then
                        sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.25, 0.5)
                    end
                    if tick <= 36 and math.random() >= 0.75 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 0.1, 2)
                    end
                    if tick <= 36 and tick % 3 == 0 and host:isHost() then
                        sounds:playSound("minecraft:entity.player.attack.nodamage", player:getPos(), 0.25, 1)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    Gun.TargetModel:setVisible(false)
                    models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(true)
                    for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth}) do
                        modelPart:setUVPixels()
                    end
                    if forcedStop then
                        for i = 1, 8 do
                            BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[i]:stop()
                        end
                    end
                    if host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.DamageIndicators, models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes}) do
                            modelPart:setVisible(true)
                        end
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
                            modelPart:setVisible(false)
                        end
                        BlueArchiveCharacter.EX_SKILL_1_MIDORI_HP_VALUE:setText("12/20")
                        BlueArchiveCharacter.EX_SKILL_1_KO:setVisible(false)
                        for i = 1, 8 do
                            models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriHPBar["HpBar"..i]:setVisible(true)
                        end
                        models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll:setColor()
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes.EyeLeft, models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.MidoriPaperDollEyes.EyeRight, models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.MidoriPaperDoll.MidoriPaperDollHead.MidoriPaperDollFaceParts.Mouth}) do
                            modelPart:setUVPixels()
                        end
                        for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
                            events.RENDER:remove(eventName)
                        end
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

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

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

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1
            }
        },

        ---コールバック関数
        callbacks = {
            ---衣装が変更された時に実行されるコールバック関数
            ---デフォルトの衣装はここに含めない。
            ---@type fun(costumeId: integer)
            ---@param costumeId integer 新たな衣装のインデックス番号
            change = function(costumeId)
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
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
                        FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
                    elseif type == "HEART" then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "CLOSED", duration, true)
                    elseif type == "RELOAD" then
                        FaceParts:resetEmotion()
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("FRUST", "TIRED", "FRUST", duration, true)
                    end
                end
            end,

            ---吹き出しアニメーション終了時に実行されるコールバック関数（任意）
            ---@type fun(type: Bubble.BubbleType, forcedStop: boolean)
            ---@param type Bubble.BubbleType 再生された吹き出しエモートの種類
            ---@param forcedStop boolean 吹き出しエモートが途中終了した場合は"true"、吹き出しエモートが最後まで再生されて終了した場合は"false"が代入される。
            onStop = function(type, forcedStop)
                if forcedStop then
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
            modelPart = models.models.main.Avatar.UpperBody.Body.TailXPivot,

            ---x軸回転における物理演算データ（省略可）
            x = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -40,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 40,

                    ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                    ---@type number
                    sneakOffset = 15,

                    ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                    bodyY = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 40,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -40,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 40
                    }
                },

                ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                horizontal = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -40,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 40,

                    ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                    bodyX = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = 40,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -40,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 40
                    }
                }
            }
        },

        {
            ---この物理演算データを適用させるモデルパーツ
            ---@type ModelPart | ModelPart[]
            modelPart = models.models.main.Avatar.UpperBody.Body.TailXPivot.TailYPivot,

            ---y軸回転における物理演算データ（省略可）
            y = {
                ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                vertical = {
                    ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                    ---@type number
                    min = -40,

                    ---このモデルパーツ、回転軸の中立の回転位置（度）
                    ---@type number
                    neutral = 0,

                    ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                    ---@type number
                    max = 40,

                    ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                    bodyZ = {
                        ---この回転事象がモデルパーツに与える回転の倍率
                        ---@type number
                        multiplayer = -80,

                        ---この回転事象がモデルパーツに与える回転の最小値
                        ---@type number
                        min = -40,

                        ---この回転事象がモデルパーツに与える回転の最大値
                        ---@type number
                        max = 40
                    }
                }
            }
        }
    },

    --その他定数・変数
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_MOMOI_HP_NAME = models.models.ex_skill_1.Gui.DamageIndicators.MomoiDamageIndicator.HPBarBackground:newText("ex_skill_1_momoi_hp_name"):setText("MOMOI"):setPos(0, 16, -1):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"),
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_MOMOI_HP_VALUE = models.models.ex_skill_1.Gui.DamageIndicators.MomoiDamageIndicator.HPBarBackground:newText("ex_skill_1_momoi_hp_value"):setText("12/20"):setPos(0, -7, -1):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"),
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_MIDORI_HP_NAME = models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.HPBarBackground:newText("ex_skill_1_midori_hp_name"):setText("MIDORI"):setPos(0, 16, -1):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"),
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_MIDORI_HP_VALUE = models.models.ex_skill_1.Gui.DamageIndicators.MidoriDamageIndicator.HPBarBackground:newText("ex_skill_1_midori_hp_value"):setText("12/20"):setPos(0, -7, -1):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"),
    ---@diagnostic disable-next-line: undefined-field
    EX_SKILL_1_KO = models.models.ex_skill_1.Gui.DamageIndicators:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"):setOutline(true):setVisible(false),
    EX_SKILL_1_TEXT_ANIMATIONS = {ExSkillTextAnimation.new("damage_indicator_1", "2"), ExSkillTextAnimation.new("damage_indicator_2", "1"), ExSkillTextAnimation.new("damage_indicator_3", "2"), ExSkillTextAnimation.new("damage_indicator_4", "1"), ExSkillTextAnimation.new("damage_indicator_5", "2"), ExSkillTextAnimation.new("damage_indicator_6", "1"), ExSkillTextAnimation.new("damage_indicator_7", "2"), ExSkillTextAnimation.new("damage_indicator_8", "1")},
    ---@diagnostic disable-next-line: undefined-field
    Ex_SKILL_1_TEXT = models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§a§lMIDORI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
}

--生徒固有初期化処理

return BlueArchiveCharacter