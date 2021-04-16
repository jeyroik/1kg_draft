Skill = Object:extend{}
Skill:implement(Config)
Skill:implement(Printer)

function Skill:new(config)
	self.name = ''
	self.description = ''
	self.cost = {}
	self.mutators = {}

	self:applyConfig(config)
end

function Skill:addMutator(name, context)
	context.mutator = name
	self.mutators[name] = context
end