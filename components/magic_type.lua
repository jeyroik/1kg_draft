MagicType = Object:extend{}
MagicType:implement(Config)

function MagicType:new(config)
	self.volume = 0
	self.name = ''
	self.isCanBeMerged = true
	self.isDestroyable = true
	self.giveScore = self.volume

	self:applyConfig(config)
end

magicTypesDict = {
	c1 = 'deck',
	c2 = 'air',
	c4 = 'water',
	c8 = 'tree',
	c16 = 'fire',
	c32 = 'life',
	c64 = 'air_ultra',
	c128 = 'water_ultra',
	c256 = 'tree_ultra',
	c512 = 'fire_ultra',
	c1024 = 'life_ultra'
}

magicNamesDict = {
	air = 'c2',
	water = 'c4',
	tree = 'c8',
	fire = 'c16',
	life = 'c32',
	air_ultra = 'c64',
	water_ultra = 'c128',
	tree_ultra = 'c256',
	fire_ultra = 'c512',
	life_ultra = 'c1024'
}