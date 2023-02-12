collision = {}
local json = require("dkjson")

function collision.load()
    -- Lire le contenu du fichier JSON local
    local contents, size = love.filesystem.read("rectangles.json")
    -- Conversion du contenu du fichier JSON en tableau Lua
    local data = json.decode(contents)
    -- Création des objets de test
    player = {x = 250, y = 230, width = 64, height = 64}
    rects = {}
    for i = 1, #data do
        local rect = {x = data[i].x, y = data[i].y, width = data[i].width, height = data[i].height}
        table.insert(rects, rect)
    end
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

    --vérification de la collision avec le rectangle B
    for i = 1, #rects do
        if checkCollision(newX, newY, player.width, player.height, rects[i].x, rects[i].y, rects[i].width, rects[i].height) then
            --si il y a collision, on ne déplace pas le cercle
            newX = player.x
            newY = player.y
        end
    end

    player.x = newX
    player.y = newY
end

function collision.draw()
    --dessin des rectangles de test
    love.graphics.setColor(255, 125, 125)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    -- draw all rect collision
    for i = 1, #rects do
        love.graphics.setColor(125, 0, 125)
        love.graphics.rectangle("fill", rects[i].x, rects[i].y, rects[i].width, rects[i].height)
    end
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
