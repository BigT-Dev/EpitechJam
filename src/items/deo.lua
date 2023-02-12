deo = {}

local animation_m = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/Deo.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

deodorant_1 = {
  ["x"] = 100,
  ["y"] = 100,
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
deodorant_2 = {
  ["x"] = 400,
  ["y"] = 400,
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
deodorant_3 = {
  ["x"] = 800,
  ["y"] = 800,
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

deodorant_list = {deodorant_1, deodorant_2, deodorant_3}

function deo.manage_animation(dt)
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

function deo.update(dt)
  for i = 1, #deodorant_list do
    if (checkrange(player.x, player.y, 40, 40, deodorant_list[i]["x"],
            deodorant_list[i]["y"], deodorant_list[i]["hitbox_x"],
                deodorant_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        deodorant_list[i]["is_find"] == false then
                            deodorant_list[i]["is_find"] = true
                            InvState["Deo"] = true
                            InvNbObj["Deo"] = InvNbObj["Deo"] + 1
    end
    if (checkrange(player.x, player.y, 100, 100, deodorant_list[i]["x"],
    deodorant_list[i]["y"], deodorant_list[i]["hitbox_x"],
        deodorant_list[i]["hitbox_y"])) and
              deodorant_list[i]["is_find"] == false then
                  deodorant_list[i]["is_coll"] = true
    else
      deodorant_list[i]["is_coll"] = false
    end
  end
  deo.manage_animation(dt)
end

function deo.draw()
  for i = 1, #deodorant_list do
    if deodorant_list[i]["is_coll"] == false then
    else
      love.graphics.draw(animation_m[var["current_frame"]], deodorant_list[i]["x"] - 12,
        deodorant_list[i]["y"] - 65)
    end
  end
  for i = 1, #deodorant_list do
    if deodorant_list[i]["is_find"] then
    else
      deodorant_list[i]:draw()
    end
  end
end