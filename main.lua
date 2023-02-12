require "collision"
require "flashlight"

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Servietsky")
    -- inventory.load()
    collision.load()
    -- flashlight.load()
end

function love.update(dt)
    -- inventory.update(dt)
    collision.update(dt)
    -- flashlight:update(dt)
end

function love.draw()
    -- inventory.draw()
    collision.draw()
end

function love.keypressed(key)
    if key == "space" then
        flashlight:toggle()
    end
end