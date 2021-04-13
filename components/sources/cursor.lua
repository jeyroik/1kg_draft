Cursor = Source:extend()

function Cursor:new(config)
    config.source_type = 'cursor'

    Cursor.super.new(self, config)
end

function Cursor:setOn()
    love.mouse.setCursor(self.source)
end

function Cursor:reset()
    love.mouse.setCursor()
end
