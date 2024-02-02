---パーティクルフレームの種類
---@alias FrameParticle.ParticleType
---| "NORMAL" 通常のパーティクル
---| "FIGURA" Figuraマークのパーティクル（穴空き三角形）

---@class FrameParticle Exスキルのフレームで使用するパーティクルの単一を管理するクラス
FrameParticle = {
    ---フレームパーティクルのインスタンスを新しく生成する。
    ---@param particleId integer スポーンさせるパーティのID。一意の値にする。
    ---@param screenPos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param type FrameParticle.ParticleType このインスタンスのパーティクルの種類
    ---@return table フレームパーティクルのインスタンス
    spawn = function (particleId, screenPos, type)
        local instance = {}

        ---パーティクルインスタンスのID。パーティクル用パーツを参照するのに用いる。
        ---@type integer
        instance.id = particleId

        ---パーティクルのアニメーションを制御するためのカウンター。
        ---@type number
        instance.counter = 0

        ---レンダーイベントで実行する関数
        ---@return boolean canDiscardInstance このインスタンスを破棄してもよいか
        instance.render = function (self)
            models.script_ex_skill_frame_particles["Particle_"..particleId]:scale(vectors.vec3(1, 1, 1):scale(1 - self.counter))
            instance.counter = math.min(self.counter + 4 / client:getFPS(), 1)
            return instance.counter == 1
        end

        ---パーティクルを削除する。パーティクルを削除するとパーティクルの再生成ができないのでこのインスタンスは破棄する。
        instance.remove = function (self)
            models.script_ex_skill_frame_particles:removeChild(models.script_ex_skill_frame_particles["Particle_"..self.id])
        end

        ---@diagnostic disable-next-line: redundant-parameter
        models.script_ex_skill_frame_particles:addChild(models.models.ex_skill_frame.Particles["Particle"..(type == "NORMAL" and 1 or 2)]:copy("Particle_"..particleId))
        models.script_ex_skill_frame_particles["Particle_"..particleId]:setPos(screenPos:copy():augmented(1):scale(-1))
        models.script_ex_skill_frame_particles["Particle_"..particleId]:setRot(90, math.map(math.random(), 0, 1, 0, 360), 180)

        return instance
    end
}

return FrameParticle