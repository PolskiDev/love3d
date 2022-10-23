-- Basic functions
function love.load()
    love3d.load()
    print "LOVE3D: Press ESC to quit."
    print "LOVE3D: Press W, A, S, D, Space Bar and Left Shift to movimentate the camera on the world."
    print "LOVE3D: Press Left Control to increase movimentation speed."
    print "LOVE3D: You can also use Love2D functions/commands inside the Love3D source code with Love's interoperability."
end
function love.update(dt)
    love3d.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if love.keyboard.isDown("lctrl") then
        speed = 3
    else
        speed = 1
    end

    if not speed then speed = 1 end
    

    love3d.camera.firstPersonMovement(dt*speed)
    love3d.controller.update(dt)
    love3d.controller.setDefaultControllers(speed,dt)
end
function love.mousemoved( x, y, dx, dy, istouch )
    love3d.mousemoved( x, y, dx, dy, istouch )
    love3d.camera.firstPersonLook(dx,dy)
end

function love.draw()
    love3d.draw()
    love3d.controller.draw()
end



-- 2. Auxiliary functions
-- Keyboard key pressed
--[[function love.keypressed(key)
    if love3d.keypressed(key) then love3d.keypressed(key) end 
end


-- Mouse or mouse wheel moved 
function love.wheelmoved( x, y )
    if love3d.wheelmoved( x, y ) then love3d.wheelmoved( x, y ) end
end

-- Mouse
function love.mousepressed( x, y, button, istouch, presses )
    if love3d.mousepressed( x, y, button, istouch, presses ) then love3d.mousepressed( x, y, button, istouch, presses ) end
end
function love.mousereleased( x, y, button, istouch, presses )
    if love3d.mousereleased( x, y, button, istouch, presses ) then love3d.mousereleased( x, y, button, istouch, presses ) end
end

-- Touch Screen
function love.touchpressed( id, x, y, dx, dy, pressure )
    if love3d.touchpressed( id, x, y, dx, dy, pressure ) then love3d.touchpressed( id, x, y, dx, dy, pressure ) end
end
function love.touchreleased( id, x, y, dx, dy, pressure )
    if love3d.touchpressed( id, x, y, dx, dy, pressure ) then love3d.touchpressed( id, x, y, dx, dy, pressure ) end
end]]