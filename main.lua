require "collision"
require "player"

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Servietsky")
    player.load()
    -- inventory.load()
    collision.load()
end

function love.update(dt)
    -- inventory.update(dt)
    player.update(dt)
end

function love.draw()
    -- inventory.draw()
    collision.draw()
    player.draw()
end

function love.keypressed(key)
    if key == "space" then
        flashlight:toggle()
    end
end