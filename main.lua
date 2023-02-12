require("src/range")
require("src/inventory")
require("src/items/deo")
require("src/items/monster")
require("src/items/items")
require("src/items/rtx")
require("src/items/nivea")
require("src/items/ammo")
require("src/items/nerf")

local inv_close = love.audio.newSource("assets/sfx/inv_close.mp3", "static")
local inv_open = love.audio.newSource("assets/sfx/inv_open.mp3", "static")

InvState = {
    ["All"] = false
}

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Inventory")
    love.graphics.setBackgroundColor(21, 21, 21)
    inv_close:setLooping(false)
    inv_open:setLooping(false)
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
        InvState["All"] = true
        if not inv_open:isPlaying() then
            love.audio.play(inv_open)
        end
    end
    if love.keyboard.isDown("escape") then
        InvState["All"] = false
        if not inv_close:isPlaying() then
            love.audio.play(inv_close)
        end
    end
    if InvState["All"] then
        inventory.draw()
    end
end