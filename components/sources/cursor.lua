local Source = require 'components/sources/source'

Cursor = Source:extend()

function Cursor:new(config)
    self.target = {}

    config.initializer = config.initializer or 'components/sources/initializers/cursor'

    Cursor.super.new(self, config)
end

function Cursor:draw()
    self:setOn()
end

function Cursor:setOn()
    love.mouse.setCursor(self.source)
end

function Cursor:reset()
    love.mouse.setCursor()
end

function Cursor:isTarget(gameObject)
    return self.target.id == gameObject.id
end

function Cursor:setTarget(gameObject)
    self.target = gameObject
end

function Cursor:releaseTarget()
    self.target = {}
end

return Cursor