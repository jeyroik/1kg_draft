Config = Object:extend()

function Config:applyConfig(config)
    for k,v in pairs(self) do
        self[k] = config[k] or v
    end
end