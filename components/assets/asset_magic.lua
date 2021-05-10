local Magic = require "components/magic/magic"

MagicAsset = Object:extend()

function MagicAsset:new()
    self.items = {
        c1	 = Magic({title = 'Deck', type='c1', name = 'deck', volume = 0, isCanBeMerged = false, isDestroyable = false}),
        c2   = Magic({title = 'Air', type='c2', name = 'air', volume = 2, isCanBeMerged = true, isDestroyable = true}),
        c4   = Magic({title = 'Water', type='c4', name = 'water', volume = 4, isCanBeMerged = true, isDestroyable = true}),
        c8   = Magic({title = 'Tree', type='c8', name = 'tree', volume = 8, isCanBeMerged = true, isDestroyable = true}),
        c16  = Magic({title = 'Fire', type='c16', name = 'fire', volume = 16, isCanBeMerged = true, isDestroyable = true}),
        c32  = Magic({title = 'Life', type='c32', name = 'life', volume = 32, isCanBeMerged = true, isDestroyable = true}),
        c64  = Magic({title = 'Ultra air', type='c64', name = 'air_ultra', volume = 64, isCanBeMerged = true, isDestroyable = true}),
        c128 = Magic({title = 'Ultra water', type='c128', name = 'water_ultra', volume = 128, isCanBeMerged = true, isDestroyable = true}),
        c256 = Magic({title = 'Ultra tree', type='c256', name = 'tree_ultra', volume = 256, isCanBeMerged = true, isDestroyable = true}),
        c512 = Magic({title = 'Ultra fire', type='c512', name = 'fire_ultra', volume = 512, isCanBeMerged = true, isDestroyable = true}),
        c1024 = Magic({title = 'Ultra life', type='c1024', name = 'life_ultra', volume = 1024, isCanBeMerged = true, isDestroyable = true}),
        c2048 = Magic({title = 'Death', type='c2048', name = 'death', volume = 2048, isCanBeMerged = false, isDestroyable = true}),
        c4096 = Magic({title = 'Ultra Death', type='c4096', name = 'ultra_death', volume = 4096, isCanBeMerged = false, isDestroyable = true})
    }

    self.names = {
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

    self.namesOrder = {
        'air',
        'water',
        'tree',
        'fire',
        'life',
        'air_ultra',
        'water_ultra',
        'tree_ultra',
        'fire_ultra',
        'life_ultra'
    }
end

function MagicAsset:getByType(typeName)
    return self.items[typeName]
end

function MagicAsset:getByName(name)
    return self.items[self.names[name]]
end

return MagicAsset