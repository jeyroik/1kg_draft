local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerStone = SourceInitializer:extend()

function InitializerStone:initSource(stone)
    
    local pack = game.assets:getImagePack(stone.path)
	local image = pack:get(stone:getMask())

    stone.width = image:getWidth()
    stone.height = image:getHeight()
end

return InitializerStone