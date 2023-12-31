Language: 　**English**　|　[日本語](./README_jp.md)

# FiguraBlueArchiveCharacters
This is the avatars for [Figura](https://modrinth.com/mod/figura), the skin mod for [Minecraft](https://www.minecraft.net/en-us), which are imitated characters who appear in "[Blue Archive](https://bluearchive.jp/)" the game for mobile devices.

Target figura version: [0.1.2](https://modrinth.com/mod/figura/version/0.1.2+1.20.1)

![Thumbnail](./README_images/thumbnail.jpg)

**This branch (base) is a generic avatar created to make a new character easily. Please move to a specific character branch from "[Creation status](#creation-status)" section below.**

## Creation status
### Done
The avatars for these characters are completed. Click on a character's name to go to the character's branch.

- [Shizuko Kawawa](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Shizuko)
- [Izuna Kuda](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Izuna)
- [Marie Iochi](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Marie)
- [Momoi Saiba](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/tree/Momoi)

### In progress
The avatars for these characters are worked in progress. It usually takes about 2~3 weeks. Click on the link in brackets to go to the issue about the character, where you can check the progress.

- Midori Saiba ([#14](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/14))

### Planned
Although the avatars for these characters are not created, there are plans to create them in the future. This is just a plan and is subject to change (I will close this project without creating them if I get bored to create them).

- Shiroko Sunaokami ([#16](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/16))
- Hoshino Takanashi ([#17](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/17))

## Features
- Imitated ex skill cut-ins.

  ![Ex skill](./README_images/ex_skill.jpg)

- An object remains after the ex skill if the ex skill type is "leaving something in a place".
  - The object doesn't affect the game at all.
  - The object will be remove when the hit boxes of a block and it are overlapped.
  - You can also remove the object by right-clicking the action of the ex skill.

  ![Placement object](./README_images/placement_object.jpg)

- Press cursor keys (↑→↓←) to show speech bubbles.
  - The "reload" speech bubble will appear automatically while loading a crossbow.

  ![Speech bubble 1](./README_images/bubble_good.jpg)

  ![Speech bubble 2](./README_images/bubble_reload.jpg)

- Holds the character's specific weapon instead of bows and crossbows. Shoots bullets instead of arrows.
  - Note that these changes are only in appearance. You are just shooting arrows in actual.

  ![Gun](./README_images/gun.jpg)

- A barrier will applied when the player has absorption hearts (yellow hearts).

  ![Barrier](./README_images/barrier.jpg)

- Will be rescued by the helicopter when the player dies.
  - This animation won't visible if the player isn't visible because of Minecraft and Figura specifications.

  ![Rescued by helicopter](./README_images/death_animation.jpg)

- Can change costume if the character has multiple costumes.

  ![Costume](./README_images/costume.jpg)

- Can change your display name to the character's name.
  - Can also display the club name which the character is participated in.
  - **Other players also need to install Figura and give enough permissions** to see your display name.

  ![Display name](./README_images/display_name.jpg)

- A cake emoji will be added during the student's birthday.
  - It won't be displayed if the display name is the player name.

  ![Birth day](./README_images/birth_day.svg)

## The action wheel
Figura provides the action wheel with which players can play some actions (emotes, animations, configs, and etc.). It will be shown when holding the action wheel key (default is B key). This avatar also has some actions.

![Action wheel](./README_images/action_wheel.jpg)

### Action 1. Ex skill
Plays the ex skill animation. Only in the third person view.

![Ex skill](./README_images/ex_skill.jpg)

### Action 2. Change costume
Changes costume if the character has multiple costumes. Scroll to select the costume and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection.

![Costume](./README_images/costume.jpg)

### Action 3. Change display name
Changes the player's display name. Scroll to select the name and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection. However, **Other players also need to install Figura and give enough permissions** to see your display name.

![Display name](./README_images/display_name_2.jpg)

### Action 4. Toggle armors visible
Toggles whether equipped armors are visible or not. Some costumes will be hidden not to interfere with the armors while equips them. This setting will only affects to vanilla armors.

I recommend to hide armors because they hide the avatar.

## How to use
Figura is available in [Forge](https://files.minecraftforge.net/net/minecraftforge/forge/), [Fabric](https://fabricmc.net/), and [Quilt](https://quiltmc.org/).

1. Install the mod loader which you want to use and make the mods available.
2. Install [Figura](https://modrinth.com/mod/figura). Note the mod dependencies.
3. Go to the download page for the character which you want to download.
4. Click green "**<>Code**" button at the top of the page and "**Download ZIP**" to download the repository files (or clone this repository).
5. Extract the file if it is a zipped file.
6. Put avatar files at `<minecraft_instance_directory>/figura/avatars/`.
   - The directory will automatically generated after launching the game with Figura installed. You can also create it manually if it doesn't exist.
7. Open the Figura menu (Δ mark) from the game menu.
8. Select the avatar from the avatar list at the left of the Figura menu.
9. Sets your permission if you need.
10. Other Figura players can see your avatar after uploading your avatar to the Figura server.

## Notes
- I'm not responsible for any damages caused by using this avatar.
- This avatar is designed for work with no resource pack and no other mods are installed. An unexpected issue may occurs when you use it with any resource packs and mods (texture and armor inconsistencies, etc.). However, I won't support in these cases.
- There may be a bug which occurs in multiplayer because my ([Gakuto1112](https://github.com/Gakuto1112)) multiplayer environment to verify the avatar is insufficient.
- Please [report an issue](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues) if you find it.
- Please contact me via [Discussions](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/discussions) or [Discord](https://discord.com/) if you want to do for my avatars. My Discord name is "vinny_san" and display name is "ばにーさん". My display name in [Figura Discord server](https://discord.gg/figuramc) is "BunnySan/ばにーさん".

## Things needed to create a new character
Please used screenshots (not direct shots of the screen).

- Character illustrations (screenshots, etc.)
  - The parts which aren't appear in them will be made up by my imagination.
  - Include costume-difference illustrations if the character has multiple costumes.
- Ex skill cut-ins (screen recordings)
  - Disable fast forward.
  - Include the scene after the ex skills.
  - It may be helpful when creating avatars if they include the whole battle.
  - Include costume-difference cut-ins if the character has multiple costumes.
- Basic information of the character (name, birthday, etc.)
  - There is a button to show them at the bottom of the student information screen.
- The name of the ex skills (skill upgrades screen)
- The characters's specific weapon (weapon upgrades screen)
  - You can see this screen even if the characters is not ★5.
- The character's initial rarity (★1, ★2, ★3)
  - Used to decide the avatar's thumbnail.
- Motivation
  - Motivation to "I will create it!".

---

![ID card](./README_images/id_card.jpg)
