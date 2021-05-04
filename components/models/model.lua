Model = Object:extend()
Model:implement(Config)

function Model:new(config)
    Model.super.new(self, config)
end

return Model