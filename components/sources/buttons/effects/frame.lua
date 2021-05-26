local ButtonEffect = require "components/sources/buttons/effects/effect"

ButtonFrame = ButtonEffect:extend()

function ButtonFrame:new(config)
end

function ButtonEffect:draw(button)
    if button.pressed then
        button:drawSelection()
    end

    button.source.text:draw()
end

return ButtonFrame