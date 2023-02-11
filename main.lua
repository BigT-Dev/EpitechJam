require "inventory"

function love.load()
    inventory.load()
end

function love.update(dt)
    inventory.update(dt)
end

function love.draw()
    inventory.draw()
end
