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

---Exスキル2において射撃を行った人を指定するタイプ
---@alias BlueArchiveCharacter.ExSkill2ShotByType
---| "MOMOI" モモイが撃った
---| "MIDORI" ミドリが撃った

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
            CLOSED2 = {7, 0},
            STARE = {9, 0},
            INVERTED = {12, 0}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            TIRED = {3, 0},
            CLOSED = {2, 0},
            ANXIOUS = {5, 0},
            CLOSED2 = {6, 0},
            STARE = {9, 0},
            STARE2 = {7, 0},
            CENTER = {10, 0}
        },

        ---口
        Mouth = {
            NORMAL = {3, 0},
            FRUST = {2, 0},
            ANXIOUS = {1, 0},
            NORMAL2 = {4, 0},
            SMILE = {0, 0},
            SHOCK = {0, 1},
            TRIANGLE = {2, 1},
            SMILE_SMALL = {3, 1}
        },

        ---口のテクスチャの解像度の倍率。4x2を基準とする。
        ---@type number
        MouthResolutionMultiplayer = 4,

        ---表情のセット（省略可）
        FacePartsSets = {
            ---ダメージを受けた時の表情（省略可）
            onDamage = {
                RightEye = "SURPLISED",
                LeftEye = "SURPLISED",
                Mouth = "SHOCK"
            }

            ---寝ている時の表情（省略可）
            --[[
            onSleep = {
                RightEye = "CLOSED",
                LeftEye = "CLOSED",
                Mouth = "CLOSED"
            }
            ]]
        }
    },

    ---スカート
    SKIRT = {
        ---スカートとして制御するモデルの配列
        ---@type ModelPart
        SkirtModels = {models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1}
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

            ---一人称視点での位置オフセット（省略可）
            first_person_pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-0.5, 3, -8),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0.5, 3, -8)
            },

            --[[
            ---一人称視点での向きオフセット（省略可）
            first_person_rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            }
            ]]

            ---三人称視点での位置オフセット（省略可）
            third_person_pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-2, 3, -6),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(2, 3, -6)
            }

            --[[
            ---三人称視点での向きオフセット（省略可）
            third_person_rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            }
            ]]

            ---装填済みクロスボウの位置オフセット（省略可）
            --[[
            charged_crossbow_pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            }
            ]]

            ---装填済みクロスボウの向きオフセット（省略可）
            --[[
            charged_crossbow_rot = {
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
            type = "HIDDEN"

            ---位置オフセット（省略可）
            --[[
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3()
            }
            ]]

            ---向きオフセット（省略可）
            --[[
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

        ---射撃音
        sound = {
            ---使用するゲームの音源名
            ---@type Minecraft.soundID
            name = "minecraft:entity.firework_rocket.blast",

            ---音源のピッチ（0.5 ~ 2）
            ---@type number
            pitch = 1
        }

        --[[
        ---利き手が変更された時に呼び出される関数。利き手に応じた銃やアクセサリーの変更に利用できる。
        ---@param direction Gun.HandDirection 新たな利き手
        onMainHandChange = function (direction)
        end
        ]]
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
                en_us = "Drawing art",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "ドローイングアート"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "PIERCE",

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
                    if not BlueArchiveCharacter.EX_SKILL[1].isPrepared then
                        models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:addChild(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1:copy("GameConsole2"))
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS = {ExSkillTextAnimation.new("damage_indicator_1", "2"), ExSkillTextAnimation.new("damage_indicator_2", "1"), ExSkillTextAnimation.new("damage_indicator_3", "2"), ExSkillTextAnimation.new("damage_indicator_4", "1"), ExSkillTextAnimation.new("damage_indicator_5", "2"), ExSkillTextAnimation.new("damage_indicator_6", "1"), ExSkillTextAnimation.new("damage_indicator_7", "2"), ExSkillTextAnimation.new("damage_indicator_8", "1")}
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(vectors.vec3(1, 1, 1):scale(1.5)):setAlignment("CENTER"):setOutline(true):setVisible(false)
                            models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§a§lMIDORI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setColor(0.098, 0.2, 0.686)
                            for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar, models.models.ex_skill_1.Gui.UI.MidoriUI.RedBar}) do
                                modelPart:setPrimaryRenderType("EMISSIVE_SOLID")
                            end
                            models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_midori_name"):setText("§a§lMIDORI"):setPos(48, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1):setAlignment("RIGHT")
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setScale(2.3, 2.3, 2.3)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Head, "MidoriPaperDollHead"))
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getTruePivot():add(0, -24, 0))
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.HeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts:addChild(models.models.main.Avatar.Head.FaceParts.Mouth:copy("Mouth"))
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(64, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setVisible(true)
                            models.models.ex_skill_1.Gui.UI.DeadEye:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts)
                            for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getChildren()) do
                                modelPart:setVisible(false)
                            end
                            models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MidoriUI, "MomoiUI"))
                            for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getChildren()) do
                                modelPart:setVisible(true)
                            end
                            models.models.ex_skill_1.Gui.UI.MomoiUI.Frame:setRot(0, 180, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setPos(139.5, 0, 62)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setColor(0.71, 0.082, 0.067)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setPos(-36, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setScale(0.6, 1, 1)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar:setPrimaryRenderType("EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MomoiUI.RedBar:remove()
                            models.models.ex_skill_1.Gui.UI.MomoiPaperDollBody:moveTo(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setPos(0, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setRot(0, 15, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setOffsetPivot(139, -0.25, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Momoi.MomoiHead, "MomoiPaperDollHead"))
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getTruePivot():add(0, -24, 0))
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.MomoiHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(64, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI:newText("ex_skill_1_momoi_name"):setText("§d§lMOMOI"):setPos(130, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1)
                        end
                        BlueArchiveCharacter.EX_SKILL[1].isPrepared = true
                    end
                    if host:isHost() then
                        models.models.ex_skill_1.Gui.UI.MidoriUI:setPos(client:getScaledWindowSize().x * -1 + 220, 0, 0)
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
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
                    elseif tick == 15 then
                        FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "NORMAL", 22, true)
                    elseif tick == 22 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[1]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(0, 8)
                        end
                    elseif tick == 24 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[2]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 26 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[3]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 28 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[4]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 30 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[5]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 32 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[6]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 34 then
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[7]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                    elseif tick == 36 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 11, true)
                        BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[8]:play()
                        local playerPos = player:getPos()
                        sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.DeadEye:setVisible(true)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes:setVisible(false)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(16, 8)
                            local task = models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko")
                            task:setPos(client:getScaledWindowSize().x / 2 * -1, -12, -30)
                            task:setVisible(true)
                            events.RENDER:register(function (delta)
                                local count = ExSkill.AnimationCount - 37 + delta
                                task:setScale(vectors.vec3(1, 1, 1):scale(count <= 1.5 and (-1.667 * count + 5) or (count + 1)))
                            end, "ex_skill_1_ko_render")
                        end
                    elseif tick == 37 then
                        models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(false)
                    elseif tick == 38 and host:isHost() then
                        events.RENDER:remove("ex_skill_1_ko_render")
                        models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setScale(3, 3, 3)
                    elseif tick == 47 then
                        FaceParts:setEmotion("STARE", "TIRED", "FRUST", 17, true)
                    elseif tick == 49 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels(24, 0)
                        end
                        models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth:setUVPixels(48, 0)
                    elseif tick == 64 then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1:setVisible(false)
                        models.models.main.Avatar.UpperBody.Body.Gun:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setPos()
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setRot()
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setVisible(true)
                        FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 8, true)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI:setVisible(false)
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
                    models.models.ex_skill_1.Momoi.MomoiUpperBody.MomoiArms.MomoiLeftArm.MomoiLeftArmBottom.GameConsole2:setVisible(true)
                    for _, modelPart in ipairs({models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight, models.models.ex_skill_1.Momoi.MomoiHead.MomoiFaceParts.Mouth}) do
                        modelPart:setUVPixels()
                    end
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setVisible(false)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:moveTo(models.models.main.Avatar.UpperBody.Body)
                    end
                    if forcedStop then
                        for i = 1, 8 do
                            BlueArchiveCharacter.EX_SKILL_1_TEXT_ANIMATIONS[i]:stop()
                        end
                    end
                    if host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes}) do
                            modelPart:setVisible(true)
                        end
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
                            modelPart:setVisible(false)
                        end
                        models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setColor()
                        models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setVisible(false)
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeRight, models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeLeft}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(64, 0)
                        for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
                            events.RENDER:remove(eventName)
                        end
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
                en_us = "Virtual Maid Shot",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "バーチャル・メイドショット"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "VIBRATION",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.ex_skill_2},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "ex_skill_2", "costume_maid", "gun"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-14, 22, -13),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 135, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-18, 36, -9),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(40, 190, 0)
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
                    --デバッグ用
                    --models.models.main.Avatar:setVisible(false)

                    if not BlueArchiveCharacter.EX_SKILL[2].isPrepared then
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI:addChild(models.models.ex_skill_2.Gui.UI.MomoiUI.UI1:copy("UI1Shadow"))
                            models.models.ex_skill_2.Gui.UI.MomoiUI.UI1Shadow:setPos(-1, -1, 1)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.UI1Shadow:setColor(0, 0, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI:addChild(models.models.ex_skill_2.Momoi.MomoiUpperBody.MomoiArms.MomoiRightArm.MomoiRightArmBottom.Gun:copy("GunIcon"))
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setPos(-36, 15, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setRot(0, 90, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setScale(1.67, 1.67, 1.67)
                            for i = 2, 3 do
                                local icon = models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon1:copy("LifeIcon"..i)
                                models.models.ex_skill_2.Gui.UI.MomoiUI:addChild(icon)
                                icon:setPos((i - 1) * -15, 0, 0)
                            end
                            for _, modelPart in ipairs(models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets:getChildren()) do
                                modelPart:setColor(0.5, 0.5, 0.5)
                            end
                            for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon, models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets}) do
                                modelPart:setVisible(false)
                            end
                            models.models.ex_skill_2.Gui.UI.MomoiUI:setVisible(true)
                            models.models.ex_skill_2.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Gui.UI.MomoiUI, "MidoriUI"))
                            for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon, models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets}) do
                                modelPart:setVisible(true)
                            end
                            for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MidoriUI.UI1, models.models.ex_skill_2.Gui.UI.MidoriUI.UI1Shadow, models.models.ex_skill_2.Gui.UI.MidoriUI.UI2}) do
                                modelPart:setRot(0, 180, 0)
                            end
                            models.models.ex_skill_2.Gui.UI.MidoriBullets:moveTo(models.models.ex_skill_2.Gui.UI.MidoriUI)
                            for _, modelPart in ipairs(models.models.ex_skill_2.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets:getChildren()) do
                                modelPart:setColor(0.5, 0.5, 0.5)
                            end
                            models.models.ex_skill_2.Gui.UI.MidoriUI:addChild(models.models.main.Avatar.UpperBody.Body.Gun:copy("GunIcon"))
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setPos(52, 15, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setRot(0, 90, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setScale(2.5, 2.5, 2.5)
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setVisible(true)
                            for i = 1, 3 do
                                models.models.ex_skill_2.Gui.UI.MidoriUI["LifeIcon"..i]:setPos(22 - (i - 1) * 15, 0, 0)
                            end
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:addChild(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.Frame:copy("FrameShadow"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.FrameShadow:setPos(-1, -1, 1)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.FrameShadow:setColor(0, 0, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.Background:setColor(1, 0.643, 0.71)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Momoi.MomoiHead, "MomoiPaperDollHead"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:getTruePivot():add(-64, -24, 0))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setScale(4.1, 4.1, 4.1)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts:addChild(models.models.main.Avatar.Head.FaceParts.Mouth:copy("Mouth"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setVisible(true)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:newText("ex_skill_2_gameover_text"):setText("§c§lGAME\nOVER"):setPos(32, -5, 0):setWidth(64):setAlignment("CENTER"):setScale(2, 2, 2):setShadow(true):setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setVisible(true)
                            models.models.ex_skill_2.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Gui.UI.MomoiHeadUI, "MidoriHeadUI"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(true)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.Background:setColor(0.573, 0.98, 0.604)
                            ---@diagnostic disable-next-line: discard-returns
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI:newPart("MidoriPaperDoll", "None")
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setScale(4.1, 4.1, 4.1)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setOffsetPivot(33.25, 12.5, 16)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setRot(0, -15, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Head, "MidoriPaperDollHead"))
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts:addChild(models.models.main.Avatar.Head.FaceParts.Mouth:copy("Mouth"))
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(0, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setVisible(true)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPrimaryRenderType("CUTOUT")
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:getTruePivot():add(0, -24, 0))
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.HeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody, "MidoriPaperDollBody"))
                            --models.models.ex_skill_2.Gui:setParentType("World")
                        end
                        BlueArchiveCharacter.EX_SKILL[2].isPrepared = true
                    end

                    if host:isHost() then
                        models.models.ex_skill_2.Gui:setVisible(true)
                        local windowsSize = client:getScaledWindowSize()
                        models.models.ex_skill_2.Gui.UI.MomoiUI:setPos(-90, (windowsSize.y - 20) * -1, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriUI:setPos(windowsSize.x * -1 + 10, (windowsSize.y - 20) * -1, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI:setPos(windowsSize.x * -1 + 88, 0, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI:setOffsetPivot(windowsSize.x * -1 + 88, 0, 0)
                        models.models.ex_skill_2.Gui.UI.DamageEffect:setPos(windowsSize.x * -0.5, 0, 0)
                        models.models.ex_skill_2.Gui.UI.DamageEffect.CrackEffect:setPrimaryTexture("RESOURCE", "minecraft:textures/block/destroy_stage_9.png")
                        models.models.ex_skill_2.Gui.UI.DamageEffect.RedEffect:setScale(windowsSize.x / 12, windowsSize.y, 1)
                        models.models.ex_skill_2.Gui.UI.DamageEffect.CrackEffect:setScale(vectors.vec3(1, 1, 1):scale(windowsSize.y / 16))
                        events.RENDER:register(function ()
                            local windowHalfX = windowsSize.x / 2
                            models.models.ex_skill_2.Gui.UI.DamageEffect.RedEffect:setPos(models.models.ex_skill_2.Gui.UI.DamageEffect.RedEffectAnchor:getAnimPos().x * windowHalfX + windowHalfX, 0, 0)
                            models.models.ex_skill_2.Gui.UI.DamageEffect.CrackEffect:setOpacity(models.models.ex_skill_2.Gui.UI.DamageEffect.CrackEffectAnchor:getAnimPos().x * -1)
                        end, "ex_skill_2_damege_effect_render")
                        models.models.ex_skill_2.Gui.UI:setVisible(true)
                    end
                    models.models.main.Avatar.UpperBody.Body.Gun:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
                    models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setPos()
                    models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setVisible(true)
                    models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft:setUVPixels(24, 0)
                    models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight:setUVPixels(12, 0)
                    FaceParts:setEmotion("NORMAL", "CENTER", "NORMAL", 16, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    --Exスキルアニメーションを任意のティックで停止させるスニペット。デバッグ用。
                    --"<>"内を適切な値で置換すること。
                    if tick == 1000 then
                        for _, animation in ipairs(BlueArchiveCharacter.EX_SKILL[2].animations) do
                            animations["models."..animation]["ex_skill_"..2]:pause()
                        end
                    end

                    ---銃弾のパーティクルを出す。
                    ---@param anchor ModelPart パーティクルを出す場所を示すアンカーポイント
                    ---@param offsetRotX number パーティクルの射出方向のX軸オフセット値
                    ---@param offsetRotY number パーティクルの射出方向のY軸オフセット値
                    ---@param whoShot BlueArchiveCharacter.ExSkill2ShotByType 射撃した人を指定する。
                    local function bulletParticle(anchor, offsetRotX, offsetRotY, whoShot)
                        local anchorPos = ModelUtils.getModelWorldPos(anchor)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity( vectors.rotateAroundAxis(bodyYaw * -1 + offsetRotY, vectors.rotateAroundAxis(offsetRotX, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0.1, 1, 0, 0), 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
                        end
                        local muzzleAnchorPos =  ModelUtils.getModelWorldPos(whoShot == "MIDORI" and models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun.MuzzleAnchor or models.models.ex_skill_2.Momoi.MomoiUpperBody.MomoiArms.MomoiRightArm.MomoiRightArmBottom.Gun.MuzzleAnchor)

                        for _ = 1, 5 do
                            particles:newParticle("minecraft:smoke", muzzleAnchorPos)
                        end
                    end

                    ---射撃音を再生する。
                    local function shotSound()
                        sounds:playSound("minecraft:entity.firework_rocket.blast", ModelUtils.getModelWorldPos(host:isHost() and models.models.main.CameraAnchor or models.models.main.Avatar), 1, math.random() * 0.25 + 0.5)
                    end

                    if tick == 13 then
                        models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                        models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight:setUVPixels(24, 0)
                    elseif tick == 16 then
                        FaceParts:setEmotion("INVERTED", "NORMAL", "NORMAL", 14, true)
                    elseif tick == 27 and host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        local centerX = windowSize.x / 2 * -1
                        local centerY = windowSize.y / 2 * -1
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.Reticules.MomoiReticuleAnchor, models.models.ex_skill_2.Gui.Reticules.MidoriReticuleAnchor}) do
                            modelPart:setPos(centerX, centerY, 0)
                        end
                        models.models.ex_skill_2.Gui.Reticules:setVisible(true)
                        events.RENDER:register(function ()
                            models.models.ex_skill_2.Gui.Reticules.MomoiReticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_2.Gui.Reticules.MomoiReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
                            models.models.ex_skill_2.Gui.Reticules.MidoriReticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_2.Gui.Reticules.MidoriReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
                        end, "ex_skill_2_reticule_render")
                    elseif tick == 30 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 125, true)
                    elseif tick == 37 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor1, 0, 90, "MOMOI")
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet24:setColor()
                        end
                    elseif tick == 39 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor9, 0, 90, "MOMOI")
                        shotSound()
                    elseif tick == 41 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor2, 0, 90, "MOMOI")
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet23:setColor()
                        end
                    elseif tick == 48 and host:isHost() then
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeLeft:setUVPixels(36, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeRight:setUVPixels(30, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
                        models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon1:setVisible(false)
                    elseif tick == 49 then
                        bulletParticle(models.models.ex_skill_2.Pillagers.Pillager1.Pillager1Head.ExSkill2ParticleAnchor5, 0, 0, "MIDORI")
                        shotSound() --ミドリの射撃音
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets.BulletM20:setColor()
                        end
                    elseif tick == 54 and host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor()
                    elseif tick == 61 then
                        bulletParticle(models.models.ex_skill_2.ExSkill2ParticleAnchor3, -90, 0, "MOMOI")
                        shotSound()
                    elseif tick == 63 then
                        bulletParticle(models.models.ex_skill_2.ExSkill2ParticleAnchor10, -90, 0, "MOMOI")
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet22:setColor()
                        end
                    elseif tick == 65 then
                        bulletParticle(models.models.ex_skill_2.ExSkill2ParticleAnchor11, -90, 0, "MOMOI")
                        shotSound()
                    elseif tick == 70 and host:isHost() then
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeLeft:setUVPixels(36, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeRight:setUVPixels(30, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(32, 0)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
                        models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon2:setVisible(false)
                    elseif tick == 73 and host:isHost() then
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor()
                    elseif tick == 74 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack2.ExSkill2ParticleAnchor12, 0, -90, "MOMOI")
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack3.ExSkill2ParticleAnchor6, 0, 0, "MIDORI")
                        shotSound() --ミドリの射撃音
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet21:setColor()
                        end
                    elseif tick == 76 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack2.ExSkill2ParticleAnchor4, 0, 0, "MOMOI")
                        shotSound()
                    elseif tick == 78 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack2.ExSkill2ParticleAnchor13, 0, -90, "MOMOI")
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet20:setColor()
                        end
                    elseif tick == 81 and host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.Reticules.MomoiReticule, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon3, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes}) do
                            modelPart:setVisible(false)
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody.DeadEye:setVisible(true)
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(48, 0)
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiUI, models.models.ex_skill_2.Gui.UI.MomoiHeadUI}) do
                            modelPart:setColor(0.25, 0.25, 0.25)
                        end
                        local task = models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text")
                        ---@diagnostic disable-next-line: undefined-field
                        task:setText("§c§lGAME\nOVER")
                        task:setVisible(true)
                    elseif tick == 83 and host:isHost() then
                        ---@diagnostic disable-next-line: undefined-field
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text"):setText("§4§lGAME\nOVER")
                    elseif tick == 85 and host:isHost() then
                        ---@diagnostic disable-next-line: undefined-field
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text"):setText("§c§lGAME\nOVER")
                    elseif tick == 87 and host:isHost() then
                        ---@diagnostic disable-next-line: undefined-field
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text"):setText("§4§lGAME\nOVER")
                    elseif tick == 89 and host:isHost() then
                        ---@diagnostic disable-next-line: undefined-field
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text"):setText("§c§lGAME\nOVER")
                    elseif tick == 92 then
                        sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.749154)
                    elseif tick == 93 then
                        bulletParticle(models.models.ex_skill_2.Pillagers.Pillager2.Pillager2Body.ExSkill2ParticleAnchor7, 0, 0, "MIDORI")
                        shotSound() --ミドリの射撃音
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets.BulletM19:setColor()
                        end
                    elseif tick == 94 then
                        sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.667420)
                    elseif tick == 96 then
                        sounds:playSound("minecraft:block.note_block.bit", host:isHost() and ModelUtils.getModelWorldPos(models.models.main.CameraAnchor) or player:getPos(), 1, 0.594604)
                    elseif tick == 111 then
                        bulletParticle(models.models.ex_skill_2.Pillagers.Pillager3.Pillager3Body.ExSkill2ParticleAnchor8, 0, 0, "MIDORI")
                        shotSound() --ミドリの射撃音
                    elseif tick == 125 then
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(18, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(12, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth:setUVPixels(64, 8)
                    elseif tick == 154 then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom)
                    elseif tick == 155 then
                        FaceParts:setEmotion("INVERTED", "NORMAL", "NORMAL", 2, true)
                        if host:isHost() then
                            for _, modelPart in ipairs({models.models.ex_skill_2.Gui.Reticules, models.models.ex_skill_2.Gui.UI}) do
                                modelPart:setVisible(false)
                            end
                            for _, eventName in ipairs({"ex_skill_2_reticule_render", "ex_skill_2_damege_effect_render"}) do
                                events.RENDER:remove(eventName)
                            end
                        end
                    elseif tick == 157 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 3, true)
                    elseif tick == 160 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "NORMAL", 7, true)
                    elseif tick == 167 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "NORMAL", 2, true)
                    elseif tick == 169 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 9, true)
                    elseif tick == 178 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE_SMALL", 25, true)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setVisible(false)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:moveTo(models.models.main.Avatar.UpperBody.Body)
                    elseif models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Gun:setVisible(false)
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Gun:moveTo(models.models.main.Avatar.UpperBody.Body)
                    end
                    for _, modelPart in ipairs({models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Eyes.EyeRight, models.models.ex_skill_2.Momoi.MomoiHead.MomoiFaceParts.Mouth}) do
                        modelPart:setUVPixels()
                    end
                    if host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.Reticules.MomoiReticule, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon1, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon2, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon3, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes}) do
                            modelPart:setVisible(true)
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody.DeadEye:setVisible(false)
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Eyes.EyeRight, models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Eyes.EyeRight, models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.FaceParts.Mouth}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.MomoiFaceParts.Mouth:setUVPixels(16, 0)
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiUI, models.models.ex_skill_2.Gui.UI.MomoiHeadUI, }) do
                            modelPart:setColor()
                        end
                        for i = 20, 24 do
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets["Bullet"..i]:setColor(0.5, 0.5, 0.5)
                        end
                        for i = 19, 20 do
                            models.models.ex_skill_2.Gui.UI.MidoriUI.MidoriBullets.MidoriRearBullets["BulletM"..i]:setColor(0.5, 0.5, 0.5)
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:getTask("ex_skill_2_gameover_text"):setVisible(false)
                        if forcedStop then
                            for _, modelPart in ipairs({models.models.ex_skill_2.Gui.Reticules, models.models.ex_skill_2.Gui.UI}) do
                                modelPart:setVisible(false)
                            end
                            for _, eventName in ipairs({"ex_skill_2_reticule_render", "ex_skill_2_damege_effect_render"}) do
                                events.RENDER:remove(eventName)
                            end
                        end
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postTransition = function(forcedStop)
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
                name = "maid",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Maid",

                    ---日本語
                    ---@type string
                    ja_jp = "メイド"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

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
                for _, modelPart in ipairs({models.models.main.Avatar.Head.Head, models.models.main.Avatar.Head.HatLayer}) do
                    modelPart:setUVPixels(0, 16)
                end
                Costume.setCostumeTextureOffset(1)
                for _, modelPart in ipairs({models.models.main.Avatar.Head.HairRibbons, models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Arms.RightArm.GDDLabel, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightCoat, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftCoat}) do
                    modelPart:setVisible(false)
                end
                for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaidH, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CMaidRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CMaidLAB}) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.CMaidB:setVisible(not Armor.ArmorVisible[3])
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
                for _, modelPart in ipairs({models.models.main.Avatar.Head.Head, models.models.main.Avatar.Head.HatLayer}) do
                    modelPart:setUVPixels()
                end
                Costume.setCostumeTextureOffset(0)
                for _, modelPart in ipairs({models.models.main.Avatar.Head.HairRibbons, models.models.main.Avatar.UpperBody.Arms.RightArm.GDDLabel, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightCoat, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftCoat}) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[3])
                for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaidH, models.models.main.Avatar.UpperBody.Body.CMaidB}) do
                    modelPart:setVisible(false)
                end
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
                if parts == "HELMET" then
                    models.models.main.Avatar.Head.Sweat:setPos(0, 0, Armor.ArmorVisible[1] and -1 or 0)
                elseif parts == "LEGGINGS" then
                    if Costume.CurrentCostume == 1 then
                        models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[3])
                    else
                        models.models.main.Avatar.UpperBody.Body.CMaidB:setVisible(not Armor.ArmorVisible[3])
                    end
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
                        FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", duration, true)
                    elseif type == "HEART" then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", duration, true)
                    elseif type == "NOTE" then
                        FaceParts:setEmotion("STARE", "STARE2", "NORMAL2", duration, true)
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("SURPLISED", "SURPLISED", "SHOCK", duration, true)
                    elseif type == "SWEAT" then
                        FaceParts:setEmotion("STARE", "TIRED", "FRUST", duration, true)
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

    ---頭ブロック
    HEAD_BLOCK = {
        ---頭以外のモデルパーツで頭ブロックにアタッチしたいモデルパーツを配列形式で列挙する。
        ---@type ModelPart>[]
        includeModels = {},

        ---頭のモデルパーツで頭ブロックから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart>[]
        excludeModels = {}

        --[[
        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
        end
        ]]

        --[[
        ---モデルのコピー直後に実行される関数（省略可）
        onAfterModelCopy = function ()
        end
        ]]
    },

    ---ポートレート
    PORTRAIT = {
        ---頭以外のモデルパーツでポートレートにアタッチしたいモデルパーツを配列形式で列挙する。
        ---@type ModelPart>[]
        includeModels = {},

        ---頭のモデルパーツでポートレートから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart>[]
        excludeModels = {models.models.main.Avatar.Head.Phone}

        --[[
        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
        end
        ]]

        --[[
        ---モデルのコピー直後に実行される関数（省略可）
        onAfterModelCopy = function ()
        end
        ]]
    },

    ---死亡アニメーションのダミーアバター
    DEATH_ANIMATION = {
        ---ダミーアバターから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart>[]
        excludeModels = {},

        ---死亡アニメーションが再生された直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase1 = function (dummyAvatar, costume)
            dummyAvatar.UpperBody.Body.Skirt:setRot(70, 0, 0)
        end,

        ---ダミーアバターが縄ばしごにつかまった直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase2 = function (dummyAvatar, costume)
            dummyAvatar.UpperBody.Body.Skirt:setRot(22.5, 0, 0)
        end

        --[[
        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
        end
        ]]

        --[[
        ---モデルのコピー直後に実行される関数（省略可）
        onAfterModelCopy = function ()
        end
        ]]
    },

    ---物理演算
    PHYSICS = {
        data = {
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
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CMaidH.HairTail,

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
                modelPart = models.models.main.Avatar.Head.CMaidH.HairTail.HairTailZPivot,

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
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonRight,

                ---y軸回転における物理演算データ（省略可）
                y = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -70,

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
                            multiplayer = -40,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -70,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.025,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -70,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -70,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 0,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 40,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -70,

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
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonRight.RibbonRightZPivot,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -20,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 20,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -20,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 20
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -20,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 20,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -20,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 20
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonLeft,

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
                        max = 70,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 40,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 70
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -0.025,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 70
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
                        max = 70,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -40,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 70
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonLeft.RibbonLeftZPivot,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -20,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 20,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -20,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 20
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -20,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 20,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -20,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 20
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = {models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight, models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft},

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
                            min = -60,

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
                        min = -140,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 0,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -60,

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
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight.RibbonBottomRightZPivot,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -22.5,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 15,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 10,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -22.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 15
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -0.025,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -22.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 15
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -22.5,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 10,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -22.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 15
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft.RibbonBottomLeftZPivot,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -15,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 22.5,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -10,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -15,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 22.5
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.025,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -15,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 22.5
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -22.5,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 10,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -22.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 15
                        }
                    }
                }
            }
        },

        ---物理演算処理後に実行されるコールバック関数（省略可）。ここでモデルパーツの向きを上書きできる。
        ---@param modelPart ModelPart 物理演算が処理されたモデルパーツ
        callback = function (modelPart)
            local playerPose = player:getPose()
            local isHorizontal = playerPose == "SWIMMING" or playerPose == "FALL_FLYING"
            if (modelPart == models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight or modelPart == models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft) and isHorizontal then
                modelPart:setRot(modelPart:getRot():scale(1 - math.clamp(Physics.VelocityAverage[5], 0, 1.6) / 1.6))
            end
        end
    }

    --その他定数・変数
}

