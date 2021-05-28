SourcePositioned = require 'components/sources/source_positioned'

Window = SourcePositioned:extend()

function Window:new(config)
    self.header = {}
    self.body = {}
    -- footer must be constructed by the body - for example by puting another window inside

    self.with = {
        header = true,
        body   = true
    }

    config.initializer = config.initializer or 'components/sources/initializers/window'

    Window.super.new(self, config)
end

function Window:draw()
    if self.with.header then
        self.header:offsetPosition(self.position.column, self.position.row)
        self.header:draw()
    end

    if self.with.body then
        self.body:offsetPosition(self.position.column, self.position.row)
        self.body:draw()
    end
end

return Window