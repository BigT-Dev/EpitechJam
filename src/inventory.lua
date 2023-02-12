inventory = {}

local mouse_click = love.audio.newSource("assets/sfx//mouse_click.mp3", "static")

InvState = {
    ["ammo"] = false,
    ["Deo"] = false,
    ["Monster"] = false,
    ["Nerf"] = false,
    ["Nivea"] = false,
    ["Rtx"] = false
}

InvSelect = {
    ["ammo"] = false,
    ["Deo"] = false,
    ["Monster"] = false,
    ["Nerf"] = false,
    ["Nivea"] = false,
    ["Rtx"] = false
}

InvNbObj = {
    ["Ammo"] = 0,
    ["Deo"] = 0,
    ["Monster"] = 0,
    ["Nerf"] = 0,
    ["Nivea"] = 0,
    ["Rtx"] = 0
}

function inventory.load()
    s_inventory = love.graphics.newImage("assets/Inventory.png")
    s_invammo = love.graphics.newImage("assets/Inv_bullets.png")
    s_invDeo = love.graphics.newImage("assets/Inv_deo.png")
    s_invMonster = love.graphics.newImage("assets/Inv_monster.png")
    s_invNerf = love.graphics.newImage("assets/Inv_nerf.png")
    s_invNivea = love.graphics.newImage("assets/Inv_nivea.png")
    s_invRtx = love.graphics.newImage("assets/Inv_rtx.png")
    s_invSelect1 = love.graphics.newImage("assets/Inv_select1.png")
    s_invSelect2 = love.graphics.newImage("assets/Inv_select2.png")
    s_invSelect3 = love.graphics.newImage("assets/Inv_select3.png")
    s_invSelect4 = love.graphics.newImage("assets/Inv_select4.png")
    s_invSelect5 = love.graphics.newImage("assets/Inv_select5.png")
    s_invSelect6 = love.graphics.newImage("assets/Inv_select6.png")
    Ammo_desc = love.graphics.newImage("assets/items/Ammo_desc.png")
    Deo_desc = love.graphics.newImage("assets/items/Deo_desc.png")
    Monster_desc = love.graphics.newImage("assets/items/Monster_desc.png")
    Nerf_desc = love.graphics.newImage("assets/items/Nerf_desc.png")
    Nivea_desc = love.graphics.newImage("assets/items/Nivea_desc.png")
    Rtx_desc = love.graphics.newImage("assets/items/CG_desc.png")
    font = love.graphics.newFont("assets/font/Minecraft.ttf", 24)
    love.graphics.setFont(font)
    mouse_click:setLooping(false)
end

function inventory.update(dt)
    local mouseX, mouseY = love.mouse.getPosition()

    -- If mouse is over the inventory
    if mouseX >= 789 and mouseX < 900 and mouseY > 370 and mouseY < 500 then
        InvSelect["Rtx"] = true
    else
        InvSelect["Rtx"] = false
    end
    if mouseX >= 906 and mouseX < 1015 and mouseY > 370 and mouseY < 500 then
        InvSelect["Deo"] = true
    else
        InvSelect["Deo"] = false
    end
    if mouseX >= 1021 and mouseX < 1130 and mouseY > 370 and mouseY < 500 then
        InvSelect["Monster"] = true
    else
        InvSelect["Monster"] = false
    end
    if mouseX >= 789 and mouseX < 900 and mouseY > 504 and mouseY < 633 then
        InvSelect["ammo"] = true
    else
        InvSelect["ammo"] = false
    end
    if mouseX >= 906 and mouseX < 1015 and mouseY > 504 and mouseY < 633 then
        InvSelect["Nivea"] = true
    else
        InvSelect["Nivea"] = false
    end
    if mouseX >= 1021 and mouseX < 1130 and mouseY > 504 and mouseY < 633 then
        InvSelect["Nerf"] = true
    else
        InvSelect["Nerf"] = false
    end
end

function inventory.desc_draw()
    -- if the mouse is over the item, draw the description
    local mouseX, mouseY = love.mouse.getPosition()

    if mouseX >= 789 and mouseX < 900 and mouseY > 370 and mouseY < 500
    and InvState["Rtx"] then
        love.graphics.draw(Rtx_desc, 793, 654)
        love.graphics.draw(s_invSelect1)
    else
    end
    if mouseX >= 906 and mouseX < 1015 and mouseY > 370 and mouseY < 500
    and InvState["Deo"] then
        love.graphics.draw(Deo_desc, 793, 654)
        love.graphics.draw(s_invSelect2)
    else
    end
    if mouseX >= 1021 and mouseX < 1130 and mouseY > 370 and mouseY < 500
    and InvState["Monster"] then
        love.graphics.draw(Monster_desc, 793, 654)
        love.graphics.draw(s_invSelect3)
    else
    end
    if mouseX >= 789 and mouseX < 900 and mouseY > 504 and mouseY < 633
    and InvState["ammo"] then
        love.graphics.draw(Ammo_desc, 793, 654)
        love.graphics.draw(s_invSelect4)
    else
    end
    if mouseX >= 906 and mouseX < 1015 and mouseY > 504 and mouseY < 633
    and InvState["Nivea"] then
        love.graphics.draw(Nivea_desc, 793, 654)
        love.graphics.draw(s_invSelect5)
    else
    end
    if mouseX >= 1021 and mouseX < 1130 and mouseY > 504 and mouseY < 633
    and InvState["Nerf"] then
        love.graphics.draw(Nerf_desc, 793, 654)
        love.graphics.draw(s_invSelect6)
    else
    end
end

function inventory.draw()
    love.graphics.clear(0, 1, 0)
    love.graphics.draw(s_inventory, 0, 0)
    if InvState["Rtx"] then
        love.graphics.draw(s_invRtx, 0, 0)
        love.graphics.print(InvNbObj["Rtx"], 880, 378)
    end
    if InvState["Deo"] then
        love.graphics.draw(s_invDeo, 0, 0)
        love.graphics.print(InvNbObj["Deo"], 997, 378)
    end
    if InvState["Monster"] then
        love.graphics.draw(s_invMonster, 0, 0)
        love.graphics.print(InvNbObj["Monster"], 1113, 378)
    end
    if InvState["ammo"] then
        love.graphics.draw(s_invammo, 0, 0)
        love.graphics.print(InvNbObj["Ammo"], 880, 515)
    end
    if InvState["Nivea"] then
        love.graphics.draw(s_invNivea, 0, 0)
        love.graphics.print(InvNbObj["Nivea"], 997, 515)
    end
    if InvState["Nerf"] then
        love.graphics.draw(s_invNerf, 0, 0)
        love.graphics.print(InvNbObj["Nerf"], 1113, 515)
    end
    inventory.desc_draw()
end