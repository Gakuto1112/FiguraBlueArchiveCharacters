<!-- $inject(locale_link) -->

# FiguraBlueArchiveCharacters
<!-- DESCRIPTION_START -->
This is the avatars for [Figura](https://modrinth.com/mod/figura), the skin mod for [Minecraft](https://www.minecraft.net/en-us) Java Edition, which are imitated characters who appear in "[Blue Archive](https://bluearchive.jp/)" the game for mobile devices.

Target figura version: [0.1.4](https://modrinth.com/mod/figura/version/0.1.4+1.20.1)

(Some avatar functions don't work correctly in Minecraft 1.20.4 doe to [a bug in Figura](https://github.com/FiguraMC/Figura/issues/197). I recommend using in Minecraft 1.20.1.)
<!-- DESCRIPTION_END -->

[![Thumbnail](../README_images/thumbnail.jpg)](https://youtu.be/JrPhLR34mLA)

(You can watch the introduction video by clicking the above image.)

<!-- $inject(creation_status) -->

## Features
- Imitated ex skill cut-ins.

  ![Ex skill](../README_images/ex_skill.jpg)

- An object remains after the ex skill if the ex skill type is "leaving something in a place".
  - The object doesn't affect the game at all.
  - The object will be remove when the hit boxes of a block and it are overlapped.
  - You can remove all placement objects by holding the Ex skill key (default: V).

  ![Placement object](../README_images/placement_object.jpg)

- Press cursor keys (↑→↓←) to show speech bubbles.
  - The "reload" speech bubble will appear automatically while loading a crossbow.

  ![Speech bubble 1](../README_images/bubble_good.jpg)

  ![Speech bubble 2](../README_images/bubble_reload.jpg)

- Holds the character's specific weapon instead of bows and crossbows. Shoots bullets instead of arrows.
  - Note that these changes are only in appearance. You are just shooting arrows in actual.

  ![Gun](../README_images/gun.jpg)

- A barrier will applied when the player has absorption hearts (yellow hearts).

  ![Barrier](../README_images/barrier.jpg)

- Will be rescued by the helicopter when the player dies.
  - This animation won't visible if the player isn't visible because of Minecraft and Figura specifications.

  ![Rescued by helicopter](../README_images/death_animation.jpg)

- Can change costume if the character has multiple costumes.

  ![Costume](../README_images/costume.jpg)

- Some characters have unique models for in-game vehicles.

  ![Vehicle models](../README_images/vehicle_model.jpg)

- Can change your display name to the character's name.
  - Can also display the club name which the character is participated in.
  - **Other players also need to install Figura and give enough permissions** to see your display name.

  ![Display name](../README_images/display_name.jpg)

- A cake emoji will be added during the student's birthday.
  - It won't be displayed if the display name is the player name.

  ![Birth day](../README_images/birth_day.svg)

## Ex Skill
The familiar Ex skill cut-in from the original game is imitated. To play Ex skill cut-in, press the Ex skill key (default is "V" key) while in the **third-person perspective**.

![Ex skill](../README_images/ex_skill.jpg)

Ex skill cut-ins are only visual and have no effect. However, some Ex skills leave objects in place after the cut-in (also only visual).

> [!NOTE]
> - Ex skill animations are designed for the case where the screen ratio is 16:9. Although you can play them in a screen ratio other than 16:9, but some parts may be crowded out of the screen.
> - Ex skill animations are design for the case where the field of view (FOV) is standard (70). The FOV will be temporarily adjusted to the standard if it is not standard. However, use of some other mods or FOV changes because of changes of the player's movement speed prevents the script from adjusting it.

## The action wheel
Figura provides the action wheel with which players can play some actions (emotes, animations, configs, and etc.). It will be shown when holding the action wheel key (default is B key). This avatar also has some actions.

> [!IMPORTANT]
> The Ex skill action has been changed to play on key press.

![Action wheel](../README_images/action_wheel.jpg)

### Action 1. Change costume
Changes costume if the character has multiple costumes. Scroll to select the costume and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection.

![Costume](../README_images/costume.jpg)

### Action 2. Change display name
Changes the player's display name. Scroll to select the name and closing the action wheel to confirm. Left-click to reset to current selection, and right-clock to reset to default during selection. However, **Other players also need to install Figura and give enough permissions** to see your display name.

![Display name](../README_images/display_name_2.jpg)

### Action 3. Toggle armors visible
Toggles whether equipped armors are visible or not. Some costumes will be hidden not to interfere with the armors while equips them. This setting will only affects to vanilla armors.

I recommend to hide armors because they hide the avatar.

### Action 4. Toggle first-person weapon models
Toggles whether weapon models (including students' guns) are visible or not in first person perspective. If toggled off, Minecraft items will be displayed instead. Regardless of this setting, weapon models are always displayed in third person perspective.

![First-person weapon models](../README_images/first_person_weapons.jpg)

### Action 5. Change amount of Ex skill frame particles
Changes the amount of triangular particles that appear from the red or blue borders that appear during Ex skill animations. Reducing or disabling particles may improve performance.

As an additional option, I have added an option to disable the frame during the Ex skill animations. This is the closest to the original one.

### Action 6. Toggle vehicle models
Toggles the vehicle models replacement feature for some characters. This option is disabled for characters with no vehicle models.

![Vehicle models](../README_images/vehicle_model_2.jpg)

<!-- $inject(how_to_use) -->

<!-- $inject(notes) -->

## Known issues
- The halo (head ring) and arms holding weapons may not be rendered when activating a shader pack with [Iris Shaders](https://www.irisshaders.dev/) only once after game startup ([#63](https://github.com/Gakuto1112/FiguraBlueArchiveCharacters/issues/63)).
  - You can resolve this issue by reloading the avatar.

---

![ID card](../README_images/id_card.jpg)