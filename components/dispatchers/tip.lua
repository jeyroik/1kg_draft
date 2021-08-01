local GameObject = require 'components/game/object'
local Label      = require 'components/sources/text_overlay'

TipDispatcher = GameObject:extend()

function TipDispatcher:draw(args, object)
    local label = Label({
        x = args.x+12,
        y = args.y+25,
        body = object.label,
        overlay_mode = 'fill',
        overlay_offset = 5,
        overlay_color = {0,0,0,1}
    })
    label:draw()
end

return TipDispatcher