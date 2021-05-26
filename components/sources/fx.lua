local Source = require 'components/sources/source'

Fx = Source:extend()

function Fx:new(config)
    self.volume = 0
    self.mode = 'static'

    config.initializer = config.initializer or 'components/sources/initializers/fx'

    Fx.super.new(self, config)
end

function Fx:render()
    self:play()
end

function Fx:play()
    love.audio.stop(self.source)
    love.audio.play(self.source)
end

return Fx