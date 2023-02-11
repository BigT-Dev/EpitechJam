inventory = {}

function inventory.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Servietsky")

    s_inventory = love.graphics.newImage("assets/Inventory.png")
    s_invBullets = love.graphics.newImage("assets/Inv_bullets.png")
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

    InvState = {
        ["Bullets"] = false,
        ["Deo"] = false,
        ["Monster"] = false,
        ["Nerf"] = false,
        ["Nivea"] = false,
        ["Rtx"] = false
    }
    InvSelect = {
        ["Bullets"] = false,
        ["Deo"] = false,
        ["Monster"] = false,
        ["Nerf"] = false,
        ["Nivea"] = false,
        ["Rtx"] = false
    }
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
        InvSelect["Bullets"] = true
    else
        InvSelect["Bullets"] = false
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

function inventory.draw()
    love.graphics.clear(0, 1, 0)
    love.graphics.draw(s_inventory, 0, 0)
    -- If the object is in the inventory
    if InvSelect["Rtx"] then
        love.graphics.draw(s_invSelect1, 0, 0)
    end
    if InvSelect["Deo"] then
        love.graphics.draw(s_invSelect2, 0, 0)
    end
    if InvSelect["Monster"] then
        love.graphics.draw(s_invSelect3, 0, 0)
    end
    if InvSelect["Bullets"] then
        love.graphics.draw(s_invSelect4, 0, 0)
    end
    if InvSelect["Nivea"] then
        love.graphics.draw(s_invSelect5, 0, 0)
    end
    if InvSelect["Nerf"] then
        love.graphics.draw(s_invSelect6, 0, 0)
    end
    -- If the object is in the inventory
    if InvState["Rtx"] then
        love.graphics.draw(s_invRtx, 0, 0)
    end
    if InvState["Deo"] then
        love.graphics.draw(s_invDeo, 0, 0)
    end
    if InvState["Monster"] then
        love.graphics.draw(s_invMonster, 0, 0)
    end
    if InvState["Bullets"] then
        love.graphics.draw(s_invBullets, 0, 0)
    end
    if InvState["Nivea"] then
        love.graphics.draw(s_invNivea, 0, 0)
    end
    if InvState["Nerf"] then
        love.graphics.draw(s_invNerf, 0, 0)
    end
    -- if the left mouse button is pressed, draw the selected object
    if love.mouse.isDown(1) then
        if InvSelect["Rtx"] then
            love.graphics.draw(s_invRtx, 0, 0)
        end
        if InvSelect["Deo"] then
            love.graphics.draw(s_invDeo, 0, 0)
        end
        if InvSelect["Monster"] then
            love.graphics.draw(s_invMonster, 0, 0)
        end
        if InvSelect["Bullets"] then
            love.graphics.draw(s_invBullets, 0, 0)
        end
        if InvSelect["Nivea"] then
            love.graphics.draw(s_invNivea, 0, 0)
        end
        if InvSelect["Nerf"] then
            love.graphics.draw(s_invNerf, 0, 0)
        end
    end
end
