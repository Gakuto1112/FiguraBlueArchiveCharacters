---@class ExSkill2WaveParticleManager 水着のExスキルアニメーション後の波を表現するパーティクルを管理するクラス
ExSkill2WaveParticleManager = {
    ---波パーティクルのインスタンスクラス
    ---@type ExSkill2WaveParticle
    ExSkill2WaveParticle = require("scripts.ex_skill.ex_skill_2_wave_particle"),

    ---フレームパーティクルのインスタンスを保持するテーブル
    ---@type table<table>
    ParticleGroups = {},

    ---パーティクルをスポーンさせる。
    ---@param self ExSkill2WaveParticleManager
    spawn = function (self)
        if events.TICK:getRegisteredCount("ex_skill_2_wave_particle_spawn_tick") == 1 then
            events.TICK:remove("ex_skill_2_wave_particle_spawn_tick")
        end
        local tickCount = 0
        local playerPos = player:getPos()
        local bodyYaw = player:getBodyYaw()
        events.TICK:register(function ()
            table.insert(self.ParticleGroups, self.ExSkill2WaveParticle.spawn(playerPos, bodyYaw))
            if #self.ParticleGroups == 1 then
                events.TICK:register(function ()
                    for index, waveParticle in ipairs(self.ParticleGroups) do
                        waveParticle:onTick()
                        if waveParticle.tickCount == 40 then
                            table.remove(self.ParticleGroups, index)
                            if #self.ParticleGroups == 0 then
                                events.TICK:remove("ex_skill_2_wave_particle_tick")
                            end
                        end
                    end
                end, "ex_skill_2_wave_particle_tick")
            end
            tickCount = tickCount + 1
            if tickCount == 20 then
                events.TICK:remove("ex_skill_2_wave_particle_spawn_tick")
            end
        end, "ex_skill_2_wave_particle_spawn_tick")
    end
}

return ExSkill2WaveParticleManager