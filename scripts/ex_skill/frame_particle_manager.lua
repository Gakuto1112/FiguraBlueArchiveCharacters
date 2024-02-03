---@class FrameParticleManager Exスキルのフレームで使用するパーティクルを管理するクラス
FrameParticleManager = {
    ---フレームパーティクルのインスタンスを保持するテーブル
    ---@type table<table>
    Particles = {},

    ---フレームパーティクルのIDを管理するカウンター
    ---@type integer
    IdCounter = 1,

    ---レンダーイベントを処理したかどうか
    ---@type boolean
    IsRenderProcessed = false,

    ---レンダーイベント内で実行する関数
    render = function (self)
        if not self.IsRenderProcessed then
            for index, particle in ipairs(self.Particles) do
                if particle:render() then
                    table.remove(self.Particles, index)
                    if #self.Particles == 0 then
                        events.RENDER:remove("ex_skill_frame_particle_render")
                        events.WORLD_RENDER:remove("ex_skill_frame_particle_world_render")
                        self.IdCounter = 1
                        self.IsRenderProcessed = false
                    end
                end
            end
            self.IsRenderProcessed = true
        end
    end,

    ---ワールドレンダーイベント内で実行する関数
    worldRender = function (self)
        self.IsRenderProcessed = false
    end,

    ---パーティクルをスポーンさせる。
    ---@param screenPos Vector2 パーティクルをスポーンさせるスクリーン上の座標。GUIスケールも考慮される。
    ---@param velocity Vector2 パーティクルの秒間移動距離（ピクセル）
    spawn = function (self, screenPos, velocity)
        local instance = FrameParticle.spawn(self.IdCounter, screenPos, math.random() > 0.9999 and "FIGURA" or "NORMAL", velocity)
        table.insert(self.Particles, instance)
        self.IdCounter = self.IdCounter + 1
        if #self.Particles == 1 then
            events.RENDER:register(function ()
                self:render()
            end, "ex_skill_frame_particle_render")
            events.WORLD_RENDER:register(function ()
                self:worldRender()
            end, "ex_skill_frame_particle_world_render")
        end
    end,

    ---初期化関数
    init = function ()
        ---@diagnostic disable-next-line: discard-returns
        models:newPart("script_ex_skill_frame_particles", "Gui")
    end
}

FrameParticleManager.init()

return FrameParticleManager