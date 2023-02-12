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
    local posShaderx = player.x - love.graphics.getWidth() / 2
    local posShadery = player.y - love.graphics.getHeight() / 2

    local posLightx = player.x + player.width / 2
    local posLighty = player.y + player.height / 2

    if light.isOn then
        love.graphics.stencil(function()
            love.graphics.draw(light.lightImage, posLightx, posLighty, light.angle, 4, 1, 0, light.lightImage:getHeight() / 2)
        end, "replace", 1)
        love.graphics.setStencilTest("equal", 0)
        love.graphics.setShader(blackShader)
        love.graphics.rectangle("fill", posShaderx, posShadery, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setShader()
        love.graphics.setStencilTest()
    else
        love.graphics.setColor(0, 0, 0, 0.9436)
        love.graphics.rectangle("fill", posShaderx, posShadery, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function flashlight:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()

    -- Position relative du joueur par rapport à l'écran
    local posPlayerRelativeX = love.graphics.getWidth() / 2
    local posPlayerRelativeY = love.graphics.getHeight() / 2
    mouseX = mouseX
    mouseY = mouseY

    light.angle = math.atan2(mouseY - posPlayerRelativeY, mouseX - posPlayerRelativeX)
end

function flashlight:thunder()
    light.isThundering = true
end

function flashlight:toggle()
    light.isOn = not light.isOn
end