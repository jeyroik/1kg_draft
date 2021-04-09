Config = Object:extend()

function Config:applyConfig(config)
	if config then
		for k,v in pairs(self) do
			self[k] = config[k] or v
		end
	end
end