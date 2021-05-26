local ButtonEffect = require "components/sources/buttons/effects/effect"

ButtonColor = ButtonEffect:extend()

function ButtonColor:new(config)
    self.color = {1,1,1,1}

    ButtonColor.super.new(self, config)
end

function ButtonColor:draw(button)
    if button.pressed then
        love.graphics.setColor(self.color)
    end
    
    button.source.text:draw()

    if button.pressed then
        love.graphics.setColor({1,1,1})
    end
end

return ButtonColor