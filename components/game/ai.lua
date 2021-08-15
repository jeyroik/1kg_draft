local GameObject = require 'components/game/object'

AI = GameObject:extend()

function AI:new()
    AI.super.new(self, config)
end

function AI:play(player)
    local gr = {'down', 'up', 'left', 'right'}
    local dir = love.math.random(1, 4)
    love.event.push('keypressed', gr[dir])
end

return AI