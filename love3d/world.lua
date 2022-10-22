local world = {}

function world.getCameraX()
    return love3d.camera.position[1]
end
function world.getCameraY()
    return love3d.camera.position[2]
end
function world.getCameraZ()
    return love3d.camera.position[3]
end



function world.getLookingX()
    return love3d.camera.target[1]
end
function world.getLookingY()
    return love3d.camera.target[2]
end
function world.getLookingZ()
    return love3d.camera.target[3]
end


function world.getLookingUpX()
    return love3d.camera.up[1]
end
function world.getLookingUpY()
    return love3d.camera.up[2]
end
function world.getLookingUpZ()
    return love3d.camera.up[3]
end


return world
