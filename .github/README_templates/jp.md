<!-- $inject(locale_link) -->

# FiguraBlueArchiveCharacters
スマートフォンゲーム「[ブルーアーカイブ](https://bluearchive.jp/)」に登場するキャラクターを再現した、[Minecraft](https://www.minecraft.net/ja-jp) Java EditionのスキンMod「[Figura](https://modrinth.com/mod/figura)」で使用できるアバターデータです。

ターゲットFiguraバージョン：[0.1.4](https://modrinth.com/mod/figura/version/0.1.4+1.20.1)

（Minecraft 1.20.4では[Figuraの不具合](https://github.com/FiguraMC/Figura/issues/197)により一部機能が正しく動作しません。Minecraft 1.20.1での利用をお勧めします。）

![サムネイル](../README_images/thumbnail.png)

このブランチは**才羽 モモイ**のブランチです。

## 作成状況
### 作成済み
これらのキャラクターのアバターは完成しました。キャラクターの名前をクリックするとそのキャラクターのブランチに移動できます。

- [河和 シズコ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Shizuko)
- [久田 イズナ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Izuna)
- [伊落 マリー](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Marie)
- [才羽 モモイ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Momoi)
- [才羽 ミドリ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Midori)
- [砂狼 シロコ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Shiroko)
- [小鳥遊 ホシノ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Hoshino)（※1）

※1: 現在、水着衣装は実装されていません。後程実装します。しばらくお待ちください。

### 作成中
これらのキャラクターのアバターは作成中です。通常2~3週間程要します。括弧内のリンクをクリックすると対象のissueに移動でき、そこで進捗を確認できます。

（現在作成中のアバターはありません。）

### 作成予定
これらのキャラクターのアバターは作成していないものの、今後作成する予定です。上から順に作成予定です。これはあくまでも予定であり、順番が変更されたり作成を中止したりする可能性があります。

- 黒見 セリカ（[#37](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/37)）
- 鷲見 セリナ（[#38](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/38)）
- 阿慈谷 ヒフミ（[#39](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/39)）

## 特徴
- Exスキルのカットインを再現しています。

  ![Exスキル](../README_images/ex_skill.jpg)

- 「場に何かを残す」タイプのスキルの場合、Exスキルアニメーション後にオブジェクトが残り続けます。
  - ゲームには一切影響を与えません。
  - オブジェクトとブロックの当たり判定が重なった時に、そのオブジェクトは消えます。
  - Exスキルのアクションを右クリックでもオブジェクトを消せます。

  ![設置物](../README_images/placement_object.jpg)

- 弓やクロスボウの代わりに生徒固有の武器を構えます。矢の代わりに銃弾が発射されます。
  - 変化するのは見た目だけであり、実際はただ矢を撃っているだけなのでご注意下さい。

  ![銃](../README_images/gun.jpg)

- カーソルキー（↑→↓←）で吹き出しを表示できます。
  - クロスボウに装填中は自動で装填の吹き出しが表示されます。

  ![吹き出し1](../README_images/bubble_good.jpg)

  ![吹き出し2](../README_images/bubble_reload.jpg)

- 衝撃吸収のハート（黄色のハート）を持っている場合は、バリアが付きます。

  ![バリア](../README_images/barrier.jpg)

- プレイヤーが死ぬとヘリコプターで回収されます。
  - MinecraftやFiguraの仕様上、プレイヤーが表示されていないとこのアニメーションが表示されません。

  ![ヘリコプターで回収](../README_images/death_animation.jpg)

- 生徒に衣装違いがあれば、衣装変更が可能であり、衣装によって再生されるExスキルも異なります。

  ![衣装](../README_images/costume.jpg)

- プレイヤーの名前を生徒の名前にすることができます。
  - 部活名を表示することもできます。
  - 他のプレイヤーがこの名前を見えるようにするには、**他のプレイヤーもFiguraを導入し、他のプレイヤー側であなたに対する信頼設定を十分上げる必要があります。**

  ![プレイヤーの名前](../README_images/display_name.jpg)

- 生徒の誕生日には（ささやかながら）名前にケーキマークが付きます。
  - 表示名がプレイヤー名である場合は表示されません。

  ![誕生日](../README_images/birth_day.svg)

## Exスキル
本家でお馴染みのExスキルのカットインが再現されています。Exスキルを再生するには、**三人称視点で**Exスキルのキー（デフォルトは「V」キー）を押してください。

![Exスキル](../README_images/ex_skill.jpg)

Exスキルのカットインは見た目だけであり、効果は特にありません。ただし、Exスキルによってはカットインの後にオブジェクトをその場に残すものもあります（こちらも見た目だけです）。

> [!NOTE]
> - Exスキルアニメーションは画面比率が16:9の場合を想定して作られています。16:9以外の画面比率でもExスキルアニメーションは再生できますが、見切れる可能性があります。
> - Exスキルアニメーションは視野（FOV）が標準（70）である場合を想定して作られています。標準以外の場合でExスキルアニメーションを再生すると一時的に視野が標準になるよう補正されます。ただし、一部のmodの同時使用や移動速度の変化による視野の変化の場合は正常な補正がされません。

## アクションホイール
Figuraには、アクションホイールキー（デフォルトは「B」キー）を押すことで、エモートなどを実行できるリングメニューが実装されています。このレポジトリのアバターには共通したアクションが用意されています。

> [!IMPORTANT]
> Exスキルのアクションはキー押下で再生されるように変更されました。

![アクションホイール](../README_images/action_wheel.jpg)

### アクション1. 衣装変更
衣装違いがあれば衣装を変更できます。スクロールで衣装を変更し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。

![衣装](../README_images/costume.jpg)

### アクション2. 名前変更
プレイヤーの表示名を変更します。スクロールで表示名を選択し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。ただし、他のプレイヤーが変更された名前を見るには、**そのプレイヤーもFiguraを導入し、他のプレイヤー側であなたに対する信頼設定を十分上げる必要があります。**

![プレイヤーの名前](../README_images/display_name_2.jpg)

### アクション3. 防具の表示の切り替え
防具を表示するかどうかを設定できます。ただし、折角のアバターが隠れてしまうので、防具を非表示にすることをお勧めします。

### アクション4. Exスキルアニメーション中のカメラワークの精度の変更
Exスキルアニメーション中に使用されるカメラの当たり判定の検出の精度を変更します。精度を高くするとカメラのがたつきが軽減される一方で処理の負荷が増加します。スクロールで精度を変更し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。

<!-- $inject(how_to_use) -->

#### 追記事項
ここに書かれてあるアバターのダウンロード方法の他に、レポジトリのトップページの右側にある「Releases」からでもアバターファイルをダウンロードできるようにしました。各リリースノートの「Assets」の項目に各アバターのzipファイルが添付されています。

<!-- $inject(notes) -->

---

![IDカード](../README_images/id_card.jpg)