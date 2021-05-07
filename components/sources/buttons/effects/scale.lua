local ButtonEffect = require "components/sources/buttons/effects/effect"

ButtonScale = ButtonEffect:extend()

function ButtonScale:new(config)
    self.mode = 'in'

    ButtonScale.super.new(self, config)
end

function ButtonScale:draw(button)
    local text = button.source.text
    
    if button.pressed then
        if self.mode == 'in' then
            text.sx = text.sx*2 or text.sx
            text.sy = text.sx*2 or text.sy
            text.x = button.x-text.width
            text.y = button.y-text.height
        else
            text.sx = text.sx/2 or text.sx
            text.sy = text.sx/2 or text.sy
            text.x = text.width/2
            text.y = text.height/2
        end

    end
    text:draw()
end

return ButtonScale