---ステータスエフェクトの分類分け
---@alias HpBar.EffectType
---| "UP" ステータス上昇系
---| "DOWN" ステータス低下系
---| "CC" 行動制限系
---| "SPECIAL" 能力強化系

---@class HpBar HPバーの動作を制御するクラス
HpBar = {
    ---エフェクトの分類分けテーブル
    ---@type {[string]: HpBar.EffectType}
    EffectTypes = {
        instant_health = "UP",
        water_breathing = "SPECIAL",
        invisibility = "SPECIAL",
        resistance = "UP",
        unluck = "DOWN",
        blindness = "CC",
        haste = "UP",
        poison = "DOWN",
        slowness = "DOWN",
        hunger = "DOWN",
        slow_falling = "SPECIAL",
        fire_resistance = "UP",
        saturation = "UP",
        jump_boost = "UP",
        mining_fatigue = "DOWN",
        dolphing_grace = "UP",
        heath_boost = "UP",
        regeneration = "UP",
        speed = "UP",
        luck = "UP",
        bad_omen = "SPECIAL",
        strength = "UP",
        darkness = "CC",
        hero_of_the_village = "SPECIAL",
        levitation = "CC",
        instant_damage = "DOWN",
        weakness = "DOWN",
        nausea = "CC",
        wither = "DOWN",
        absorption = "UP",
        glowing = "SPECIAL",
        night_vision = "SPECIAL"
    },

    ---Hpバーに表示しているバフテーブル
    ---@type {[string]: table}
    EffectTable = {},

    EffectStartIndex = 1,

    NextEffectCount = 0,

    ---HPゲージの長さを変更する。
    ---@param scale number HPゲージの長さ。0-1の間で指定する。
    setHpGage = function (scale)
        local targetLength = 15.225 * scale - 0.3
        models.models.hp_bar.Camera.HpGage.HpBar.Bar:setScale(math.clamp(targetLength / 14.925, 0, 1), 1, 1)
        models.models.hp_bar.Camera.HpGage.HpBar.BarTipRight:setPos(math.min(14.925 - targetLength, 14.925), 0, 0)
    end,

    ---バリアゲージの長さを変更する。
    ---@param scale number バリアゲージの長さ。0-1の間で指定する。
    setBarrierGage = function (scale)
        if scale == 0 then
            models.models.hp_bar.Camera.BarrierGage:setVisible(false)
            models.models.hp_bar.Camera.BuffArea:setPos(0, -1, 0)
        else
            models.models.hp_bar.Camera.BarrierGage:setVisible(true)
            models.models.hp_bar.Camera.BuffArea:setPos()
            local targetLength = 15.225 * scale - 0.195
            models.models.hp_bar.Camera.BarrierGage.BarrierBar.Bar:setScale(math.clamp(targetLength / 15.03, 0, 1), 1, 1)
            models.models.hp_bar.Camera.BarrierGage.BarrierBar.BarTipRight:setPos(math.min(15.03 - targetLength, 15.03), 0, 0)
        end
    end,

    ---初期化関数
    ---@param self HpBar
    init = function (self)
        events.TICK:register(function ()
            self.setHpGage(player:getHealth() / player:getMaxHealth())
            if host:isHost() then
                local validEffects = {}
                local newEffectTable = {}
                for _, effect in ipairs(host:getStatusEffects()) do
                    local matchedString = effect.name:match("minecraft%.([%w_]+)$")
                    if matchedString ~= nil and self.EffectTypes[matchedString] ~= nil then
                        local entry = {}
                        entry.name = matchedString
                        entry.duration = effect.duration
                        entry.amplifier = effect.amplifier
                        table.insert(validEffects, entry)
                        if self.EffectTable[matchedString] == nil then
                            --Effect Start
                        end
                        newEffectTable[matchedString] = {duration = effect.duration, amplifier = effect.amplifier}
                        self.EffectTable[matchedString] = nil
                    end
                end
                for effectName, effect in pairs(self.EffectTable) do
                    --Effect End
                end
                self.EffectTable = newEffectTable
                for i = 1, 4 do
                    models.models.hp_bar.Camera.BuffArea["BuffSlot"..i]:setVisible(false)
                end
                local effectIndex = 1
                local index = 0
                for effectName, effect in pairs(self.EffectTable) do
                    if effectIndex == self.EffectStartIndex then
                        index = 1
                    end
                    if index >= 1 and index <= 4 then
                        local effectType = self.EffectTypes[effectName]
                        models.models.hp_bar.Camera.BuffArea["BuffSlot"..index].BuffBackground:setUVPixels(effectType == "UP" and 0 or (effectType == "DOWN" and 24 or (effectType == "CC" and 48 or 72)))
                        models.models.hp_bar.Camera.BuffArea["BuffSlot"..index].BuffIcon:setPrimaryTexture("RESOURCE", "minecraft:textures/mob_effect/"..effectName..".png")
                        models.models.hp_bar.Camera.BuffArea["BuffSlot"..index].BuffIcon:setPos(0, effectType == "UP" and 0 or (effectType == "DOWN" and 0.583 or 0.292))
                        local opacity = (effect.duration >= 0 and effect.duration < 100) and math.abs((effect.duration % 20) * 0.075 - 0.75) + 0.25 or 1
                        models.models.hp_bar.Camera.BuffArea["BuffSlot"..index]:setOpacity(opacity)
                        if effect.amplifier == 0 then
                            models.models.hp_bar.Camera.BuffArea["BuffSlot"..index]:getTask("effect_amplifier"):setVisible(false)
                        else
                            local textTask = models.models.hp_bar.Camera.BuffArea["BuffSlot"..index]:getTask("effect_amplifier")
                            textTask:setText("x"..(effect.amplifier + 1))
                            textTask:setOpacity(opacity)
                            textTask:setVisible(true)
                        end
                        models.models.hp_bar.Camera.BuffArea["BuffSlot"..index]:setVisible(true)
                    end
                    index = index >= 1 and index + 1 or index
                    effectIndex = effectIndex + 1
                end
                if self.EffectStartIndex > effectIndex - 1 then
                    self.EffectStartIndex = 1
                    self.NextEffectCount = 0
                end
                if effectIndex >= 6 then
                    self.NextEffectCount = self.NextEffectCount + 1
                    if self.NextEffectCount == 60 then
                        if self.EffectStartIndex + 4 <= effectIndex then
                            self.EffectStartIndex = self.EffectStartIndex + 4
                        else
                            self.EffectStartIndex = 1
                        end
                        self.NextEffectCount = 0
                    end
                else
                    self.NextEffectCount = 0
                end
                if self.EffectTable.absorption ~= nil then
                    self.setBarrierGage(player:getAbsorptionAmount() / ((self.EffectTable.absorption.amplifier + 1) * 4))
                else
                    self.setBarrierGage(0)
                end
            end
        end)

        for i = 1, 4 do
            local textTask = models.models.hp_bar.Camera.BuffArea["BuffSlot"..i]:newText("effect_amplifier")
            textTask:setPos(-0.75, 1.4, 0)
            textTask:setScale(0.2, 0.2, 0.2)
            textTask:setShadow(true)
            textTask:setAlignment("RIGHT")
        end

        self.setHpGage(player:getHealth() / player:getMaxHealth())
        self.setBarrierGage(0)
    end
}

HpBar:init()

return HpBar