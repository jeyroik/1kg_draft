InitializerImagePack = SourceInitializer:extend()

function InitializerImagePack:initSource(pack)
    for elAlias, cfg in pairs(pack.path) do
        pack.source[elAlias] = Image({
            path = pack.name .. '/'.. cfg.path,
            radian = cfg.radian,
            sx = cfg.sx,
            sy = cfg.sy
        })
    end
end

return InitializerImagePack