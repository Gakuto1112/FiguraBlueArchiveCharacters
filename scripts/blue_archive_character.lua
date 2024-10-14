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
            en_us = "Hoshino",

            ---日本語
            ---@type string
            ja_jp = "ホシノ"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "Takanashi",

            ---日本語
            ---@type string
            ja_jp = "小鳥遊"
        },

        ---生徒所属の部活名
        clubName = {
            ---英語
            ---@type string
            en_us = "Countermeasure Council",

            ---日本語
            ---@type string
            ja_jp = "対策委員会",
        },

        ---生徒の誕生日
        birth = {
            ---誕生月
            ---@type integer
            month = 1,

            ---誕生日
            ---@type integer
            day = 2
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
            ANGRY = {7, 0},
            CLOSED2 = {0, 1},
            INVERTED = {1, 1},
            SERIOUS_ANGRY = {2, 1}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {2, 0},
            TIRED = {4, 0},
            CLOSED = {5, 0},
            ANGRY = {7, 0},
            ANGRY_CENTER = {8, 0},
            CLOSED2 = {-1, 1},
            SERIOUS_ANGRY = {2, 1}
        },

        ---口
        Mouth = {
            CLOSED2 = {1, 0},
            W = {2, 0},
            YAWN = {3, 0},
            OPENED = {0, 0}
        },

        ---表情のセット（省略可）
        FacePartsSets = {
            ---ダメージを受けた時の表情（省略可）
            --[[
            onDamage = {
                RightEye = "SURPLISED",
                LeftEye = "SURPLISED",
                Mouth = "CLOSED"
            }
            ]]

            ---寝ている時の表情（省略可）
            onSleep = {
                RightEye = "CLOSED",
                LeftEye = "CLOSED",
                Mouth = "YAWN"
            }
        }
    },

    ---腕
    ARMS = {
        ---コールバック関数
        ---@type {[string]: function}
        callbacks = {
            ---腕の状態が変更された際のコールバック関数（任意）
            ---@param right integer 新しい右腕の状態
            ---@param left integer 新しい左腕の状態
            ---@return {right?: integer, left?: integer}|nil overriddenArmState 返した値で腕の状態を上書きできる。
            onArmStateChanged = function (right, left)
                if right == 0 and left == 0 and BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled and not BlueArchiveCharacter.COSTUME.costumes[3].IsAFK then
                    return {right = 5, left = 5}
                elseif right == 1 and left == 2 then
                    local isLeftHanded = player:isLeftHanded()
                    if (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem().id == "minecraft:shield" and isLeftHanded) then
                        return {right = 1, left = 4}
                    elseif BlueArchiveCharacter.COSTUME.costumes[3].IsAFK then
                        return {right = 0, left = 0}
                    end
                elseif right == 2 and left == 1 then
                    local isLeftHanded = player:isLeftHanded()
                    if (player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded) then
                        return {right = 4, left = 1}
                    elseif BlueArchiveCharacter.COSTUME.costumes[3].IsAFK then
                        return {right = 0, left = 0}
                    end
                end
            end,

            ---右腕の追加処理（任意）
            ---@param state integer 新しい右腕の状態
            onAddtionalRightArmProcess = function (state)
                if state == 1 then
                    events.RENDER:register(function ()
                        if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled then
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(models.models.main.Avatar.UpperBody.Arms.RightArm:getRot():add(10, 0, 0))
                        end
                    end, "right_arm_render")
                elseif state == 2 then
                    events.TICK:register(function ()
                        local isLeftHanded = player:isLeftHanded()
                        if ((player:getHeldItem().id == "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and isLeftHanded)) and Arms.ArmState.right == 2 then
                            Arms:setArmState(4, nil)
                        elseif BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun then
                            Arms:setArmState(1, 1)
                        end
                    end, "right_arm_tick")
                    events.RENDER:register(function ()
                        if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled then
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(models.models.main.Avatar.UpperBody.Arms.RightArm:getRot():add(10, 0, 0))
                        end
                    end, "right_arm_render")
                elseif state == 4 then
                    events.TICK:register(function ()
                        Arms:processArmWingCount()
                        local isLeftHanded = player:isLeftHanded()
                        if ((player:getHeldItem().id ~= "minecraft:shield" and not isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and isLeftHanded)) and Arms.ArmState.right == 4 then
                            Arms:setArmState(2, nil)
                        end
                    end, "right_arm_tick")
                    events.RENDER:register(function (delta, context)
                        local isSwingingArm = player:isSwingingArm() and not player:isLeftHanded()
                        models.models.main.Avatar.UpperBody.Arms.RightArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "RightArm" or "Body")
                        models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.ArmSwingCount + delta) / 100 * math.pi * 2) * 2.5 + 40, 30, 0))
                    end, "right_arm_render")
                elseif state == 5 then
                    events.TICK:register(function ()
                        if  Arms.ArmState.left == 5 then
                            local activeHand = player:getActiveHand()
                            local isLeftHanded = player:isLeftHanded()
                            models.models.main.Avatar.UpperBody.Arms.RightArm:setRot(player:getActiveItem().id ~= "minecraft:air" and ((activeHand == "MAIN_HAND" and not isLeftHanded) or (activeHand == "OFF_HAND" and isLeftHanded)) and vectors.vec3() or vectors.vec3(20, 0, 20))
                        end
                    end, "right_arm_tick")
                end
            end,

            ---左腕の追加処理（任意）
            ---@param state integer 新しい左腕の状態
            onAddtionalLeftArmProcess = function (state)
                if state == 1 then
                    events.RENDER:register(function ()
                        if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled then
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(models.models.main.Avatar.UpperBody.Arms.LeftArm:getRot():add(10, 0, 0))
                        end
                    end, "left_arm_render")
                elseif state == 2 then
                    events.TICK:register(function ()
                        local isLeftHanded = player:isLeftHanded()
                        if ((player:getHeldItem().id == "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id == "minecraft:shield" and not isLeftHanded)) and Arms.ArmState.left == 2 then
                            Arms:setArmState(nil, 4)
                        elseif BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun then
                            Arms:setArmState(1, 1)
                        end
                    end, "left_arm_tick")
                    events.RENDER:register(function ()
                        if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled then
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(models.models.main.Avatar.UpperBody.Arms.LeftArm:getRot():add(10, 0, 0))
                        end
                    end, "left_arm_render")
                elseif state == 4 then
                    events.TICK:register(function ()
                        Arms:processArmWingCount()
                        local isLeftHanded = player:isLeftHanded()
                        if ((player:getHeldItem().id ~= "minecraft:shield" and isLeftHanded) or (player:getHeldItem(true).id ~= "minecraft:shield" and not isLeftHanded)) and Arms.ArmState.left == 4 then
                            Arms:setArmState(nil, 2)
                        end
                    end, "left_arm_tick")
                    events.RENDER:register(function (delta, context)
                        local isSwingingArm = player:isSwingingArm() and player:isLeftHanded()
                        models.models.main.Avatar.UpperBody.Arms.LeftArm:setParentType((isSwingingArm or context == "FIRST_PERSON") and "LeftArm" or "Body")
                        models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(isSwingingArm and vectors.vec3() or vectors.vec3(math.sin((Arms.ArmSwingCount + delta) / 100 * math.pi * 2) * -2.5 + 40, -30, 0))
                    end, "left_arm_render")
                elseif state == 5 then
                    events.TICK:register(function ()
                        if Arms.ArmState.left == 5 then
                            local activeHand = player:getActiveHand()
                            local isLeftHanded = player:isLeftHanded()
                            models.models.main.Avatar.UpperBody.Arms.LeftArm:setRot(player:getActiveItem().id ~= "minecraft:air" and ((activeHand == "OFF_HAND" and not isLeftHanded) or (activeHand == "MAIN_HAND" and isLeftHanded)) and vectors.vec3() or vectors.vec3(20, 0, -20))
                        end
                    end, "left_arm_tick")
                end
            end
        }
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
        scale = 1.3,

        ---構えている時
        hold = {
            ---構え方
            ---@type BlueArchiveCharacter.GunHoldType
            type = "NORMAL",

            ---一人称視点での位置オフセット（省略可）
            first_person_pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-1, 0, -8),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(1, 0, -8)
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
                right = vectors.vec3(-1.75, 0, -8),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(1.75, 0, -8)
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
            type = "BODY",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-3, 3.5, 3),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(3, 3.5, 3)
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-45, -90, 0),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(-45, 90, 0)
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
        },

        ---利き手が変更された時に呼び出される関数。利き手に応じた銃やアクセサリーの変更に利用できる。
        ---@param direction Gun.HandDirection 新たな利き手
        onMainHandChange = function (direction)
            if direction == "RIGHT" then
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag:setPos()
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag:setRot(0, 0, 45)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.ShoulderRope:setRot(0, 0, -2.5)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.ShoulderRope.ShoulderRopeKnob:setRot()
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.BagTop.WhaleStrap:setPos()
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.BagTop.WhaleStrap:setRot(0, 0, -45)
            else
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag:setPos(6, 0, 0)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag:setRot(0, 180, -45)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.ShoulderRope:setRot(0, 180, 1)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.ShoulderRope.ShoulderRopeKnob:setRot(0, 180, 0)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.BagTop.WhaleStrap:setPos(0, 0, 2.3)
                models.models.main.Avatar.UpperBody.Body.CSwimsuitB.GunBag.BagTop.WhaleStrap:setRot(0, 180, -45)
            end
        end
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
                en_us = "Tactical Suppression",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "戦術的鎮圧"
            },

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.UpperBody.Body.Gun.Barrel.ShineEffect},

            ---Exスキルアニメーションが含まれるモデルファイル名
            ---アニメーション名は"ex_skill_<Exスキルのインデックス番号>"にすること。
            ---@type string[]
			animations = {"main", "gun", "ex_skill_1"},

            ---Exスキルアニメーションでのカメラワークのデータ
            camera = {
                ---Exスキルアニメーション開始時
                start = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-4.5, 7.75, -44.5),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, -160, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-13.5, 13.5, -25),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-15, 215, 0)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    FaceParts:setEmotion("ANGRY", "ANGRY", "CLOSED2", 53, true)
                    ---@diagnostic disable-next-line: undefined-field
                    models.models.main.Avatar.UpperBody.Body.Gun.Barrel.ShineEffect:setColor(client:hasShaderPack() and vectors.vec3(1, 0.5, 0.5) or vectors.vec3(1, 1, 1))
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 0 then
                        models.models.main.Avatar.UpperBody.Body.Gun:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom)
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setPos()
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:setRot()
                        models.models.main.Avatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setVisible(false)
                    elseif tick == 8 or tick == 15 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.chest.locked"), player:getPos(), 1, 2)
                    elseif tick == 12 then
                        local bodyYaw = player:getBodyYaw()
                        local particlePos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Body.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 3.66, -1, 0, 1, 0):scale(0.0625))
                        for _ = 1, 10 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6 - 0.3, math.random() * 0.2 - 0.1, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
                        end
                    elseif tick == 19 then
                        local bodyYaw = player:getBodyYaw()
                        local particlePos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 3.66, -1, 0, 1, 0):scale(0.0625))
                        for _ = 1, 10 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.6 - 0.3, math.random() * 0.2 - 0.1, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
                        end
                    elseif tick == 36 or tick == 45 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.anvil.place"), player:getPos(), 1, 2)
                    elseif tick == 38 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder1.GasPiston1, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder2.GasPiston2}) do
                            local bodyYaw = player:getBodyYaw()
                            local particlePos = ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0):scale(0.0625))
                            for _ = 1, 5 do
                                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.06 - 0.03, -0.05, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
                            end
                        end
                    elseif tick == 47 then
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder3.GasPiston3, models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder4.GasPiston4}) do
                            local bodyYaw = player:getBodyYaw()
                            local particlePos = ModelUtils.getModelWorldPos(modelPart):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0):scale(0.0625))
                            for _ = 1, 5 do
                                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setScale(0.25):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.06 - 0.03, -0.025, 0, 0, 1, 0)):setColor(1, 0.64, 0.59):setLifetime(4)
                            end
                        end
                    elseif tick == 53 then
                        models.models.main.Avatar.UpperBody.Body.Shield:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom)
                        FaceParts:setEmotion("ANGRY", "ANGRY_CENTER", "CLOSED2", 19, true)
                    elseif tick == 55 then
                        local bodyYaw = player:getBodyYaw()
                        local particlePos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 10, 4, 0, 1, 0):scale(0.0625))
                        for _ = 1, 5 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setScale(0.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 0, 1, 0)):setColor(0.973, 0.714, 0.29):setLifetime(2)
                        end
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.anvil.place"), player:getPos(), 0.25, 4)
                    elseif tick == 70 then
                        local bodyYaw = player:getBodyYaw()
                        local particlePos = ModelUtils.getModelWorldPos(models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Shield.Section2):add(vectors.rotateAroundAxis(bodyYaw * -1, -2, 3, 4, 0, 1, 0):scale(0.0625))
                        for _ = 1, 5 do
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:electric_spark"), particlePos):setScale(0.5):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 0.25 - 0.125, math.random() * 0.25 - 0.125, 0, 0, 1, 0)):setColor(0.973, 0.714, 0.29):setLifetime(2)
                        end
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.anvil.place"), player:getPos(), 0.25, 4)
                    elseif tick == 72 then
                        FaceParts:setEmotion("ANGRY", "CLOSED2", "CLOSED2", 32, true)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.flintandsteel.use"), player:getPos(), 1, 2)
                    elseif tick == 79 then
                        local particlePos = player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 1, 0, -3, 0, 1, 0))
                        particles:newParticle(CompatibilityUtils:checkParticle("minecraft:explosion_emitter"), particlePos)
                        for _ = 1, 100 do
                            local particleOffset = vectors.vec3(math.random() - 0.5, math.random() * 0.5, math.random() - 0.5)
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:poof"), particlePos:copy():add(particleOffset)):setScale(5):setVelocity(particleOffset)
                        end
                        local particleBlock = world.getBlockState(particlePos:copy():add(0, -1, 0)).id
                        if particleBlock ~= "minecraft:air" and particleBlock ~= "minecraft:void_air" then
                            for _ = 1, 50 do
                                particles:newParticle(CompatibilityUtils.getBlockParticleId(particleBlock), particlePos):setScale(0.75):setVelocity(math.random() * 0.8 - 0.4, math.random() * 1, math.random() * 0.8 - 0.4):setLifetime(40)
                            end
                        end
                        local playerPos = player:getPos()
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.iron_door.open"), playerPos, 1, 2)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.player.levelup"), playerPos, 0.5, 1.5)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.generic.explode"), playerPos, 0.5, 0.5)
                    end
                    if tick % 2 == 0 then
                        ---銃弾を表現するパーティクル
                        ---@param pos Vector3 パーティクルをスポーンさせる場所
                        local function ammoParticle(pos)
                            local bodyYaw = player:getBodyYaw()
                            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:flame"), pos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -1, 0, 1, 0)):setLifetime(20)
                            local smokePos = pos:copy()
                            for _ = 1, 5 do
                                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:smoke"), smokePos:add(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, 0.5, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, 0, 0, -0.5, 0, 1, 0)):setGravity(0):setLifetime(20)
                            end
                        end
                        local particlePos = math.random()
                        if particlePos < 0.4 then
                            ammoParticle(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, -1, particlePos * 7.5, 4, 0, 1, 0)))
                        elseif particlePos < 0.6 then
                            ammoParticle(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, (particlePos - 0.4) * 10 - 1, 3, 4, 0, 1, 0)))
                        else
                            ammoParticle(player:getPos():add(vectors.rotateAroundAxis(player:getBodyYaw() * -1, 1, (particlePos - 0.6) * 7.5, 4, 0, 1, 0)))
                        end
                    end
                end,

                ---Exスキルアニメーション終了後のトランジション開始前に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postAnimation = function(forcedStop)
                    if models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.Gun:moveTo( models.models.main.Avatar.UpperBody.Body)
                    end
                    if player:isLeftHanded() then
                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.GUN.put.pos.left))
                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(BlueArchiveCharacter.GUN.put.rot.left)
                    else
                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(BlueArchiveCharacter.GUN.put.pos.right))
                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(BlueArchiveCharacter.GUN.put.rot.right)
                    end
                    if models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Shield ~= nil then
                        models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.Shield:moveTo(models.models.main.Avatar.UpperBody.Body)
                    end
                    if ExSkill.AnimationCount >= 0 then
                        models.models.main.Avatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setVisible(true)
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
                en_us = "Aquatic Support",

                ---日本語
                ---実際のスキルの名前と同じにする。
                ---@type string
                ja_jp = "水上支援"
            },

            ---Exスキルアニメーション開始時に表示し、Exスキルアニメーション終了時に非表示にするモデルパーツ
            ---@type ModelPart[]
			models = {models.models.main.Avatar.LowerBody.WhaleFloat, models.models.ex_skill_2.Waves},

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
                    pos = vectors.vec3(-54, 100.6, -147.4),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-15, -150, 0)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(-248, 17.6, -340.6),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(-15, -180, 30)
                }
            },

            ---コールバック関数
            callbacks = {
                ---Exスキルアニメーション開始前のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun()
                preAnimation = function()
                    BlueArchiveCharacter.resetExSkill2Feature()
                    models.models.ex_skill_2.Waves:setColor(world.getBiome(player:getPos()):getWaterColor())
                    FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
                end,

                ---Exスキルアニメーション再生中のみ実行されるティック関数
                ---@type fun(tick: integer)
                ---@param tick integer アニメーションの現在位置を示す。単位はティック。
                animationTick = function(tick)
                    if tick == 3 then
                        local modelPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Waves.Wave1):add(0, 7, 0)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 500 do
                            local offset = vectors.vec3(math.random() * 32 - 16, 0, math.random() * 5)
                            local particleOffset = offset:copy()
                            particleOffset.x = particleOffset.x * (math.random() * 0.025 + 0.025)
                            particleOffset.y = 0.25
                            particleOffset.z = (particleOffset.z - 2.5) * (math.random() * 0.025 + 0.025)
                            particles:newParticle(CompatibilityUtils.getDustParticleId(vectors.vec3(1000000000, 1000000000, 1000000000), 5), modelPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, offset, 0, 1, 0))):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1, particleOffset, 0, 1, 0)):setGravity(1):setLifetime(40)
                        end
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.bucket.empty"), modelPos, 1, 0.5)
                    elseif tick == 13 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 29, true)
                    elseif tick == 39 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.generic.splash"), ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
                    elseif tick == 42 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "W", 13, true)
                    elseif tick == 52 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.generic.swim"), ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
                    elseif tick == 55 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "W", 13, true)
                    elseif tick == 68 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 2, true)
                    elseif tick == 70 then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "OPENED", 12, true)
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.generic.swim"), ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
                    elseif tick == 82 then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "OPENED", 4, true)
                    elseif tick == 85 then
                        FaceParts:setEmotion("INVERTED", "CLOSED", "OPENED", 28, true)
                    elseif tick == 86 then
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.bucket.empty"), ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1), 1, 0.5)
                    end

                    if tick >= 8 and tick < 28 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.ex_skill_2.Waves.Wave2.Wave2ParticleAnchor)
                        local bodyYaw = player:getBodyYaw()
                        for _ = 1, 20 do
                            particles:newParticle(CompatibilityUtils.getDustParticleId(vectors.vec3(1000000000, 1000000000, 1000000000), 5), anchorPos:copy():add(vectors.rotateAroundAxis(bodyYaw * -1, math.random() * 32 - 16, 0, 0, 0, 1, 0))):setVelocity(math.random() * 0.2 - 0.1, 0.5, math.random() * 0.2 - 0.1):setGravity(1):setLifetime(20)
                        end
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.bucket.empty"), anchorPos, 1, 0.5)
                    elseif tick >= 41 then
                        local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1)
                        local dirVector = ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor2):sub(anchorPos):normalize()
                        local YVector = ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor3):sub(anchorPos):normalize()
                        for _ = 1, 20 do
                            local particleDirection = math.random() * 60 - 30
                            particleDirection = particleDirection > 0 and particleDirection + 30 or particleDirection - 30
                            particles:newParticle(CompatibilityUtils.getDustParticleId(vectors.vec3(1000000000, 1000000000, 1000000000), 3), anchorPos):setVelocity(vectors.rotateAroundAxis(particleDirection, dirVector, YVector):add(YVector:copy():scale(math.random())):normalize():scale(0.5)):setGravity(0.5):setLifetime(10)
                        end
                        if tick % 2 == 0 then
                            sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.bucket.empty"), anchorPos, 0.1, 0.5)
                        end
                    end

                    if tick % 2 == 0 then
                        for _, modelPart in ipairs({models.models.ex_skill_2.Waves.Surface, models.models.ex_skill_2.Waves.Wave1}) do
                            modelPart:setUVPixels(0, modelPart:getUVPixels().y + 16)
                        end
                    end
                    models.models.ex_skill_2.Waves.Wave2:setUVPixels(0, models.models.ex_skill_2.Waves.Wave2.Wave2:getUVPixels().y + 16)
                end,

                ---Exスキルアニメーション終了後のトランジション終了後に実行されるコールバック関数（任意）
                ---@type fun(forcedStop: boolean)
                ---@param forcedStop boolean アニメーションが途中終了した場合は"true"、アニメーションが最後まで再生されて終了した場合は"false"が代入される。
                postTransition = function(forcedStop)
                    if not forcedStop then
                        local playerPos = player:getPos()
                        for i = 1, 6 do
                            for j = 0, 35 do
                                particles:newParticle(CompatibilityUtils.getDustParticleId(vectors.vec3(1000000000, 1000000000, 1000000000), 2), playerPos):setVelocity(vectors.rotateAroundAxis(j * 12, 0, -0.25, i * 0.05, 0, 1, 0)):setPower(0.25):setColor((i - 1) * 0.2, 1, 1)
                            end
                        end
                        ExSkill2WaveParticleManager:spawn()
                        sounds:playSound(CompatibilityUtils:checkSound("minecraft:item.bucket.empty"), playerPos, 1, 0.5)
                        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.CSwimsuitB.RashGuardB, models.models.main.Avatar.UpperBody.Arms.RightArm.CSwimsuitRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CSwimsuitRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.CSwimsuitLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CSwimsuitLAB, models.models.main.Avatar.LowerBody.Legs.RightLeg.CSwimsuitRL, models.models.main.Avatar.LowerBody.Legs.LeftLeg.CSwimsuitLL}) do
                            modelPart:setVisible(false)
                        end
                        models.models.main.Avatar.Head.CSwimsuitH.Glasses:setPos(0, -4, 0)
                        BlueArchiveCharacter.ExSkill_2_CostumeChangeTimer = 1000
                        events.TICK:register(function ()
                            if not client:isPaused() then
                                if BlueArchiveCharacter.ExSkill_2_CostumeChangeTimer == 0 then
                                    BlueArchiveCharacter.resetExSkill2Feature()
                                end
                                BlueArchiveCharacter.ExSkill_2_CostumeChangeTimer = BlueArchiveCharacter.ExSkill_2_CostumeChangeTimer - 1
                            end
                        end, "ex_skill_2_post_tick")
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
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 2,

                ---クジラフロートに乗っているかどうか
                ---@type boolean
                WhaleFloatEnabled = false,

                ---前ティックにクジラフロートに乗っていたかどうか
                ---@type boolean
                WhaleFloatEnabledPrev = false,

                ---クジラフロート上でのAFKカウンター
                ---@type integer
                WhaleFloatAFKCount = 0,

                ---AFK中かどうか
                ---@type boolean
                IsAFK = false
            },
            {
                ---コスチュームの内部名
                ---@type string
                name = "battle",

                ---コスチュームの表示名
                display_name = {
                    ---英語
                    ---@type string
                    en_us = "Battle",

                    ---日本語
                    ---@type string
                    ja_jp = "臨戦"
                },

                ---この衣装での生徒の配置タイプ
                ---@type BlueArchiveCharacter.FormationType
                formationType = "STRIKER",

                ---コスチュームに対応するExスキルのインデックス番号
                ---@type integer
                exSkill = 1,

                ---サブハンドガンを持っているかどうか
                ---@param boolean
                HasSubGun = false
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
                    --覆面水着団
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaskedH}) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.HairEnds, models.models.main.Avatar.UpperBody.Body.Hairs}) do
                        modelPart:setVisible(false)
                    end
                elseif costumeId == 3 then
                    --水着
                    Costume.setCostumeTextureOffset(1)
                    models.models.main.Avatar.Head.HatLayer:setUVPixels(0, 16)
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.CSwimsuitH, models.models.main.Avatar.UpperBody.Body.CSwimsuitB, models.models.main.Avatar.UpperBody.Arms.RightArm.CSwimsuitRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CSwimsuitRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.CSwimsuitLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CSwimsuitLAB, models.models.main.Avatar.LowerBody.Legs.RightLeg.CSwimsuitRL, models.models.main.Avatar.LowerBody.Legs.LeftLeg.CSwimsuitLL}) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs, models.models.main.Avatar.UpperBody.Body.IDCard, models.models.main.Avatar.UpperBody.Body.Tie, models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Body.Shield}) do
                        modelPart:setVisible(false)
                    end

                    events.TICK:register(function ()
                        local vehicle = player:getVehicle()
                        if vehicle ~= nil  then
                            local id = vehicle:getType()
                            BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled = ActionWheel.ShouldReplaceVehicleModels and (id == "minecraft:boat" or id == "minecraft:chest_boat") and #vehicle:getPassengers() == 1
                            if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled then
                                if not BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev then
                                    BlueArchiveCharacter.COSTUME.costumes[3].LookDirPrev = player:getLookDir()
                                    models.models.main.Avatar.LowerBody.WhaleFloat:setVisible(true)
                                    renderer:setRenderVehicle(false)
                                    models.models.main.Avatar.Head:setRot(10, 0, 0)
                                    if Gun.CurrentGunPosition == "RIGHT" then
                                        Arms:setArmState(1, 2)
                                    elseif Gun.CurrentGunPosition == "LEFT" then
                                        Arms:setArmState(2, 1)
                                    else
                                        Arms:setArmState(5, 5)
                                    end
                                    for _, animationModel in ipairs({"models.main", "models.ex_skill_2"}) do
                                        animations[animationModel]["float_ride"]:play()
                                    end
                                    events.TICK:register(function ()
                                        if world.getBlockState(player:getPos()).id == "minecraft:water" then
                                            animations["models.main"]["whale_float"]:setPlaying(true)
                                            if Physics.VelocityAverage[5] >= 0.35 then
                                                FaceParts:setEmotion("CLOSED", "CLOSED", "W", 1, false)
                                            end
                                            if Physics.VelocityAverage[5] >= 0.1  then
                                                local bodyYaw = player:getBodyYaw()
                                                local anchorPos = ModelUtils.getModelWorldPos(models.models.main.Avatar.LowerBody.WhaleFloat.WhaleParticleAnchor1):add(vectors.rotateAroundAxis(bodyYaw * -1, 0.1875, 0, 0, 0, 1, 0))
                                                for _ = 1, 5 do
                                                    local particleDirection = math.random() * 60 - 30
                                                    particleDirection = particleDirection > 0 and particleDirection + 30 or particleDirection - 30
                                                    particles:newParticle(CompatibilityUtils.getDustParticleId(vectors.vec3(1000000000, 1000000000, 1000000000), 3), anchorPos):setVelocity(vectors.rotateAroundAxis(bodyYaw * -1 + particleDirection + 150, vectors.vec3(1, 1, 1), 0, 1, 0):scale(math.random()):normalize():scale(Physics.VelocityAverage[5])):setGravity(0.5):setLifetime(10)
                                                end
                                            end

                                            if player:getVehicle():getNbt().Type == "bamboo" then
                                                models.models.main.Avatar:setPos(0, -6, 0)
                                                CameraManager.setCameraPivot(vectors.vec3(0, 0.1875, 0))
                                                renderer:setEyeOffset(0, 0.1875, 0)
                                            else
                                                models.models.main.Avatar:setPos()
                                                CameraManager.setCameraPivot(vectors.vec3(0, 0.5625, 0))
                                                renderer:setEyeOffset(0, 0.5625, 0)
                                            end
                                        else
                                            animations["models.main"]["whale_float"]:setPlaying(false)
                                            if player:getVehicle():getNbt().Type == "bamboo" then
                                                models.models.main.Avatar:setPos(0, -9, 0)
                                                CameraManager.setCameraPivot(vectors.vec3())
                                                renderer:setEyeOffset()
                                            else
                                                models.models.main.Avatar:setPos(0, -3, 0)
                                                CameraManager.setCameraPivot(vectors.vec3(0, 0.375, 0))
                                                renderer:setEyeOffset(0, 0.375, 0)
                                            end
                                        end
                                        local lookdir = player:getLookDir()
                                        if player:getVelocity():length() < 0.01 and BlueArchiveCharacter.COSTUME.costumes[3].LookDirPrev:copy():sub(lookdir):length() == 0 and not player:isSwingingArm() and PlayerUtils:getDamageStatus() == "NONE" and player:getActiveItem().id == "minecraft:air" then
                                            BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount = BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount + 1
                                            if BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount == 2400 then
                                                BlueArchiveCharacter.COSTUME.costumes[3].IsAFK = true
                                                for _, animationModel in ipairs({"models.main", "models.costume_swimsuit", "models.ex_skill_2"}) do
                                                    animations[animationModel]["float_afk"]:setSpeed(1)
                                                    animations[animationModel]["float_afk"]:play()
                                                end
                                                Arms:setArmState(0, 0)
                                                Physics.disable()
                                            elseif BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount >= 2430 then
                                                FaceParts:setEmotion("CLOSED2", "CLOSED2", "YAWN", 1, false)
                                            end
                                        else
                                            if BlueArchiveCharacter.COSTUME.costumes[3].IsAFK then
                                                BlueArchiveCharacter.COSTUME.costumes[3].IsAFK = false
                                                for _, animationModel in ipairs({"models.main", "models.costume_swimsuit", "models.ex_skill_2"}) do
                                                    animations[animationModel]["float_afk"]:setSpeed(-1)
                                                end
                                                events.TICK:remove("whale_float_afk_end_tick")
                                                events.TICK:register(function ()
                                                    if animations["models.main"]["float_afk"]:getTime() == 0 then
                                                        for _, animationModel in ipairs({"models.main", "models.costume_swimsuit", "models.ex_skill_2"}) do
                                                            animations[animationModel]["float_afk"]:stop()
                                                        end
                                                        if Gun.CurrentGunPosition == "RIGHT" then
                                                            Arms:setArmState(1, 2)
                                                        elseif Gun.CurrentGunPosition == "LEFT" then
                                                            Arms:setArmState(2, 1)
                                                        else
                                                            Arms:setArmState(5, 5)
                                                        end
                                                        Physics:enable()
                                                        events.TICK:remove("whale_float_afk_end_tick")
                                                    end
                                                end, "whale_float_afk_end_tick")
                                            end
                                            BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount = 0
                                        end
                                        BlueArchiveCharacter.COSTUME.costumes[3].LookDirPrev = lookdir
                                    end, "whale_float_tick")
                                end
                                BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev = true
                            elseif BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev then
                                BlueArchiveCharacter.stopWhaleFloat()
                                BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev = false
                            end
                        elseif BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev then
                            BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabled = false
                            BlueArchiveCharacter.stopWhaleFloat()
                            BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev = false
                        end
                    end, "whale_float_tick_2")
                elseif costumeId == 4 then
                    --臨戦
                    Costume.setCostumeTextureOffset(2)
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.Head, models.models.main.Avatar.Head.HatLayer}) do
                        modelPart:setUVPixels(0, 16)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.Head.CBattleH, models.models.main.Avatar.UpperBody.Body.CBattleB, models.models.main.Avatar.UpperBody.Body.SubGun}) do
                        modelPart:setVisible(true)
                    end
                    for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Hairs, models.models.main.Avatar.UpperBody.Body.IDCard, models.models.main.Avatar.UpperBody.Body.Tie}) do
                        modelPart:setVisible(false)
                    end
                    events.TICK:register(function ()
                        BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun = false
                        if Gun.CurrentGunPosition ~= "NONE" then
                            local isLeftHanded = player:isLeftHanded()
                            local heldItem = player:getHeldItem(Gun.CurrentGunPosition == "RIGHT" ~= isLeftHanded)
                            for _, gunItem in ipairs(Gun.GUN_ITEMS) do
                                if gunItem == heldItem.id then
                                    BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun = true
                                    break
                                end
                            end
                        end
                        if BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun then
                            models.models.main.Avatar.UpperBody.Body.SubGun:setScale(1.5, 1.5, 1.5)
                            models.models.main.Avatar.UpperBody.Body.SubGun:setParentType("Item")
                        else
                            models.models.main.Avatar.UpperBody.Body.SubGun:setPos(-1, 17.5, -1.9)
                            models.models.main.Avatar.UpperBody.Body.SubGun:setRot(-30, 90, 0)
                            models.models.main.Avatar.UpperBody.Body.SubGun:setScale()
                            models.models.main.Avatar.UpperBody.Body.SubGun:setParentType("None")
                        end
                    end, "costume_battle_tick")
                    events.ITEM_RENDER:register(function (_, mode)
                        if BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun then
                            if Gun.CurrentGunPosition == "RIGHT" then
                                if mode == "FIRST_PERSON_LEFT_HAND" then
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setPos(-1, 0.5, -2.5)
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setRot()
                                    return models.models.main.Avatar.UpperBody.Body.SubGun
                                elseif mode == "THIRD_PERSON_LEFT_HAND" then
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setPos(0, -2, -1)
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setRot()
                                    return models.models.main.Avatar.UpperBody.Body.SubGun
                                end
                            elseif Gun.CurrentGunPosition == "LEFT" then
                                if mode == "FIRST_PERSON_RIGHT_HAND" then
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setPos(-1, 0.5, -1)
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setRot()
                                    return models.models.main.Avatar.UpperBody.Body.SubGun
                                elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setPos(0, -2, -1)
                                    models.models.main.Avatar.UpperBody.Body.SubGun:setRot()
                                    return models.models.main.Avatar.UpperBody.Body.SubGun
                                end
                            end
                        end
                    end, "costume_battle_item_render")
                end
            end,

            ---衣装がリセットされた時に実行されるコールバック関数
            ---あらゆる衣装からデフォルトの衣装へ推移できるようにする。
            ---@type fun()
            reset = function()
                Costume.setCostumeTextureOffset(0)
                models.models.main.Avatar.Head.HatLayer:setUVPixels()
                BlueArchiveCharacter.resetExSkill2Feature()
                for _, modelPart in ipairs({models.models.main.Avatar.Head.CMaskedH, models.models.main.Avatar.Head.CSwimsuitH, models.models.main.Avatar.UpperBody.Body.CSwimsuitB, models.models.main.Avatar.UpperBody.Arms.RightArm.CSwimsuitRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CSwimsuitRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.CSwimsuitLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CSwimsuitLAB, models.models.main.Avatar.LowerBody.Legs.RightLeg.CSwimsuitRL, models.models.main.Avatar.LowerBody.Legs.LeftLeg.CSwimsuitLL, models.models.main.Avatar.Head.CBattleH, models.models.main.Avatar.UpperBody.Body.CBattleB, models.models.main.Avatar.UpperBody.Body.SubGun}) do
                    modelPart:setVisible(false)
                end
                for _, modelPart in ipairs({models.models.main.Avatar.Head.HairEnds, models.models.main.Avatar.UpperBody.Body.Hairs, models.models.main.Avatar.UpperBody.Body.IDCard, models.models.main.Avatar.UpperBody.Body.Tie, models.models.main.Avatar.UpperBody.Body.Skirt, models.models.main.Avatar.UpperBody.Body.Shield}) do
                    modelPart:setVisible(true)
                end
                for _, eventName in ipairs({"whale_float_tick_2", "costume_battle_tick"}) do
                    events.TICK:remove(eventName)
                end
                events.ITEM_RENDER:remove("costume_battle_item_render")
                BlueArchiveCharacter.stopWhaleFloat()
                BlueArchiveCharacter.COSTUME.costumes[4].HasSubGun = false
            end,

            ---防具が変更された（防具が見える/見えない）時に実行されるコールバック関数
            ---@type fun(index: integer)
            ---@param parts Armor.ArmorPart 変更された防具の部位
            armorChange = function(parts)
                if parts == "CHEST_PLATE" then
                    if Armor.ArmorVisible[2] then
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos(0, 0, 1)
                    else
                        models.models.main.Avatar.UpperBody.Body.Hairs.BackHair:setPos()
                    end
                elseif parts == "LEGGINGS" then
                    models.models.main.Avatar.UpperBody.Body.Skirt:setVisible(Costume.CurrentCostume <= 2 and not Armor.ArmorVisible[3])
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
                        FaceParts:setEmotion("NORMAL", "NORMAL", "W", duration, true)
                    elseif type == "HEART" then
                        FaceParts:setEmotion("NORMAL", "NORMAL", "YAWN", duration, true)
                    elseif type == "NOTE" then
                        FaceParts:setEmotion("CLOSED", "CLOSED", "W", duration, true)
                    elseif type == "QUESTION" then
                        FaceParts:setEmotion("CLOSED2", "CLOSED2", "YAWN", duration, true)
                    elseif type == "SWEAT" then
                        FaceParts:setEmotion("SERIOUS_ANGRY", "SERIOUS_ANGRY", "CLOSED2", duration, true)
                        models.models.main.Avatar.Head.FaceParts.Face:setUVPixels(6, 0)
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
                models.models.main.Avatar.Head.FaceParts.Face:setUVPixels()
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
        excludeModels = {},

        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
            models.models.main.Avatar.Head.FaceParts.Face:setUVPixels()
        end,

        ---モデルのコピー直後に実行される関数（省略可）
        onAfterModelCopy = function ()
            if Bubble ~= nil and Bubble.Emoji == "SWEAT" and Bubble.BubbleCounter ~= 0 then
                models.models.main.Avatar.Head.FaceParts.Face:setUVPixels(6, 0)
            end
        end
    },

    ---ポートレート
    PORTRAIT = {
        ---頭以外のモデルパーツでポートレートにアタッチしたいモデルパーツを配列形式で列挙する。
        ---@type ModelPart[]
        includeModels = {},

        ---頭のモデルパーツでポートレートから除外したいモデルパーツを配列形式で列挙する。
        ---@type ModelPart[]
        excludeModels = {models.models.main.Avatar.Head.Cowlick, models.models.main.Avatar.Head.HairEnds},

        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
            models.models.main.Avatar.Head.FaceParts.Face:setUVPixels()
        end,

        ---モデルのコピー直後に実行される関数（省略可）
        onAfterModelCopy = function ()
            if Bubble ~= nil and Bubble.Emoji == "SWEAT" and Bubble.BubbleCounter ~= 0 then
                models.models.main.Avatar.Head.FaceParts.Face:setUVPixels(6, 0)
            end
        end
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
            if costume <= 2 then
                dummyAvatar.UpperBody.Body.Skirt:setRot(25, 0, 0)
                dummyAvatar.UpperBody.Body.Shield:setPos(4.5, -2.5, 0)
                dummyAvatar.UpperBody.Body.Shield:setRot(70, 90, 0)
                dummyAvatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setRot(-55, 0, 0)
                if costume == 1 then
                    dummyAvatar.UpperBody.Body.Hairs.BackHair:setRot(-35, 0, 0)
                end
            else
                for _, modelPart in ipairs({dummyAvatar.Head.CSwimsuitH.HairTails.HairTailLeft.HairLeftBottom, dummyAvatar.Head.CSwimsuitH.HairTails.HairTailRight.HairRightBottom}) do
                    modelPart:setRot(25, 0, 0)
                end
            end
        end,

        ---ダミーアバターが縄ばしごにつかまった直後に実行される関数（省略可）
        ---@param dummyAvatar ModelPart ダミーアバターのルート
        ---@param costume integer ダミーアバターのコスチュームのインデックス
        onPhase2 = function (dummyAvatar, costume)
            if costume <= 2 then
                dummyAvatar.UpperBody.Body.Shield:setPos()
                dummyAvatar.UpperBody.Body.Shield:setRot(0, 90, 0)
                dummyAvatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setRot()
                if costume == 1 then
                    dummyAvatar.UpperBody.Body.Hairs.BackHair:setRot(-9.6599, -3.2113, -12.0868)
                end
            else
                dummyAvatar.Head.CSwimsuitH.HairTails.HairTailLeft.HairLeftBottom:setRot(-15, 0, 30)
                dummyAvatar.Head.CSwimsuitH.HairTails.HairTailRight.HairRightBottom:setRot(-15, 0, -10)
            end
        end,

        ---モデルのコピー直前に実行される関数（省略可）
        onBeforeModelCopy = function ()
            models.models.main.Avatar.Head.FaceParts.Face:setUVPixels()
            models.models.main.Avatar.LowerBody.WhaleFloat:setVisible(false)
        end

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
        vehicleOptionEnabled = true
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
                        neutral = -5,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -5,

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
                            max = -5
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
                        min = -90,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -5,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -5
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.Cowlick,

                ---x軸回転における物理演算データ（省略可）
                x = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -30,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -20,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 0,

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -40,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -30,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -30,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -20,

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
                            min = 0,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 150
                        }
                    }
                },

                ---y軸回転における物理演算データ（省略可）
                y = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = 40,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 40,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 40
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = 40,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 40,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 40
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTails.HairTailLeft.HairLeftBottom,

                ---x軸回転における物理演算データ（省略可）
                x = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -165,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10,

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
                            min = -82.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 10
                        },

                        ---頭の回転によるによるモデルパーツの回転データ（省略可）
                        headRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.05,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -82.5,

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
                            min = -165,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 7.5
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -155,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -45,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -45
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTails.HairTailLeft.HairLeftBottom.HairLeftBottomZ,

                ---z軸回転における物理演算データ（省略可）
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
                        max = 100,

                        ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        headZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -80,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 100
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
                        max = 100
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTails.HairTailRight.HairRightBottom,

                ---x軸回転における物理演算データ（省略可）
                x = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -165,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 10,

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
                            min = -82.5,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 10
                        },

                        ---頭の回転によるによるモデルパーツの回転データ（省略可）
                        headRot = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 0.05,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -82.5,

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
                            min = -165,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 7.5
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -155,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -45,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -45
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CSwimsuitH.HairTails.HairTailRight.HairRightBottom.HairRightBottomZ,

                ---z軸回転における物理演算データ（省略可）
                z = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -100,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 80,

                        ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        headZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -100,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 80
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -100,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -20,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 80
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CBattleH.HairTail,

                ---x軸回転における物理演算データ（省略可）
                x = {
                    ---体が垂直方向である時（通常時）の物理演算データ（省略可）
                    vertical = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -170,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = 0,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = 30,

                        ---スニーク時にこのモデルパーツの回転に加えられるオフセット値（省略可）
                        ---@type number
                        sneakOffset = -20,

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
                            max = 10
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
                            max = 0
                        },

                        ---体を基準とした、上下方向移動によるモデルパーツの回転データ（省略可）
                        bodyY = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = 80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -170,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 0
                        }
                    },

                    ---体が水平方向である時（水泳時、エリトラ飛行時）の物理演算データ（省略可）
                    horizontal = {
                        ---このモデルパーツ、回転軸の絶対的な回転の最小値（度）
                        ---@type number
                        min = -135,

                        ---このモデルパーツ、回転軸の中立の回転位置（度）
                        ---@type number
                        neutral = -30,

                        ---このモデルパーツ、回転軸の絶対的な回転の最大値（度）
                        ---@type number
                        max = -30,

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
                            max = -30
                        }
                    }
                }
            },

            {
                ---この物理演算データを適用させるモデルパーツ
                ---@type ModelPart | ModelPart[]
                modelPart = models.models.main.Avatar.Head.CBattleH.HairTail.HairTailZPivot,

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
                        max = 80,

                        ---頭を基準とした、左右方向移動によるモデルパーツの回転データ（省略可）
                        headZ = {
                            ---この回転事象がモデルパーツに与える回転の倍率
                            ---@type number
                            multiplayer = -80,

                            ---この回転事象がモデルパーツに与える回転の最小値
                            ---@type number
                            min = -80,

                            ---この回転事象がモデルパーツに与える回転の最大値
                            ---@type number
                            max = 80
                        }
                    }
                }
            }
        },

        ---物理演算処理後に実行されるコールバック関数（省略可）。ここでモデルパーツの向きを上書きできる。
        ---@param modelPart ModelPart 物理演算が処理されたモデルパーツ
        callback = function (modelPart)
            if modelPart == models.models.main.Avatar.Head.CBattleH.HairTail then
                local modelRot = modelPart:getRot()
                local headRotY = math.deg(math.asin(player:getLookDir().y))
                if headRotY < 0 then
                    modelRot.x = math.min(modelRot.x, 30)
                end
                modelPart:setRot(modelRot)
            end
        end
    },

    --その他定数・変数

    ---盾を手に持っているかどうか
    ---@type boolean
    HasShield = false,

    ---盾の展開状態を設定する。
    ---@param newValue boolean 新しい値
    ---@param playShieldSound boolean 盾の展開音を再生するかどうか
    setShield = function (self, newValue, playShieldSound)
        if newValue and not self.HasShield then
            models.models.main.Avatar.UpperBody.Body.Shield:setParentType("Item")
            models.models.main.Avatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setVisible(false)
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1}) do
                modelPart:setRot()
            end
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder3.GasPiston3, models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder4.GasPiston4, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder1.GasPiston1, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder2.GasPiston2}) do
                modelPart:setPos(0, -1.4, 0)
            end
            models.models.main.Avatar.UpperBody.Body.Shield.Section3.Handle2:setPos(0, 0.25, 0)
            models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.Handle:setPos(0, -0.25, 0)
            if playShieldSound then
                sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.anvil.place"), player:getPos(), 0.1, 2)
            end
        elseif not newValue and self.HasShield then
            models.models.main.Avatar.UpperBody.Body.Shield:setParentType("None")
            if ExSkill.AnimationCount == -1 then
                models.models.main.Avatar.UpperBody.Body.Shield.Section2.ShoulderBelt:setVisible(true)
            end
            models.models.main.Avatar.UpperBody.Body.Shield:setPos()
            models.models.main.Avatar.UpperBody.Body.Shield:setRot(5, 90, 0)
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1}) do
                modelPart:setRot(-180, 0, 0)
            end
            for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder3.GasPiston3, models.models.main.Avatar.UpperBody.Body.Shield.Section2.GasCylinder4.GasPiston4, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder1.GasPiston1, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.GasCylinder2.GasPiston2, models.models.main.Avatar.UpperBody.Body.Shield.Section3.Handle2, models.models.main.Avatar.UpperBody.Body.Shield.Section2.Section1.Handle}) do
                modelPart:setPos()
            end
            models.models.main.Avatar.UpperBody.Body.Shield:setSecondaryRenderType("NONE")
        end
        self.HasShield = newValue
    end,

    ---Exスキル2で衣装を変化させる時間を測るタイマー
    ---@type integer
    ExSkill_2_CostumeChangeTimer = 1000,

    ---Exスキル2の衣装変化機能をリセットする。
    resetExSkill2Feature = function ()
        for _, modelPart in ipairs({models.models.main.Avatar.UpperBody.Body.CSwimsuitB.RashGuardB, models.models.main.Avatar.UpperBody.Arms.RightArm.CSwimsuitRA, models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.CSwimsuitRAB, models.models.main.Avatar.UpperBody.Arms.LeftArm.CSwimsuitLA, models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.CSwimsuitLAB, models.models.main.Avatar.LowerBody.Legs.RightLeg.CSwimsuitRL, models.models.main.Avatar.LowerBody.Legs.LeftLeg.CSwimsuitLL}) do
            modelPart:setVisible(true)
        end
        models.models.main.Avatar.Head.CSwimsuitH.Glasses:setPos()
        events.TICK:remove("ex_skill_2_post_tick")
    end,

    ---クジラフロートのアニメーションを停止する。
    stopWhaleFloat = function ()
        events.TICK:remove("whale_float_tick")
        events.TICK:remove("whale_float_afk_end_tick")
        models.models.main.Avatar.LowerBody.WhaleFloat:setVisible(false)
        renderer:setRenderVehicle(true)
        models.models.main.Avatar.Head:setRot()
        if Gun.CurrentGunPosition == "RIGHT" then
            Arms:setArmState(1, 2)
        elseif Gun.CurrentGunPosition == "LEFT" then
            Arms:setArmState(2, 1)
        else
            Arms:setArmState(0, 0)
        end
        for _, animationModel in ipairs({"models.main", "models.ex_skill_2"}) do
            animations[animationModel]["float_ride"]:stop()
            animations[animationModel]["float_afk"]:stop()
        end
        animations["models.costume_swimsuit"]["float_afk"]:stop()
        animations["models.main"]["whale_float"]:stop()
        models.models.main.Avatar:setPos()
        if CameraManager ~= nil then
            CameraManager.setCameraPivot(vectors.vec3())
        end
        renderer:setEyeOffset()
        BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatAFKCount = 0
        BlueArchiveCharacter.COSTUME.costumes[3].IsAFK = false
        BlueArchiveCharacter.COSTUME.costumes[3].WhaleFloatEnabledPrev = false
    end
}

