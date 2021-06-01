local ButtonEffect = require "components/sources/buttons/effects/effect"

ButtonFrame = ButtonEffect:extend()

function ButtonFrame:new(config)
end

function ButtonEffect:draw(button)
    if button.state ~= 'default' then
        button:drawSelection()
    end

    button.source.text:draw()
end

return ButtonFrame