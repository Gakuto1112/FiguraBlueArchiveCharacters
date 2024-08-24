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
            en_us = "Umika",

            ---日本語
            ---@type string
            ja_jp = "ウミカ"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "Satohama",

            ---日本語
            ---@type string
            ja_jp = "里浜"
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
            day = 1
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
            TIRED = {3, 0},
            CLOSED = {4, 0},
            CLOSED2 = {6, 0},
            INVERTED = {7, 0},
            NARROW = {8, 0}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            TIRED = {2, 0},
            CLOSED = {3, 0},
            CENTER = {4, 0},
            CLOSED2 = {5, 0},
            NARROW_CENTER = {8, 0},
            NARROW = {-1, 1}
        },

        ---口
        Mouth = {
            CIRCLE = {0, 0},
            SMILE = {1, 0},
            OPENED = {2, 0},
            DROOL = {3, 0},
            YUMMY = {0, 1},
            OPENED2 = {1, 1},
            ANXIOUS = {2, 1}
        }

        ---表情のセット（省略可）
        --[[
        FacePartsSets = {
            ---ダメージを受けた時の表情（省略可）
            onDamage = {
                RightEye = "SURPLISED",
                LeftEye = "SURPLISED",
                Mouth = "CLOSED"
            }

            ---寝ている時の表情（省略可）
            onSleep = {
                RightEye = "CLOSED",
                LeftEye = "CLOSED",
                Mouth = "CLOSED"
            }
        }
        ]]
    },

    ---スカート
    SKIRT = {
        ---スカートとして制御するモデルの配列
        ---@type ModelPart[]
        SkirtModels = {models.models.main.Avatar.UpperBody.Body.Skirt}
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
                right = vectors.vec3(1.5, 0, -4),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(1.5, 0, -4)
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
                right = vectors.vec3(-1.75, 0, -7),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(1.75, 0, -7)
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

            --[[
            ---装填済みクロスボウの位置オフセット（省略可）
            charged_crossbow_pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-8.95, 1, 0),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(9.05, 1, 0)
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
            type = "BODY",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, 3, 3),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 3, 3)
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(0, -90, 45),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(0, 90, -45)
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
            placementModel = models.models.placement_object.PlacementObject,

            ---設置物の当たり判定
            boundingBox = {
                ---設置物の底の中心点のオフセット位置（任意）。基準点は(0, 0, 0)。
                ---@type Vector3
                offsetPos = vectors.vec3(),

                ---当たり判定の大きさ。BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心
                ---@type Vector3
                size = vectors.vec3(8, 8, 8)
            },

            ---設置物の設置モード
            ---@type PlacementObjectManager.PlecementMode
            placementMode = "MOVE",

            ---設置物にかかる重力（任意）。1が標準的な自由落下。0で空中静止。負の数で反重力。
            ---@type number
            gravity = 1,

            ---設置物に火炎耐性を付与するかどうか（任意）。trueにすると炎やマグマで焼かれなくなる。
            ---@type boolean
            hasFireResistance = false,

            ---コールバック関数
            callbacks = {
                ---設置物インスタンスが生成された直後に呼ばれる関数（任意）
                ---@param placementObject table 設置物インスタンス
                onInit = function (placementObject)
                end,

                ---設置物インスタンスが破棄される直前に呼ばれる関数（任意）
                ---@param placementObject table 設置物インスタンス
                onDeinit = function (placementObject)
                end,

                ---各ティック毎に呼ばれる関数（任意）
                ---@param placementObject table 設置物のインスタンス
                onTick = function (placementObject)
                end,

                ---各レンダーティック毎に呼ばれる関数（任意）
                ---@param delta number デルタ値
                ---@param context Event.Render.context レンダーコンテキスト
                ---@param matrix Matrix4 レンダーマトリックス
                ---@param placementObject table 設置物のインスタンス
                onRender = function (delta, context, matrix, placementObject)
                end,

                ---設置物が接地した瞬間に呼ばれる関数（任意）
                ---@param placementObject table 設置物のインスタンス
                onGround = function (placementObject)
                end
            }
        }
        ]]

        {
            ---設置物として扱うモデル
            ---指定したモデルをコピーして設置物とする。
            ---@type ModelPart
            placementModel = models.models.placement_object.PlacementObject,

            ---設置物の当たり判定
            boundingBox = {
                --[[
                ---設置物の底の中心点のオフセット位置（任意）。基準点は(0, 0, 0)。
                ---@type Vector3
                offsetPos = vectors.vec3()
                ]]

                ---当たり判定の大きさ。BlockBenchでのサイズの値をそのまま入力する。基準点はモデルの底面の中心
                ---@type Vector3
                size = vectors.vec3(38, 37, 38)
            },

            ---設置物の設置モード
            ---@type PlacementObjectManager.PlecementMode
            placementMode = "COPY",

            --[[
            ---設置物にかかる重力（任意）。1が標準的な自由落下。0で空中静止。負の数で反重力。
            ---@type number
            gravity = 1,

            ---設置物に火炎耐性を付与するかどうか（任意）。trueにすると炎やマグマで焼かれなくなる。
            ---@type boolean
            hasFireResistance = false,
            ]]

            ---コールバック関数
            callbacks = {
                ---設置物インスタンスが破棄される直前に呼ばれる関数（任意）
                ---@param placementObject table 設置物インスタンス
                onDeinit = function (placementObject)
                    local modelName = placementObject.objectModel:getName()
                    while events.TICK:getRegisteredCount("firework_launcher_"..modelName.."_tick") > 0 do
                        events.TICK:remove("firework_launcher_"..modelName.."_tick")
                        events.RENDER:remove("firework_launcher_"..modelName.."_render")
                    end
                end
            }
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
                en_us = "The festival has begun!",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "お祭り開始です！"
            },

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.ex_skill_1, models.models.main.Avatar.Head.FaceParts.Eyes.EyeShines, models.models.main.LaughterLines},

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
                    pos = vectors.vec3(-9, 24, -23),

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
                    pos = vectors.vec3(25.9, 22.75, -43.4),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 180, -5)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun()
                preTransition = function()
                    if #PlacementObjectManager.PlacementObjects == 5 then
                        PlacementObjectManager:remove(1)
                    end
                end,

                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    if not BlueArchiveCharacter.EX_SKILL[1].IsPrepared then
                        ---屋台のたこ焼き看板のテキストレンダータスクを作成する。
                        ---@param parent ModelPart テキストレンダータスクを作成する対象の親パーツ
                        ---@param posOffset Vector3 テキストレンダータスクの位置オフセット
                        ---@param rot number テキストレンダータスク設置の基準となるY軸の向き
                        local function makeTakoyakiText(parent, posOffset, rot)
                            local parentName = parent:getName()
                            parent:newText(parentName.."_takoyaki_text_1"):setText("§0§lたこやき"):setPos(vectors.rotateAroundAxis(rot, 0, 3, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_flavor_text_1"):setText("§2§l本場の味"):setPos(vectors.rotateAroundAxis(rot, -9, 5, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_takoyaki_text_2"):setText("§0§lたこやき"):setPos(vectors.rotateAroundAxis(rot + 180, 0, 3, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_flavor_text_2"):setText("§2§l本場の味"):setPos(vectors.rotateAroundAxis(rot + 180, -9, 5, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                        end

                        ---屋台のいか焼き看板のテキストレンダータスクを作成する。
                        ---@param parent ModelPart テキストレンダータスクを作成する対象の親パーツ
                        ---@param posOffset Vector3 テキストレンダータスクの位置オフセット
                        ---@param rot number テキストレンダータスク設置の基準となるY軸の向き
                        local function makeIkayakiText(parent, posOffset, rot)
                            local parentName = parent:getName()
                            parent:newText(parentName.."_ikayaki_text_1"):setText("§4§lいかやき"):setPos(vectors.rotateAroundAxis(rot, 0, 3, 0, 0, 1, 0):add(posOffset)):setRot(0, rot, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_flavor_text_1"):setText("§1§l海の味"):setPos(vectors.rotateAroundAxis(rot, 15, 5, 0, 0, 1, 0):add(posOffset)):setRot(rot % 360 == 90 and vectors.vec3(-90, 80, -90) or (rot % 360 == 270 and vectors.vec3(90, -80, -90) or vectors.vec3(0, 0, -10))):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_ikayaki_text_2"):setText("§4§lいかやき"):setPos(vectors.rotateAroundAxis(rot + 180, 0, 3, -1.02, 0, 1, 0):add(posOffset)):setRot(0, rot + 180, 0):setScale(0.85, 0.85, 0.85):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                            parent:newText(parentName.."_flavor_text_2"):setText("§1§l海の味"):setPos(vectors.rotateAroundAxis(rot + 180, 15, 5, -1.02, 0, 1, 0):add(posOffset)):setRot((rot + 180) % 360 == 90 and vectors.vec3(-90, 80, -90) or ((rot + 180) % 360 == 270 and vectors.vec3(90, -80, -90) or vectors.vec3(0, 0, -10))):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                        end

                        makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofFront, vectors.vec3(0, -6, -1.01), 0)
                        makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofRight, vectors.vec3(0.501, -6, 22.5), -90)
                        makeTakoyakiText(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallRoof.StallRoofLeft, vectors.vec3(-0.501, -6, 22.5), 90)
                        for i = 1, 2 do
                            models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_takoyaki_text"):setText("§4§lた\nこ\nや\nき"):setPos(-0.25, -0.25, -0.01):setScale(0.25, 0.25, 0.25):setAlignment("CENTER"):setOutline(true)
                            models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newItem("MenuLabel"..i.."_emerald_item"):setItem(CompatibilityUtils:checkItem("minecraft:emerald")):setPos(0.75, -10.75, -0.01):setScale(0.1, 0.1, 0)
                            models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_price_text"):setText("§0§lx5"):setPos(-0.5, -10.5, -0.01):setScale(0.1, 0.1, 0.1):setAlignment("CENTER")
                        end
                        models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newText("MenuSign_takoyaki_text"):setText("§4§lたこ\n焼き"):setPos(-3.25, 4.25, -0.01):setScale(0.35, 0.35, 0.35):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                        models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newItem("MenuSign_emerald_item"):setItem(CompatibilityUtils:checkItem("minecraft:emerald")):setPos(3, -3.25, -0.01):setScale(0.175, 0.175, 0)
                        models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallFrames.MenuSign:newText("MenuSign_price_text"):setText("§0§lx5"):setPos(0.5, -3, -0.01):setScale(0.15, 0.15, 0.15):setAlignment("CENTER"):setOutline(true):setOutlineColor(0.8, 0.8, 0.8)
                        models.models.ex_skill_1.Stalls.TakoyakiStall:newBlock("TakoyakiStall_step"):setBlock(CompatibilityUtils:checkBlock("minecraft:scaffolding")):setPos(20, -6, 16)

                        models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.PlanksSheet:setPrimaryTexture("RESOURCE", "minecraft:textures/block/oak_planks.png")
                        makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofFront, vectors.vec3(0, -6, -1.01), 0)
                        makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofRight, vectors.vec3(0.501, -6, 22.5), -90)
                        makeIkayakiText(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallRoof.StallRoofLeft, vectors.vec3(-0.501, -6, 22.5), 90)
                        for i = 1, 3 do
                            models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable["MenuLabel"..i]:newItem("MenuLabel"..i.."_emerald_item"):setItem(CompatibilityUtils:checkItem("minecraft:emerald")):setPos(1.75, -2, -0.01):setScale(0.25, 0.25, 0)
                            models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable["MenuLabel"..i]:newText("MenuLabel"..i.."_price_text"):setText("§0§lx"..(i - 1) * 2 + 1):setPos(-1.5, -1.75, -0.01):setScale(0.25, 0.25, 0.25):setAlignment("CENTER")
                        end
                        models.models.ex_skill_1.Stalls.IkayakiStall:newBlock("IkayakiStall_step"):setBlock(CompatibilityUtils:checkBlock("minecraft:scaffolding")):setPos(15, -6, 16)
                        BlueArchiveCharacter.EX_SKILL[1].IsPrepared = true
                    end
                    events.RENDER:register(function ()
                        models.models.main.LaughterLines:setOffsetPivot(models.models.main.LaughterLines.LaughterLinesInner:getAnimPos())
                    end, "ex_skill_1_render")
                    FaceParts:setEmotion("NORMAL", "CENTER", "CIRCLE", 11, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 11 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "SMILE", 10, true)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.player.attack.sweep"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 0.25, 0.75)
                    elseif tick == 21 then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "SMILE", 7, true)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.player.attack.sweep"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 0.25, 0.75)
                    elseif tick == 28 then
                        FaceParts:setEmotion("INVERTED", "NORMAL", "SMILE", 6, true)
                    elseif tick == 34 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 6, true)
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot)
                        local bodyYaw = player:getBodyYaw()
                        for i = 0, 7 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:wax_off"), anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 45 + 0.1, 0, -0.015, 0, 0, 0, 1), 0, 1, 0)):setScale(0.25):setColor(1, 1, 0.71):setLifetime(20)
                        end
                        Bubble:play("GOOD", 20, vectors.vec2(), 0, false)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.egg.throw"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 0.5, 2)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.experience_orb.pickup"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 1, 1.5)
                    elseif tick == 40 then
                        FaceParts:setEmotion("INVERTED", "NORMAL", "OPENED", 14, true)
                    elseif tick == 54 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Dumplings, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Takoyaki3, models.models.ex_skill_1.Dogs.Dog2.Dog2Head.Sweat}) do
                            modelPart:setVisible(true)
                        end
                        FaceParts:setEmotion("NORMAL", "NORMAL", "DROOL", 26, true)
                        if host:isHost() then
                            sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.fire.extinguish"), ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.IkayakiTableItems.IkayakiPlate.ExSkill1ParticleAnchor3), 0.25, 0.5)
                        end
                    elseif tick == 80 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "YUMMY", 12, true)
                    elseif tick == 92 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "YUMMY", 2, true)
                    elseif tick == 94 then
                        FaceParts:setEmotion("NORMAL", "CENTER", "CIRCLE", 28, true)
                    elseif tick == 97 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.item.pickup"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 1, 1.25)
                    elseif tick == 110 then
                        models.models.ex_skill_1.Dogs.Dog2.Dog2Head.Sweat:setVisible(false)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Ikayaki9:setVisible(true)
                    elseif tick == 122 then
                        FaceParts:setEmotion("NARROW", "NARROW_CENTER", "SMILE", 29, true)
                    elseif tick == 129 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.item.pickup"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 1, 0.75)
                    elseif tick == 132 then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Ikayaki9:moveTo(models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm)
                        models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.ChocoBanana:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
                    elseif tick == 151 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "SMILE", 5, true)
                    elseif tick == 156 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED2", 34, true)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.player.levelup"), ModelUtils.getModelWorldPos(models.models.main.Avatar), 1, 1)
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_1.ExSkill1ParticleAnchor5)
                        local bodyYaw = player:getBodyYaw()
                        for i = 1, 6 do
                            local particleColor = i <= 3 and (vectors.vec3(0.667, 0.949, 0.561):add(vectors.vec3(-0.02,- 0.137, -0.094):scale((i - 1) / 2))) or (vectors.vec3(1, 0.78, 0.38):add(vectors.vec3(0, 0.22, 0.165):scale((i - 4) / 2)))
                            for j = 0, 4 * i do
                                local offset = vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(j * (360 / (8 * i)) - 90.1, 0, 0.25, 0, 0, 0, 1), 0, 1, 0)
                                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:wax_off"), anchorPos:copy():add(offset:copy():scale(i))):setVelocity(offset:copy():scale(0.35)):setScale(2):setLifetime(32):setColor(particleColor)
                            end
                        end
                    end

                    ---湯気のパーティクルを1つスポーンさせる。
                    ---@param pos Vector3 パーティクルのスポーン座標
                    local function spawnvaporParticle(pos)
                        particles:newParticle(CompatibilityUtils:checkParticle("minecraft:poof"), pos):setVelocity(math.random() * 0.05 - 0.025, 0.035, math.random() * 0.05 - 0.025):setScale(0.25)
                    end

                    if tick >= 54 and tick < 92 and (tick - 54) % 8 == 0 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar.Head):add(0, 0.25, 0)
                        local bodyYaw = player:getBodyYaw()
                        for i = 1, 7 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:happy_villager"), anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, vectors.rotateAroundAxis(i * 45, 0, -0.1, 0, 0, 0, 1), 0, 1, 0)):setScale(0.75):setLifetime(10)
                        end
                        if tick >= 66 then
                            sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.egg.throw"), anchorPos, 0.25, 2)
                        end
                    end
                    local vaporAnchor1 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable.TakoyakiTableItems.TakoyakiPlate.TakoyakiPlate2.ExSkill1ParticleAnchor1)
                    local bodyYaw = player:getBodyYaw()
                    for _ = 1, 2 do
                        spawnvaporParticle(vaporAnchor1:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 1.874375 - 0.921875, 0, math.random() * 0.484375 - 0.2421875, 0, 1, 0)))
                    end
                    local vaporAnchor2 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.TakoyakiStall.TakoyakiStallTable.TakoyakiTableItems.Takoyaki.ExSkill1ParticleAnchor2)
                    spawnvaporParticle(vaporAnchor2:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6875 - 0.34375, 0, math.random() * 0.4375 - 0.21875, 0, 1, 0)))
                    local vaporAnchor3 = ModelUtils.getModelWorldPos(models.models.ex_skill_1.Stalls.IkayakiStall.IkayakiStallTable.IkayakiTableItems.IkayakiPlate.ExSkill1ParticleAnchor3)
                    for _ = 1, 2 do
                        spawnvaporParticle(vaporAnchor3:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 1.6875 - 0.84375, 0, math.random() * 0.484375 - 0.2421875, 0, 1, 0)))
                    end
                    if tick >= 54 and tick % 2 == 0 then
                        local vaporAnchor4 = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Takoyaki3.ExSkill1ParticleAnchor4)
                        spawnvaporParticle(vaporAnchor4:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.265625 - 0.1328125, 0, math.random() * 0.265625 - 0.1328125, 0, 1, 0)))
                    end
                    if tick % 4 == 0 and not host:isHost() then
                        for _, anchorPos in ipairs({vaporAnchor1, vaporAnchor3}) do
                            sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.fire.extinguish"), anchorPos, 0.005, 0.5)
                        end
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.Ikayaki9 ~= nil then
                        models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm.Ikayaki9:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
                    end
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ChocoBanana ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.ChocoBanana:moveTo(models.models.ex_skill_1.Dogs.Dog3.Dog3UpperBody.Dog3RightArm)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Dumplings, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Takoyaki3, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Ikayaki9}) do
                        modelPart:setVisible(false)
                    end
                    events.RENDER:remove("ex_skill_1_render")
                    if forcedStop then
                        Bubble:stop()
                    else
                        local bodyYaw = player:getBodyYaw()
                        PlacementObjectManager:place(1, player:getPos():add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 1, 4, 0, 1, 0)), (bodyYaw * -1 + 180) % 360)
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postTransition = function(forcedStop)
                    if not forcedStop and BlueArchiveCharacter.EX_SKILL[1].TipShowed == nil and host:isHost() then
                        print(Language:getTranslate("ex_skill_1__tip_1_pre")..KeyManager.KeyMappings["ex_skill"]:getKeyName()..Language:getTranslate("ex_skill_1__tip_1_post"))
                        print(Language:getTranslate("ex_skill_1__tip_2_pre")..KeyManager.KeyMappings["firework_launch"]:getKeyName()..Language:getTranslate("ex_skill_1__tip_2_post"))
                        BlueArchiveCharacter.EX_SKILL[1].TipShowed = true
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
                if parts == "HELMET" then
                    if Armor.ArmorVisible[1] then
                        BlueArchiveCharacter.PHYSICS.data[3].z.vertical.max = 10
                        BlueArchiveCharacter.PHYSICS.data[3].z.horizontal.max = 10
                        BlueArchiveCharacter.PHYSICS.data[4].z.vertical.min = -10
                        BlueArchiveCharacter.PHYSICS.data[4].z.horizontal.min = -10
                        models.models.main.Avatar.Head.Brim:setVisible(false)
                    else
                        BlueArchiveCharacter.PHYSICS.data[3].z.vertical.max = 180
                        BlueArchiveCharacter.PHYSICS.data[3].z.horizontal.max = 180
                        BlueArchiveCharacter.PHYSICS.data[4].z.vertical.min = -180
                        BlueArchiveCharacter.PHYSICS.data[4].z.horizontal.min = -180
                        models.models.main.Avatar.Head.Brim:setVisible(true)
                    end
                elseif parts == "CHEST_PLATE" then
                    if Armor.ArmorVisible[2] then
                        models.models.main.Avatar.UpperBody.Body.BackRibbons:setVisible(false)
                        models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair:setPos(0, 0, -1)
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 1)
                    else
                        models.models.main.Avatar.UpperBody.Body.BackRibbons:setVisible(true)
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs.FrontHair, models.models.main.Avatar.UpperBody.Body.Hairs.BackHair}) do
                            modelPart:setPos()
                        end
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
                        if ExSkill.AnimationCount == -1 then
                            FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", duration, true)
                        end
                    elseif type == "HEART" then
                        FaceParts:setEmotion("NARROW", "NARROW", "SMILE", duration, true)
                    elseif type == "NOTE" then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", duration, true)
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "CIRCLE", duration, true)
                    elseif type == "SWEAT" then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "ANXIOUS", duration, true)
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
        ---@type ModelPart[]
        includeModels = {models.models.main.Avatar.UpperBody.Body.Hairs},

        ---頭のモデルパーツで頭ブロックから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart[]
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
        ---@type ModelPart[]
        includeModels = {},

        ---頭のモデルパーツでポートレートから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart[]
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

    ---死亡アニメーションのダミーアバター
    DEATH_ANIMATION = {
        ---ダミーアバターから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart[]
        excludeModels = {},

        ---死亡アニメーションが再生された直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase1 = function (dummyAvatar, costume)
            dummyAvatar.LowerBody:setVisible(false)
            dummyAvatar.UpperBody.Body.Skirt:setScale(1.5, 0.35, 2)
        end,

        ---ダミーアバターが縄ばしごにつかまった直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase2 = function (dummyAvatar, costume)
            dummyAvatar.LowerBody:setVisible(true)
            dummyAvatar.UpperBody.Body.Skirt:setRot(30, 0, 0)
            dummyAvatar.UpperBody.Body.Skirt:setScale(1.2, 1, 1)
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

    ---アクションホイールに関わる設定
    ACTION_WHEEL = {
        ---乗り物のモデル置き換えオプションを有効にするかどうか。
        ---@type boolean
        vehicleOptionEnabled = false
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
                modelPart = models.models.main.Avatar.Head.Ears.RightEar,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = 5,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 10,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 180,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 180
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -0.05,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 90
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = 5,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 10,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 180,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 180
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.Ears.LeftEar,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -180,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -10,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -5,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -180,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = -5
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
                            max = -5
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -180,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -10,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -5,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -180,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = -5
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.Brim.BrimRightRibbon,

                x = {
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

                        ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                        ---@type number
                        headRotMultiplayer = -1,
                    }
                },

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -35,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 150,

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

                        ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        headZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -35,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 90
                        },

                        ---頭の回転によるによるモデルパーツの回転データ（省略可）
                        headRot = {
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
                        min = -35,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 10,

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
                modelPart = models.models.main.Avatar.Head.Brim.BrimLeftRibbon,

                x = {
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

                        ---頭の縦方向の回転と共にこのモデルパーツの回転に加えられる値の倍率（省略可）
                        ---@type number
                        headRotMultiplayer = -1,
                    }
                },

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -150,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 35,

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
                            max = 0
                        },

                        ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        headZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -90,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 35
                        },

                        ---頭の回転によるによるモデルパーツの回転データ（省略可）
                        headRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.05,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -150,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -150,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -10,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 35,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -150,

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
                modelPart = {models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon1, models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon2},

                ---x軸回転における物理演算データ（省略可）
                x = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -145,

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
                            min = -70,

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
                            min = -145,

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
                modelPart = {models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon3, models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon4},

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
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -65,

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
                            min = -65,

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
                modelPart = {models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon2.BackRibbon2ZPivot, models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon4.BackRibbon4ZPivot},

                ---x軸回転における物理演算データ（省略可）
                z = {
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
                        max = 90,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 5
                        },

                        ---体を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        bodyZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -80,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 90
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.01,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 5
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -80,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 90,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 5
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = {models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon1.BackRibbon1ZPivot, models.models.main.Avatar.UpperBody.Body.BackRibbons.BackRibbon3.BackRibbon3ZPivot},

                ---x軸回転における物理演算データ（省略可）
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
                        max = 80,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        },

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
                            max = 80
                        },

                        ---体の回転によるによるモデルパーツの回転データ（省略可）
                        bodyRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.01,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -90,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 80,

                        ---体を基準とした、前後方向移動によるモデルパーツの回転データ（省略可）
                        bodyX = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -20,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    }
                }
            }
        }

        --[[
        ---物理演算処理後に実行されるコールバック関数（省略可）。ここでモデルパーツの向きを上書きできる。
        ---@param modelPart ModelPart 物理演算が処理されたモデルパーツ
        callback = function (modelPart)
        end
        ]]
    },

    --その他定数・変数

    ---花火台発射のクールダウン
    ExSKill1LaunchCooldown = 0
}

