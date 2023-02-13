menu = {}

local sfx = {
    love.audio.newSource("sounds/loader/mouse_click.mp3", "static"),
    love.audio.newSource("sounds/starter.mp3", "static")
}

local img = {
    love.graphics.newImage("assets/menu/menu/1.png"),
    love.graphics.newImage("assets/menu/menu/2.png"),
    love.graphics.newImage("assets/menu/menu/3.png"),
    love.graphics.newImage("assets/menu/menu/4.png")
}

local bouton = {
    love.graphics.newImage("assets/menu/buttons/1.png"),
    love.graphics.newImage("assets/menu/buttons/2.png"),
    love.graphics.newImage("assets/menu/buttons/3.png"),
    love.graphics.newImage("assets/menu/buttons/4.png")
}

local text = {
    love.graphics.newImage("assets/menu/text/1.png"),
    love.graphics.newImage("assets/menu/text/2.png"),
    love.graphics.newImage("assets/menu/text/3.png"),
    love.graphics.newImage("assets/menu/text/4.png")
}

local desc_text = {
    love.graphics.newImage("assets/menu/description/1.png"),
    love.graphics.newImage("assets/menu/description/2.png"),
    love.graphics.newImage("assets/menu/description/3.png"),
    love.graphics.newImage("assets/menu/description/4.png")
}

local animation_p1 = {
    love.graphics.newImage("assets/menu/animation/1.png"),
    love.graphics.newImage("assets/menu/animation/2.png")
}

local animation_p2 = {
    love.graphics.newImage("assets/menu/animation/3.png"),
    love.graphics.newImage("assets/menu/animation/4.png")
}

local animation_p3 = {
    love.graphics.newImage("assets/menu/animation/5.png"),
    love.graphics.newImage("assets/menu/animation/6.png")
}

local animation_p4 = {
    love.graphics.newImage("assets/menu/animation/7.png"),
    love.graphics.newImage("assets/menu/animation/8.png")
}

local var = {
    ["index"] = 1,
    ["button_1.x"] = 500,
    ["button_1.y"] = 500,
    ["button_2.x"] = 1350,
    ["button_2.y"] = 500,
    ["start.x"] = 775,
    ["start.y"] = 700,
    ["set.x"] = 1705,
    ["set.y"] = 890,
    ["exit.x"] = 125,
    ["exit.y"] = 80,
    ["is_exit"] = false,
    ["is_start"] = false,
    ["setting"] = false,
    ["buttonHovered_right"] = false,
    ["buttonHovered_left"] = false,
    ["current_frame"] = 1,
    ["frame_rate"] = 5,
    ["time_since_last_frame"] = 0
}

function menu.manage_animation()
    if var["time_since_last_frame"] > (1 / var["frame_rate"]) then
        var["time_since_last_frame"] = var["time_since_last_frame"] -
            (1 / var["frame_rate"])
                var["current_frame"] = var["current_frame"] + 1
        if var["current_frame"] > #animation_p1 or
                var["current_frame"] > #animation_p2 or
                    var["current_frame"] > #animation_p3 or
                        var["current_frame"] > #animation_p4 then
                            var["current_frame"] = 1
        end
    end
end

function menu.update(dt)
    local x, y = love.mouse.getPosition()
    var["time_since_last_frame"] = var["time_since_last_frame"] + dt

    if x > var["button_1.x"] and x < var["button_1.x"] + 200 and y >
        var["button_1.y"] and y < var["button_1.y"] + 200 then
            var["buttonHovered_left"] = true
    elseif x > var["button_2.x"] and x < var["button_2.x"] + 200 and y >
        var["button_2.y"] and y < var["button_2.y"] + 200 then
            var["buttonHovered_right"] = true
    else
        var["buttonHovered_left"] = false
        var["buttonHovered_right"] = false
    end
    menu.manage_animation()
end

function menu.display_player()
    if (var["index"] == 1) then
        love.graphics.draw(animation_p3[var["current_frame"]], 820, 390)
    end
    if (var["index"] == 2) then
        love.graphics.draw(animation_p4[var["current_frame"]], 820, 390)
    end
    if (var["index"] == 3) then
        love.graphics.draw(animation_p2[var["current_frame"]], 820, 390)
    end
    if (var["index"] == 4) then
        love.graphics.draw(animation_p1[var["current_frame"]], 820, 390)
    end
end

function menu.display_desc()
    if (var["index"] == 1) then
        love.graphics.draw(desc_text[1], 0, 0)
    end
    if (var["index"] == 2) then
        love.graphics.draw(desc_text[3], 0, 0)
    end
    if (var["index"] == 3) then
        love.graphics.draw(desc_text[2], 0, 0)
    end
    if (var["index"] == 4) then
        love.graphics.draw(desc_text[4], 0, 0)
    end
end

function menu.draw_exit()
    if var["exit"] then
        love.graphics.draw(bouton[3], 135, 95, 0, 0.35, 0.35)
        love.event.quit()
    else
        love.graphics.draw(bouton[3], var["exit.x"], var["exit.y"], 0, 0.5, 0.5)
    end
end

function menu.draw_start()
    if var["is_start"] then
        love.graphics.draw(bouton[4], 800,
            800, 0, 0.8, 0.8)
    else
        love.graphics.draw(bouton[4], var["start.x"],
            var["start.x"])
    end
end

function menu.draw()
    love.graphics.print("Menu", 0, 0)
    love.graphics.draw(img[var["index"]], 0, 0)
    love.graphics.draw(bouton[1], var["button_1.x"],
        var["button_1.y"], 0, 0.4, 0.4)
    love.graphics.draw(bouton[2], var["button_2.x"],
        var["button_2.y"], 0, 0.4, 0.4)
    love.graphics.draw(text[var["index"]], 0, 0)
    if var["buttonHovered_left"] then
        love.graphics.draw(bouton[1], 490, 490, 0, 0.5, 0.5)
    end
    if var["buttonHovered_right"] then
        love.graphics.draw(bouton[2], 1350, 490, 0, 0.5, 0.5)
    end
    menu.display_desc()
    menu.display_player()
    menu.draw_start()
    menu.draw_exit()
end

function menu.exit(x, y)
    if x > var["exit.x"] and x < var["exit.x"] + 200 and y >
    var["exit.y"] and y < var["exit.y"] + 200 then
        var["exit"] = true
        sfx[1]:play()
    end
end

function menu.start(x, y)
    if x > var["start.x"] and x < var["start.x"] + 300 and y >
    var["start.y"] and y < var["start.y"] + 300 then
        sfx[1]:play()
        sfx[2]:play()
        if var["index"] == 1 then
            global_var.var["state"] = "transition"
            var["is_start"] = true
        end
        if var["index"] == 2 then
            global_var.var["state"] = "transition"
            var["is_start"] = true
        end
        if var["index"] == 3 then
            global_var.var["state"] = "transition"
            var["is_start"] = true
        end
        if var["index"] == 4 then
            global_var.var["state"] = "transition"
            var["is_start"] = true
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if x > var["button_1.x"] and x < var["button_1.x"] + 200 and y >
        var["button_1.y"] and y < var["button_1.y"] + 200 then
            var["index"] = var["index"] - 1
            sfx[1]:play()
        if var["index"] == 0 then
            var["index"] = 4
        end
    end
    if x > var["button_2.x"] and x < var["button_2.x"] + 200 and y >
        var["button_2.y"] and y < var["button_2.y"] + 200 then
            var["index"] = var["index"] + 1
            sfx[1]:play()
        if var["index"] == 5 then
            var["index"] = 1
        end
    end
    menu.start(x ,y)
    menu.exit(x, y)
end