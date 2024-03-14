---@alias Gun.GunPosition
---| "NONE"
---| "RIGHT"
---| "LEFT"

---@class Gun 生徒の銃を制御するクラス
---@field GUN_ITEMS Minecraft.itemID[] 銃のモデルを適用するアイテムIDのテーブル
---@field TargetModel ModelPart 銃のモデルパーツ
Gun = {
    --定数
    GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow"},

    --フィールド
    TargetModel = models.models.gun.Gun,
}

---現在の銃の位置
---@type Gun.GunPosition
local currentGunStatus = "NONE"

---前ティックに左利きだったかどうか
---@type boolean
local leftHandedPrev = player:isLeftHanded()

---前ティックに手に持っていたアイテム: 1. メインハンド, 2. オフハンド
---@type table<ItemStack>
local heldItemsPrev = {world.newItem("minecraft:air"), world.newItem("minecraft:air")}

---背中の銃の位置・向きを設定する。
local function setBodyGunPos()
    if player:isLeftHanded() then
        if BlueArchiveCharacter.GUN.put.pos ~= nil and BlueArchiveCharacter.GUN.put.pos.left ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(0, 12):add(BlueArchiveCharacter.GUN.put.pos.left))
        else
            Gun.TargetModel:setPos(vectors.vec3(0, 12))
        end
        if BlueArchiveCharacter.GUN.put.rot ~= nil and BlueArchiveCharacter.GUN.put.rot.left ~= nil then
            Gun.TargetModel:setRot(BlueArchiveCharacter.GUN.put.rot.left)
        else
            Gun.TargetModel:setRot()
        end
    else
        if BlueArchiveCharacter.GUN.put.pos ~= nil and BlueArchiveCharacter.GUN.put.pos.right ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(0, 12):add(BlueArchiveCharacter.GUN.put.pos.right))
        else
            Gun.TargetModel:setPos(vectors.vec3(0, 12))
        end
        if BlueArchiveCharacter.GUN.put.rot ~= nil and BlueArchiveCharacter.GUN.put.rot.right ~= nil then
            Gun.TargetModel:setRot(BlueArchiveCharacter.GUN.put.rot.right)
        else
            Gun.TargetModel:setRot()
        end
    end
end

---銃が背中にある際のティック処理
local function bodyGunTick()
    local leftHanded = player:isLeftHanded()
    if leftHanded ~= leftHandedPrev then
        setBodyGunPos()
        leftHandedPrev = leftHanded
    end
end

---右手に銃を持った際のティック処理
local function rightGunTick()
    Gun.TargetModel:setSecondaryRenderType(player:getHeldItem(player:isLeftHanded()):hasGlint() and "GLINT" or "NONE")
end
---左手に銃を持った際のティック処理
local function leftGunTick()
    Gun.TargetModel:setSecondaryRenderType(player:getHeldItem(not player:isLeftHanded()):hasGlint() and "GLINT" or "NONE")
end

---右手に銃を持った際のレンダー処理
local function rightGunRender(_, context)
    if context == "FIRST_PERSON" then
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(false, false)
        else
            animations["models.main"]["gun_hold_right"]:stop()
        end
        vanilla_model.RIGHT_ITEM:setVisible(true)
        Gun.TargetModel:setVisible(false)
    else
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(true, false)
        else
            animations["models.main"]["gun_hold_right"]:play()
        end
        vanilla_model.RIGHT_ITEM:setVisible(false)
        Gun.TargetModel:setVisible(true)
    end
end

---左手に銃を持った際のレンダー処理
local function leftGunRender(_, context)
    if context == "FIRST_PERSON" then
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(false, false)
        else
            animations["models.main"]["gun_hold_left"]:stop()
        end
        vanilla_model.LEFT_ITEM:setVisible(true)
        Gun.TargetModel:setVisible(false)
    else
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(true, true)
        else
            animations["models.main"]["gun_hold_left"]:play()
        end
        vanilla_model.LEFT_ITEM:setVisible(false)
        Gun.TargetModel:setVisible(true)
    end
