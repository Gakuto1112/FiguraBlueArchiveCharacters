言語: 　[English](./README.md)　|　**日本語**

# FiguraBlueArchiveCharacters
<!-- DESCRIPTION_START -->
スマートフォンゲーム「[ブルーアーカイブ](https://bluearchive.jp/)」に登場するキャラクターを再現した、[Minecraft](https://www.minecraft.net/ja-jp) Java EditionのスキンMod「[Figura](https://modrinth.com/mod/figura)」で使用できるアバターデータです。

ターゲットFiguraバージョン：[0.1.4](https://modrinth.com/mod/figura/version/0.1.4+1.20.1)

（Minecraft 1.20.4では[Figuraの不具合](https://github.com/FiguraMC/Figura/issues/197)により一部機能が正しく動作しません。Minecraft 1.20.1での利用をお勧めします。）
<!-- DESCRIPTION_END -->

![サムネイル](./README_images/thumbnail.jpg)

（上記画像をクリックすると紹介映像が見れます。）

## 作成状況
### 作成済み
これらのキャラクターのアバターは完成しました。「[使用方法](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/base/.github/README_jp.md#使用方法)」の章に従ってダウンロード及びゲーム内での使用が可能です。

- 河和シズコ
- 久田イズナ
- 伊落マリー
- 才羽モモイ
- 才羽ミドリ
- 砂狼シロコ
- 小鳥遊ホシノ
- 里浜ウミカ

### 作成中
これらのキャラクターのアバターは作成中です。 通常は2~3週間程を製作に要しますが、最近は多忙により更新が遅れています。括弧内のリンクをクリックすると対象のissueに移動でき、そこで進捗を確認できます。

（現在作成中のアバターはありません。）

### 作成予定
これらのキャラクターのアバターは作成していないものの、今後作成する予定です。上から順に作成予定です。これはあくまでも予定であり、順番が変更されたり作成を中止したりする可能性があります。

- 小鳥遊ホシノ（臨戦）（[#62](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/62)）
- 棗イロハ（[#64](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/64)）
- 丹花イブキ（[#65](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/65)）
- 黒見セリカ（[#37](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/37)）
- 鷲見セリナ（[#38](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/38)）
- 阿慈谷ヒフミ（[#39](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/39)）

## 特徴
- Exスキルのカットインを再現しています。

  ![Exスキル](./README_images/ex_skill.jpg)

- 「場に何かを残す」タイプのスキルの場合、Exスキルアニメーション後にオブジェクトが残り続けます。
  - ゲームには一切影響を与えません。
  - オブジェクトとブロックの当たり判定が重なった時に、そのオブジェクトは消えます。
  - Exスキルの再生キー（デフォルト：V）を長押しすると設置物を全削除できます。

  ![設置物](./README_images/placement_object.jpg)

- 弓やクロスボウの代わりに生徒固有の武器を構えます。矢の代わりに銃弾が発射されます。
  - 変化するのは見た目だけであり、実際はただ矢を撃っているだけなのでご注意下さい。

  ![銃](./README_images/gun.jpg)

- カーソルキー（↑→↓←）で吹き出しを表示できます。
  - クロスボウに装填中は自動で装填の吹き出しが表示されます。

  ![吹き出し1](./README_images/bubble_good.jpg)

  ![吹き出し2](./README_images/bubble_reload.jpg)

- 衝撃吸収のハート（黄色のハート）を持っている場合は、バリアが付きます。

  ![バリア](./README_images/barrier.jpg)

- プレイヤーが死ぬとヘリコプターで回収されます。
  - MinecraftやFiguraの仕様上、プレイヤーが表示されていないとこのアニメーションが表示されません。

  ![ヘリコプターで回収](./README_images/death_animation.jpg)

- 生徒に衣装違いがあれば、衣装変更が可能であり、衣装によって再生されるExスキルも異なります。

  ![衣装](./README_images/costume.jpg)

- プレイヤーの名前を生徒の名前にすることができます。
  - 部活名を表示することもできます。
  - 他のプレイヤーがこの名前を見えるようにするには、**他のプレイヤーもFiguraを導入し、他のプレイヤー側であなたに対する信頼設定を十分上げる必要があります。**

  ![プレイヤーの名前](./README_images/display_name.jpg)

- 生徒の誕生日には（ささやかながら）名前にケーキマークが付きます。
  - 表示名がプレイヤー名である場合は表示されません。

  ![誕生日](./README_images/birth_day.svg)

## Exスキル
本家でお馴染みのExスキルのカットインが再現されています。Exスキルを再生するには、**三人称視点で**Exスキルのキー（デフォルトは「V」キー）を押してください。

![Exスキル](./README_images/ex_skill.jpg)

Exスキルのカットインは見た目だけであり、効果は特にありません。ただし、Exスキルによってはカットインの後にオブジェクトをその場に残すものもあります（こちらも見た目だけです）。

> [!NOTE]
> - Exスキルアニメーションは画面比率が16:9の場合を想定して作られています。16:9以外の画面比率でもExスキルアニメーションは再生できますが、見切れる可能性があります。
> - Exスキルアニメーションは視野（FOV）が標準（70）である場合を想定して作られています。標準以外の場合でExスキルアニメーションを再生すると一時的に視野が標準になるよう補正されます。ただし、一部のmodの同時使用や移動速度の変化による視野の変化の場合は正常な補正がされません。

## アクションホイール
Figuraには、アクションホイールキー（デフォルトは「B」キー）を押すことで、エモートなどを実行できるリングメニューが実装されています。このレポジトリのアバターには共通したアクションが用意されています。

> [!IMPORTANT]
> Exスキルのアクションはキー押下で再生されるように変更されました。

![アクションホイール](./README_images/action_wheel.jpg)

### アクション1. 衣装変更
衣装違いがあれば衣装を変更できます。スクロールで衣装を変更し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。

![衣装](./README_images/costume.jpg)

### アクション2. 名前変更
プレイヤーの表示名を変更します。スクロールで表示名を選択し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。ただし、他のプレイヤーが変更された名前を見るには、**そのプレイヤーもFiguraを導入し、他のプレイヤー側であなたに対する信頼設定を十分上げる必要があります。**

![プレイヤーの名前](./README_images/display_name_2.jpg)

### アクション3. 防具の表示の切り替え
防具を表示するかどうかを設定できます。ただし、折角のアバターが隠れてしまうので、防具を非表示にすることをお勧めします。

### アクション4. 一人称視点での武器モデルの表示の切り替え
一人称視点において、武器のモデル（銃など）を表示するかどうかを設定できます。オフにした場合、代わりにバニラのアイテムが表示されます。この設定に関わらず、三人称視点では常に武器モデルが表示されます。

![一人称視点での武器モデル](./README_images/first_person_weapons.jpg)

### アクション5. Exスキルフレームのパーティクル量の変更
Exスキルアニメーション中に表示される赤や青の枠から出現する三角形のパーティクルの量を調整できます。パーティクルを減らしたり無効にしたりすることで、パフォーマンスが改善されるかもしれません。

追加のオプションとして、Exスキルアニメーション中のフレーム表示をなくすオプションを追加しました。この状態が本家に一番近い状態です。

## 使用方法
Figuraは[Forge](https://files.minecraftforge.net/net/minecraftforge/forge/)、[Fabric](https://fabricmc.net/)、[NeoForge](https://neoforged.net/)に対応しています。

1. 使用したいModローダーをインストールし、Modを使用できる状態にします。
2. [Figura](https://modrinth.com/mod/figura)を追加します。Modの依存関係にご注意ください。
3. [リリースページ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/releases)に移動します。
   - [レポジトリのトップページ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters)の右側からも移動できます。
4. リリースノート内の「Assets」の項目にアバターのzipファイルが添付されているので、お好みのアバターをダウンロードします。
5. 圧縮ファイルを展開し、中にあるアバターデータを取り出します。
6. `<マインクラフトのゲームフォルダ>/figura/avatars/`にアバターのデータを配置します。
   - Figuraを導入した状態で一度ゲームを起動すると自動的に作成されます。存在しない場合は手動での作成も可能です。
7. ゲームメニューからFiguraメニュー（Δマーク）を開きます。
8. 画面左のアバターリストからアバターを選択します。
9. 必要に応じて権限設定をして下さい。
10. アバターをサーバーにアップロードすると、他のFiguraプレイヤーもあなたのアバターを見ることができます。
    - **海賊版（割れ、非正規版、無料版）のマインクラフトでは、アバターをアップロードすることはできません。**
    これはFiguraの仕様であり、これに関しては対応できません。

## 注意事項
- このアバターを使用して発生した、いかなる損害の責任も負いかねます。
- このアバターは、デフォルトのリソースパックでの動作を想定しています。また、他MODの使用は想定していません。想定動作環境外ではテクスチャの不整合、防具が表示されない/非表示にならない、といった不具合が想定されます。この場合の不具合は対応しない場合がありますのでご了承下さい。
- 私（[Gakuto1112](https://github.com/Gakuto1112)）のマルチプレイで動作検証を行う環境が不十分である為、マルチプレイにおいて発生する不具合がある可能性があります。
- 不具合がありましたら、[Issues](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues)までご連絡下さい。
- アバター関係で私に連絡したい方は[Discussions](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/discussions)または、[Discord](https://discord.com/)でご連絡下さい。私のDiscordのアカウント名は「vinny_san」で表示名は「ばにーさん」です。[FiguraのDiscordサーバー](https://discord.gg/figuramc)での表示名は「BunnySan/ばにーさん」です。

## 既知の不具合
- 利き手変更時に武器が正しく描画されない（[#24](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/24)）。
  - 武器を持ち直すと解消されます。
- [Iris Shaders](https://www.irisshaders.dev/)を用いて影Modを有効化した際に、ゲーム起動後の1回のみに限り、ヘイロー（頭の輪っか）や武器を構える腕が描画されないことがある（[#63](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/63)）。
  - アバターを再読み込みすると解消されます。

---

![IDカード](./README_images/id_card.jpg)
