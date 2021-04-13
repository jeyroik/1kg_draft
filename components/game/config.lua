require "components/game/recombine"

Config = Object:extend()
Config:implement(Recombine)

function Config:applyConfig(config)
	self:recombineTable(self, config)
end