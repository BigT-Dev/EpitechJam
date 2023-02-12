flashlight = {}

local blackShader = love.graphics.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        return vec4(0, 0, 0, 0.9436);
    }
]])

function flashlight:load()

    light = {}
    light.x = player.x
    light.y = player.y
    light.lightImage = love.graphics.newImage("assets/light.png")
    light.isOn = true
    light.angle = 0
    light.isThundering = false
    return
end


function flashlight:draw()
    if (light.isOn) then
        love.graphics.stencil(function()
            love.graphics.draw(light.lightImage, light.x, light.y, light.angle, 4, 1, 0, light.lightImage:getHeight() / 2)
        end, "replace", 1)
        love.graphics.setStencilTest("equal", 0)
    elseif (light.isThundering == false) then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end
    if (light.isThundering == false) then
        love.graphics.setShader(blackShader)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setShader()
        love.graphics.setStencilTest()
    end
    light.isThundering = false
end


function flashlight:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    light.x = player.x
    light.y = player.y
    light.angle = math.atan2(mouseY - light.y, mouseX - light.x)
end

function flashlight:thunder()
    light.isThundering = true
end

function flashlight:toggle()
    light.isOn = not light.isOn
end