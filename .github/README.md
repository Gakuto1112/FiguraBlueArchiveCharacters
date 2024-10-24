Language: 　**English**　|　[日本語](./README_jp.md)

# FiguraBlueArchiveCharacters
<!-- DESCRIPTION_START -->
This is the avatars for [Figura](https://modrinth.com/mod/figura), the skin mod for [Minecraft](https://www.minecraft.net/en-us) Java Edition, which are imitated characters who appear in "[Blue Archive](https://bluearchive.jp/)" the game for mobile devices.

Target figura version: [0.1.4](https://modrinth.com/mod/figura/version/0.1.4+1.20.1)

(Some avatar functions don't work correctly in Minecraft 1.20.4 doe to [a bug in Figura](https://github.com/FiguraMC/Figura/issues/197). I recommend using in Minecraft 1.20.1.)
<!-- DESCRIPTION_END -->

[![Thumbnail](./README_images/thumbnail.jpg)](https://youtu.be/JrPhLR34mLA)

(You can watch the introduction video by clicking the above image.)

## Creation status
### Done
The avatars for these characters are completed. You can download and use avatars below in the game according to the chapter "[How to use](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/blob/base/.github/README.md#how-to-use)".

- Shizuko Kawawa
- Izuna Kuda
- Mari Iochi
- Momoi Saiba
- Midori Saiba
- Shiroko Sunaookami
- Hoshino Takanashi
- Umika Satohama

### In progress
The avatars for these characters are worked in progress. It usually takes about 2~3 weeks, but works have been delayed because of my recently busy schedule. Click on the link in brackets to go to the issue about the character, where you can check the progress.

- Hoshino Takanashi (Battle) ([#62](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/62))

### Planned
Although the avatars for these characters are not created, there are plans to create them in the future. They will be created in order from top to bottom. This is just a plan and the order may change or creation may be discontinued.

- Mari Iochi (Idol) ([#82](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/82))
- Iroha Natsume ([#64](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/64))
- Ibuki Tanga ([#65](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/65))
- Serika Kuromi ([#37](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/37))
- Serina Sumi ([#38](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/38))
- Hihumi Ajitani ([#39](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/39))

## Features
- Imitated ex skill cut-ins.

  ![Ex skill](./README_images/ex_skill.jpg)

- An object remains after the ex skill if the ex skill type is "leaving something in a place".
  - The object doesn't affect the game at all.
  - The object will be remove when the hit boxes of a block and it are overlapped.
  - You can remove all placement objects by holding the Ex skill key (default: V).

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

- Some characters have unique models for in-game vehicles.

  ![Vehicle models](./README_images/vehicle_model.jpg)

- Can change your display name to the character's name.
  - Can also display the club name which the character is participated in.
  - **Other players also need to install Figura and give enough permissions** to see your display name.

  ![Display name](./README_images/display_name.jpg)

- A cake emoji will be added during the student's birthday.
  - It won't be displayed if the display name is the player name.

  ![Birth day](./README_images/birth_day.svg)

## Ex Skill
The familiar Ex skill cut-in from the original game is imitated. To play Ex skill cut-in, press the Ex skill key (default is "V" key) while in the **third-person perspective**.

![Ex skill](./README_images/ex_skill.jpg)

Ex skill cut-ins are only visual and have no effect. However, some Ex skills leave objects in place after the cut-in (also only visual).

> [!NOTE]
> - Ex skill animations are designed for the case where the screen ratio is 16:9. Although you can play them in a screen ratio other than 16:9, but some parts may be crowded out of the screen.
> - Ex skill animations are design for the case where the field of view (FOV) is standard (70). The FOV will be temporarily adjusted to the standard if it is not standard. However, use of some other mods or FOV changes because of changes of the player's movement speed prevents the script from adjusting it.

## The action wheel
Figura provides the action wheel with which players can play some actions (emotes, animations, configs, and etc.). It will be shown when holding the action wheel key (default is B key). This avatar also has some actions.

> [!IMPORTANT]
> The Ex skill action has been changed to play on key press.

![Action wheel](./README_images/action_wheel.jpg)

### Action 1. Change costume
Changes costume if the character has multiple costumes. Scroll to select the costume and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection.

![Costume](./README_images/costume.jpg)

### Action 2. Change display name
Changes the player's display name. Scroll to select the name and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection. However, **Other players also need to install Figura and give enough permissions** to see your display name.

![Display name](./README_images/display_name_2.jpg)

### Action 3. Toggle armors visible
Toggles whether equipped armors are visible or not. Some costumes will be hidden not to interfere with the armors while equips them. This setting will only affects to vanilla armors.

I recommend to hide armors because they hide the avatar.

### Action 4. Toggle first-person weapon models
Toggles whether weapon models (including students' guns) are visible or not in first person perspective. If toggled off, Minecraft items will be displayed instead. Regardless of this setting, weapon models are always displayed in third person perspective.

![First-person weapon models](./README_images/first_person_weapons.jpg)

### Action 5. Change amount of Ex skill frame particles
Changes the amount of triangular particles that appear from the red or blue borders that appear during Ex skill animations. Reducing or disabling particles may improve performance.

As an additional option, I have added an option to disable the frame during the Ex skill animations. This is the closest to the original one.

### Action 6. Toggle vehicle models
Toggles the vehicle models replacement feature for some characters. This option is disabled for characters with no vehicle models.

![Vehicle models](./README_images/vehicle_model_2.jpg)

## How to use
Figura is available in [Forge](https://files.minecraftforge.net/net/minecraftforge/forge/), [Fabric](https://fabricmc.net/) and [NeoForge](https://neoforged.net/).

1. Install the mod loader which you want to use and make the mods available.
2. Install [Figura](https://modrinth.com/mod/figura). Note the mod dependencies.
3. Go to the [release page](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/releases).
   - You can also go there from the right side of [the repository's home page](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters).
4. Download the avatar of your choice that attached to "Assets" section of the release notes.
5. Unzip the zipped file and take the avatar data inside this.
6. Put avatar files at `<minecraft_instance_directory>/figura/avatars/`.
   - The directory will automatically generated after launching the game with Figura installed. You can also create it manually if it doesn't exist.
7. Open the Figura menu (Δ mark) from the game menu.
8. Select the avatar from the avatar list at the left of the Figura menu.
9. Sets your permission if you need.
10. Other Figura players can see your avatar after uploading your avatar to the Figura server.
    - **If your Minecraft is Pirated (cracked, unlicensed, free), you cannot upload your avatar.** This is a Figura specification and I cannot help you with this.

## Notes
- I'm not responsible for any damages caused by using this avatar.
- This avatar is designed for work with no resource pack and no other mods are installed. An unexpected issue may occurs when you use it with any resource packs and mods (texture and armor inconsistencies, etc.). However, I may not support you in these cases.
- There may be a bug which occurs in multiplayer because my ([Gakuto1112](https://github.com/Gakuto1112)) multiplayer environment to verify the avatar is insufficient.
- Please [report an issue](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues) if you find it.
- Please contact me via [Discussions](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/discussions) or [Discord](https://discord.com/) if you want to do for my avatars. My Discord name is "vinny_san" and display name is "ばにーさん". My display name in [Figura Discord server](https://discord.gg/figuramc) is "BunnySan/ばにーさん".

## Known issues
- The halo (head ring) and arms holding weapons may not be rendered when activating a shader pack with [Iris Shaders](https://www.irisshaders.dev/) only once after game startup ([#63](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/63)).
  - You can resolve this issue by reloading the avatar.

---

![ID card](./README_images/id_card.jpg)
