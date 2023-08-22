---@alias Gun.GunPosition
---| "BODY"
---| "RIGHT"
---| "LEFT"

---@class Gun 生徒の銃を制御するクラス
---@field TargetModel ModelPart 銃のモデルパーツ
Gun = {
    --定数
    GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow"},

    --フィールド
    TargetModel = models.models.gun.Gun,
}

---前ティックに左利きだったかどうか
---@type boolean
local leftHandedPrev = player:isLeftHanded()

---前ティックに手に持っていたアイテム: 1. メインハンド, 2. オフハンド
---@type table<ItemStack>
local heldItemsPrev = {world.newItem("minecraft:air"), world.newItem("minecraft:air")}

---背中の銃の位置・向きを設定する。
local function setBodyGunPos()
    if player:isLeftHanded() then
        Gun.TargetModel:setRot(0, 180, 45)
    else
        Gun.TargetModel:setRot(0, 0, -45)
    end
    Gun.TargetModel:setPos(0, 16, 3)
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
    if GunPosition == "BODY" then
        for _, tickName in ipairs({"right_gun_tick", "left_gun_tick"}) do
            events.TICK:remove(tickName)
        end
        if events.TICK:getRegisteredCount("body_gun_tick") == 0 then
            events.TICK:register(bodyGunTick, "body_gun_tick")
        end
        Gun.TargetModel:setSecondaryRenderType("NONE")
        for _, renderName in ipairs({"right_gun_render", "left_gun_render"}) do
            events.RENDER:remove(renderName)
        end
        for _, itemModel in ipairs({vanilla_model.RIGHT_ITEM, vanilla_model.LEFT_ITEM}) do
            itemModel:setVisible(true)
        end
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Body)
        setBodyGunPos()
        Arms.setBowPose(false, false)
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
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.RightArm)
        Gun.TargetModel:setPos(4, 10, 0)
        Gun.TargetModel:setRot(-90, 0, 90)
        Arms.setBowPose(true, false)
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
        Gun.TargetModel = Gun.TargetModel:moveTo(models.models.main.Avatar.UpperBody.Arms.LeftArm)
        Gun.TargetModel:setPos(-4, 10, 0)
        Gun.TargetModel:setRot(-90, 0, 90)
        Arms.setBowPose(true, true)
    end
end

events.TICK:register(function()
    local heldItems = {player:getHeldItem(false), player:getHeldItem(true)}
    local targetItemFound = false
    if heldItems[1].id ~= heldItemsPrev[1].id or heldItems[2].id ~= heldItemsPrev[2].id then
        for _, gunItem in ipairs(Gun.GUN_ITEMS) do
            if heldItems[1].id == gunItem then
                setGunPose(player:isLeftHanded() and "LEFT" or "RIGHT")
                targetItemFound = true
                break
            end
        end
        if not targetItemFound then
            for _, gunItem in ipairs(Gun.GUN_ITEMS) do
                if heldItems[2].id == gunItem then
                    setGunPose(player:isLeftHanded() and "RIGHT" or "LEFT")
                    targetItemFound = true
                    break
                end
            end
        end
        if not targetItemFound then
            setGunPose("BODY")
        end
        heldItemsPrev = heldItems
    end
end)

Gun.TargetModel:setScale(1.5, 1.5, 1.5)
setGunPose("BODY")

return Gun