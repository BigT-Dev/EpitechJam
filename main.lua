require("src/range")
require("src/inventory")
require("src/items/deo")
require("src/items/monster")
require("src/items/items")
require("src/items/rtx")
require("src/items/nivea")
require("src/items/ammo")
require("src/items/nerf")

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Inventory")
    love.graphics.setBackgroundColor(21, 21, 21)
    range.load()
    inventory.load()
end

function love.update(dt)
    range.update(dt)
    items.update(dt)

    if love.keyboard.isDown("c") then
        inventory.update(dt)
    end
end

function love.draw()
    range.draw()
    items.draw()
    love.graphics.setColor(50, 50, 50)
    if love.keyboard.isDown("c") then
        inventory.draw()
    end
end