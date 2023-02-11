Flashlight = {}

local blackShader = love.graphics.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        return vec4(0, 0, 0, 1);
    }
]])

function Flashlight:load(x, y)
    love.window.setMode(1080, 720)
    love.window.setTitle("Servietsky")

    self.x = x
    self.y = y
    self.lightImage = love.graphics.newImage("assets/light.png")
    self.isOn = true
    self.angle = 0
    return
end


function Flashlight:draw()
    if self.isOn then
        love.graphics.stencil(function()
            love.graphics.draw(self.lightImage, self.x, self.y, self.angle, 4, 1, 0, self.lightImage:getHeight() / 2)
        end, "replace", 1)
        love.graphics.setStencilTest("equal", 0)
        love.graphics.setShader(blackShader)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setShader()
        love.graphics.setStencilTest()
    else
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end
end


function Flashlight:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self.angle = math.atan2(mouseY - self.y, mouseX - self.x)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
end

function Flashlight:toggle()
    self.isOn = not self.isOn
end
