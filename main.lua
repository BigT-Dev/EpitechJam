require "flashlight"

function love.load()
    flashlight = Flashlight
    flashlight:load(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    background = love.graphics.newImage("assets/background.png")
end

function love.draw()
    love.graphics.draw(background, -500, -600)
    flashlight:draw()
end

function love.update(dt)
    flashlight:update(dt)
end

function love.keypressed(key)
    if key == "space" then
        flashlight:toggle()
    end
    if key == "t" then
        flashlight:thunder()
    end
end
