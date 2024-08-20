---@class Missile 視覚的なミサイルを出現させるクラス
Missile = {
    ---ミサイルインスタンスを生成する。
    ---@param startPos Vector3 ロケット花火の出現位置
    ---@param rot Vector3 ロケット花火が飛んでいく方向
    new = function (startPos, rot)
        local instance = {}

        ---ミサイルのモデル
        ---@type ModelPart
        instance.missileModel = models.models.ex_skill_1.Missile:copy("Missile_"..client.intUUIDToString(client:generateUUID()))

        ---ミサイルの現在位置
        ---@type Vector3
        instance.currentPos = startPos

        ---ミサイルの次ティックの位置
        ---@type Vector3
        instance.nextPos = startPos

        ---ミサイルが飛んでいく方向を示すベクトル
        ---@type Vector3
        instance.rotVec = vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, 0, 0, 1, 1, 0, 0), 0, 1, 0), 0, 0, 1)

        ---ミサイルが爆発するまでのカウンタ
        ---@type integer
        instance.blastCount = 200

        ---ミサイルを飛ばす音のインスタンス
        ---@type Sound
        instance.launchSound = sounds:playSound("minecraft:entity.firework_rocket.launch", instance.currentPos, 1, 0.5)

        ---このインスタンスの破棄を要求するかどうか。trueにした次のティックにインスタンスは破棄される。
        ---@type boolean
        instance.deinitRequired = false

        ---このインスタンスが生成された直後に呼ばれる関数
        instance.onInit = function ()
            models.script_missile:addChild(instance.missileModel)
            instance.missileModel:setPos(instance.currentPos:copy():scale(16))
            instance.missileModel:setRot(rot:copy())
            instance.missileModel:setVisible(true)
        end

        ---このインスタンスが破棄される直前に呼ばれる関数
        instance.onDeinit = function ()
            instance.missileModel:remove()
        end

        ---各ティック毎に呼ばれる関数
        instance.onTick = function ()
            if instance.blastCount == 0 then
                instance.blast()
            end
            --花火の位置を強制更新
            instance.currentPos = instance.nextPos
            instance.missileModel:setPos(instance.currentPos:copy():scale(16))
            instance.launchSound:setPos(instance.currentPos)

            --当たり判定チェック
            for _, collisionBox in ipairs(world.getBlockState(instance.currentPos):getCollisionShape()) do
                local collisionBoxStart = instance.currentPos:copy():floor():add(collisionBox[1])
                local collisionBoxEnd = instance.currentPos:copy():floor():add(collisionBox[2])

                if collisionBoxStart.x <= instance.currentPos.x and collisionBoxEnd.x >= instance.currentPos.x and collisionBoxStart.y <= instance.currentPos.y and collisionBoxEnd.y >= instance.currentPos.y and collisionBoxStart.z <= instance.currentPos.z and collisionBoxEnd.z >= instance.currentPos.z then
                    instance.blast()
                    return
                end
            end

            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:large_smoke"), instance.currentPos):setVelocity(vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1))
            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:flame"), instance.currentPos):setScale(1.5):setVelocity(vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, math.random() * 0.05 - 0.025, math.random() * 0.05 - 0.025, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1)):setLifetime(4)

            --次ティックの花火の位置を算出
            instance.nextPos = instance.currentPos:copy():add(instance.rotVec:copy():scale(1.4))

            instance.blastCount = instance.blastCount - 1
        end

        ---各レンダーティック毎に呼ばれる関数
        ---@param delta number デルタ値
        instance.onRender = function (delta)
            instance.missileModel:setPos(instance.nextPos:copy():sub(instance.currentPos):scale(delta):add(instance.currentPos):scale(16))
        end

        ---花火を爆発させる。
        instance.blast = function ()
            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:explosion_emitter"), instance.currentPos)
            for _ = 1, 20 do
                local randomOffset = vectors.vec3(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:poof"), instance.currentPos:copy():add(randomOffset:copy():scale(5))):setScale(3):setVelocity(randomOffset:copy():scale(1))
            end
            sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.generic.explode"), instance.currentPos, 0.5, 1):setAttenuation(5)
            instance.blastCount = -1
            instance.deinitRequired = true
        end

        return instance
    end
}

return Missile