---@class ExSkill2WaveParticle 水着のExスキルアニメーション後の波を表現するパーティクルの1グループを管理するクラス
ExSkill2WaveParticle = {
    ---パーティクルグループのインスタンスを新しく生成する。
    ---@param pos Vector3 パーティクルの基準位置
    ---@param rot number パーティクルの向き（度数法）
    ---@return table particleGroupInstance パーティクルグループのインスタンス
    spawn = function (pos, rot)
        local instance = {}

        ---インスタンスで扱うパーティクルのインスタンスを保持するテーブル
        ---@type Particle[]
        instance.particles = {}

        ---パーティクルの速度調整のためのティックカウンター
        ---@type integer
        instance.tickCount = 0

        ---毎ティック呼び出される関数
        instance.onTick = function (self)
            local velocityAddition = vectors.rotateAroundAxis(rot * -1 + 120, 0, math.cos(self.tickCount / 60 * 2 * math.pi) * 0.03, math.cos(self.tickCount / 80 * math.pi) * -0.02, 0, 1, 0)
            for _, particle in ipairs(self.particles) do
                particle:setVelocity(particle:getVelocity():add(velocityAddition))
            end
            self.tickCount = self.tickCount + 1
        end

        local particlePos = vectors.rotateAroundAxis(rot * -1 + 120, 0, 0, 0.5, 0, 1, 0):add(pos)
        local particleOffset = vectors.rotateAroundAxis(rot * -1 + 120, -1, 0, 0, 0, 1, 0)
        for i = -0.5, 0.5, 0.5 do
            for _ = 1, 3 do
                local colorFactor = math.random()
                table.insert(instance.particles, particles:newParticle("minecraft:dust 1000000000 1000000000 1000000000 2", particlePos:copy():add(particleOffset:copy():scale(i))):setVelocity(vectors.rotateAroundAxis(rot * -1 + 120, math.random() * 0.1 - 0.05, 0, 0.3, 0, 1, 0)):setColor(colorFactor, 1, 1):setLifetime(colorFactor * 25 + 5))
            end
        end

        return instance
    end
}

return ExSkill2WaveParticle