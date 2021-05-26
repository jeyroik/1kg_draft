local ButtonEffect = require "components/sources/buttons/effects/effect"

ButtonPosition = ButtonEffect:extend()

function ButtonPosition:new(config)
end

function ButtonPosition:draw(button)
    button.source.text:draw()
end

return ButtonPosition