Skill = Object:extend{}

function Skill:new(name, config)
	self.name = name
	self.description = config.description or ''
	self.cost = config.cost  or {}
	self.mutators = config.mutators or {}
	self.toEnemy = config.toEenemy or false
end

function Skill:addMutator(name, context)
	context.mutator = name
	self.mutators[name] = context
end

function Skill:addCost(manaName, amount)
	self.cost[manaName] = amount
end