MagicType = Object:extend{}

function MagicType:new(name, volume, isCanBeMerged, isDestroyable, giveScore)
	self.volume = volume
	self.name = name
	self.isCanBeMerged = isCanBeMerged
	self.isDestroyable = isDestroyable
	self.giveScore = giveScore and giveScore or volume
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