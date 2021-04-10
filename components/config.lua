Config = Object:extend()

function Config:applyConfig(config)
	if config then
		for k,v in pairs(self) do
			if config[k] ~= nil then
				self[k] = config[k]
			else
				self[k] = v
			end
		end
	end
end