require "inventory"

function love.load()
    love.window.setMode(1920, 1080)
    inventory.load()
end

function love.update(dt)
    inventory.update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(155, 0, 0)
    inventory.draw()
end
