Model = require 'components/models/model'
ModelCharacter = Model:extend()

function ModelCharacter:new(config)
    self.title = ''
    self.description = ''

    self.level = 1
    self.health = 1
    self.attack = 0
    self.defense = 0

    self.skill = {
		active = {},
		passive = {}
	}
	self.avatar = {
		path = 'chars',
		frame = 1
	}

    ModelCharacter.super.new(self, config)
end