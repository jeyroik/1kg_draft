local SourceInitializer = require 'components/sources/initializers/initializer'
local Rectangle         = require 'components/sources/rectangle'
local InitializerText   = require 'components/sources/initializers/text'

InitializerTextOverlay = SourceInitializer:extend()

function InitializerTextOverlay:initSource(text)
    InitializerText.initSource(self, text)
    text.overlay = Rectangle({
        mode = text.overlay_mode,
        x = text.x - text.overlay_offset,
        y = text.y - text.overlay_offset,
        width = text.source:getWidth() * text.sx + text.overlay_offset*2,
        height = text.source:getHeight() * text.sy + text.overlay_offset*2,
        color = text.overlay_color
    })
end

return InitializerTextOverlay