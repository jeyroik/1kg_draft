local Source = require 'components/sources/source'

ButtonEffect = Source:extend()

function ButtonEffect:new(config)
    config = config or {}
    config.initializer = config.initializer or 'components/sources/initializers/buttons/effects/effect'
    ButtonEffect.super.new(self, config)
end

function ButtonEffect:draw(button)
end

return ButtonEffect