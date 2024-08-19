---パーティクルフレームの種類
---@alias FrameParticle.ParticleType
---| "NORMAL" 通常のパーティクル
---| "FIGURA" Figuraマークのパーティクル（穴空き三角形）

---@class FrameParticle Exスキルのフレームで使用するパーティクルの単一を管理するクラス
FrameParticle = {
    ---フレームパーティクルのインスタンスを新しく生成する。
    ---@param particleUUID string スポーンさせるパーティクルのUUID
    ---@param screenPos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param type FrameParticle.ParticleType このインスタンスのパーティクルの種類
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    ---@return table フレームパーティクルのインスタンス
    spawn = function (particleUUID, screenPos, type, velocity)
        local instance = {}

        ---パーティクルのモデルパーツ
        ---@type ModelPart
        ---@diagnostic disable-next-line: redundant-parameter
        instance.particle = models.models.ex_skill_frame.Particles["Particle"..(type == "NORMAL" and 1 or 2)]:copy(particleUUID)

        ---パーティクルの現在位置
        ---@type Vector3
        instance.currentPos = screenPos:augmented(100):scale(-1)

        ---次ティックのパーティクルの位置
        ---@type Vector3
        instance.nextPos = instance.currentPos

        ---パーティクルの秒間移動距離（ピクセル）
        ---@type Vector2
        instance.velocity = velocity

        ---パーティクルのアニメーションを制御するためのカウンター。
        ---@type number
        instance.counter = 0

        ---このインスタンスを破棄すべきかどうか
        ---@type boolean
        instance.shouldDeinit = false

        ---ティックイベントで実行する関数
        instance.tick = function (self)
            --パーティクル位置を強制更新
            self.currentPos = self.nextPos:copy()
            self.particle:setPos(self.currentPos)
            self.particle:setScale(vectors.vec3(1, 1, 1):scale(1 - self.counter / 5))

            --カウンターを更新
            self.counter = self.counter + 1
            if self.counter == 5 then
                self.particle:remove()
            elseif self.counter == 6 then
                self.shouldDeinit = true
            end

            --次ティックの位置を計算
            if self.velocity:length() > 0 then
                self.nextPos = self.currentPos:copy():add(self.velocity:copy():scale(-0.05):augmented(100))
            end
        end

        ---レンダーイベントで実行する関数
        ---@param delta number デルタ値
        instance.render = function (self, delta)
            self.particle:setPos(self.nextPos:copy():sub(self.currentPos):scale(delta):add(self.currentPos))
            self.particle:setScale(vectors.vec3(1, 1, 1):scale(1 - (self.counter + delta) / 5))
        end

        models.models.ex_skill_frame.Gui.script_ex_skill_frame_particles:addChild(instance.particle)
        instance.particle:setPos(instance.currentPos)
        instance.particle:setRot(90, math.random() * 360, 180)

        return instance
    end
}

return FrameParticle