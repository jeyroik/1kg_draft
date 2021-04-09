ScreenLayer = Object:extend()
ScreenLayer:implement(Config)
ScreenLayer:implement(Printer)

function ScreenLayer:new(config)
    self.mode = ''
    self.name = ''
    self.data = {}

    self:applyConfig(config)
end