end

---銃の構えを変更する。
---@param GunPosition Gun.GunPosition 変更先の構え位置
local function setGunPose(GunPosition)
    if GunPosition == "NONE" then
        for _, tickName in ipairs({"right_gun_tick", "left_gun_tick"}) do
            events.TICK:remove(tickName)
        end
        Gun.TargetModel:setSecondaryRenderType("NONE")
        for _, renderName in ipairs({"right_gun_render", "left_gun_render"}) do
            events.RENDER:remove(renderName)
        end
        if ExSkill ~= nil and ExSkill.AnimationCount > -1 then
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(false)
            end
        else
            for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
                itemModel:setVisible(true)
            end
        end
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(false, false)
        elseif BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
            for _, animationName in ipairs({"gun_hold_right", "gun_hold_left"}) do
                animations["models.main"][animationName]:stop()
            end
        end
        if BlueArchiveCharacter.GUN.put.type == "BODY" then
            Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Body)
            if events.TICK:getRegisteredCount("body_gun_tick") == 0 then
                events.TICK:register(bodyGunTick, "body_gun_tick")
            end
            setBodyGunPos()
        elseif BlueArchiveCharacter.GUN.put.type == "HIDDEN" then
            Gun.TargetModel:setVisible(false)
        end
    elseif GunPosition == "RIGHT" then
        for _, tickName in ipairs({"body_gun_tick", "left_gun_tick"}) do
            events.TICK:remove(tickName)
        end
        if events.TICK:getRegisteredCount("right_gun_tick") == 0 then
            events.TICK:register(rightGunTick, "right_gun_tick")
        end
        events.RENDER:remove("left_gun_render")
        if events.RENDER:getRegisteredCount("right_gun_render") == 0 then
            events.RENDER:register(rightGunRender, "right_gun_render")
        end
        vanilla_model.LEFT_ITEM:setVisible(true)
        if BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
            animations["models.main"]["gun_hold_left"]:stop()
        end
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
        if BlueArchiveCharacter.GUN.hold.pos ~= nil and BlueArchiveCharacter.GUN.hold.pos.right ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(4, 8, 0):add(BlueArchiveCharacter.GUN.hold.pos.right))
        else
            Gun.TargetModel:setPos(vectors.vec3(4, 8, 0))
        end
        if BlueArchiveCharacter.GUN.hold.rot ~= nil and BlueArchiveCharacter.GUN.hold.rot.right ~= nil then
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90):add(BlueArchiveCharacter.GUN.hold.rot.right))
        else
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90))
        end
        if not client:isPaused() then
            sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
        end
    else
        for _, tickName in ipairs({"body_gun_tick", "right_gun_tick"}) do
            events.TICK:remove(tickName)
        end
        if events.TICK:getRegisteredCount("left_gun_tick") == 0 then
            events.TICK:register(leftGunTick, "left_gun_tick")
        end
        events.RENDER:remove("right_gun_render")
        if events.RENDER:getRegisteredCount("left_gun_render") == 0 then
            events.RENDER:register(leftGunRender, "left_gun_render")
        end
        vanilla_model.RIGHT_ITEM:setVisible(true)
        if BlueArchiveCharacter.GUN.hold.type == "NORMAL" then
            Arms:setBowPose(true, true)
        elseif BlueArchiveCharacter.GUN.hold.type == "CUSTOM" then
            animations["models.main"]["gun_hold_right"]:stop()
            animations["models.main"]["gun_hold_left"]:play()
        end
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm)
        if BlueArchiveCharacter.GUN.hold.pos ~= nil and BlueArchiveCharacter.GUN.hold.pos.left ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(-4, 8, 0):add(BlueArchiveCharacter.GUN.hold.pos.left))
        else
            Gun.TargetModel:setPos(vectors.vec3(-4, 8, 0))
        end
        if BlueArchiveCharacter.GUN.hold.rot ~= nil and BlueArchiveCharacter.GUN.hold.rot.left ~= nil then
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90):add(BlueArchiveCharacter.GUN.hold.rot.left))
        else
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90))
        end
        if not client:isPaused() then
            sounds:playSound("minecraft:item.flintandsteel.use", player:getPos(), 1, 2)
        end
    end
