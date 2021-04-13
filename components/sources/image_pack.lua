ImagePack = Image:extend()

function ImagePack:new(config)
    config.source_type = 'image_pack'

    ImagePack.super.new(self, config)
end

-- @param string alias
-- @return Image
function ImagePack:get(alias)
    return self.source[alias]
end