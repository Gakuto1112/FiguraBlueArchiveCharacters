---@class Firework 視覚的なロケット花火を出現させるクラス
Firework = {
    ---ロケット花火インスタンスを生成する。
    ---@param startPos Vector3 ロケット花火の出現位置
    ---@param rot Vector3 ロケット花火が飛んでいく方向
    new = function (startPos, rot)
        local instance = {}

        ---ロケット花火のアイテムタスク
        ---@type ItemTask
        instance.itemTask = models.script_firework:newItem("firework_"..client.intUUIDToString(client:generateUUID())):setItem(CompatibilityUtils:checkItem("minecraft:firework_rocket")):setScale(0.5, 0.5, 0.5)

        ---ロケット花火の現在位置
        ---@type Vector3
        instance.currentPos = startPos

        ---ロケット花火の次ティックの位置
        ---@type Vector3
        instance.nextPos = startPos

        ---ロケット花火が飛んでいく方向を示すベクトル
        ---@type Vector3
        instance.rotVec = vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, 0, 0, 1, 1, 0, 0), 0, 1, 0), 0, 0, 1)

        ---ロケット花火が爆発するまでのカウンタ
        ---@type integer
        instance.blastCount = 40

        ---ロケット花火を飛ばす音のインスタンス
        ---@type Sound
        instance.launchSound = sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.firework_rocket.launch"), instance.currentPos, 1, 0.5)

        ---この設置物インスタンスの破棄を要求するかどうか。trueにした次のティックにインスタンスは破棄される。
        ---@type boolean
        instance.deinitRequired = false

        ---このインスタンスが生成された直後に呼ばれる関数
        instance.onInit = function ()
            instance.itemTask:setPos(instance.currentPos:copy():scale(16))
            instance.itemTask:setRot(rot:copy():add(90, 0, 0))
        end

        ---このインスタンスが破棄される直前に呼ばれる関数
        instance.onDeinit = function ()
            instance.itemTask:remove()
        end

        ---各ティック毎に呼ばれる関数
        instance.onTick = function ()
            if instance.blastCount == 0 then
                instance.blast()
            end
            --花火の位置を強制更新
            instance.currentPos = instance.nextPos
            instance.itemTask:setPos(instance.currentPos:copy():scale(16))
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

            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:firework"), instance.currentPos):setVelocity(vectors.rotateAroundAxis(rot.z, vectors.rotateAroundAxis(rot.y, vectors.rotateAroundAxis(rot.x, math.random() * 0.05 - 0.025, 0.1, 0, 1, 0, 0), 0, 1, 0), 0, 0, 1))

            --次ティックの花火の位置を算出
            instance.nextPos = instance.currentPos:copy():add(instance.rotVec:copy():scale(1.4))

            instance.blastCount = instance.blastCount - 1
        end

        ---各レンダーティック毎に呼ばれる関数
        ---@param delta number デルタ値
        instance.onRender = function (delta)
            instance.itemTask:setPos(instance.nextPos:copy():sub(instance.currentPos):scale(delta):add(instance.currentPos):scale(16))
        end

        ---花火を爆発させる。
        instance.blast = function ()
            local fireworkColor = vectors.hsvToRGB(math.random(), 0.8, 1)
            particles:newParticle(CompatibilityUtils:checkParticle("minecraft:flash"), instance.currentPos):setColor(fireworkColor)
            for _ = 1, 400 do
                local particleAngleX = math.random() * math.pi * 2
                local particleAngleY = math.random() * math.pi * 2
                particles:newParticle(CompatibilityUtils:checkParticle("minecraft:firework"), instance.currentPos):setVelocity(math.cos(particleAngleX) * math.cos(particleAngleY) * 0.4, math.sin(particleAngleY) * 0.4, math.sin(particleAngleX) * math.cos(particleAngleY) * 0.4):setColor(fireworkColor)
            end
            sounds:playSound(CompatibilityUtils:checkSound("minecraft:entity.firework_rocket.large_blast"), instance.currentPos, 1, 1):setAttenuation(5)
            instance.blastCount = -1
            instance.deinitRequired = true
        end

        return instance
    end
}

return Firework