local Magic = require "components/magic/magic"

AssetMagic = Object:extend()

function AssetMagic:new()
    self.items = {
        deck        = Magic({title = 'Deck', name = 'deck', isCanBeMerged = false, isDestroyable = false}),
        air         = Magic({title = 'Air', name = 'air', isCanBeMerged = true, isDestroyable = true, mergeTo = 'water'}),
        water       = Magic({title = 'Water', name = 'water', isCanBeMerged = true, isDestroyable = true, mergeTo = 'tree'}),
        tree        = Magic({title = 'Tree', name = 'tree', isCanBeMerged = true, isDestroyable = true, mergeTo = 'fire'}),
        fire        = Magic({title = 'Fire', name = 'fire', isCanBeMerged = true, isDestroyable = true, mergeTo = 'life'}),
        life        = Magic({title = 'Life', name = 'life', isCanBeMerged = true, isDestroyable = true, mergeTo = 'air_ultra'}),
        air_ultra   = Magic({title = 'Ultra air', name = 'air_ultra', isCanBeMerged = true, isDestroyable = true, mergeTo = 'water_ultra'}),
        water_ultra = Magic({title = 'Ultra water', name = 'water_ultra', isCanBeMerged = true, isDestroyable = true, mergeTo = 'tree_ultra'}),
        tree_ultra  = Magic({title = 'Ultra tree', name = 'tree_ultra', isCanBeMerged = true, isDestroyable = true, mergeTo = 'life_ultra'}),
        fire_ultra  = Magic({title = 'Ultra fire', name = 'fire_ultra', isCanBeMerged = true, isDestroyable = true}),
        life_ultra  = Magic({title = 'Ultra life', name = 'life_ultra', isCanBeMerged = true, isDestroyable = true}),
        death       = Magic({title = 'Death', name = 'death', isCanBeMerged = false, isDestroyable = true}),
        death_ultra = Magic({title = 'Ultra Death', name = 'ultra_death', isCanBeMerged = false, isDestroyable = true})
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