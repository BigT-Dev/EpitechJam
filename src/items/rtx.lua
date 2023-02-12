rtx = {}

local pick = love.audio.newSource("assets/sfx/item_pick1.mp3", "static")

local animation_e = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/Rtx.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

rtx_1 = {
  ["x"] = 800,
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
rtx_2 = {
  ["x"] = 800,
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
rtx_3 = {
  ["x"] = 1200,
  ["y"] = 1000,
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

rtx_list = {rtx_1, rtx_2, rtx_3}

function rtx.manage_animation(dt)
  var["time_since_last_frame"] = var["time_since_last_frame"] + dt

  if var["time_since_last_frame"] > (1 / var["frame_rate"]) then
      var["time_since_last_frame"] = var["time_since_last_frame"] -
          (1 / var["frame_rate"])
              var["current_frame"] = var["current_frame"] + 1
      if var["current_frame"] > #animation_e then
          var["current_frame"] = 1
      end
  end
end

function rtx.update(dt)
  for i = 1, #rtx_list do
    if (checkrange(player.x, player.y, 40, 40, rtx_list[i]["x"],
            rtx_list[i]["y"], rtx_list[i]["hitbox_x"],
                rtx_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        rtx_list[i]["is_find"] == false then
                            rtx_list[i]["is_find"] = true
                            InvState["Rtx"] = true
                            InvNbObj["Rtx"] = InvNbObj["Rtx"] + 1
                            if not pick:isPlaying() then
                              love.audio.play(pick)
                            end
    end
    if (checkrange(player.x, player.y, 100, 100, rtx_list[i]["x"],
    rtx_list[i]["y"], rtx_list[i]["hitbox_x"],
        rtx_list[i]["hitbox_y"])) and
              rtx_list[i]["is_find"] == false then
                  rtx_list[i]["is_coll"] = true
    else
      rtx_list[i]["is_coll"] = false
    end
  end
  rtx.manage_animation(dt)
end

function rtx.draw()
  for i = 1, #rtx_list do
    if rtx_list[i]["is_coll"] == false then
    else
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(animation_e[var["current_frame"]], rtx_list[i]["x"] - 12,
            rtx_list[i]["y"] - 65)
    end
  end
  for i = 1, #rtx_list do
    if rtx_list[i]["is_find"] then
    else
      rtx_list[i]:draw()
    end
  end
end