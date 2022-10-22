-- Forked from Gabriel Margarido
-- October 2022

-- originally written by groverbuger for g3d
-- September 2021
-- MIT license

--[[
         __       __
       /'__`\    /\ \
   __ /\_\L\ \   \_\ \
 /'_ `\/_/_\_<_  /'_` \
/\ \L\ \/\ \L\ \/\ \L\ \
\ \____ \ \____/\ \___,_\
 \/___L\ \/___/  \/__,_ /
   /\____/
   \_/__/
--]]

love3d = {
    _VERSION     = "Löve3D 1.5.2",
    _DESCRIPTION = "Simple and easy 3D engine for LÖVE.",
    _URL         = "https://github.com/groverburger/g3d",
    _LICENSE     = [[
        MIT License

        Copyright (c) 2022 groverburger

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    ]],
    path = ...,
    shaderpath = ... .. "/love3d.vert",
    display = {}
}

-- the shader is what does the heavy lifting, displaying 3D meshes on your 2D monitor
require(love3d.path .. "/loader")
love3d.shader = love.graphics.newShader(love3d.shaderpath)
love3d.newModel = require(love3d.path .. "/model")
love3d.camera = require(love3d.path .. "/camera")
love3d.collisions = require(love3d.path .. "/collisions")
love3d.loadObj = require(love3d.path .. "/objloader")
love3d.vectors = require(love3d.path .. "/vectors")
love3d.class = require(love3d.path .. "/class")
love3d.engine = require(love3d.path .. "/timer")
--love3d = require(love3d.path .. "/loader")
love3d.inspect = require(love3d.path .. "/inspect")
love3d.world = require(love3d.path .. "/world")
love3d.controller = require(love3d.path .. "/paddy")


love3d.display.width, love3d.display.height = love.graphics.getDimensions()

love3d.camera.updateProjectionMatrix()
love3d.camera.updateViewMatrix()

-- so that far polygons don't overlap near polygons
love.graphics.setDepthMode("lequal", true)


-- get rid of love3d from the global namespace and return it instead
local love3d = love3d
_G.love3d = nil
return love3d
