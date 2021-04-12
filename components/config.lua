require "components/recombine"

Config = Object:extend()
Config:implement(Recombine)

function Config:applyConfig(config)
	self:recombineTable(self, config)
end