local mouse = {}
local player =  {}


function love.player()

    player[1] = ("sprite/Thanatos.png")
    player[2] = ("sprite/Chinese.png")
    player[3] = ("sprite/DCs_Guardian.png")
    player[4] = ("sprite/Master_Legend.png")


    player.spritesheet = love.graphics.newImage(player[4])
    player.x = 1321
    player.y = 1400
    player.grid = animation.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
    player.animations = {}
    player.animations.down = animation.newAnimation (player.grid('1-2', 1),  0.25)

end

function love.load ()
    love.window.setMode(1920, 1080)
    love.window.setTitle("LAST DAY IN TEK")

    animation = require 'librairies/animation'

    camera = require 'librairies/camera'
    cam = camera()

    love.player()
    background = love.graphics.newImage("sprite/Background.png")
end

function love.angle()
    local mouseX, mouseY = love.mouse.getPosition()
    local angle = math.atan2(player.y - mouseY, player.x - mouseX ) * 3
    player.animations.down:draw(player.spritesheet, player.x, player.y, angle, nil, nil, 32, 32)
end

function love.camtrack()

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

function love.update(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - 60 * 0.07
    end
    if love.keyboard.isDown("right") then
        player.x = player.x + 60 * 0.07
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - 60 * 0.07
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 60 * 0.07
    end
    player.animations.down:update(dt)

    cam:lookAt(player.x, player.y)
    cam.scale = 2
    love.camtrack()
    love.angle()

end

function love.draw()
    cam:attach()
        love.graphics.draw(background, 10, -750)
        love.angle()
    cam:detach()
end