---脚と丈の長いスカートの調整が有効かどうか
---@type boolean
local legAdjustmentEnabled = true

---前ティックに脚とスカートの調整をしたかどうか
---@type boolean
local legAdjustedPrev = false

---前ティックは脚を隠すべきだったかどうか
---@type boolean
local shouldHideLegsPrev = false

events.TICK:register(function ()
    local skirtVisible = models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1:getVisible()
    local shouldHideLegs = skirtVisible and player:getVehicle() ~= nil
    if shouldHideLegs and not shouldHideLegsPrev then
        models.models.main.Avatar.LowerBody.Legs:setVisible(false)
        models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1:setScale(1.2, 0.35, 1.5)
    elseif not shouldHideLegs and shouldHideLegsPrev then
        models.models.main.Avatar.LowerBody.Legs:setVisible(true)
        models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1:setScale()
    end
    local shouldAdjustLegs = legAdjustmentEnabled and skirtVisible and not shouldHideLegs
    if shouldAdjustLegs and not legAdjustedPrev then
        events.RENDER:register(function ()
            local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
            models.models.main.Avatar.LowerBody.Legs.RightLeg:setRot(rightLegRotX * -0.45, 0, 0)
            models.models.main.Avatar.LowerBody.Legs.LeftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.45, 0, 0)
            local rightLegRotAbs = math.abs(rightLegRotX)
            local playerPose = player:getPose()
            local skirtFlipVal = math.min(math.abs(Physics.VelocityAverage[7]) * 0.00025 + ((playerPose == "SWIMMING" or playerPose == "FALL_FLYING") and 0 or math.max(Physics.VelocityAverage[2] * -0.25, 0)), 0.5)
            models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1:setScale(1 + skirtFlipVal, 1 - skirtFlipVal, rightLegRotAbs * 0.001 + 1 + skirtFlipVal)
            models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
            models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2.Skirt3:setScale(rightLegRotAbs * -0.0001 + 1, 1, rightLegRotAbs * 0.001 + 1)
            models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2.Skirt3.Skirt4:setScale(rightLegRotAbs * -0.00005 + 1, 1, rightLegRotAbs * 0.0005 + 1)
        end, "skirt_render")
    elseif not shouldAdjustLegs and legAdjustedPrev then
        events.RENDER:remove("skirt_render")
        for _, modelPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg}) do
            modelPart:setRot()
        end
        if not shouldHideLegs then
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1, models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2, models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2.Skirt3, models.models.main.Avatar.UpperBody.Body.CMaidB.Skirt1.Skirt2.Skirt3.Skirt4}) do
                modelPart:setScale()
            end
        end
    end
    shouldHideLegsPrev = shouldHideLegs
    legAdjustedPrev = shouldAdjustLegs
end)

return BlueArchiveCharacter