local GameObject = require 'components/game/object'

GameCursor = GameObject:extend()

function GameCursor:new(config)
    self.target = {}
    self.path = ''

    GameCursor.super.new(self, config)

    self.source = love.mouse.getSystemCursor(self.path)
end

function GameCursor:setOn()
    love.mouse.setCursor(self.source)
end

function GameCursor:reset()
    love.mouse.setCursor()
end

function GameCursor:isTarget(gameObject)
    return self.target.id == gameObject.id
end

function GameCursor:setTarget(gameObject)
    self.target = gameObject
end

function GameCursor:releaseTarget()
    self.target = {}
end

return GameCursor