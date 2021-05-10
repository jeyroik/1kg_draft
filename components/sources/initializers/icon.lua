local SourceInitializer = require 'components/sources/initializers/initializer'
local Image             = require 'components/sources/image'
local Text              = require 'components/sources/text'

InitializerIcon = SourceInitializer:extend()

function InitializerIcon:initSource(icon)
    icon.image = Image(icon.image)
    icon.text = Text(icon.text)
end

return InitializerIcon