events.ENTITY_INIT:register(function ()
    --生徒固有初期化処理
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
        local robeVisible = models.models.main.Avatar.UpperBody.Body.Skirt:getVisible()
        local shouldHideLegs = robeVisible and player:getVehicle() ~= nil
        if shouldHideLegs and not shouldHideLegsPrev then
            models.models.main.Avatar.LowerBody.Legs:setVisible(false)
            models.models.main.Avatar.UpperBody.Body.Skirt:setScale(1.5, 0.35, 2)
        elseif not shouldHideLegs and shouldHideLegsPrev then
            models.models.main.Avatar.LowerBody.Legs:setVisible(true)
            models.models.main.Avatar.UpperBody.Body.Skirt:setScale()
        end
        local shouldAdjustLegs = legAdjustmentEnabled and robeVisible and not shouldHideLegs
        if shouldAdjustLegs and not legAdjustedPrev then
            events.RENDER:register(function ()
                local rightLegRotX = vanilla_model.RIGHT_LEG:getOriginRot().x
                models.models.main.Avatar.LowerBody.Legs.RightLeg:setRot(rightLegRotX * -0.55, 0, 0)
                models.models.main.Avatar.LowerBody.Legs.LeftLeg:setRot(vanilla_model.LEFT_LEG:getOriginRot().x * -0.55, 0, 0)
                local rightLegRotAbs = math.abs(rightLegRotX)
                models.models.main.Avatar.UpperBody.Body.Skirt:setScale(1, 1, rightLegRotAbs * 0.0025 + 1)
                local robeScale2 = vectors.vec3(rightLegRotAbs * -0.000625 + 1, 1, rightLegRotAbs * 0.00125 + 1)
                models.models.main.Avatar.UpperBody.Body.Skirt.Skirt2:setScale(robeScale2)
                models.models.main.Avatar.UpperBody.Body.Skirt.Skirt2.Skirt3:setScale(robeScale2)
            end, "skirt_render")
        elseif not shouldAdjustLegs and legAdjustedPrev then
            events.RENDER:remove("skirt_render")
            for _, modelPart in ipairs({models.models.main.Avatar.LowerBody.Legs.RightLeg, models.models.main.Avatar.LowerBody.Legs.LeftLeg}) do
                modelPart:setRot()
            end
            if not shouldHideLegs then
                for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Body.Skirt.Skirt2, models.models.main.Avatar.UpperBody.Body.Skirt.Skirt2.Skirt3}) do
                    modelPart:setScale()
                end
            end
        end
        shouldHideLegsPrev = shouldHideLegs
        legAdjustedPrev = shouldAdjustLegs
    end)

    events.RENDER:register(function (delta, context)
        if ExSkill.AnimationCount == -1 and context ~= "FIRST_PERSON" then
            if Gun.CurrentGunPosition == "NONE" then
                models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeve:setRot(math.clamp(vanilla_model.RIGHT_ARM:getOriginRot().x * -1 + 90, -35, 35), 0, 0)
                models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeve:setRot(math.clamp(vanilla_model.LEFT_ARM:getOriginRot().x * -1 + 90, -35, 35), 0, 0)
            else
                models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeve:setRot(math.clamp(models.models.main.Avatar.UpperBody.Arms.RightArm:getRot().x * -1 + 90, -35, 35), 0, 0)
                models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeve:setRot(math.clamp(models.models.main.Avatar.UpperBody.Arms.LeftArm:getRot().x * -1 + 90, -35, 35), 0, 0)
            end
        else
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeve, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeve}) do
                modelPart:setRot()
            end
        end
        models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeve:setOffsetPivot(0, models.models.main.Avatar.UpperBody.Arms.RightArm.RightSleeve:getTrueRot().x < 0 and -7 or 0, 0)
        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeve:setOffsetPivot(0, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftSleeve:getTrueRot().x < 0 and -7 or 0, 0)
    end)

    if host:isHost() then
        events.TICK:register(function ()
            if not client:isPaused() then
                BlueArchiveCharacter.ExSKill1LaunchCooldown = math.max(BlueArchiveCharacter.ExSKill1LaunchCooldown - 1, 0)
            end
        end)

        KeyManager:register("firework_launch", "key.keyboard.g", function ()
            if #PlacementObjectManager.PlacementObjects > 0 then
                if BlueArchiveCharacter.ExSKill1LaunchCooldown == 0 then
                    pings.lauchFireworks()
                    BlueArchiveCharacter.ExSKill1LaunchCooldown = 200
                else
                    sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.note_block.bass"), player:getPos(), 1, 0.5)
                    print(Language:getTranslate("ex_skill_1__in_cool_down_pre")..math.ceil(BlueArchiveCharacter.ExSKill1LaunchCooldown / 20)..Language:getTranslate("ex_skill_1__in_cool_down_post"))
                end
            end
        end)

        Language.LanguageData.en_us["ex_skill_1__in_cool_down_pre"] = "Please wait "
        Language.LanguageData.ja_jp["ex_skill_1__in_cool_down_pre"] = "あと"
        Language.LanguageData.en_us["ex_skill_1__in_cool_down_post"] = " more seconds to lanch fireworks."
        Language.LanguageData.ja_jp["ex_skill_1__in_cool_down_post"] = "秒待ってください。"
        Language.LanguageData.en_us["ex_skill_1__tip_1_pre"] = "§9§l[TIP]§r Hold "
        Language.LanguageData.ja_jp["ex_skill_1__tip_1_pre"] = "§9§l[TIP]§r "
        Language.LanguageData.en_us["ex_skill_1__tip_1_post"] = " key to put all firework launchers away!"
        Language.LanguageData.ja_jp["ex_skill_1__tip_1_post"] = "キーを長押しすると花火台を全て片付けます！"
        Language.LanguageData.en_us["ex_skill_1__tip_2_pre"] = "§9§l[TIP]§r Press "
        Language.LanguageData.ja_jp["ex_skill_1__tip_2_pre"] = "§9§l[TIP]§r "
        Language.LanguageData.en_us["ex_skill_1__tip_2_post"] = " key to launch fireworks from all firework launchers!"
        Language.LanguageData.ja_jp["ex_skill_1__tip_2_post"] = "キーを押すと\"たまや～\"ができます！"
    end
