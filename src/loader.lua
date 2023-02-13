loader = {}

local img = {
    love.graphics.newImage("assets/loader/1_load.png"),
    love.graphics.newImage("assets/loader/TW.png"),
    love.graphics.newImage("assets/loader/2_load.png"),
    love.graphics.newImage("assets/loader/3_load.png"),
    love.graphics.newImage("assets/loader/4_load.png"),
    love.graphics.newImage("assets/loader/5_load.png")
}

local var = {
    ["elapsedTime"] = 0,
    ["transition_duration"] = 10,
    ["index"] = 1,
    ["delay"] = 2,
    ["time"] = love.timer.getTime()
}


function loader.load()
    glob_sfx[1]:setLooping(false)
    glob_sfx[1]:play()
end

function loader.update(dt)
    var["elapsedTime"] = var["elapsedTime"] + dt

    if var["elapsedTime"] >= 1 then
        loader.load()
    end

    if var["elapsedTime"] >= var["transition_duration"] then
        var["index"] = var["index"] + 1
        var["elapsedTime"] = 0
        if var["index"] == 7 then
            global_var.var["state"] = "menu"
            end
    end
end

function loader.draw()
    local opacity = var["elapsedTime"] / var["transition_duration"]

    if love.timer.getTime() - var["time"] > var["delay"] then
        love.graphics.draw(img[var["index"]], 0, 0)
        love.graphics.setColor(0, 0, 0, opacity)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        return
    end
end
