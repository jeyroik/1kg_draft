SourcePositioned = require 'components/sources/source_positioned'

WindowBody = SourcePositioned:extend()

function WindowBody:new(config)
    self.content = {}
    config.initializer = config.initializer or 'components/sources/initializers/windows/body'
    
    WindowBody.super.new(self, config)
end

function WindowBody:drawSource()
    for i, item in pairs(self.content) do
        item:offsetGridPosition(self.grid.column, self.grid.row)
        item:draw()
    end
end

return WindowBody