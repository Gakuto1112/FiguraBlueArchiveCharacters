---@class HypixelZombies Hypixelの「Zombies」にアバターを対応させるパッチ
HypixelZombies = {
    ---前ティック以前のツールの耐久度割合
    ---@type number[]
    DamagerPercentPrev = {1, 1},

    ---初期化処理
    ---@param self HypixelZombies
    init = function(self)
        Gun.GUN_ITEMS = {"minecraft:bow", "minecraft:crossbow", "minecraft:wooden_hoe", "minecraft:stone_hoe", "minecraft:iron_hoe", "minecraft:wooden_shovel", "minecraft:stone_shovel", "minecraft:shears", "minecraft:diamond_hoe", "minecraft:golden_hoe", "minecraft:iron_shovel", "minecraft:diamond_pickaxe", "minecraft:golden_pickaxe", "minecraft:golden_shovel", "minecraft:flint_and_steel"}
        events.TICK:register(function ()
            local heldItem = player:getHeldItem()
            local maxDamage = heldItem:getMaxDamage()
            local damagePercent = (maxDamage - heldItem:getDamage()) / maxDamage
            if maxDamage > 0 then
                if damagePercent - self.DamagerPercentPrev[1] > 0 and damagePercent - self.DamagerPercentPrev[1] <= 0.2 then
                    if Bubble.BubbleCounter == 0 then
                        Bubble:play("RELOAD", -1, 0, 0, false)
                    end
                elseif Bubble.Emoji == "RELOAD" then
                    Bubble:stop()
                end
                table.insert(self.DamagerPercentPrev, damagePercent)
            else
                if Bubble.Emoji == "RELOAD" then
                    Bubble:stop()
                end
                table.insert(self.DamagerPercentPrev, 1)
            end
            table.remove(self.DamagerPercentPrev, 1)
        end)
    end
}

HypixelZombies:init()

return HypixelZombies