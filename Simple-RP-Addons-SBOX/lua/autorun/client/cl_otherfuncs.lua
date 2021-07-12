--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

function box(r, x, y, w, h, c)
    
    draw.RoundedBox(r, x, y, w, h, c)

end

function rect(m, x, y, w, h, c)

    if m == nil then
        
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)
    
    else
    
        surface.SetMaterial(Material(m))
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)

    end

end

function icon(m, x, y, w, h, c)
    
    surface.SetMaterial(Material(m))
    surface.SetDrawColor(c)
    surface.DrawTexturedRect(x, y, w, h)

end

function text(s, f, x, y, c, aX, aY)
    
    if aY == nil then

        draw.SimpleText(s, f, x + 1, y + 1, Color(c.r - 150, c.g - 150, c.b - 150, c.a), aX)
        draw.SimpleText(s, f, x, y, c, aX)

    else
        
        draw.SimpleText(s, f, x, y, c, aX, aY)
        draw.SimpleText(s, f, x + 1, y + 1, Color(c.r - 150, c.g - 150, c.b - 150, c.a), aX, aY)

    end

end

function circle(x, y, radius, seg, col)

    surface.SetDrawColor(col)

    local cir = {}

    table.insert(cir, {x = x, y = y, u = 0.5, v = 0.5})
    
    for i = 0, seg do
        
        local a = math.rad((i / seg) * -360)
        table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5})
    
    end

    local a = math.rad(0)
    table.insert(cir, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5})

    surface.DrawPoly(cir)

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--