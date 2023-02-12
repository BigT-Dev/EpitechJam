local mouse = {}
local player =  {}

function love.player()

    player.spritesheet = love.graphics.newImage("sprite/Thanatos.png")
    player.x = 1321
    player.y = 1234
    player.grid = animation.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
    player.animations = {}
    player.animations.down = animation.newAnimation (player.grid('1-2', 1),  0.3)

end

function love.load ()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Last Day in tek")

    animation = require 'librairies/animation'

    camera = require 'librairies/camera'
    cam = camera()

    love.player()
    background = love.graphics.newImage("sprite/Map2.png")
end

function love.angle()
    local mouseX, mouseY = love.mouse.getPosition()
    local angle = math.atan2(mouseY - player.y, mouseX - player.x)
    player.animations.down:draw(player.spritesheet, player.x, player.y, angle, nil, nil, 32, 32)
end

function love.cammove()

    local width = love.graphics.getWidth()
    local Height = love.graphics.getHeight()

    if cam.x > (2 * width/4) then
        cam.x = (2 * width/4)
    end

    if cam.x < (width/4) then
        cam.x = (width/4)
    end

    if cam.y < (Height/4) then
        cam.y = (Height/4)
    end

end

function love.update(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - 60 * 0.5
    end
    if love.keyboard.isDown("right") then
        player.x = player.x + 60 * 0.5
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - 60 * 0.5
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 60 * 0.5
    end
    player.animations.down:update(dt)

    love.angle()
    cam:lookAt(player.x, player.y)
    cam.scale = 2
    love.cammove()

end

function love.draw()
    cam:attach()
        love.graphics.draw(background, 10, -750)
        love.angle()
    cam:detach()
end