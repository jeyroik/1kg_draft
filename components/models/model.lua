Model = Object:extend()
Model:implement(Config)

function Model:new(config)
    self:applyConfig(config)
end

return Model