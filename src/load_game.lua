load_game = {}

local var = {
    ["text"] = "Bonsoir c'est Marvin,\nabsolument tout les objets qui permettaient\nle bon fonctionnement de l'ecole ont etes caches.\nIl y a 6 objets differents a trouver,\nmais bien plus en tout.\n\n\nBon courage et moi\nje vais aller me coucher.",
    ["font"] = love.graphics.newFont("assets/fonts/Minecraft.ttf", 30),
    ["img"] = love.graphics.newImage("assets/load_game/m_phone.png"),
    ["text_key"] = "Apuyer sur la touche 'E' pour continuer",
    ["char_index"] = 1,
    ["char_timer"] = 0,
    ["delay_timer_text"] = 3,
    ["delay_timer_key"] = 6,
    ["width"] = 1920,
    ["height"] = 1080,
    ["rectX"] = 1920 / 2,
    ["rectY"] = 1080,
    ["rectWidth"] = 300,
    ["rectHeight"] = 500
}

function load_game.move_rect(dt)
    var["rectY"] = var["rectY"] - 200 * dt
    if var["rectY"] < var["height"] / 2 then
        var["rectY"] = var["height"] / 2
    end
end

function load_game.write_text_marvin(dt)
    glob_sfx[3]:setLooping(true)

    if var["delay_timer_text"] > 0 then
        var["delay_timer_text"] = var["delay_timer_text"] - dt
      else
        glob_sfx[3]:play()
        var["char_timer"] = var["char_timer"] + dt
        if var["char_timer"] >= 0.1 then
          var["char_index"] = var["char_index"] + 1
          var["char_timer"] = 0
        end
    end
end

function load_game.write_push(dt)
    if var["delay_timer_key"]  > 0 then
        var["delay_timer_key"] = var["delay_timer_key"]  - dt
    else
        var["char_timer"] = var["char_timer"] + dt
        if var["char_timer"] >= 0.1 then
          var["char_index"] = var["char_index"] + 1
          var["char_timer"] = 0
        end
    end
end

function load_game.update(dt)
    var["char_timer"] = var["char_timer"] + dt

    load_game.move_rect(dt)
    load_game.write_text_marvin(dt)
    load_game.write_push(dt)

    if love.keyboard.isDown("e") then
        glob_sfx[3]:stop()
        global_var.var["state"] = "game"
    end
end

function load_game.draw()
    love.graphics.setFont(var["font"])
    love.graphics.draw(var["img"], var["rectX"] - var["rectWidth"] / 2,
        var["rectY"] - var["rectHeight"] / 2)
    if var["delay_timer_text"] <= 0 then
        love.graphics.print(string.sub(var["text"], 1,
            var["char_index"]), 1150, 320)
    end
    if var["delay_timer_key"] <= 0 then
        love.graphics.print(string.sub(var["text_key"], 1,
            var["char_index"]), 680, 800)
    end
end