end)

function pings.lauchFireworks()
    PlacementObjectManager:applyFunc(1, function (objectData, index)
        local modelName = objectData.objectModel:getName()

        while events.TICK:getRegisteredCount("firework_launcher_"..modelName.."_tick") > 0 do
            events.TICK:remove("firework_launcher_"..modelName.."_tick")
            events.RENDER:remove("firework_launcher_"..modelName.."_render")
        end

        local count = 0
        local rot = objectData.objectModel:getRot().y
        events.TICK:register(function ()
            if not client:isPaused() then
                local fireworkPos = vectors.vec3()
                if count == 0 then
                    fireworkPos = objectData.currentPos:copy():add(vectors.rotateAroundAxis(rot, 0.234375, 1.734375, -0.72, 0, 1, 0))
                    FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 177.5, 0))
                elseif count == 10 then
                    fireworkPos = objectData.currentPos:copy():add(vectors.rotateAroundAxis(rot, -0.234375, 1.734375, -0.72, 0, 1, 0))
                    FireworkManager:spawn(fireworkPos, vectors.vec3(-17.5, rot + 182.5, 0))
                elseif count == 20 then
                    fireworkPos = objectData.currentPos:copy():add(vectors.rotateAroundAxis(rot, 0.234375, 1.296875, -0.72, 0, 1, 0))
                    FireworkManager:spawn(fireworkPos, vectors.vec3(-12.5, rot + 177.5, 0))
                elseif count == 30 then
                    fireworkPos = objectData.currentPos:copy():add(vectors.rotateAroundAxis(rot, -0.234375, 1.296875, -0.72, 0, 1, 0))
                    FireworkManager:spawn(fireworkPos, vectors.vec3(-12.5, rot + 182.5, 0))
                elseif count == 35 then
                    events.TICK:remove("firework_launcher_"..modelName.."_tick")
                    events.RENDER:remove("firework_launcher_"..modelName.."_render")
                end
                if count % 10 == 0 then
                    for _ = 1, 10 do
                        particles:newParticle(CompatibilityUtils:checkParticle("minecraft:smoke"), fireworkPos:copy():add(math.random() * 0.25 - 0.125, math.random() * 0.25 + 0.25, math.random() * 0.25 - 0.125))
                    end
                    sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.blaze.hurt"), objectData.currentPos, 1, 1.5)
                end
                count = count + 1
            end
        end, "firework_launcher_"..modelName.."_tick")
        events.RENDER:register(function (delta)
            if not client:isPaused() then
                ---バレルのレンダー処理
                ---@param barrelModel ModelPart 処理対象のバレルもモデル
                ---@param barrelCount number バレルのカウンタ値。0~1。
                local function barrelRender(barrelModel, barrelCount)
                    barrelModel:setPos(0, 0, barrelCount * 4)
                    barrelModel:setColor(vectors.vec3(1, 1, 1):sub(vectors.vec3(0, 0.087, 0.242):scale(barrelCount)))
                end
                barrelRender(objectData.objectModel.Cannon.CannonHead.CannonBarrel1, math.max((count + delta) * -0.2 + 1, 0))
                barrelRender(objectData.objectModel.Cannon.CannonHead.CannonBarrel2, count >= 10 and math.clamp((count + delta) * -0.2 + 3, 0, 1) or 0)
                barrelRender(objectData.objectModel.Cannon.CannonHead.CannonBarrel3, count >= 20 and math.clamp((count + delta) * -0.2 + 5, 0, 1) or 0)
                barrelRender(objectData.objectModel.Cannon.CannonHead.CannonBarrel4, count >= 30 and math.clamp((count + delta) * -0.2 + 7, 0, 1) or 0)
            end
        end, "firework_launcher_"..modelName.."_render")
    end)
end

return BlueArchiveCharacter