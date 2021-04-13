LayerData = Layer:extend()

function LayerData:new(config)
    self.tip = {}
    self.selection = {}

    LayerData.super.new(self, config)

    self.mode = 'data'
end

function LayerData:init()

end

function LayerData:getMagicType(name)
    return game.assets:getMisc('magicTypes')[name]
end

function LayerData:translateMagicType(name)
    return game.assets:getMisc('magicTypesDict')[name]
end

function LayerData:translateMagicName(name)
    return game.assets:getMisc('magicNamesDict')[name]
end