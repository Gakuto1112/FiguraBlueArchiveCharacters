---@alias Gun.GunPosition
---| "NONE"
---| "RIGHT"
---| "LEFT"

---@class Gun 生徒の銃を制御するクラス
---@field GUN_ITEMS table<string> 銃のモデルを適用するアイテムIDのテーブル
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
        if BlueArchiveCharacter.GUN.putPosOffset ~= nil and BlueArchiveCharacter.GUN.putPosOffset.left ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(0, 12):add(BlueArchiveCharacter.GUN.putPosOffset.left))
        else
            Gun.TargetModel:setPos(vectors.vec3(0, 12))
        end
        if BlueArchiveCharacter.GUN.putRotOffset ~= nil and BlueArchiveCharacter.GUN.putRotOffset.left ~= nil then
            Gun.TargetModel:setRot(BlueArchiveCharacter.GUN.putRotOffset.left)
        else
            Gun.TargetModel:setRot()
        end
    else
        if BlueArchiveCharacter.GUN.putPosOffset ~= nil and BlueArchiveCharacter.GUN.putPosOffset.right ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(0, 12):add(BlueArchiveCharacter.GUN.putPosOffset.right))
        else
            Gun.TargetModel:setPos(vectors.vec3(0, 12))
        end
        if BlueArchiveCharacter.GUN.putRotOffset ~= nil and BlueArchiveCharacter.GUN.putRotOffset.right ~= nil then
            Gun.TargetModel:setRot(BlueArchiveCharacter.GUN.putRotOffset.right)
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
    vanilla_model.RIGHT_ITEM:setVisible(context == "FIRST_PERSON")
end

---左手に銃を持った際のレンダー処理
local function leftGunRender(_, context)
    vanilla_model.LEFT_ITEM:setVisible(context == "FIRST_PERSON")
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
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        if BlueArchiveCharacter.GUN.holdPose == "NORMAL" then
            Arms:setBowPose(false, false)
        elseif BlueArchiveCharacter.GUN.holdPose == "CUSTOM" then
            for _, animationName in ipairs({"gun_hold_right", "gun_hold_left"}) do
                animations["models.main"][animationName]:stop()
            end
        end
        if BlueArchiveCharacter.GUN.PutType == "BODY" then
            Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Body)
            if events.TICK:getRegisteredCount("body_gun_tick") == 0 then
                events.TICK:register(bodyGunTick, "body_gun_tick")
            end
            setBodyGunPos()
        elseif BlueArchiveCharacter.GUN.PutType == "HIDDEN" then
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
        Gun.TargetModel:setVisible(true)
        vanilla_model.LEFT_ITEM:setVisible(true)
        if BlueArchiveCharacter.GUN.holdPose == "NORMAL" then
            Arms:setBowPose(true, false)
        elseif BlueArchiveCharacter.GUN.holdPose == "CUSTOM" then
            animations["models.main"]["gun_hold_left"]:stop()
            animations["models.main"]["gun_hold_right"]:play()
        end
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
        if BlueArchiveCharacter.GUN.holdPosePosOffset ~= nil and BlueArchiveCharacter.GUN.holdPosePosOffset.right ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(4, 8, 0):add(BlueArchiveCharacter.GUN.holdPosePosOffset.right))
        else
            Gun.TargetModel:setPos(vectors.vec3(4, 8, 0))
        end
        if BlueArchiveCharacter.GUN.holdPoseRotOffset ~= nil and BlueArchiveCharacter.GUN.holdPoseRotOffset.right ~= nil then
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90):add(BlueArchiveCharacter.GUN.holdPoseRotOffset.right))
        else
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90))
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
        Gun.TargetModel:setVisible(true)
        vanilla_model.RIGHT_ITEM:setVisible(true)
        if BlueArchiveCharacter.GUN.holdPose == "NORMAL" then
            Arms:setBowPose(true, true)
        elseif BlueArchiveCharacter.GUN.holdPose == "CUSTOM" then
            animations["models.main"]["gun_hold_right"]:stop()
            animations["models.main"]["gun_hold_left"]:play()
        end
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm)
        if BlueArchiveCharacter.GUN.holdPosePosOffset ~= nil and BlueArchiveCharacter.GUN.holdPosePosOffset.left ~= nil then
            Gun.TargetModel:setPos(vectors.vec3(-4, 8, 0):add(BlueArchiveCharacter.GUN.holdPosePosOffset.left))
        else
            Gun.TargetModel:setPos(vectors.vec3(-4, 8, 0))
        end
        if BlueArchiveCharacter.GUN.holdPoseRotOffset ~= nil and BlueArchiveCharacter.GUN.holdPoseRotOffset.left ~= nil then
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90):add(BlueArchiveCharacter.GUN.holdPoseRotOffset.left))
        else
            Gun.TargetModel:setRot(vectors.vec3(-90, 0, 90))
        end
    end
end

events.TICK:register(function()
    local heldItems = {player:getHeldItem(false), player:getHeldItem(true)}
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

Gun.TargetModel:setScale(1.5, 1.5, 1.5)
setGunPose("NONE")

return Gun