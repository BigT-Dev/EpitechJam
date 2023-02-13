global_var = global_var or {}

require "src/collision"
require "src/flashlight"
require("src/loader")
require("src/menu")
require("src/load_game")
require("src/transition")
require("src/end_game")
require("src/inventory")
require("src/range")
require("src/inventory")
require("src/items/deo")
require("src/items/monster")
require("src/items/items")
require("src/items/rtx")
require("src/items/nivea")
require("src/items/ammo")
require("src/items/nerf")

global_var.var = {
    ["state"] = "game"
}

InvState = {
    ["All"] = false
}

local inv_close = love.audio.newSource("assets/sfx/inv_close.mp3", "static")
local inv_open = love.audio.newSource("assets/sfx/inv_open.mp3", "static")

function love.load()
    love.window.setMode(1920, 1080, {fullscreen = true})
    love.window.setTitle("Servietsky")
    inventory.load()
    collision.load()
    flashlight.load()
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if global_var.var["state"] == "loader" then
        loader.update(dt)
    elseif global_var.var["state"] == "menu" then
        menu.update(dt)
    elseif global_var.var["state"] == "transition" then
        transition.update(dt)
    elseif global_var.var["state"] == "load_game" then
        load_game.update(dt)
    elseif global_var.var["state"] == "game" then
        collision.update(dt)
        flashlight:update(dt)
        if love.keyboard.isDown("c") then
            inventory.update(dt)
        end
        -- items.update(dt)
    elseif global_var.var["state"] == "end_game" then
        end_game.update(dt)
    end
end

function love.draw()
    if global_var.var["state"] == "loader" then
        loader.draw()
    elseif global_var.var["state"] == "menu" then
        menu.draw()
    elseif global_var.var["state"] == "transition" then
        transition.draw()
    elseif global_var.var["state"] == "load_game" then
        load_game.draw()
    elseif global_var.var["state"] == "game" then
        love.graphics.setColor(255, 255, 255, 255)
        collision.draw()
        if love.keyboard.isDown("c") then
            inventory.draw()
        end
        -- items.draw()
    elseif global_var.var["state"] == "end_game" then
        end_game.draw()
    end
end
