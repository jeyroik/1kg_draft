ImagePack = Source:extend()

function ImagePack:new(config)
    self.name = ''
    config.initializer = config.initializer or 'components/sources/initializers/image_pack'

    ImagePack.super.new(self, config)
end

-- @param string alias
-- @return Image
function ImagePack:get(alias)
    return self.source[alias]
end