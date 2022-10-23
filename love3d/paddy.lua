--[[
 paddy - an onscreen controller display for touch enabled devices


 * Copyright (C) 2017 Ricky K. Thomson
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * u should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 --]]

 local paddy = {}
 paddy.debug = true

 paddy.OS1 = 'Android'
 paddy.OS2 = 'iOS'
 
 -- The size of the buttons which can be pressed.
 paddy.buttonw = 50
 paddy.buttonh = 50
 
 
 -- This lists any buttons which are currently being pressed
 paddy.touched = {}
 
 -- Create a dpad widget
 paddy.dpad = {}
 
 -- The properties of the canvas to draw
 paddy.dpad.w = paddy.buttonw*3
 paddy.dpad.h = paddy.buttonh*3
 paddy.dpad.x = 20
 paddy.dpad.y = love.graphics.getHeight()-20-paddy.dpad.h
 paddy.dpad.canvas = love.graphics.newCanvas(paddy.dpad.w,paddy.dpad.h)
 
 -- These just make things look prettier
 paddy.dpad.opacity = 200
 paddy.dpad.padding = 5
 
 -- Setup the names for the buttons, and their position on the canvas
 paddy.dpad.buttons = {
     { name="up",   x=paddy.buttonw, y=0 },
     { name="left", x=0, y=paddy.buttonh },
     { name="right",x=paddy.buttonw*2, y=paddy.buttonh },
     { name="down", x=paddy.buttonw, y=paddy.buttonh*2 },
 }
 
 
 -- Create a buttons widget
 paddy.buttons = {}
 
 -- The properties of the canvas to draw
 paddy.buttons.w = paddy.buttonw*3
 paddy.buttons.h = paddy.buttonh*3
 paddy.buttons.x = love.graphics.getWidth()-20-paddy.buttons.w
 paddy.buttons.y = love.graphics.getHeight()-20-paddy.buttons.h
 paddy.buttons.canvas = love.graphics.newCanvas(paddy.buttons.w,paddy.buttons.h)
 
 -- These just make things look prettier
 paddy.buttons.opacity = 200
 paddy.buttons.padding = 5
 
 -- Setup the names for the buttons, and their position on the canvas
 paddy.buttons.buttons = {
     { name="y", x=paddy.buttonw, y=0 },
     { name="x", x=0, y=paddy.buttonh },
     { name="b", x=paddy.buttonw*2, y=paddy.buttonh },
     { name="a", x=paddy.buttonw, y=paddy.buttonh*2 },
 }
 
 -- Stores any widgets containing interactive buttons
 paddy.widgets = { paddy.dpad, paddy.buttons }
 
 
 function paddy.draw()
    if love.system.getOS() == paddy.OS1
    or love.system.getOS() == paddy.OS2
    then
        -- Draw the control pad
        for _,widget in ipairs(paddy.widgets) do
            love.graphics.setColor(0.607,0.607,0.607,0.196)
            love.graphics.circle("fill", widget.x+widget.w/2,widget.y+widget.h/2,widget.w/2)
    
            love.graphics.setCanvas(widget.canvas)
            love.graphics.clear()
        
            love.graphics.setColor(0.607,0.607,0.607,1)
        
    
            for _,button in ipairs(widget.buttons) do
                if button.isDown then
                    love.graphics.setColor(0.607,0.607,0.607,1)
                    love.graphics.rectangle("fill", 
                        button.x+widget.padding, 
                        button.y+widget.padding, 
                        paddy.buttonw-widget.padding*2, 
                        paddy.buttonh-widget.padding*2,
                        10
                    )
                else
                    love.graphics.setColor(0.607,0.607,0.607,0.784)	
                    love.graphics.rectangle("line", 
                        button.x+widget.padding, 
                        button.y+widget.padding, 
                        paddy.buttonw-widget.padding*2, 
                        paddy.buttonh-widget.padding*2,
                        10
                    )
                end
                
                
                -- Temporary code until  button naming can be improved
                if paddy.debug then
                    love.graphics.setColor(1,1,1,1)
                    
                    local font = love.graphics.newFont(20)
                    love.graphics.setFont(font)
                    local str = button.name
                    
    
                    
                    love.graphics.printf(
                        button.name, 
                        button.x+paddy.buttonw/2,
                        button.y+paddy.buttonh/2, 
                        font:getWidth(str),
                        "center"
                    )
                end
            end
        
            love.graphics.setCanvas()
            love.graphics.setColor(1,1,1,widget.opacity)
            love.graphics.draw(widget.canvas, widget.x, widget.y)
        end
        
        
        -- debug related
        if paddy.debug then
            for _,id in ipairs(paddy.touched) do
                local x,y = love.touch.getPosition(id)
                love.graphics.circle("fill",x,y,20)
            end
        end
    end
 end
 
 function paddy.isDown(key)
    if love.system.getOS() == paddy.OS1
    or love.system.getOS() == paddy.OS2
    then
        -- Check for any buttons which are currently being pressed
        for _,widget in ipairs(paddy.widgets) do
            for _,button in ipairs(widget.buttons) do
                if button.isDown and button.name == key then return true end
            end
        end
    end
 end
 
 function paddy.update(dt)
     -- Decide which buttons are being pressed based on a 
     -- simple collision, then change the state of the button
     if love.system.getOS() == paddy.OS1
     or love.system.getOS() == paddy.OS2
     then
        paddy.touched = love.touch.getTouches()
        
        for _,widget in ipairs(paddy.widgets) do
            for _,button in ipairs(widget.buttons) do
                button.isDown = false
                for _,id in ipairs(paddy.touched) do	
                    local tx,ty = love.touch.getPosition(id)
                    if  tx >= widget.x+button.x 
                    and tx <= widget.x+button.x+paddy.buttonw 
                    and ty >= widget.y+button.y 
                    and ty <= widget.y+button.y+paddy.buttonh then
                        button.isDown = true
                    end
                end
            end
        end
     end
 end
 
 function paddy.setDefaultControllers(speed,dt)
    if love.system.getOS() == paddy.OS1
    or love.system.getOS() == paddy.OS2
    then
        if paddy.isDown("up") then
            love3d.camera.position[3] = love3d.camera.position[3] + speed*dt       
        end
        if paddy.isDown("down") then
            love3d.camera.position[3] = love3d.camera.position[3] - speed*dt       
        end
    end

 end
 



 return paddy