---銃の位置を示す列挙型
---@alias Gun.GunPosition
---| "NONE"
---| "RIGHT"
---| "LEFT"

---@class Gun 生徒の銃を制御するクラス
Gun = {
    ---銃のモデルを適用するアイテムIDのテーブル
    ---@type Minecraft.itemID[]
    GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow"},

    ---一人称で武器（銃を含む）のモデル
    ---@type boolean
    ShowWeaponInFirstPerson = Config.loadConfig("firstPersonWeapon", true),

    ---現在の銃の位置
    ---@type Gun.GunPosition
    CurrentGunPosition = "NONE",

    ---前ティックに左利きだったかどうか
    ---@type boolean
    LeftHandedPrev = player:isLeftHanded(),

    ---前ティックに手に持っていたアイテム: 1. メインハンド, 2. オフハンド
    ---@type ItemStack[]
    HeldItemsPrev = {world.newItem("minecraft:air"), world.newItem("minecraft:air")},

    ---銃の位置を変更する。
    ---@param GunPosition Gun.GunPosition 変更先の構え位置
    setGunPosition = function (self, GunPosition)
        if GunPosition == "NONE" then
            for _, tickName in ipairs({"right_gun_tick", "left_gun_tick"}) do
                events.TICK:remove(tickName)
            end
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("None")
            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
            if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
                Arms:setBowPose(false, false)
            elseif BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
                for _, animationName in ipairs({"gun_hold_right", "gun_hold_left"}) do
                    animations["models.main"][animationName]:stop()
                end
            end
            if BlueArchiveCharacter.GUN.put.type == "BODY" then
                if events.TICK:getRegisteredCount("body_gun_tick") == 0 then
                    events.TICK:register(function ()
                        local leftHanded = player:isLeftHanded()
                        if leftHanded ~= self.LeftHandedPrev then
                            self.setBodyGunPos()
                            self.LeftHandedPrev = leftHanded
                        end
                    end, "body_gun_tick")
                end
                self.setBodyGunPos()
            elseif BlueArchiveCharacter.GUN.put.type == "HIDDEN" then
                models.models.main.Avatar.UpperBody.Body.Gun:setVisible(false)
            end
            self.CurrentGunPosition = "NONE"
        elseif GunPosition == "RIGHT" then
            for _, tickName in ipairs({"body_gun_tick", "left_gun_tick"}) do
                events.TICK:remove(tickName)
            end
            if events.TICK:getRegisteredCount("right_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.GUN_ITEMS) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("GLINT")
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
                    end
                end, "right_gun_tick")
            end
            if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
                Arms:setBowPose(true, false)
            elseif BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
                animations["models.main"]["gun_hold_left"]:stop()
                animations["models.main"]["gun_hold_right"]:play()
            end
            models.models.main.Avatar.UpperBody.Body.Gun:setVisible(true)
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
            end
            self.CurrentGunPosition = "RIGHT"
        else
            for _, tickName in ipairs({"body_gun_tick", "right_gun_tick"}) do
                events.TICK:remove(tickName)
            end
            if events.TICK:getRegisteredCount("left_gun_tick") == 0 then
                events.TICK:register(function ()
                    local heldItem = player:getHeldItem(not player:isLeftHanded())
                    local hasGlint = false
                    for _, gunItem in ipairs(self.GUN_ITEMS) do
                        if gunItem == heldItem.id and heldItem:hasGlint() then
                            models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("GLINT")
                            hasGlint = true
                            break
                        end
                    end
                    if not hasGlint then
                        models.models.main.Avatar.UpperBody.Body.Gun:setSecondaryRenderType("NONE")
                    end
                end, "left_gun_tick")
            end
            if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
                Arms:setBowPose(true, true)
            elseif BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
                animations["models.main"]["gun_hold_right"]:stop()
                animations["models.main"]["gun_hold_left"]:play()
            end
            models.models.main.Avatar.UpperBody.Body.Gun:setVisible(true)
            models.models.main.Avatar.UpperBody.Body.Gun:setParentType("Item")
            if not client:isPaused() then
                sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
            end
            self.CurrentGunPosition = "LEFT"
        end
    end,

    ---背中の銃の位置・向きを設定する。
    setBodyGunPos = function ()
        local offsetPos = vectors.vec3()
        local offsetRot = vectors.vec3()
        if player:isLeftHanded() then
            if BlueArchiveCharacter.GUN.put.pos ~= nil and BlueArchiveCharacter.GUN.put.pos.left ~= nil then
                offsetPos = BlueArchiveCharacter.GUN.put.pos.left
            end
            if BlueArchiveCharacter.GUN.put.rot ~= nil and BlueArchiveCharacter.GUN.put.rot.left ~= nil then
                offsetRot = BlueArchiveCharacter.GUN.put.rot.left
            end
        else
            if BlueArchiveCharacter.GUN.put.pos ~= nil and BlueArchiveCharacter.GUN.put.pos.right ~= nil then
                offsetPos = BlueArchiveCharacter.GUN.put.pos.right
            end
            if BlueArchiveCharacter.GUN.put.rot ~= nil and BlueArchiveCharacter.GUN.put.rot.right ~= nil then
                offsetRot = BlueArchiveCharacter.GUN.put.rot.right
            end
        end
        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 12, 0):add(offsetPos))
        models.models.main.Avatar.UpperBody.Body.Gun:setRot(offsetRot)
    end,

    ---初期化関数
    init = function (self)
        events.TICK:register(function()
            local heldItems = (player:getPose() ~= "SLEEPING" and ExSkill.AnimationCount == -1) and {player:getHeldItem(false), player:getHeldItem(true)} or {world.newItem("minecraft:air"), world.newItem("minecraft:air")}
            local targetItemFound = false
            if heldItems[1].id ~= self.HeldItemsPrev[1].id or heldItems[2].id ~= self.HeldItemsPrev[2].id then
                for _, gunItem in ipairs(Gun.GUN_ITEMS) do
                    if heldItems[1].id == gunItem then
                        --メインハンドに対象アイテムを持つ
                        targetItemFound = true
                        if player:isLeftHanded() then
                            if self.CurrentGunPosition ~= "LEFT" then
                                self:setGunPosition("LEFT")
                            end
                        else
                            if self.CurrentGunPosition ~= "RIGHT" then
                                self:setGunPosition("RIGHT")
                            end
                        end
                        break
                    end
                end
                if not targetItemFound then
                    for _, gunItem in ipairs(Gun.GUN_ITEMS) do
                        if heldItems[2].id == gunItem then
                            --オフハンドに対象アイテムを持つ
                            targetItemFound = true
                            if player:isLeftHanded() then
                                if self.CurrentGunPosition ~= "RIGHT" then
                                    self:setGunPosition("RIGHT")
                                end
                            else
                                if self.CurrentGunPosition ~= "LEFT" then
                                    self:setGunPosition("LEFT")
                                end
                            end
                            break
                        end
                    end
                end
                if not targetItemFound then
                    --対象アイテムは持たない
                    if self.CurrentGunPosition ~= "NONE" then
                        self:setGunPosition("NONE")
                    end
                end
                self.HeldItemsPrev = heldItems
            end
        end)

        events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
            if path ~= nil then
                local velocityDistance = player:getVelocity():length()
                local distanceFromSound = math.abs(pos:copy():sub(player:getPos()):length() - velocityDistance)
                if (id == "minecraft:entity.arrow.shoot" or id == "minecraft:item.crossbow.loading_end" or id == "minecraft:item.crossbow.shoot") and math.abs(velocityDistance - distanceFromSound) < 1 then
                    if id == "minecraft:item.crossbow.loading_end" then
                        sounds:playSound("minecraft:block.dispenser.fail", pos, 1, 2)
                    elseif player:isUnderwater() then
                        sounds:playSound("minecraft:entity.generic.extinguish_fire", pos, 0.5, 1.5)
                    else
                        local particleAnchor = ModelUtils.getModelWorldPos(renderer:isFirstPerson() and (Gun.CurrentGunPosition == "RIGHT" and models.models.main.Avatar.UpperBody.Arms.RightArm.RightArmBottom.RightItemPivot or models.models.main.Avatar.UpperBody.Arms.LeftArm.LeftArmBottom.LeftItemPivot) or models.models.main.Avatar.UpperBody.Body.Gun.MuzzleAnchor)
                        for _ = 1, 5 do
                            particles:newParticle("minecraft:smoke", particleAnchor)
                        end
                        sounds:playSound(BlueArchiveCharacter.GUN.sound.name, pos, 1, BlueArchiveCharacter.GUN.sound.pitch)
                    end
                    return true
                elseif (id == "minecraft:item.crossbow.loading_start" or id == "minecraft:item.crossbow.loading_middle" or id:match("^minecraft:item%.crossbow%.quick_charge_[1-3]$") ~= nil) and distanceFromSound < 1 and player:getActiveItem().id == "minecraft:crossbow" then
                    local activeItemTime = player:getActiveItemTime()
                    local quickChageLevel = 0
                    local activeItem = player:getActiveItem()
                    if activeItem.tag.Enchantments ~= nil then
                        for _, enchant in ipairs(activeItem.tag.Enchantments) do
                            if enchant.id == "minecraft:quick_charge" then
                                quickChageLevel = enchant.lvl
                                break
                            end
                        end
                    end
                    if (quickChageLevel <= 4 and activeItemTime + quickChageLevel >= 4 and activeItemTime + quickChageLevel <= 6) or (quickChageLevel == 5 and activeItemTime <= 2) then
                        sounds:playSound("minecraft:item.flintandsteel.use", pos, 1, 2)
                        return true
                    elseif id == "minecraft:item.crossbow.loading_middle" then
                        return true
                    end
                end
            end
        end)

        events.ITEM_RENDER:register(function (item, mode, pos, rot , scale, lefthanded)
            if mode ~= "HEAD" and self.CurrentGunPosition == (lefthanded and "LEFT" or "RIGHT") and (self.ShowWeaponInFirstPerson or mode =="THIRD_PERSON_LEFT_HAND" or mode == "THIRD_PERSON_RIGHT_HAND") then
                for _, gunItem in ipairs(self.GUN_ITEMS) do
                    if item.id == gunItem then
                        if lefthanded then
                            if mode == "FIRST_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.first_person_pos ~= nil and BlueArchiveCharacter.GUN.hold.first_person_pos.left ~= nil then
                                    offsetPos = BlueArchiveCharacter.GUN.hold.first_person_pos.left
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.first_person_rot ~= nil and BlueArchiveCharacter.GUN.hold.first_person_rot.left ~= nil then
                                    offsetRot = BlueArchiveCharacter.GUN.hold.first_person_rot.left
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                local activeItemId = player:getActiveItem().id
                                if activeItemId == "minecraft:bow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(20, -7.5, -5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and item.tag.Charged == 1 then
                                    local crossbowOffsetPos = vectors.vec3()
                                    if BlueArchiveCharacter.GUN.hold.charged_crossbow_pos ~= nil and BlueArchiveCharacter.GUN.hold.charged_crossbow_pos.left ~= nil then
                                        crossbowOffsetPos = BlueArchiveCharacter.GUN.hold.charged_crossbow_pos.left
                                    end
                                    local crossbowOffsetRot = vectors.vec3()
                                    if BlueArchiveCharacter.GUN.hold.charged_crossbow_rot ~= nil and BlueArchiveCharacter.GUN.hold.charged_crossbow_rot.left ~= nil then
                                        crossbowOffsetRot = BlueArchiveCharacter.GUN.hold.charged_crossbow_rot.left
                                    end
                                    if player:isLeftHanded() then
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(-10, -1.25, 6):add(offsetPos):add(crossbowOffsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 10, 0):add(offsetRot):add(crossbowOffsetRot))
                                    else
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos):add(crossbowOffsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot):add(crossbowOffsetRot))
                                    end
                                end
                            elseif mode == "THIRD_PERSON_LEFT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.third_person_pos ~= nil and BlueArchiveCharacter.GUN.hold.third_person_pos.left ~= nil then
                                    offsetPos = BlueArchiveCharacter.GUN.hold.third_person_pos.left
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.third_person_rot ~= nil and BlueArchiveCharacter.GUN.hold.third_person_rot.left ~= nil then
                                    offsetRot = BlueArchiveCharacter.GUN.hold.third_person_rot.left
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        else
                            if mode == "FIRST_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.first_person_pos ~= nil and BlueArchiveCharacter.GUN.hold.first_person_pos.right ~= nil then
                                    offsetPos = BlueArchiveCharacter.GUN.hold.first_person_pos.right
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.first_person_rot ~= nil and BlueArchiveCharacter.GUN.hold.first_person_rot.right ~= nil then
                                    offsetRot = BlueArchiveCharacter.GUN.hold.first_person_rot.right
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                local activeItemId = player:getActiveItem().id
                                if activeItemId == "minecraft:bow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -2.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(20, 7.5, 5):add(offsetRot))
                                elseif activeItemId == "minecraft:crossbow" then
                                    models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, 0.25, 4.25):add(offsetPos))
                                    models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                                elseif item.id == "minecraft:crossbow" and item.tag.Charged == 1 then
                                    local crossbowOffsetPos = vectors.vec3()
                                    if BlueArchiveCharacter.GUN.hold.charged_crossbow_pos ~= nil and BlueArchiveCharacter.GUN.hold.charged_crossbow_pos.right ~= nil then
                                        crossbowOffsetPos = BlueArchiveCharacter.GUN.hold.charged_crossbow_pos.right
                                    end
                                    local crossbowOffsetRot = vectors.vec3()
                                    if BlueArchiveCharacter.GUN.hold.charged_crossbow_rot ~= nil and BlueArchiveCharacter.GUN.hold.charged_crossbow_rot.right ~= nil then
                                        crossbowOffsetRot = BlueArchiveCharacter.GUN.hold.charged_crossbow_rot.right
                                    end
                                    if player:isLeftHanded() then
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -1.25, 4.25):add(offsetPos):add(crossbowOffsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot):add(crossbowOffsetRot))
                                    else
                                        models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(10, -1.25, 6):add(offsetPos):add(crossbowOffsetPos))
                                        models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, -10, 0):add(offsetRot):add(crossbowOffsetRot))
                                    end
                                end
                            elseif mode == "THIRD_PERSON_RIGHT_HAND" then
                                local offsetPos = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.third_person_pos ~= nil and BlueArchiveCharacter.GUN.hold.third_person_pos.right ~= nil then
                                    offsetPos = BlueArchiveCharacter.GUN.hold.third_person_pos.right
                                end
                                local offsetRot = vectors.vec3()
                                if BlueArchiveCharacter.GUN.hold.third_person_rot ~= nil and BlueArchiveCharacter.GUN.hold.third_person_rot.right ~= nil then
                                    offsetRot = BlueArchiveCharacter.GUN.hold.third_person_rot.right
                                end
                                models.models.main.Avatar.UpperBody.Body.Gun:setPos(vectors.vec3(0, -4.25, 4.25):add(offsetPos))
                                models.models.main.Avatar.UpperBody.Body.Gun:setRot(vectors.vec3(0, 0, 0):add(offsetRot))
                            end
                        end
                        return models.models.main.Avatar.UpperBody.Body.Gun
                    end
                end
            end
        end)

        if BlueArchiveCharacter.GUN.scale ~= nil then
            models.models.main.Avatar.UpperBody.Body.Gun:setScale(vectors.vec3(1, 1, 1):scale(BlueArchiveCharacter.GUN.scale))
        end

        self:setGunPosition("NONE")
    end
}

Gun:init()

return Gun