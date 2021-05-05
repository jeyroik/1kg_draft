Layer = Object:extend()
Layer:implement(Config)
Layer:implement(Printer)

function Layer:new(config)
    self.mode = ''
    self.name = ''
    self.data = {}

    self:applyConfig(config)
end

return Layer