--生徒固有初期化処理
events.ENTITY_INIT:register(function ()
    events.TICK:register(function()
        BlueArchiveCharacter:setShield((player:getHeldItem().id == "minecraft:shield" or player:getHeldItem(true).id == "minecraft:shield") and ExSkill.AnimationCount == -1, true)
        if Costume.CurrentCostume == 3 and not BlueArchiveCharacter.HasShield then
            models.models.main.Avatar.UpperBody.Body.Shield:setVisible(false)
        end
    end)

    events.ITEM_RENDER:register(function (item, mode)
        if item.id == "minecraft:shield" and mode ~= "HEAD" and BlueArchiveCharacter.HasShield and (Gun.ShowWeaponInFirstPerson or mode == "THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND") then
            if mode == "FIRST_PERSON_LEFT_HAND" then
                local leftHanded = player:isLeftHanded()
                if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                    models.models.main.Avatar.UpperBody.Body.Shield:setPos(8, -20.25, 2.5)
                    models.models.main.Avatar.UpperBody.Body.Shield:setRot(0, 0, -5)
                else
                    models.models.main.Avatar.UpperBody.Body.Shield:setPos(6, -22.5, 2.5)
                    models.models.main.Avatar.UpperBody.Body.Shield:setRot(0, 0, 5)
                end
            elseif mode == "FIRST_PERSON_RIGHT_HAND" then
                local leftHanded = player:isLeftHanded()
                if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                    models.models.main.Avatar.UpperBody.Body.Shield:setPos(0, -19.25, 2.5)
                    models.models.main.Avatar.UpperBody.Body.Shield:setRot(0, 0, 5)
                else
                    models.models.main.Avatar.UpperBody.Body.Shield:setPos(2, -22.5, 2.5)
                    models.models.main.Avatar.UpperBody.Body.Shield:setRot(0, 0, -5)
                end
            elseif mode == "THIRD_PERSON_LEFT_HAND" then
                if Arms.ArmState.left == 4 then
                    if player:isCrouching() then
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(3.5, -19.5, 0)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(80, 5, 30)
                    else
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(2, -20.5, -1)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(55, 20, 25)
                    end
                else
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "OFF_HAND" and not leftHanded) or (player:getActiveHand() == "MAIN_HAND" and leftHanded)) then
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(2, -20.5, -2)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(50, 30, 30)
                    else
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(2, -20.5, 2.5)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(5, 90, 0)
                    end
                end
            elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                if Arms.ArmState.right == 4 then
                    if player:isCrouching() then
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(4.5, -19.5, 0)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(80, -5, -30)
                    else
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(6, -20.5, -1)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(55, -20, -25)
                    end
                else
                    local leftHanded = player:isLeftHanded()
                    if player:getActiveItemTime() > 0 and ((player:getActiveHand() == "MAIN_HAND" and not leftHanded) or (player:getActiveHand() == "OFF_HAND" and leftHanded)) then
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(6, -20.5, -2)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(50, -30, -30)
                    else
                        models.models.main.Avatar.UpperBody.Body.Shield:setPos(6, -20.5, 2.5)
                        models.models.main.Avatar.UpperBody.Body.Shield:setRot(5, -90, 0)
                    end
                end
            end
            models.models.main.Avatar.UpperBody.Body.Shield:setSecondaryRenderType(item:hasGlint() and "GLINT" or "NONE")
            models.models.main.Avatar.UpperBody.Body.Shield:setVisible(true)
            return models.models.main.Avatar.UpperBody.Body.Shield
        end
    end)

    events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
        if path ~= nil then
            if id == "minecraft:item.shield.block" and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 0.2 and player:getActiveItem().id == "minecraft:shield" then
                sounds:playSound(CompatibilityUtils:checkSound("minecraft:block.anvil.place"), pos, 1, 4)
                ---@diagnostic disable-next-line: redundant-return-value
                return true
            end
        end
    end)

    for _, modelPart in ipairs({models.models.ex_skill_2.Waves.Surface, models.models.ex_skill_2.Waves.Wave1}) do
        modelPart:setPrimaryTexture("RESOURCE", "textures/block/water_still.png")
    end
    models.models.ex_skill_2.Waves.Wave2:setPrimaryTexture("RESOURCE", "textures/block/water_flow.png")
end)

return BlueArchiveCharacter