require "inventory"
require "collision"

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Servietsky")
    -- inventory.load()
    collision.load()
end

function love.update(dt)
    -- inventory.update(dt)
    collision.update(dt)
end

function love.draw()
    -- inventory.draw()
    collision.draw()
end
