items = {}

function checkrange(ax1, ay1, aw, ah, bx1, by1, bw, bh)
    local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
    return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function items.update(dt)
    deo.update(dt)
    monster.update(dt)
    rtx.update(dt)
    nivea.update(dt)
    ammo.update(dt)
    nerf.update(dt)
end

function items.draw()
    deo.draw()
    monster.draw()
    rtx.draw()
    nivea.draw()
    ammo.draw()
    nerf.draw()
end