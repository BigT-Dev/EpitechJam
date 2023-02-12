end_game = {}

local var = {
    ["story"] = "Merci d'avoir joue a ce jeu !\n\nMerci a nos developpeurs, beatmakers et graphistes !\n\nGrace a vous, en seulement 2 jours nous avons pu creer ce jeu !\n\nCredits:\n\n Batoule Damene \n\n Sasha Dupeyroux \n\n Mathis Evain \n\n Timothee Lessellier aka le best des postes \n\n Thomas Rochefeuille \n",
    ["delay_timer"] = 3,
    ["char_index"] = 1,
    ["char_timer"] = 0,
    ["font"] = love.graphics.newFont("assets/fonts/Minecraft.ttf", 30)
}

function end_game.update(dt)
    if var["delay_timer"] > 0 then
        var["delay_timer"] = var["delay_timer"] - dt
    else
        var["char_timer"] = var["char_timer"] + dt
        if var["char_timer"] >= 0.1 then
            var["char_index"] = var["char_index"] + 1
            var["char_timer"] = 0
        end
    end
end

function end_game.draw()
    love.graphics.setFont(var["font"])
    if var["delay_timer"] <= 0 then
        love.graphics.print(string.sub(var["story"], 1, var["char_index"]), 100, 100)
    end
end
