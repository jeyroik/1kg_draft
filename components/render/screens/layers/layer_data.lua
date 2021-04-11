LayerData = Layer:extend()

function LayerData:new(config)
    self.tip = {}
    self.selection = {}
    self.magicTypes = {}
    self.magicTypesDict = {}
    self.magicNamesDict = {}

    LayerData.super.new(self, config)

    self.mode = 'data'
end

function LayerData:init()
    self:loadMagicTypes()
end

function LayerData:loadMagicTypes()
    self.magicTypes = {
        c1	 = MagicType({name = 'Deck', volume = 0, isCanBeMerged = false, isDestroyable = false}),
        c2   = MagicType({name = 'Air', volume = 2, isCanBeMerged = true, isDestroyable = true}),
        c4   = MagicType({name = 'Water', volume = 4, isCanBeMerged = true, isDestroyable = true}),
        c8   = MagicType({name = 'Tree', volume = 8, isCanBeMerged = true, isDestroyable = true}),
        c16  = MagicType({name = 'Fire', volume = 16, isCanBeMerged = true, isDestroyable = true}),
        c32  = MagicType({name = 'Life', volume = 32, isCanBeMerged = true, isDestroyable = true}),
        c64  = MagicType({name = 'Ultra air', volume = 64, isCanBeMerged = true, isDestroyable = true}),
        c128 = MagicType({name = 'Ultra water', volume = 128, isCanBeMerged = true, isDestroyable = true}),
        c256 = MagicType({name = 'Ultra tree', volume = 256, isCanBeMerged = true, isDestroyable = true}),
        c512 = MagicType({name = 'Ultra fire', volume = 512, isCanBeMerged = true, isDestroyable = true}),
        c1024 = MagicType({name = 'Ultra life', volume = 1024, isCanBeMerged = true, isDestroyable = true}),
        c2048 = MagicType({name = 'Death', volume = 2048, isCanBeMerged = false, isDestroyable = true}),
        c4096 = MagicType({name = 'Ultra Death', volume = 4096, isCanBeMerged = false, isDestroyable = true})
    }

    self.magicTypesDict = {
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
        c1024 = 'life_ultra',
        c2048 = 'death',
        c4096 = 'death_ultra'
    }

    self.magicNamesDict = {
        deck = 'c1',
        air = 'c2',
        water = 'c4',
        tree = 'c8',
        fire = 'c16',
        life = 'c32',
        air_ultra = 'c64',
        water_ultra = 'c128',
        tree_ultra = 'c256',
        fire_ultra = 'c512',
        life_ultra = 'c1024',
        death = 'c2048',
        death_ultra = 'c4096'
    }
end

function LayerData:getMagicType(name)
    return self.magicTypes[name]
end

function LayerData:translateMagicType(name)
    return self.magicTypesDict[name]
end

function LayerData:translateMagicName(name)
    return self.magicNamesDict[name]
end