collision = {}
local json = require("dkjson")

function collision.load()
  s_map = love.graphics.newImage("assets/Map.png")
  -- Lire le contenu du fichier JSON local
  local contents, size = love.filesystem.read("rectangles.json")
  -- Conversion du contenu du fichier JSON en tableau Lua
  local data = json.decode(contents)
  -- Création des objets de test
  player = {x = 1321, y = 2214, width = 32, height = 32}
  rects = {}
  for i = 1, #data do
      local rect = {x = data[i].x, y = data[i].y, width = data[i].width, height = data[i].height}
      table.insert(rects, rect)
  end

  animation = require 'libraries/animation'
  camera = require 'libraries/camera'
  cam = camera()
  cam.scale = 2

  love.player()
end

function collision.update(dt)
  --position souhaitée du rectangle A
  local newX = player.x
  local newY = player.y

  --gestion des déplacements du cercle avec les flèches du clavier
  if love.keyboard.isDown("d") then
    newX = player.x + 400 * dt
  end
  if love.keyboard.isDown("q") then
    newX = player.x - 400 * dt
  end
  if love.keyboard.isDown("z") then
    newY = player.y - 400 * dt
  end
  if love.keyboard.isDown("s") then
    newY = player.y + 400 * dt
  end
  -- if love.keyboard.isDown("left") then
  --   player.x = player.x - 60 * 0.07
  -- end
  -- if love.keyboard.isDown("right") then
  --     player.x = player.x + 60 * 0.07
  -- end
  -- if love.keyboard.isDown("up") then
  --     player.y = player.y - 60 * 0.07
  -- end
  -- if love.keyboard.isDown("down") then
  --     player.y = player.y + 60 * 0.07
  -- end

  for i = 1, #rects do
    if checkCollision(newX, newY, player.width, player.height, rects[i].x, rects[i].y, rects[i].width, rects[i].height) then
        --si il y a collision, on ne déplace pas le cercle
        newX = player.x
        newY = player.y
    end
  end

  player.x = newX
  player.y = newY

  player.animations.down:update(dt)

  cam:lookAt(player.x, player.y)
  love.camtrack()
  love.angle()
end

function collision.draw()
  cam:attach()
    love.graphics.draw(s_map, 0, 0, 0, 1, 1)
    love.angle()
    -- --dessin des rectangles de test
    -- love.graphics.setColor(255, 125, 125)
    -- love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    -- flashlight.draw()
  cam:detach()
end

  --fonction de détection de collisions entre rectangles
function checkCollision(ax, ay, aw, ah, bx, by, bw, bh)
  -- Calcul des coordonnées des bords du rectangle
  local left = ax
  local right = ax + aw
  local top = ay
  local bottom = ay + ah

  -- Vérification de la collision
  if left > bx + bw or right < bx or top > by + bh or bottom < by then
    return false
  else
    return true
  end
end

function love.player()

  player[1] = ("sprite/Thanatos.png")
  player[2] = ("sprite/Chinese.png")
  player[3] = ("sprite/DCs_Guardian.png")
  player[4] = ("sprite/Master_Legend.png")


  player.spritesheet = love.graphics.newImage(player[4])
  player.grid = animation.newGrid(64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
  player.animations = {}
  player.animations.down = animation.newAnimation (player.grid('1-2', 1), 0.25)

end

function love.angle()
  local mouseX, mouseY = love.mouse.getPosition()
  local angle = math.atan2(player.y - mouseY, player.x - mouseX ) * 2.5
  player.animations.down:draw(player.spritesheet, player.x, player.y, angle, nil, nil, 32, 32)
end

function love.camtrack()

  local width = love.graphics.getWidth()
  local Height = love.graphics.getHeight()

  if cam.x > (2* width/4) then
      cam.x = (2* width/4)
  end

  if cam.x < (width/4) then
      cam.x = (width/4)
  end

  if cam.y < (Height/4) then
      cam.y = (Height/4)
  end

  if cam.y > (7.3* Height/4) then
      cam.y = (7.3* Height/4)
  end

end