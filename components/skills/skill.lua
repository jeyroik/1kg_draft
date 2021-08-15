Skill = Object:extend{}
Skill:implement(Config)
Skill:implement(Printer)

function Skill:new(config)
	self.name = ''
	self.description = ''
	self.cost = {}
	self.mutators = {}
	self.level = 1
	self.scope =  'all'

	self:applyConfig(config)
end

function Skill:addMutator(name, context)
	context.mutator = name
	self.mutators[name] = context
end

function Skill:use(screen)
	for name, context in pairs(self.mutators) do
		local mutator, err = game.assets:getMutator(name)
		if err then
			self:addDbg(err)
		else
			mutator:apply(screen, context)
		end
	end
end

return Skill