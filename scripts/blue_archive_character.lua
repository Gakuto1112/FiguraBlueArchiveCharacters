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
            en_us = "FisrtName",

            ---日本語
            ---@type string
            ja_jp = "名前"
        },

        ---生徒の苗字
        lastName = {
            ---英語
            ---@type string
            en_us = "LastName",

            ---日本語
            ---@type string
            ja_jp = "苗字"
        },

        ---生徒所属の部活名
        clubName = {
            ---英語
            ---@type string
            en_us = "ClubName",

            ---日本語
            ---@type string
            ja_jp = "部活名",
        },

        ---生徒の誕生日
        birth = {
            ---誕生月
            ---@type integer
            month = 1,

            ---誕生日
            ---@type integer
            day = 1
        }
    },

    ---頭の輪っか
    HEAD_RING = {
        ---基準角度
        ---@type number
        neutralRot = 0
    },

    ---目や口
    ---パーツ名を鍵として、インデックス1に、デフォルトパーツから見て右にx番目、インデックス2に、デフォルトパーツから見て下にy番目を入力する。
    ---右目と左目については"NORMAL", "CLOSED", "SURPLISED"が必須となる。
    FACE_PARTS = {
        ---右目
        RightEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            CLOSED = {2, 0}
        },

        ---左目
        LeftEye = {
            NORMAL = {0, 0},
            SURPLISED = {1, 0},
            CLOSED = {2, 0}
        },

        ---口
        Mouth = {
            CLOSED = {0, 0}
        }
    },

    ---銃
    GUN = {
        ---銃の大きさの倍率（省略可）
        ---@type number
        scale = 1.2,

        ---構えている時
        hold = {
            ---構え方
            ---@type BlueArchiveCharacter.GunHoldType
            type = "NORMAL",

            ---位置オフセット（省略可）
            pos = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(-1.5, 10, 7),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(-4.5, 10, 7)
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
                right = vectors.vec3(1.5, 6, 8),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(-7.5, 6, 8)
            },

            ---向きオフセット（省略可）
            rot = {
                ---右手で構える場合（省略可）
                ---@type Vector3
                right = vectors.vec3(90, 180, -90),

                ---左手で構える場合（省略可）
                ---@type Vector3
                left = vectors.vec3(90, 180, -90)
            }
        },

        ---射撃音
        sound = {
            ---使用するゲームの音源名
            ---@type Minecraft.soundID
            name = "minecraft:entity.iron_golem.hurt",

            ---音源のピッチ（0.5 ~ 2）
            ---@type number
            pitch = 2
        }
    },

    ---設置物
    PLACEMENT_OBJECT = {
        ---設置物スクリプトを使用するかどうか
        ---falseにするとスクリプトを読み込まないため、この場合PlacementObject関数を呼び出さないように注意すること。
        ---@type boolean
        use = true,

        ---設置物として扱うモデル
        ---このテーブルのインデックス番号がPlacementObject:place()で指定するobjectIndexになる。
        ---@type ModelPart[]
        objects = {models.models.placement_object.PlacementObject},

        ---設置物の当たり判定
        ---2つ目のテーブルは、上記"objects"のモデルと対応する当たり判定データのインデックス番号を一致させること。
        hitBoxes = {
            {
                ---当たり判定（ヒットボックス）データ
                ---直方体（立方体）のxyz座標がそれぞれ最小の頂点を指定し、そこからのxyz軸での長さを指定する。BlockBench上の数値をそのまま入力する。なお、設置物のヒットボックスは複数定義可能。
                ---@type Vector3[]
                {vectors.vec3(-4, 0, -4), vectors.vec3(8, 8, 8)}
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
			models = {},

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
                    pos = vectors.vec3(0, 28, -64),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 180)
                },

                ---Exスキルアニメーション終了時
                fin = {
                    ---カメラの位置
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    pos = vectors.vec3(0, 28, -64),

                    ---カメラの向き
                    ---BBアニメーション上での値をそのまま入力する。
                    ---@type Vector3
                    rot = vectors.vec3(0, 180)
                }
            },

            ---コールバック関数
            callbacks = {
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
    },

    --その他定数・変数
}

if BlueArchiveCharacter.PLACEMENT_OBJECT.use then
    for _, hitBoxPair in ipairs(BlueArchiveCharacter.PLACEMENT_OBJECT.hitBoxes) do
        for _, hitBox in ipairs(hitBoxPair) do
            for _ , chunk in ipairs(hitBox) do
                chunk:scale(1 / 16)
            end
        end
    end
end

for _, exSkill in ipairs(BlueArchiveCharacter.EX_SKILL) do
	exSkill.camera.start.pos:mul(-1, 1, 1):scale(1 / 16)
	exSkill.camera.fin.pos:mul(-1, 1, 1):scale(1 / 16)
end

--生徒固有初期化処理

return BlueArchiveCharacter