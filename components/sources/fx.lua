Fx = Source:extend()

function Fx:new(config)
    self.volume = 0
    self.mode = 'static'

    config.initializer = 'components/sources/initializers/fx'

    Fx.super.new(self, config)
end

function Fx:render()
    self:play()
end

function Fx:play()
    love.audio.stop(self.source)
    love.audio.play(self.source)
end