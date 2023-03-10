animation = require 'libraries/animation'
camera = require 'libraries/camera'
local mouse = {}
player = {x = 1321, y = 2134, width = 32, height = 32}

function player.load()
    cam = camera()
    player.player()
    background = love.graphics.newImage("sprite/Map.png")
end

function player.update(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - 400 * dt
    end
    if love.keyboard.isDown("right") then
        player.x = player.x + 400 * dt
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - 400 * dt
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 400 * dt
    end
    player.animations.down:update(dt)
    collision.update(dt)
    player.angle()
    cam:lookAt(player.x, player.y)
    cam.scale = 2
    player.camtrack()

end

function player.draw()
    cam:attach()
        love.graphics.draw(background, 10, -750)
        player.angle()
    cam:detach()
end

function player.player()
    player.spritesheet = love.graphics.newImage(player[1])
    player.x = 1321
    player.y = 1234
    player.grid = animation.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
    player.animations = {}
    player.animations.down = animation.newAnimation (player.grid('1-2', 1),  0.3)

end

function player.angle()
    local mouseX, mouseY = love.mouse.getPosition()
    local angle = math.atan2(mouseY - player.y, mouseX - player.x)
    player.animations.down:draw(player.spritesheet, player.x, player.y, angle, nil, nil, 32, 32)
end

function player.camtrack()

    local width = love.graphics.getWidth()
    local Height = love.graphics.getHeight()

    if cam.x > (1.9 * width/4) then
        cam.x = (1.9 * width/4)
    end

    if cam.x < (width/3.7) then
        cam.x = (width/3.7)
    end

    if cam.y < (1.7 * -Height/4) then
        cam.y = (1.7 * -Height/4)
    end

    if cam.y > (4.7 * Height/4) then
        cam.y = (4.7 * Height/4)
    end
end