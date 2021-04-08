Skill = Object:extend{}
Skill:implement(Config)

function Skill:new(config)
	self.name = ''
	self.description = ''
	self.cost = {}
	self.mutators = {}
	self.toEnemy = false

	self:applyConfig(config)
end

function Skill:addMutator(name, context)
	context.mutator = name
	self.mutators[name] = context
end

function Skill:addCost(manaName, amount)
	self.cost[manaName] = amount
end