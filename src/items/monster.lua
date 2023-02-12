monster = {}

local pick = love.audio.newSource("assets/sfx/item_pick1.mp3", "static")

local animation_m = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/Monster.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

monster_1 = {
  ["x"] = 200,
  ["y"] = 200,
  ["hitbox_x"] = 100,
  ["hitbox_y"] = 100,
  ["is_find"] = false,
  ["is_coll"] = false,
  draw = function(self)
    if (player.x - love.graphics.getWidth() / 2) < self["x"] and
    (player.x + love.graphics.getWidth() / 2) > self["x"] and
    (player.y - love.graphics.getHeight() / 2) < self["y"] and
    (player.y + love.graphics.getHeight() / 2) > self["y"] then

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(img[1], self["x"], self["y"])
    love.graphics.setColor(255, 255, 255, 0)
    love.graphics.rectangle("line", self["x"], self["y"],
      self["hitbox_x"], self["hitbox_y"])
  end
end
}
monster_2 = {
  ["x"] = 500,
  ["y"] = 500,
  ["hitbox_x"] = 100,
  ["hitbox_y"] = 100,
  ["is_find"] = false,
  ["is_coll"] = false,
  draw = function(self)
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(img[1], self["x"], self["y"])
      love.graphics.setColor(255, 255, 255, 0)
      love.graphics.rectangle("line", self["x"], self["y"],
        self["hitbox_x"], self["hitbox_y"])
  end,
}
monster_3 = {
  ["x"] = 900,
  ["y"] = 900,
  ["hitbox_x"] = 100,
  ["hitbox_y"] = 100,
  ["is_find"] = false,
  ["is_coll"] = false,
  draw = function(self)
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(img[1], self["x"], self["y"])
      love.graphics.setColor(255, 255, 255, 0)
      love.graphics.rectangle("line", self["x"], self["y"],
        self["hitbox_x"], self["hitbox_y"])
  end,
}

monster_list = {monster_1, monster_2, monster_3}

function monster.manage_animation(dt)
  var["time_since_last_frame"] = var["time_since_last_frame"] + dt

  if var["time_since_last_frame"] > (1 / var["frame_rate"]) then
      var["time_since_last_frame"] = var["time_since_last_frame"] -
          (1 / var["frame_rate"])
              var["current_frame"] = var["current_frame"] + 1
      if var["current_frame"] > #animation_m then
          var["current_frame"] = 1
      end
  end
end

function monster.update(dt)
  for i = 1, #monster_list do
    if (checkrange(player.x, player.y, 40, 40, monster_list[i]["x"],
            monster_list[i]["y"], monster_list[i]["hitbox_x"],
                monster_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        monster_list[i]["is_find"] == false then
                            monster_list[i]["is_find"] = true
                            InvState["Monster"] = true
                            InvNbObj["Monster"] = InvNbObj["Monster"] + 1
                            if not pick:isPlaying() then
                              love.audio.play(pick)
                            end
    end
    if (checkrange(player.x, player.y, 10000, 10000, monster_list[i]["x"],
    monster_list[i]["y"], monster_list[i]["hitbox_x"],
        monster_list[i]["hitbox_y"])) and
              monster_list[i]["is_find"] == false then
                  monster_list[i]["is_coll"] = true
    else
      monster_list[i]["is_coll"] = false
    end
  end
  monster.manage_animation(dt)
end

function monster.draw()
  for i = 1, #monster_list do
    if monster_list[i]["is_coll"] == false then
    else
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(animation_m[var["current_frame"]], monster_list[i]["x"] - 12,
        monster_list[i]["y"] - 65)
        monster_list[i]:draw()
    end
  end
  -- for i = 1, #monster_list do
    -- if monster_list[i]["is_find"] then
    -- else
    -- end
  -- end
end