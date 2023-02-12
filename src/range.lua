range = {}

function range.load(dt)
    player = {}
    player.x = 400
    player.y = 250
    player.speed = 500
end

function range.update(dt)
    local vx = 0
    local vy = 0

    if love.keyboard.isDown("d") then
        vx = player.speed
        player.x = player.x + 300 * dt
    end
    if love.keyboard.isDown("q") then
        vx = player.speed * -1
        player.x = player.x - 300 * dt
    end
    if love.keyboard.isDown("z") then
        vy = player.speed * -1
        player.y = player.y - 300 * dt
    end
    if love.keyboard.isDown("s") then
        vy = player.speed
        player.y = player.y + 300 * dt
    end
end

function range.draw()
    love.graphics.setColor(0, 0, 125)
    love.graphics.circle("fill", player.x, player.y, 40)
    love.graphics.setColor(255, 255, 255, 255)
end