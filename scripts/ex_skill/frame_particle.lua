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
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    ---@return table フレームパーティクルのインスタンス
    spawn = function (particleId, screenPos, type, velocity)
        local instance = {}

        ---パーティクルのモデルパーツ
        ---@type ModelPart
        ---@diagnostic disable-next-line: redundant-parameter
        instance.particle = models.models.ex_skill_frame.Particles["Particle"..(type == "NORMAL" and 1 or 2)]:copy("Particle_"..particleId)

        ---パーティクルの秒間移動距離（ピクセル）
        ---@type Vector2
        instance.velocity = velocity

        ---パーティクルのアニメーションを制御するためのカウンター。
        ---@type number
        instance.counter = 0

        ---レンダーイベントで実行する関数
        ---@return boolean canDiscardInstance このインスタンスを破棄してもよいか
        instance.render = function (self)
            local fps = client:getFPS()
            if self.velocity ~= vectors.vec2(0, 0) then
                self.particle:setPos(self.particle:getPos():add(self.velocity:augmented(0):scale(-1 / fps)))
            end
            self.particle:setScale(vectors.vec3(1, 1, 1):scale(1 - self.counter))
            instance.counter = math.min(self.counter + 4 / fps , 1)
            if instance.counter == 1 then
                instance:remove()
                return true
            else
                return false
            end
        end

        ---パーティクルを削除する。パーティクルを削除するとパーティクルの再生成ができないのでこのインスタンスは破棄する。
        instance.remove = function (self)
            models.models.ex_skill_frame.Gui.script_ex_skill_frame_particles:removeChild(self.particle)
        end

        models.models.ex_skill_frame.Gui.script_ex_skill_frame_particles:addChild(instance.particle)
        instance.particle:setPos(screenPos:augmented(1):scale(-1))
        instance.particle:setRot(90, math.map(math.random(), 0, 1, 0, 360), 180)

        return instance
    end
}

return FrameParticle