SourcePositioned = require 'components/sources/source_positioned'

WindowHeader = SourcePositioned:extend()

function WindowHeader:new(config)
    self.text    = ''
    self.buttons = {}
    config.initializer = config.initializer or 'components/sources/initializers/windows/header'

    WindowHeader.super.new(self, config)
end

function WindowHeader:drawSource()
    self.text:offsetPosition(self.position.column, self.position.row)
    self.text:draw()
    
    for i, button in pairs(self.buttons) do
        button:offsetPosition(self.position.column, self.position.row)
        button:draw()
    end
end

return WindowHeader