Fx = Source:extend()

function Fx:new(config)
    self.volume = 0
    self.mode = 'static'

    config.source_type = 'fx'

    Fx.super.new(self, config)
end

function Fx:play()
    love.audio.stop(self.source)
    love.audio.play(self.source)
end