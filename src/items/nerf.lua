nerf = {}

local animation_m = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/nerf.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

nerf_1 = {
  ["x"] = 900,
  ["y"] = 200,
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
nerf_2 = {
  ["x"] = 1200,
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
nerf_3 = {
  ["x"] = 1500,
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

nerf_list = {nerf_1, nerf_2, nerf_3}

function nerf.manage_animation(dt)
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

function nerf.update(dt)
  for i = 1, #nerf_list do
    if (checkrange(player.x, player.y, 40, 40, nerf_list[i]["x"],
            nerf_list[i]["y"], nerf_list[i]["hitbox_x"],
                nerf_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        nerf_list[i]["is_find"] == false then
                            nerf_list[i]["is_find"] = true
                            InvState["Nerf"] = true
                            InvNbObj["Nerf"] = InvNbObj["Nerf"] + 1
    end
    if (checkrange(player.x, player.y, 100, 100, nerf_list[i]["x"],
    nerf_list[i]["y"], nerf_list[i]["hitbox_x"],
        nerf_list[i]["hitbox_y"])) and
              nerf_list[i]["is_find"] == false then
                  nerf_list[i]["is_coll"] = true
    else
      nerf_list[i]["is_coll"] = false
    end
  end
  nerf.manage_animation(dt)
end

function nerf.draw()
  for i = 1, #nerf_list do
    if nerf_list[i]["is_coll"] == false then
    else
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(animation_m[var["current_frame"]], nerf_list[i]["x"] - 12,
          nerf_list[i]["y"] - 65)
    end
  end
  for i = 1, #nerf_list do
    if nerf_list[i]["is_find"] then
    else
      nerf_list[i]:draw()
    end
  end
end