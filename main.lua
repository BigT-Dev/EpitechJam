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

glob_sfx = {
    love.audio.newSource("sounds/loader/loading_theme_song.mp3", "static"),
    love.audio.newSource("sounds/mus/ambiance.mp3", "static"),
    love.audio.newSource("sounds/sfx/typing.mp3", "static"),
    love.audio.newSource("sounds/loader/mouse_click.mp3", "static"),
    love.audio.newSource("sounds/mus/ambiance2.mp3", "static"),
    love.audio.newSource("sounds/sfx/step.mp3", "static"),
    love.audio.newSource("sounds/mus/rain.mp3", "static"),
}

function love.load()
    love.window.setMode(1920, 1080, {fullscreen = true})
    love.window.setTitle("Servietsky")
    inv_close:setLooping(false)
    inv_open:setLooping(false)
    glob_sfx[1]:setLooping(false)
    glob_sfx[2]:setLooping(true)
    glob_sfx[7]:setLooping(true)
    inventory.load()
    collision.load()
    flashlight.load()
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if drawMonster == false and drawDeo == false and drawNivea == false and drawRtx == false then
        gameEnd = true
    end
    if global_var.var["state"] == "loader" then
        loader.update(dt)
    elseif global_var.var["state"] == "menu" then
        menu.update(dt)
    elseif global_var.var["state"] == "transition" then
        glob_sfx[1]:stop()
        love.audio.setVolume(0.12)
        transition.update(dt)
    elseif global_var.var["state"] == "load_game" then
        glob_sfx[5]:play()
        load_game.update(dt)
    elseif global_var.var["state"] == "game" then
        love.audio.setVolume(0.1)
        glob_sfx[5]:stop()
        glob_sfx[2]:play()
        glob_sfx[7]:play()
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
            love.audio.play(inv_open)
            InvState["All"]= true
        end
        if love.keyboard.isDown("x") then
            love.audio.play(inv_close)
            InvState["All"]= false
        end
        if InvState["All"] then
            inventory.draw()
        else
        end
        -- items.draw()
    elseif global_var.var["state"] == "end_game" then
        end_game.draw()
    end
end
