local Model = require 'components/models/model'
ModelCharacter = Model:extend()

function ModelCharacter:new(config)
    self.title = ''
    self.description = ''

    self.level = 1
    self.experience = 0
    self.rank = 1 -- 1 - ordinary, 2 - rare, 3 - ultra rare, 4 - epic, 5 - legendary, 6 - mythical, 10 - unique
    self.health = 1
    self.attack = 0
    self.defense = 0
    self.conviction = 0 -- убеждение
    self.will = 0 -- воля

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

function ModelCharacter:addExperience(amount)
    self.experience = self.experience + amount
    local nextLevelExp = (self.level + 1) * self.level * (10*self.rank)

    if self.experience >= nextLevelExp then
        self.experience = self.experience-nextLevelExp
        self.level = self.level+1
        self:addExperience(0)
    end

    if self.level >= self.rank*10 then
        self.level = self.level - self.rank*10
        self.rank = self.rank + 1
    end
end

function ModelCharacter:merge(character)
    local exp = self:getMergeExp(character)

    self:addExperience(exp)
end

function ModelCharacter:getMergeExp(character)
    local exp = 0
    if character.name == self.name then
        exp = character.level * character.rank * character.experience
    else
        exp = (character.experience * character.rank) / 2
    end

    return exp
end

return ModelCharacter