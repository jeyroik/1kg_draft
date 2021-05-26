local SourceInitializer = require 'components/sources/initializers/initializer'
local Image             = require 'components/sources/image'
local InitializerImage  = require 'components/sources/initializers/image'

InitializerQuads = InitializerImage:extend()

function InitializerQuads:initSource(source)
    source.image = Image({ path = source.path })
    local imageWidth = source.image:getWidth()
    local imageHeight = source.image:getHeight()

    local qWidth = (imageWidth / source.columns)
    local qHeight = (imageHeight / source.rows)

    for i=0,source.rows do
        for j=0,source.columns do
            table.insert(
                source.source,
                love.graphics.newQuad(j * (qWidth), i * (qHeight), qWidth, qHeight, imageWidth, imageHeight)
            )
        end
    end

    source.width = qWidth
    source.height = qHeight
end

return InitializerQuads