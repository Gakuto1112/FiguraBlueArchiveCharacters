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
            en_us = "Momoi",

            ---日本語
            ---@type string
            ja_jp = "モモイ"
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
            SURPLISED2 = {5, 0},
            ANGRY = {6, 0},
            ANXIOUS = {1, 1},
            UNEQUAL = {3, 1},
            ANGRY_CENTER = {7, 0}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            TIRED = {3, 0},
            CLOSED = {2, 0},
            SURPLISED2 = {4, 0},
            ANGRY2 = {-1, 1},
            ANXIOUS = {1, 1},
            UNEQUAL = {2, 1},
            ANGRY = {7, 0},
            ANGRY_INVERTED = {8, 0},
            NORMAL_CENTER = {3, 1}
        },

        ---口
        Mouth = {
            FUN = {3, 0},
            ANXIOUS = {2, 0},
            SHOCK = {1, 0},
            ANGRY = {0, 1},
            OPENED = {0, 0},
            SMILE = {2, 1},
            TRIANGLE = {3, 1}
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
                en_us = "Agony of creation",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "生みの苦しみ"
            },

            ---スキルの種類
            ---アクションホイールの色に影響を与える。ゲーム内での生徒の攻撃属性と同じにする。
            ---@type BlueArchiveCharacter.SkillType
            skillType = "PIERCE",

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.Head.EffectPanel, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1, models.models.ex_skill_1.Midori, models.models.ex_skill_1.Gui},

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
                    pos = vectors.vec3(-12, 7, -28),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-10, 200, -25)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(4, 18, 15),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(10, 40, 0)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    if not BlueArchiveCharacter.EX_SKILL[1].isPrepared then
                        models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:addChild(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.GameConsole1:copy("GameConsole2"))
                        BlueArchiveCharacter.ExSkill1TextAnimations = {ExSkillTextAnimation.new("damage_indicator_1", "4"), ExSkillTextAnimation.new("damage_indicator_2", "3"), ExSkillTextAnimation.new("damage_indicator_3", "5")}
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI:newText("ex_skill_1_ko"):setText("§cK.O."):setScale(1.5, 1.5, 1.5):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.33, 0, 0):setVisible(false)
                            models.models.ex_skill_1.Gui.TextAnchor:newText("ex_skill_1:text"):setText("§d§lMOMOI"):setScale(4, 4, 4):setAlignment("RIGHT"):setOutline(true):setOutlineColor(1, 1, 1)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.Background:setColor(0.71, 0.082, 0.067)
                            for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.YellowBar, models.models.ex_skill_1.Gui.UI.MomoiUI.RedBar}) do
                                modelPart:setPrimaryRenderType("EMISSIVE_SOLID")
                            end
                            models.models.ex_skill_1.Gui.UI.MomoiUI:newText("ex_skill_1_momoi_name"):setText("§d§lMOMOI"):setPos(130, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setScale(2.3, 2.3, 2.3)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Head, "MomoiPaperDollHead"))
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getTruePivot():add(0, -24, 0))
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.HeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts:addChild(models.models.main.Avatar.Head.FaceParts.Mouth:copy("Mouth"))
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setVisible(true)
                            models.models.ex_skill_1.Gui.UI.DeadEye:moveTo(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts)
                            for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
                                modelPart:setVisible(false)
                            end
                            models.models.ex_skill_1.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Gui.UI.MomoiUI, "MidoriUI"))
                            for _, modelPart in ipairs(models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:getChildren()) do
                                modelPart:setVisible(true)
                            end
                            models.models.ex_skill_1.Gui.UI.MidoriUI.Frame:setRot(0, 180, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setPos(-139.5, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.Background:setColor(0.098, 0.2, 0.686)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPos(36, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setOffsetPivot(-135, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setScale(0.7, 1, 1)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.YellowBar:setPrimaryRenderType("EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MidoriUI.RedBar:remove()
                            models.models.ex_skill_1.Gui.UI.MidoriPaperDollBody:moveTo(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollBody:setPos(-139, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setPos(0, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setRot(0, -15, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:setOffsetPivot(-139, 0, 0)
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_1.Midori.MidoriHead, "MidoriPaperDollHead"))
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead:setPos(models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll:getTruePivot():add(0, -24, 0))
                            models.models.ex_skill_1.Gui.UI.MidoriUI.PaperDoll.MidoriPaperDollHead.MidoriHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_1.Gui.UI.MidoriUI:newText("ex_skill_1_midori_name"):setText("§a§lMIDORI"):setPos(48, 13, 0):setScale(1.5, 1.5, 1.5):setOutline(true):setOutlineColor(1, 1, 1):setAlignment("RIGHT")
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
                        FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", 16, true)
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.5)
                    elseif tick == 1 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 1.75)
                    elseif tick == 2 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 1, 2)
                    elseif tick == 14 then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels(12, 0)
                        end
                    elseif tick == 16 then
                        FaceParts:setEmotion("ANXIOUS", "ANXIOUS", "ANXIOUS", 24, true)
                    elseif tick == 24 then
                        BlueArchiveCharacter.ExSkill1TextAnimations[1]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
                        end
                    elseif tick == 27 and host:isHost() then
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
                    elseif tick == 31 then
                        BlueArchiveCharacter.ExSkill1TextAnimations[2]:play()
                        sounds:playSound("minecraft:entity.generic.hurt", player:getPos(), 0.25, 1)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
                        end
                    elseif tick == 34 and host:isHost() then
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
                    elseif tick == 36 then
                        BlueArchiveCharacter.ExSkill1TextAnimations[3]:play()
                        local playerPos = player:getPos()
                        sounds:playSound("minecraft:entity.generic.hurt", playerPos, 0.25, 1)
                        sounds:playSound("minecraft:entity.player.levelup", playerPos, 1, 1.5)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes:setVisible(false)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 8)
                            models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye:setVisible(true)
                            local task = models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko")
                            task:setPos(client:getScaledWindowSize().x / 2 * -1, -12, -30)
                            task:setVisible(true)
                            events.RENDER:register(function (delta)
                                local count = ExSkill.AnimationCount - 37 + delta
                                task:setScale(vectors.vec3(1, 1, 1):scale(count <= 1.5 and (-1.667 * count + 5) or (count + 1)))
                            end, "ex_skill_1_ko_render")
                        end
                    elseif tick == 38 then
                        models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeLeft:setUVPixels(24, 0)
                        models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight:setUVPixels(18, 0)
                        if host:isHost() then
                            events.RENDER:remove("ex_skill_1_ko_render")
                            models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setScale(3, 3, 3)
                        end
                    elseif tick == 40 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "ANXIOUS", 3, true)
                        models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs)
                        for _, modelPart in ipairs({models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                    elseif tick == 43 then
                        FaceParts:setEmotion("SURPLISED2", "SURPLISED2", "SHOCK", 24, true)
                    elseif tick == 66 then
                        models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeLeft:setUVPixels(24, 0)
                        models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight:setUVPixels(18, 0)
                    elseif tick == 67 then
                        models.models.ex_skill_1.Gui.UI:setVisible(false)
                        FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", 41, true)
                        models.models.main.Avatar.Head.EffectPanel:setUVPixels(9, 0)
                        if host:isHost() then
                            models.models.ex_skill_1.Gui.TextAnchor:setVisible(true)
                            events.RENDER:register(function ()
                                local windowSize = client:getScaledWindowSize()
                                models.models.ex_skill_1.Gui.TextAnchor:setPos(models.models.ex_skill_1.Gui.TextAnchor:getAnimPos():scale(windowSize.y / 2 / 100):add(0, windowSize.y * -1 + 30, 0))
                            end, "ex_skill_1_text_render")
                        end
                    elseif tick == 83 then
                        sounds:playSound("minecraft:entity.generic.explode", player:getPos(), 0.25, 0.5)
                    end
                    if tick <= 38 and math.random() >= 0.75 then
                        sounds:playSound("minecraft:block.note_block.bit", player:getPos(), 0.1, 2)
                    end
                    if tick <= 38 and tick % 3 == 0 and host:isHost() then
                        sounds:playSound("minecraft:entity.player.attack.nodamage", player:getPos(), 0.25, 1)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.EffectPanel, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeLeft, models.models.ex_skill_1.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight}) do
                        modelPart:setUVPixels()
                    end
                    if models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2 ~= nil then
                        models.models.ex_skill_1.Midori.MidoriLowerBody.MidoriLegs.GameConsole2:moveTo(models.models.ex_skill_1.Midori.MidoriUpperBody.MidoriArms.MidoriLeftArm.MidoriLeftArmBottom)
                    end
                    if forcedStop then
                        for i = 1, 3 do
                            BlueArchiveCharacter.ExSkill1TextAnimations[i]:stop()
                        end
                    end
                    if host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes}) do
                            modelPart:setVisible(true)
                        end
                        for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.DeadEye, models.models.ex_skill_1.Gui.TextAnchor}) do
                            modelPart:setVisible(false)
                        end
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 16)
                        models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll:setColor()
                        models.models.ex_skill_1.Gui.UI:getTask("ex_skill_1_ko"):setVisible(false)
                        for _, eventName in ipairs ({"ex_skill_1_text_render", "ex_skill_1_ko_render"}) do
                            events.RENDER:remove(eventName)
                        end
                        if forcedStop then
                            for _, modelPart in ipairs({models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight, models.models.ex_skill_1.Gui.UI.MomoiUI.PaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft}) do
                                modelPart:setUVPixels()
                            end
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
                en_us = "Virtual Maid Weapon!",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "バーチャル・メイドウェポン！"
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
			animations = {"main", "costume_maid", "gun", "ex_skill_2"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(9, 32, -47),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(20, -155, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(19, 36.1, -14.5),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(45, -210, 0)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    if not BlueArchiveCharacter.EX_SKILL[2].isPrepared then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Pillagers.Pillager1.Pillager1Head.PillagerHead, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1Head.Pillager1Nose, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1Body, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1RightArm, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1LeftArm, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1RightLeg, models.models.ex_skill_2.Pillagers.Pillager1.Pillager1LeftLeg}) do
                            modelPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/illager/pillager.png")
                        end
                        for _, part in ipairs({"Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}) do
                            for i = 2, 3 do
                                models.models.ex_skill_2.Pillagers["Pillager"..i]["Pillager"..i..part]:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Pillagers.Pillager1["Pillager1"..part]))
                            end
                        end
                        for y = 0, 1 do
                            for x = 0, 1 do
                                models.models.ex_skill_2.Covers.CoverLeft:newBlock("ex_skill_2_block_"..y * 2 + x):setBlock("minecraft:barrel[facing=up]"):setPos(x * 16, y * 16, 0)
                            end
                        end
                        models.models.ex_skill_2.Covers.CoverLeft:newBlock("ex_skill_2_block_4"):setBlock("minecraft:barrel[facing=up]"):setPos(16, 0, -16)
                        --models.models.ex_skill_2.Covers.CoverLeft:newBlock("ex_skill_2_block_5"):setBlock("minecraft:decorated_pot"):setPos(16, 16, -16) --ブロックタスクで何故か飾り壺が描画されない...
                        for i = 0, 1 do
                            models.models.ex_skill_2.Covers.CoverRight:newBlock("ex_skill_2_block_"..6 + i):setBlock("minecraft:barrel[facing=up]"):setPos(-16, i * 16, 0)
                        end
                        for i = 0, 1 do
                            models.models.ex_skill_2.Covers.CoverRight:newBlock("ex_skill_2_block_"..8 + i):setBlock("minecraft:barrel[facing=up]"):setPos(-32, 0, i * -16)
                        end
                        for i = 0, 1 do
                            models.models.ex_skill_2.Covers.CoverBack1:newBlock("ex_skill_2_block_"..10 + i):setBlock("minecraft:barrel[facing=up]"):setPos(i * 16, 0, 0)
                        end
                        models.models.ex_skill_2.Covers.CoverBack1:newBlock("ex_skill_2_block_12"):setBlock("minecraft:barrel[facing=up]"):setPos(16, 16, 0)
                        --models.models.ex_skill_2.Covers.CoverBack1:newBlock("ex_skill_2_block_13"):setBlock("minecraft:dirt"):setPos(0, 16, 0) --ブロックタスクで何故か飾り壺が描画されない...
                        for i = 0, 1 do
                            models.models.ex_skill_2.Covers.CoverBack2:newBlock("ex_skill_2_block_"..14 + i):setBlock("minecraft:chiseled_bookshelf[facing=north,slot_0_occupied=true,slot_1_occupied=true,slot_2_occupied=true,slot_3_occupied=true,slot_4_occupied=true,slot_5_occupied=true]"):setPos(-8, i * 16, -8)
                        end
                        for i = 0, 1 do
                            models.models.ex_skill_2.Covers.CoverBack3:newBlock("ex_skill_2_block_"..16 + i):setBlock("minecraft:red_wool"):setPos(-8, i * 16, -8)
                        end
                        models.models.ex_skill_2.Covers.CoverBack4:newBlock("ex_skill_2_block_18"):setBlock("minecraft:dark_oak_planks"):setPos(0, 0, 0)
                        --models.models.ex_skill_2.Covers.CoverBack4:newBlock("ex_skill_2_block_19"):setBlock("minecraft:dirt"):setPos(-16, 16, 0) --ブロックタスクで何故か飾り壺が描画されない...
                        for y = 0, 6 do
                            for x = 0, 8 do
                                local blockCount = y * 9 + x
                                models.models.ex_skill_2.Wall:newBlock("ex_skill_2_block_"..20 + blockCount):setBlock( (blockCount == 13 or blockCount == 22 or blockCount == 29 or blockCount == 30 or blockCount == 32 or blockCount == 33 or blockCount == 40 or blockCount == 49) and "minecraft:dark_oak_log[axis=z]" or "minecraft:dark_oak_planks"):setPos(x * 16, y * 16, 0)
                            end
                        end
                        for j = 0, 1 do
                            for i = 0, 6 do
                                models.models.ex_skill_2.Wall:newBlock("ex_skill_2_block_"..83 + j * 7 + i):setBlock("minecraft:dark_oak_planks"):setPos(j * 128, i * 16, -16)
                            end
                        end
                        --models.models.ex_skill_2.Wall.Paintings.MainPainting:newEntity("ex_skill_2_entity_1"):setPos(0, 32, 0):setRot(0, 180, 0):setLight(15, 15) --謎の影ができて、それが消せない...
                        models.models.ex_skill_2.Covers.CoverLeft.DecoratedPod1.Base_Side:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/decorated_pot/decorated_pot_side.png")
                        for _, potPart in ipairs({models.models.ex_skill_2.Covers.CoverLeft.DecoratedPod1.Base_Top, models.models.ex_skill_2.Covers.CoverLeft.DecoratedPod1.Neck1, models.models.ex_skill_2.Covers.CoverLeft.DecoratedPod1.Neck2}) do
                            potPart:setPrimaryTexture("RESOURCE", "minecraft:textures/entity/decorated_pot/decorated_pot_base.png")
                        end
                        for index, modelPart in ipairs({models.models.ex_skill_2.Covers.CoverBack1, models.models.ex_skill_2.Covers.CoverBack4}) do
                            modelPart:addChild(models.models.ex_skill_2.Covers.CoverLeft.DecoratedPod1:copy("DecoratedPod"..(index + 1)))
                        end
                        models.models.ex_skill_2.Covers.CoverBack1.DecoratedPod2:setPos(0, 0, 160)
                        models.models.ex_skill_2.Covers.CoverBack4.DecoratedPod3:setPos(-128, 0, 176)
                        models.models.ex_skill_2.Wall.Paintings.MainPainting.Painting_Back:setPrimaryTexture("RESOURCE", "minecraft:textures/painting/back.png")
                        for _, modelPart in ipairs({models.models.ex_skill_2.Midori.MidoriHead.MidoriHeadRing, models.models.ex_skill_2.Wall.SpecialItemGroup}) do
                            modelPart:setLight(15)
                        end
                        for i = 1, 3 do
                            models.models.ex_skill_2.Pillagers["Pillager"..i]["Pillager"..i.."RightArm"]:newItem("ex_skill_2_pillager_"..i.."_crossbow"):setItem("minecraft:crossbow"):setPos(0, -12, -2):setRot(0, 0, -135)
                        end
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI:addChild(models.models.ex_skill_2.Gui.UI.MomoiUI.UI1:copy("UI1Shadow"))
                            models.models.ex_skill_2.Gui.UI.MomoiUI.UI1Shadow:setPos(-1, -1, 1)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.UI1Shadow:setColor(0, 0, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI:addChild(models.models.main.Avatar.UpperBody.Body.Gun:copy("GunIcon"))
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setPos(27, 15, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setRot(0, 90, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setScale(2.5, 2.5, 2.5)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.GunIcon:setVisible(true)
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
                            models.models.ex_skill_2.Gui.UI.MidoriUI:addChild(models.models.ex_skill_2.Midori.MidoriUpperBody.MidoriArms.MidoriRightArm.MidoriRightArmBottom.Gun2:copy("GunIcon"))
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setPos(116, 15, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setRot(0, 90, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriUI.GunIcon:setScale(1.67, 1.67, 1.67)
                            for i = 1, 3 do
                                models.models.ex_skill_2.Gui.UI.MidoriUI["LifeIcon"..i]:setPos(22 - (i - 1) * 15, 0, 0)
                            end
                            models.models.ex_skill_2.Gui.UI.MidoriUI:newText("ex_skill_2_reload_text"):setText("§4§lRELOAD"):setPos(154, 190, 0):setScale(1.6, 1.6, 1.6):setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:addChild(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.Frame:copy("FrameShadow"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.FrameShadow:setPos(-1, -1, 1)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.FrameShadow:setColor(0, 0, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.Background:setColor(1, 0.643, 0.71)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:addChild(ModelUtils:copyModel(models.script_head_block.Head, "MomoiPaperDollHead"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead:setPos(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:getPivot():add(0, -24, 0))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.HeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setScale(4.1, 4.1, 4.1)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts:addChild(models.models.main.Avatar.Head.FaceParts.Mouth:copy("Mouth"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(0, 16)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setVisible(true)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setVisible(true)
                            models.models.ex_skill_2.Gui.UI:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Gui.UI.MomoiHeadUI, "MidoriHeadUI"))
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll:setVisible(true)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.Background:setColor(0.573, 0.98, 0.604)
                            ---@diagnostic disable-next-line: discard-returns
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI:newPart("MidoriPaperDoll", "None")
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setRot(0, -15, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setPos(-158, -38, 140)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Midori.MidoriHead, "MidoriPaperDollHead"))
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead:setPos(18.25, -88.5, -57)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.MidoriHeadRing:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll.MidoriPaperDollHead.MidoriFaceParts.Eyes.EyeRight:setUVPixels(-6, 0)
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:addChild(ModelUtils:copyModel(models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollBody, "MidoriPaperDollBody"))
                            models.models.ex_skill_2.Gui.UI.MidoriHeadUI.MidoriPaperDoll:setScale(4.1, 4.1, 4.1)
                        end
                        BlueArchiveCharacter.EX_SKILL[2].isPrepared = true
                    end
                    if host:isHost() then
                        models.models.ex_skill_2.Gui:setVisible(true)
                        local windowsSize = client:getScaledWindowSize()
                        models.models.ex_skill_2.Gui.UI.MomoiUI:setPos(-90, (windowsSize.y - 20) * -1, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriUI:setPos(windowsSize.x * -1 + 10, (windowsSize.y - 20) * -1, 0)
                        models.models.ex_skill_2.Gui.UI.MidoriHeadUI:setPos(windowsSize.x * -1 + 88, 0, 0)
                    end
                    models.models.main.Avatar.UpperBody.Body.Gun:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
                    models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setPos()
                    models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setRot()
                    models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setVisible(true)
                    local specialItemValue = math.random() --0.80未満で「金のマガジン」、0.80~0.90未満で「エメラルド」、0.90~1.00未満で「ダイヤモンド」
                    if specialItemValue >= 0.8 then
                        models.models.ex_skill_2.Wall.SpecialItemGroup.SpecialItem.GoldenMagazine:setVisible(false)
                        models.models.ex_skill_2.Wall.SpecialItemGroup.SpecialItem:newItem("special_item"):setItem(specialItemValue < 0.9 and "minecraft:emerald" or "minecraft:diamond")
                    else
                        models.models.ex_skill_2.Wall.SpecialItemGroup.SpecialItem.GoldenMagazine:setVisible(true)
                    end
                    BlueArchiveCharacter.EX_SKILL[2].glowColor = specialItemValue < 0.8 and vectors.vec3(1, 0.984, 0.4) or (specialItemValue < 0.9 and vectors.vec3(0.686, 0.992, 0.804) or vectors.vec3(0.631, 0.984, 0.91))
                    models.models.ex_skill_2.Wall.SpecialItemGroup.GlowEffects:setColor(BlueArchiveCharacter.EX_SKILL[2].glowColor)
                    local paintingResources = {"minecraft:textures/painting/pointer.png", "minecraft:textures/painting/pigscene.png", "minecraft:textures/painting/burning_skull.png"}
                    models.models.ex_skill_2.Wall.Paintings.MainPainting.Painting_Front:setPrimaryTexture("RESOURCE", paintingResources[math.ceil(math.random() * #paintingResources)])
                    --[[
                        local paintingVarients = {"minecraft:pointer", "minecraft:pigscene", "minecraft:burning_skull"}
                        ---@diagnostic disable-next-line: undefined-field
                        models.models.ex_skill_2.Wall.Paintings.MainPainting:getTask("ex_skill_2_entity_1"):setNbt("minecraft:painting", toJson({variant = paintingVarients[math.ceil(math.random() * #paintingVarients)]}))
                    ]]
                    ---@diagnostic disable-next-line: discard-returns
                    models.models.ex_skill_2.Covers.CoverBack4:newPart("MissText", "Camera")
                    models.models.ex_skill_2.Covers.CoverBack4.MissText:setOffsetPivot(8, 24, 8)
                    BlueArchiveCharacter.EX_SKILL_2_MISS_TEXT_1 = ExSkill2TextAnimation.new(models.models.ex_skill_2.Covers.CoverBack4.MissText)
                    ---@diagnostic disable-next-line: discard-returns
                    models.models.ex_skill_2.Covers.CoverBack1:newPart("MissText", "Camera")
                    models.models.ex_skill_2.Covers.CoverBack1.MissText:setOffsetPivot(8, 24, 8)
                    BlueArchiveCharacter.EX_SKILL_2_MISS_TEXT_2 = ExSkill2TextAnimation.new(models.models.ex_skill_2.Covers.CoverBack1.MissText)
                    FaceParts:setEmotion("ANGRY_CENTER", "ANGRY", "OPENED", 4, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    ---銃弾のパーティクルを出す。
                    ---@param anchor ModelPart パーティクルを出す場所を示すアンカーポイント
                    local function bulletParticle(anchor)
                        local anchorPos = ModelUtils.getModelWorldPos(anchor)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0.1, 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
                        end
                        local muzzleAnchorPos =  ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.RightArm.Gun.MuzzleAnchor)

                        for _ = 1, 5 do
                            particles:newParticle("minecraft:smoke", muzzleAnchorPos)
                        end
                    end

                    ---射撃音を再生する。
                    local function shotSound()
                        sounds:playSound("minecraft:entity.firework_rocket.blast", ModelUtils.getModelWorldPos(host:isHost() and models.models.main.CameraAnchor or models.models.main.Avatar), 1, math.random() * 0.25 + 0.5)
                    end

                    ---飾り壺を割った時の演出
                    ---@param potModel ModelPart 飾り壺のモデル
                    local function potBreak(potModel)
                        local potPos = ModelUtils.getModelWorldPos(potModel)
                        for _ = 1, 32 do
                            particles:newParticle("minecraft:block minecraft:decorated_pot", potPos:copy():add(math.random() - 0.5, math.random(), math.random() - 0.5))
                        end
                        sounds:playSound("minecraft:block.glass.break", potPos, 1, 0.5)
                        potModel:setVisible(false)
                    end

                    if tick == 1 then
                        local playerPos = ModelUtils.getModelWorldPos(models.models.main.Avatar)
                        local bodyYaw = player:getBodyYaw()
                        particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, -0.75, 1.25, 0, 0, 1, 0):add(playerPos)):setScale(1):setColor(1, 0.984, 0.4):setLifetime(20)
                        particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, 0.65, 1.9, 0, 0, 1, 0):add(playerPos)):setScale(0.5):setColor(1, 0.984, 0.4):setLifetime(20)
                    elseif tick == 4 then
                        FaceParts:setEmotion("ANGRY_CENTER", "ANGRY", "SMILE", 6, true)
                    elseif tick == 10 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 4, true)
                    elseif tick == 14 then
                        FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "SMILE", 11, true)
                    elseif tick == 25 then
                        FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", 22, true)
                    elseif  tick == 28 then
                        local windowSize = client:getScaledWindowSize()
                        local centerX = windowSize.x / 2 * -1
                        local centerY = windowSize.y / 2 * -1
                        models.models.ex_skill_2.Gui.ReticuleAnchor:setPos(centerX, centerY, 0)
                        models.models.ex_skill_2.Gui.Reticule:setVisible(true)
                        events.RENDER:register(function ()
                            models.models.ex_skill_2.Gui.Reticule:setPos(vectors.vec3(centerX, centerY, 0):add(models.models.ex_skill_2.Gui.ReticuleAnchor:getAnimPos():scale(windowSize.y / 270)))
                        end, "ex_skill_2_render")
                    elseif tick == 35 then
                        models.models.ex_skill_2.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight:setUVPixels(-6, 0)
                    elseif tick == 42 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack2.ExSkill2ParticleAnchor1)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet24:setColor()
                        end
                    elseif tick == 44 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack3.ExSkill2ParticleAnchor2)
                        shotSound()
                    elseif tick == 47 then
                        FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", 33, true)
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack4.ExSkill2ParticleAnchor3)
                        shotSound()
                        potBreak(models.models.ex_skill_2.Covers.CoverBack4.DecoratedPod3)
                        BlueArchiveCharacter.EX_SKILL_2_MISS_TEXT_1:play()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon1:setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet23:setColor()
                        end
                    elseif tick == 50 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack3.ExSkill2ParticleAnchor4)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor()
                        end
                    elseif tick == 52 then
                        bulletParticle(models.models.ex_skill_2.Wall.Paintings.MainPainting.ExSkill2ParticleAnchor5)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet22:setColor()
                        end
                    elseif tick == 55 then
                        bulletParticle(models.models.ex_skill_2.Wall.ExSkill2ParticleAnchor6)
                        shotSound()
                    elseif tick == 60 and host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(0, 16)
                    elseif tick == 68 then
                        bulletParticle(models.models.ex_skill_2.Wall.ExSkill2ParticleAnchor7)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet21:setColor()
                        end
                    elseif tick == 70 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor8)
                        shotSound()
                        potBreak(models.models.ex_skill_2.Covers.CoverBack1.DecoratedPod2)
                        BlueArchiveCharacter.EX_SKILL_2_MISS_TEXT_2:play()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon2:setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor(1, 0.75, 0.75)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft:setUVPixels(12, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight:setUVPixels(6, 0)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(16, 0)
                        end
                    elseif tick == 72 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor9)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet20:setColor()
                        end
                    elseif tick == 73 and host:isHost() then
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor()
                    elseif tick == 80 then
                        FaceParts:setEmotion("SURPLISED", "SURPLISED", "SHOCK", 35, true)
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor10)
                        shotSound()
                    elseif tick == 83 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor11)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet19:setColor()
                        end
                    elseif tick == 86 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Covers.CoverBack1.ExSkill2ParticleAnchor12)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:electric_spark", anchorPos):setScale(1):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0.1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 1, 0)):setColor(0.98, 0.843, 0.341):setLifetime(2)
                        end
                        shotSound()
                    elseif tick == 88 or tick == 99 then
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet18:setColor()
                        end
                    elseif tick == 105 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack2.ExSkill2ParticleAnchor13)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet17:setColor()
                        end
                    elseif tick == 108 then
                        bulletParticle(models.models.ex_skill_2.Covers.CoverBack3.ExSkill2ParticleAnchor14)
                        shotSound()
                    elseif tick == 110 then
                        bulletParticle(models.models.ex_skill_2.Wall.Paintings.MainPainting.ExSkill2ParticleAnchor15)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet16:setColor()
                        end
                    elseif tick == 112 then
                        bulletParticle(models.models.ex_skill_2.Wall.Paintings.MainPainting.ExSkill2ParticleAnchor16)
                        shotSound()
                    elseif tick == 113 then
                        bulletParticle(models.models.ex_skill_2.Wall.Paintings.MainPainting.ExSkill2ParticleAnchor17)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets.Bullet15:setColor()
                        end
                    elseif tick == 115 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 36, true)
                        bulletParticle(models.models.ex_skill_2.Wall.Paintings.MainPainting.ExSkill2ParticleAnchor18)
                        shotSound()
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.Reticule:setVisible(false)
                            events.RENDER:remove("ex_skill_2_render")
                        end
                    elseif tick == 116 then
                        sounds:playSound("minecraft:entity.zombie.break_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Wall.Paintings.MainPainting), 0.25, 2)
                    elseif tick == 128 then
                        sounds:playSound("minecraft:entity.player.levelup", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Wall.SpecialItemGroup), 1, 1)
                    elseif tick == 132 then
                        local anchorPos = vectors.rotateAroundAxis(player:getBodyYaw() * -1, 0, -0.75, 2, 0, 1, 0):add(ModelUtils.getModelWorldPos(models.models.ex_skill_2.Wall.Paintings.MainPainting))
                        for _ = 1, 20 do
                            local xOffset = math.random() * 4 - 2
                            local zOffset = math.random() * 4 - 2
                            particles:newParticle("minecraft:campfire_cosy_smoke", anchorPos:copy():add(xOffset, 0, zOffset)):setScale(5):setVelocity(xOffset * 0.03, 0.025, zOffset * 0.03)
                        end
                        sounds:playSound("minecraft:entity.zombie.attack_wooden_door", anchorPos, 0.25, 2)
                        sounds:playSound("minecraft:entity.pillager.hurt", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Pillagers.Pillager1), 1, 1)
                    elseif tick == 138 then
                        sounds:playSound("minecraft:entity.zombie.attack_wooden_door", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Wall.Paintings.MainPainting), 0.05, 2)
                    elseif tick == 148 and host:isHost() then
                        local windowSize = client:getScaledWindowSize()
                        models.models.ex_skill_2.Gui.TransitionFilter:setScale(windowSize.x, windowSize.y, 1)
                        models.models.ex_skill_2.Gui.TransitionFilter:setVisible(true)
                        events.RENDER:register(function (delta)
                            if ExSkill.AnimationCount <= 151 then
                                models.models.ex_skill_2.Gui.TransitionFilter:setOpacity((ExSkill.AnimationCount - 149 + delta) * 0.3333)
                            else
                                models.models.ex_skill_2.Gui.TransitionFilter:setOpacity((ExSkill.AnimationCount - 152 + delta) * -0.3333 + 1)
                            end
                        end, "ex_skill_2_transition_filter_render")
                    elseif tick == 151 then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:moveTo(models.models.main.Avatar.UpperBody.Body)
                        models.models.ex_skill_2.Wall.SpecialItemGroup:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom)
                        FaceParts:setEmotion("NORMAL", "NORMAL_CENTER", "TRIANGLE", 3, true)
                        if host:isHost() then
                            models.models.ex_skill_2.Gui.UI:setVisible(false)
                        end
                    elseif tick == 154 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 2, true)
                        if host:isHost() then
                            events.RENDER:remove("ex_skill_2_transition_filter_render")
                            models.models.ex_skill_2.Gui.TransitionFilter:setVisible(false)
                        end
                    elseif tick == 156 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "TRIANGLE", 7, true)
                    elseif tick == 163 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 2, true)
                    elseif tick == 165 then
                        FaceParts:setEmotion("NORMAL", "NORMAL_CENTER", "TRIANGLE", 6, true)
                    elseif tick == 171 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "TRIANGLE", 3, true)
                    elseif tick == 174 then
                        FaceParts:setEmotion("ANGRY", "ANGRY_INVERTED", "OPENED", 36, true)
                    elseif tick == 178 then
                        sounds:playSound("minecraft:entity.player.levelup", player:getPos(), 1, 1.5)
                    end
                    if tick >= 128 and tick < 151 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Wall.SpecialItemGroup)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 3 - 1.5, math.random() * 3 - 1.5, 0, 0, 1, 0):add(anchorPos)):setVelocity(0, 0.1, 0):setColor(BlueArchiveCharacter.EX_SKILL[2].glowColor):setLifetime(8)
                        end
                    elseif tick >= 151 and tick < 170 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.SpecialItemGroup)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 2 do
                            particles:newParticle("minecraft:end_rod", vectors.rotateAroundAxis(bodyYaw * -1 + 35, math.random() * 0.5 - 0.25, math.random() * 0.5 - 0.25, 0, 0, 1, 0):add(anchorPos)):setScale(0.25):setVelocity(0, 0.016, 0):setColor(BlueArchiveCharacter.EX_SKILL[2].glowColor):setLifetime(8)
                        end
                    end
                    if tick < 124 then
                        for i = 1, 3 do
                            if math.random() >= 0.99 then
                                sounds:playSound("minecraft:entity.pillager.ambient", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Pillagers["Pillager"..i]), 0.5, 1)
                            end
                        end
                    end
                    if tick >= 105 and tick < 124 and math.random() >= 0.95 then
                        sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Pillagers.Pillager1), 0.5, 1)
                    end
                    if tick >= 70 and tick < 124 and math.random() >= 0.95 then
                        sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Pillagers.Pillager2), 0.5, 1)
                    end
                    if tick >= 54 and tick < 124 and math.random() >= 0.95 then
                        sounds:playSound("minecraft:item.crossbow.shoot", ModelUtils.getModelWorldPos(models.models.ex_skill_2.Pillagers.Pillager3), 0.5, 1)
                    end
                    if tick >= 22 and tick < 151 and host:isHost() then
                        if (tick - 22) % 30 == 0 then
                            models.models.ex_skill_2.Gui.UI.MidoriUI:getTask("ex_skill_2_reload_text"):setVisible(true)
                        elseif (tick - 22) % 30 == 20 then
                            models.models.ex_skill_2.Gui.UI.MidoriUI:getTask("ex_skill_2_reload_text"):setVisible(false)
                        end
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    for _, modelPart in ipairs({models.models.ex_skill_2.Covers.CoverBack1.DecoratedPod2, models.models.ex_skill_2.Covers.CoverBack4.DecoratedPod3}) do
                        modelPart:setVisible(true)
                    end
                    models.models.ex_skill_2.Midori.MidoriHead.MidoriFaceParts.Eyes.EyeRight:setUVPixels()
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:setVisible(false)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.Gun:moveTo(models.models.main.Avatar.UpperBody.Body)
                    elseif models.models.main.Avatar.UpperBody.Body.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Body.Gun:setVisible(false)
                    end
                    if models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.SpecialItemGroup ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.SpecialItemGroup:moveTo(models.models.ex_skill_2.Wall)
                    end
                    models.models.ex_skill_2.Wall.SpecialItemGroup.SpecialItem:removeTask("special_item")
                    if host:isHost() then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui, models.models.ex_skill_2.Gui.Reticule}) do
                            modelPart:setVisible(false)
                        end
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon1, models.models.ex_skill_2.Gui.UI.MomoiUI.LifeIcon2}) do
                            modelPart:setVisible(true)
                        end
                        for _, modelPart in ipairs({models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeLeft, models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Eyes.EyeRight}) do
                            modelPart:setUVPixels()
                        end
                        models.models.ex_skill_2.Gui.UI.MomoiHeadUI.MomoiPaperDoll.MomoiPaperDollHead.FaceParts.Mouth:setUVPixels(0, 16)
                        for i = 15, 24 do
                            models.models.ex_skill_2.Gui.UI.MomoiUI.Bullets.RearBullets["Bullet"..i]:setColor(0.5, 0.5, 0.5)
                        end
                        models.models.ex_skill_2.Gui.UI.MidoriUI:getTask("ex_skill_2_reload_text"):setVisible(false)
                        if forcedStop then
                            models.models.ex_skill_2.Gui.TransitionFilter:setVisible(false)
                            models.models.ex_skill_2.Gui.UI.MomoiHeadUI:setColor()
                            for _, event in ipairs({"ex_skill_2_render", "ex_skill_2_transition_filter_render"}) do
                                events.RENDER:remove(event)
                            end
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
                for _, modelPart in ipairs({models.models.main.Avatar.Head.HairRibbons, models.models.main.Avatar.UpperBody.Body.CoatRibbon, models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightCoat, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftCoat}) do
                    modelPart:setVisible(false)
                end
                for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaidH, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CMaidRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CMaidLAB}) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.CMaidB:setVisible(not Armor.ArmorVisible[3])

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
                    local skirtVisible = models.models.main.Avatar.UpperBody.Body.CMaidB:getVisible()
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
                end, "skirt_tick")
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
                for _, modelPart in ipairs({models.models.main.Avatar.Head.Head, models.models.main.Avatar.Head.HatLayer}) do
                    modelPart:setUVPixels()
                end
                Costume.setCostumeTextureOffset(0)
                for _, modelPart in ipairs({models.models.main.Avatar.Head.HairRibbons, models.models.main.Avatar.UpperBody.Body.CoatRibbon, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightCoat, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftCoat}) do
                    modelPart:setVisible(true)
                end
                models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(not Armor.ArmorVisible[3])
                for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaidH, models.models.main.Avatar.UpperBody.Body.CMaidB}) do
                    modelPart:setVisible(false)
                end
                events.TICK:remove("skirt_tick")
                events.RENDER:remove("skirt_render")
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
                if parts == "HELMET" then
                    models.models.main.Avatar.Head.EffectPanel:setPos(0, 0, Armor.ArmorVisible[1] and -1 or 0)
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
                        FaceParts:setEmotion("NORMAL", "NORMAL", "FUN", duration, true)
                    elseif type == "HEART" then
                        FaceParts:setEmotion("UNEQUAL", "UNEQUAL", "OPENED", duration, true)
                    elseif type == "NOTE" then
                        FaceParts:setEmotion("ANGRY", "ANGRY", "SMILE", duration, true)
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("SURPLISED", "SURPLISED", "SHOCK", duration, true)
                    elseif type == "SWEAT" then
                        FaceParts:setEmotion("ANGRY", "ANGRY2", "ANGRY", duration, true)
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
            if costume == 1 then
                dummyAvatar.UpperBody.Body.Skirt:setRot(70, 0, 0)
            elseif costume == 2 then
                dummyAvatar.LowerBody.Legs:setVisible(false)
                dummyAvatar.UpperBody.Body.CMaidB.Skirt1:setScale(1.2, 0.35, 1.5)
                for _, modelPart in ipairs({dummyAvatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight, dummyAvatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft}) do
                    modelPart:setRot(-40, 0, 0)
                end
            end
        end,

        ---ダミーアバターが縄ばしごにつかまった直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase2 = function (dummyAvatar, costume)
            if costume == 1 then
                dummyAvatar.UpperBody.Body.Skirt:setRot(22.5, 0, 0)
            elseif costume == 2 then
                dummyAvatar.LowerBody.Legs:setVisible(true)
                dummyAvatar.UpperBody.Body.CMaidB.Skirt1:setScale(1, 1, 1)
                dummyAvatar.UpperBody.Body.CMaidB.Skirt1:setRot(32.5, 0, 0)
                dummyAvatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight:setRot(20, 0, 5)
                dummyAvatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft:setRot(20, 0, -25)
            end
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
                modelPart = {models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail, models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail},

                ---y軸回転における物理演算データ（省略可）
                y = {
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
                        max = 20
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
                        max = 20
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = {models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail.RightHairTailZPivot, models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail.LeftHairTailZPivot},

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -10,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -10,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10
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
            if modelPart:getName():match("^RightHairTail") then
                local velocityY = math.clamp(Physics.VelocityAverage[1] * -40, -20, 20)
                local velocityZ = math.clamp(Physics.VelocityAverage[2] * (isHorizontal and 160 or -40), -10, 10)
                local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
                local rotY = velocityY * (1 - math.abs(lookRotY)) + velocityZ * lookRotY
                local rotZ = velocityZ * (1 - math.abs(lookRotY)) + velocityY * lookRotY * -1
                if modelPart == models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail then
                    models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail:setRot(0, isHorizontal and rotZ or rotY, 0)
                elseif modelPart == models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail.RightHairTailZPivot then
                    models.models.main.Avatar.Head.CMaidH.HairTails.RightHairTail.RightHairTailZPivot:setRot(0, 0, isHorizontal and rotY or rotZ)
                end
            elseif modelPart:getName():match("^LeftHairTail") then
                local velocityY = math.clamp(Physics.VelocityAverage[1] * 40, -20, 20)
                local velocityZ = math.clamp(Physics.VelocityAverage[2] * (isHorizontal and -160 or 40), -10, 10)
                local lookRotY = math.deg(math.asin(player:getLookDir().y)) / 90
                local rotY = velocityY * (1 - math.abs(lookRotY)) + velocityZ * lookRotY
                local rotZ = velocityZ * (1 - math.abs(lookRotY)) + velocityY * lookRotY * -1
                if modelPart == models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail then
                    models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail:setRot(0, isHorizontal and rotZ or rotY, 0)
                elseif modelPart == models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail.LeftHairTailZPivot then
                    models.models.main.Avatar.Head.CMaidH.HairTails.LeftHairTail.LeftHairTailZPivot:setRot(0, 0, isHorizontal and rotY or rotZ)
                end
            elseif (modelPart == models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomRight or modelPart == models.models.main.Avatar.UpperBody.Body.CMaidB.BackRibbon.RibbonBottomLeft) and isHorizontal then
                modelPart:setRot(modelPart:getRot():scale(1 - math.clamp(Physics.VelocityAverage[5], 0, 1.6) / 1.6))
            end
        end
    }

    --その他定数・変数
}

return BlueArchiveCharacter