love3d = require 'love3d'
Gamestate = require 'love3d.hump.gamestate'

-- Creating new gamestate
Gamestate.new()

-- Setting entity coordinates
local moon_data = {
    x = 15, y = 15, z = 8
}
-- Creating entities
local moon = love3d.newModel("assets/sphere.obj", "assets/earth.png", {moon_data.x,moon_data.y,moon_data.z}, nil, {4,4,4})
local background = love3d.newModel("assets/sphere.obj", "assets/starfield.png", {0,0,0}, nil, {500,500,500})
-- Creating new timer
local timer = 0
-- Creating collision variable
local collidedText




-- Game
local subwoofer
function love3d.load()
    subwoofer = love.audio.newSource("subwoofer.mp3","stream")
end

function love3d.mousemoved(x,y, dx,dy)
    
end
function love3d.update(dt)
    timer = love3d.engine.newTimer(timer,dt) -- Starting the timer
    moon:setEulerRotation(0, math.pi - timer, 0) -- Setting entity natural rotation

    -- Detecting if player/camera collided with the entity
    if love3d.collisions.hasCameraCollided(10,moon_data.x,moon_data.y,moon_data.z) then
        collidedText = true
    else
        collidedText = false
    end

    love.audio.play(subwoofer)
end

function love3d.draw()
    -- Showing coordinates on the screen
    love.graphics.print("X: "..love3d.world.getCameraX(),10,10)
    love.graphics.print("Y: "..love3d.world.getCameraY(),10,30)
    love.graphics.print("Z: "..love3d.world.getCameraZ(),10,50)
    love.graphics.print("Collision: "..tostring(collidedText),10,70)


    -- Showing the timer on the screen
    love.graphics.print("Timer: "..timer,10,90)

    
    
    -- Rendering entities
    moon:draw()
    background:draw()
end