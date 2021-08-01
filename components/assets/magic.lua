local Magic = require "components/magic/magic"

AssetMagic = Object:extend()

function AssetMagic:new()
    self.items = {
        deck        = Magic({title = 'Deck', type='c1', name = 'deck', volume = 0, isCanBeMerged = false, isDestroyable = false}),
        air         = Magic({title = 'Air', type='c2', name = 'air', volume = 2, isCanBeMerged = true, isDestroyable = true, mergeTo = 'water'}),
        water       = Magic({title = 'Water', type='c4', name = 'water', volume = 4, isCanBeMerged = true, isDestroyable = true, mergeTo = 'tree'}),
        tree        = Magic({title = 'Tree', type='c8', name = 'tree', volume = 8, isCanBeMerged = true, isDestroyable = true, mergeTo = 'fire'}),
        fire        = Magic({title = 'Fire', type='c16', name = 'fire', volume = 16, isCanBeMerged = true, isDestroyable = true, mergeTo = 'life'}),
        life        = Magic({title = 'Life', type='c32', name = 'life', volume = 32, isCanBeMerged = true, isDestroyable = true, mergeTo = 'air_ultra'}),
        air_ultra   = Magic({title = 'Ultra air', type='c64', name = 'air_ultra', volume = 64, isCanBeMerged = true, isDestroyable = true, mergeTo = 'water_ultra'}),
        water_ultra = Magic({title = 'Ultra water', type='c128', name = 'water_ultra', volume = 128, isCanBeMerged = true, isDestroyable = true, mergeTo = 'tree_ultra'}),
        tree_ultra  = Magic({title = 'Ultra tree', type='c256', name = 'tree_ultra', volume = 256, isCanBeMerged = true, isDestroyable = true, mergeTo = 'life_ultra'}),
        fire_ultra  = Magic({title = 'Ultra fire', type='c512', name = 'fire_ultra', volume = 512, isCanBeMerged = true, isDestroyable = true}),
        life_ultra  = Magic({title = 'Ultra life', type='c1024', name = 'life_ultra', volume = 1024, isCanBeMerged = true, isDestroyable = true}),
        death       = Magic({title = 'Death', type='c2048', name = 'death', volume = 2048, isCanBeMerged = false, isDestroyable = true}),
        death_ultra = Magic({title = 'Ultra Death', type='c4096', name = 'ultra_death', volume = 4096, isCanBeMerged = false, isDestroyable = true})
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

function AssetMagic:getByName(name)
    return self.items[name]
end

return AssetMagic