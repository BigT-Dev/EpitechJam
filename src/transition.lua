transition = {}

local img = {
    love.graphics.newImage("assets/loader/1_load.png"),
}

local var = {
    ["elapsedTime"] = 0,
    ["transition_duration"] = 10,
    ["index"] = 1,
    ["delay"] = 2,
    ["time"] = love.timer.getTime()
}

function transition.update(dt)
    var["elapsedTime"] = var["elapsedTime"] + dt

    if var["elapsedTime"] >= var["transition_duration"] then
        var["elapsedTime"] = 0
        if var["index"] == 1 then
            global_var.var["state"] = "load_game"
        end
    end
end

function transition.draw()
    local opacity = var["elapsedTime"] / var["transition_duration"]

    if love.timer.getTime() - var["time"] > var["delay"] then
        love.graphics.draw(img[var["index"]], 0, 0)
        love.graphics.setColor(0, 0, 0, opacity)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        return
    end
end