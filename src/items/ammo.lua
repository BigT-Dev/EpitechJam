ammo = {}

local pick = love.audio.newSource("assets/sfx/item_pick3.mp3", "static")

local animation_m = {
  love.graphics.newImage("assets/items/interact_frame_1.png"),
  love.graphics.newImage("assets/items/interact_frame_2.png")
}

local img = {
  love.graphics.newImage("assets/items/Bullets.png")
}

local var = {
  ["current_frame"] = 1,
  ["frame_rate"] = 5,
  ["time_since_last_frame"] = 0
}

ammo_1 = {
  ["x"] = 100,
  ["y"] = 100,
  ["hitbox_x"] = 100,
  ["hitbox_y"] = 100,
  ["is_find"] = false,
  ["is_coll"] = false,
  draw = function(self)

    if (player.x - love.graphics.getWidth() / 2) < self["x"] and
        (player.x + love.graphics.getWidth() / 2) > self["x"] and
        (player.y - love.graphics.getHeight() / 2) < self["y"] and
        (player.y + love.graphics.getHeight() / 2) > self["y"] then

    end
    --love.graphics.setColor(255, 255, 255, 255)
    --love.graphics.draw(img[1], self["x"], self["y"])
    --love.graphics.setColor(255, 255, 255, 0)
    --love.graphics.rectangle("line", self["x"], self["y"],
      --self["hitbox_x"], self["hitbox_y"])

  end,
}
ammo_2 = {
  ["x"] = 1345,
  ["y"] = 2134,
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
ammo_3 = {
  ["x"] = 1300,
  ["y"] = 2134,
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
      pick:setLooping(false)
  end
}

ammo_list = {ammo_1, ammo_2, ammo_3}

function ammo.manage_animation(dt)
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

function ammo.update(dt)
  for i = 1, #ammo_list do
    if (checkrange(player.x, player.y, 40, 40, ammo_list[i]["x"],
            ammo_list[i]["y"], ammo_list[i]["hitbox_x"],
                ammo_list[i]["hitbox_y"])) and
                    love.keyboard.isDown("e") and
                        ammo_list[i]["is_find"] == false then
                            ammo_list[i]["is_find"] = true
                            InvState["ammo"] = true
                            InvNbObj["Ammo"] = InvNbObj["Ammo"] + 1
                            if not pick:isPlaying() then
                              love.audio.play(pick)
                            end
    end
    if (checkrange(player.x, player.y, 100, 100, ammo_list[i]["x"],
    ammo_list[i]["y"], ammo_list[i]["hitbox_x"],
        ammo_list[i]["hitbox_y"])) and
              ammo_list[i]["is_find"] == false then
                  ammo_list[i]["is_coll"] = true
    else
      ammo_list[i]["is_coll"] = false
    end
  end
  ammo.manage_animation(dt)
end

function ammo.draw()
  for i = 1, #ammo_list do
    if ammo_list[i]["is_coll"] == false then
    else
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(animation_m[var["current_frame"]], ammo_list[i]["x"] - 12,
          ammo_list[i]["y"] - 65)
    end
  end
  for i = 1, #ammo_list do
    if ammo_list[i]["is_find"] then
    else
      ammo_list[i]:draw()
    end
  end
end