end

events.TICK:register(function()
    local heldItems = (player:getPose() ~= "SLEEPING" and ExSkill.AnimationCount == -1) and {player:getHeldItem(false), player:getHeldItem(true)} or {world.newItem("minecraft:air"), world.newItem("minecraft:air")}
    local targetItemFound = false
    if heldItems[1].id ~= heldItemsPrev[1].id or heldItems[2].id ~= heldItemsPrev[2].id then
        for _, gunItem in ipairs(Gun.GUN_ITEMS) do
            if heldItems[1].id == gunItem then
                --メインハンドに対象アイテムを持つ
                targetItemFound = true
                if player:isLeftHanded() then
                    if currentGunStatus ~= "LEFT" then
                        setGunPose("LEFT")
                        currentGunStatus = "LEFT"
                    end
                else
                    if currentGunStatus ~= "RIGHT" then
                        setGunPose("RIGHT")
                        currentGunStatus = "RIGHT"
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
                        if currentGunStatus ~= "RIGHT" then
                            setGunPose("RIGHT")
                            currentGunStatus = "RIGHT"
                        end
                    else
                        if currentGunStatus ~= "LEFT" then
                            setGunPose("LEFT")
                            currentGunStatus = "LEFT"
                        end
                    end
                    break
                end
            end
        end
        if not targetItemFound then
            --対象アイテムは持たない
            if currentGunStatus ~= "NONE" then
                setGunPose("NONE")
                currentGunStatus = "NONE"
            end
        end
        heldItemsPrev = heldItems
    end
end)

events.ON_PLAY_SOUND:register(function (id, pos, _, _, _, _, path)
    if path ~= nil then
        if (id == "minecraft:entity.arrow.shoot" or id == "minecraft:item.crossbow.loading_end" or id == "minecraft:item.crossbow.shoot") and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 0.5 then
            if id == "minecraft:item.crossbow.loading_end" then
                sounds:playSound("minecraft:block.dispenser.fail", pos, 1, 2)
            else
                local particleAnchor = ModelUtils.getModelWorldPos(Gun.TargetModel["MuzzleAnchor"])
                for _ = 1, 5 do
                    particles:newParticle("minecraft:smoke", particleAnchor)
                end
                sounds:playSound(BlueArchiveCharacter.GUN.sound.name, pos, 1, BlueArchiveCharacter.GUN.sound.pitch)
            end
            ---@diagnostic disable-next-line: redundant-return-value
            return true
        elseif (id == "minecraft:item.crossbow.loading_start" or id == "minecraft:item.crossbow.loading_middle" or id:match("^minecraft:item%.crossbow%.quick_charge_[1-3]$") ~= nil) and math.abs(pos:copy():sub(player:getPos()):length() - player:getVelocity():length()) < 1 and player:getActiveItem().id == "minecraft:crossbow" then
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
            if (quickChageLevel <= 4 and activeItemTime + quickChageLevel == 6) or (quickChageLevel == 5 and activeItemTime == 2) then
                sounds:playSound("minecraft:item.flintandsteel.use", pos, 1, 2)
                ---@diagnostic disable-next-line: redundant-return-value
                return true
            elseif id == "minecraft:item.crossbow.loading_middle" then
                ---@diagnostic disable-next-line: redundant-return-value
                return true
            end
        end
    end
end)

if BlueArchiveCharacter.GUN.scale ~= nil then
    Gun.TargetModel:setScale(vectors.vec3(1, 1, 1):scale(BlueArchiveCharacter.GUN.scale))
end

setGunPose("NONE")

return Gun