言語: 　[English](./README.md)　|　**日本語**

# FiguraBlueArchiveCharacters
スマートフォンゲーム「[ブルーアーカイブ](https://bluearchive.jp/)」に登場するキャラクターを再現した、MinecraftのスキンMod「[Figura](https://modrinth.com/mod/figura)」で使用できるアバターデータです。

ターゲットFiguraバージョン：[0.1.2](https://modrinth.com/mod/figura/version/0.1.2+1.20.1)

![サムネイル](./README_images/thumbnail.jpg)

**このブランチ（base）は新たなキャラクターを作成しやすくする目的で作られた汎用アバターとなっています。下の「[作成状況](#作成状況)」から特定のキャラクターのブランチに移動して下さい。**

## 作成状況
### 作成済み
これらのキャラクターのアバターは完成しました。キャラクターの名前をクリックするとそのキャラクターのブランチに移動できます。

- [河和 シズコ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Shizuko)
- [久田 イズナ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Izuna)
- [伊落 マリー](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Marie)
- [才羽 モモイ](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Momoi)

### 作成中
これらのキャラクターのアバターは作成中です。通常2~3週間程要します。括弧内のリンクをクリックすると対象のissueに移動でき、そこで進捗を確認できます。

- 才羽 ミドリ（[#14](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/14)）

### 作成予定
これらのキャラクターのアバターは作成していないものの、今後作成する予定です。これはあくまでも予定であり、変更される可能性があります（私が飽きたら終了です）。

- 砂狼 シロコ（[#16](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/16)）
- 小鳥遊 ホシノ（[#17](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/17)）

## 特徴
- Exスキルのカットインを再現しています。

  ![Exスキル](./README_images/ex_skill.jpg)

- 「場に何かを残す」タイプのスキルの場合、Exスキルアニメーション後にオブジェクトが残り続けます。
  - ゲームには一切影響を与えません。
  - オブジェクトとブロックの当たり判定が重なった時に、そのオブジェクトは消えます。
  - Exスキルのアクションを右クリックでもオブジェクトを消せます。

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

## アクションホイール
Figuraには、アクションホイールキー（デフォルトは「B」キー）を押すことで、エモートなどを実行できるリングメニューが実装されています。このレポジトリのアバターには共通したアクションが用意されています。

![アクションホイール](./README_images/action_wheel.jpg)

### アクション1. Exスキル
Exスキルアニメーションを再生します。三人称視点でのみ再生できます。

![Exスキル](./README_images/ex_skill.jpg)

### アクション2. 衣装変更
衣装違いがあれば衣装を変更できます。スクロールで衣装を変更し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。

![衣装](./README_images/costume.jpg)

### アクション3. 名前変更
プレイヤーの表示名を変更します。スクロールで表示名を選択し、アクションホイールを閉じると確定します。選択中に左クリックをすると現在の設定値に、右クリックすると初期値にリセットされます。ただし、他のプレイヤーが変更された名前を見るには、**そのプレイヤーもFiguraを導入し、他のプレイヤー側であなたに対する信頼設定を十分上げる必要があります。**

![プレイヤーの名前](./README_images/display_name_2.jpg)

### アクション4. 防具の表示の切り替え
防具を表示するかどうかを設定できます。ただし、折角のアバターが隠れてしまうので、防具を非表示にすることをお勧めします。

## 使用方法
Figuraは[Forge](https://files.minecraftforge.net/net/minecraftforge/forge/)、[Fabric](https://fabricmc.net/)、[Quilt](https://quiltmc.org/)に対応しています。

1. 使用したいModローダーをインストールし、Modを使用できる状態にします。
2. [Figura](https://modrinth.com/mod/figura)を追加します。Modの依存関係にご注意ください。
3. 使用したいキャラクターのダウンロードページに移動します。
4. ページ上部の緑色のボタン「**Code**」から「**Download ZIP**」からこのレポジトリのファイルをダウンロードします。（または、このレポジトリをクローンします。）
5. 圧縮ファイルの場合は展開します。
6. `<マインクラフトのゲームフォルダ>/figura/avatars/`にアバターのデータを配置します。
   - Figuraを導入した状態で一度ゲームを起動すると自動的に作成されます。存在しない場合は手動での作成も可能です。
7. ゲームメニューからFiguraメニュー（Δマーク）を開きます。
8. 画面左のアバターリストからアバターを選択します。
9. 必要に応じて権限設定をして下さい。
10. アバターをサーバーにアップロードすると、他のFiguraプレイヤーもあなたのアバターを見ることができます。

## 注意事項
- このアバターを使用して発生した、いかなる損害の責任も負いかねます。
- このアバターは、デフォルトのリソースパックでの動作を想定しています。また、他MODの使用は想定していません。想定動作環境外ではテクスチャの不整合、防具が表示されない/非表示にならない、といった不具合が想定されます。この場合の不具合は対応しませんのでご了承下さい。
- 私（[Gakuto1112](https://github.com/Gakuto1112)）のマルチプレイで動作検証を行う環境が不十分である為、マルチプレイにおいて発生する不具合がある可能性があります。
- 不具合がありましたら、[Issues](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues)までご連絡下さい。
- アバター関係で私に連絡したい方は[Discussions](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/discussions)または、[Discord](https://discord.com/)でご連絡下さい。私のDiscordのアカウント名は「vinny_san」で表示名は「ばにーさん」です。[FiguraのDiscordサーバー](https://discord.gg/figuramc)での表示名は「BunnySan/ばにーさん」です。

## アバター作成に必要なもの
画面直撮りはやめて下さい。

- キャラクターイラスト（スクリーンショット等）
  - 見えない部分は想像で補います。
  - 衣装違いなどもあれば一緒に用意して下さい。
- Exスキルのカットイン（画面録画）
  - 倍速は無効にして下さい。
  - スキル使用後の様子も収めて下さい。
  - 戦闘の最初から最後までが収めてあるとアバター作成時に役立つ可能性があります。
  - 衣装違いがあればその分も収めてください。
- 生徒の基本情報（名前、誕生日など）
  - 生徒情報画面の下側にボタンがあります。
- Exスキルの名前（スキル強化の画面）
- 固有武器（固有武器強化の画面）
  - 生徒を★5にしなくてもこの画面は見れます。
- 生徒の初期レアリティ（★1、★2、★3）
  - アバターのサムネイル画像の決定に使います。
- やる気
  - 「作ってやる！」という意欲

---

![IDカード](./README_images/id_card.jpg)
