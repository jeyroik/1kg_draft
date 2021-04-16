Magic = Object:extend{}
Magic:implement(Config)

function Magic:new(config)
	self.volume = 0
	self.name = 'deck'
	self.title = 'Deck'
	self.type = 'c1'
	self.isCanBeMerged = true
	self.isDestroyable = true

	self:applyConfig(config)
end

function Magic:getName()
	return self.name
end

function Magic:getTitle()
	return self.title
end

function Magic:getType()
	return self.type
end
