local SourceInitializer = require 'components/sources/initializers/initializer'
local Image             = require 'components/sources/image'
local TextOverlay       = require 'components/sources/text_overlay'

InitializerImageTitled = SourceInitializer:extend()

function InitializerImageTitled:initSource(icon)
    icon.image = Image(icon.image)
    icon.text  = TextOverlay(icon.text)
end

return InitializerImageTitled