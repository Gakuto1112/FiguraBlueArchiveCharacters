---@class HypixelZombies Hypixelの「Zombies」にアバターを対応させるパッチ

Gun.GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow", "minecraft:wooden_hoe", "minecraft:stone_hoe", "minecraft:iron_hoe", "minecraft:wooden_shovel", "minecraft:stone_shovel", "minecraft:shears", "minecraft:diamond_hoe", "minecraft:golden_hoe", "minecraft:iron_shovel", "minecraft:diamond_pickaxe", "minecraft:golden_pickaxe", "minecraft:golden_hoe", "minecraft:flint_and_steel"}

---リロードの吹き出しエモートがZombies機能によって再生されたかどうか
---@type boolean
local reloadByZombies = false

events.TICK:register(function ()
    local heldItem = player:getHeldItem()
    local maxDamage = heldItem:getMaxDamage()
        local damagePercent = (maxDamage - heldItem:getDamage()) / maxDamage
        if maxDamage > 0 and damagePercent >= 0.05 and damagePercent < 1 and Bubble.Counter == 0 then
            Bubble:play("RELOAD", -1, false)
            reloadByZombies = true
        elseif (damagePercent < 0.05 or damagePercent == 1 or maxDamage == 0) and reloadByZombies then
            Bubble:stop()
            reloadByZombies = false
        end
end)