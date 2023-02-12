nivea = {}

local pick = love.audio.newSource("assets/sfx/item_pick1.mp3", "static")

local animation_m = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/Nivea.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

nivea_1 = {
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
nivea_2 = {
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
nivea_3 = {
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

nivea_list = {nivea_1, nivea_2, nivea_3}

function nivea.manage_animation(dt)
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

function nivea.update(dt)
  for i = 1, #nivea_list do
    if (checkrange(player.x, player.y, 40, 40, nivea_list[i]["x"],
            nivea_list[i]["y"], nivea_list[i]["hitbox_x"],
                nivea_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        nivea_list[i]["is_find"] == false then
                            nivea_list[i]["is_find"] = true
                            InvState["Nivea"] = true
                            InvNbObj["Nivea"] = InvNbObj["Nivea"] + 1
                            if not pick:isPlaying() then
                              love.audio.play(pick)
                            end
    end
    if (checkrange(player.x, player.y, 100, 100, nivea_list[i]["x"],
    nivea_list[i]["y"], nivea_list[i]["hitbox_x"],
        nivea_list[i]["hitbox_y"])) and
              nivea_list[i]["is_find"] == false then
                  nivea_list[i]["is_coll"] = true
    else
      nivea_list[i]["is_coll"] = false
    end
  end
  nivea.manage_animation(dt)
end

function nivea.draw()
  for i = 1, #nivea_list do
    if nivea_list[i]["is_coll"] == false then
    else
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(animation_m[var["current_frame"]], nivea_list[i]["x"] - 12,
          nivea_list[i]["y"] - 65)
    end
  end
  for i = 1, #nivea_list do
    if nivea_list[i]["is_find"] then
    else
      nivea_list[i]:draw()
    end
  end
end