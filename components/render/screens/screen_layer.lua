ScreenLayer = Object:extend()
ScreenLayer:implement(config)

function ScreenLayer:new(config)
    self.mode = ''
    self.name = ''
    self.data = {}

    self:applyConfig(config)
end