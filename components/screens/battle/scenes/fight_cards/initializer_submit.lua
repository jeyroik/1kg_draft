InitializerButton = require "components/sources/initializers/button"

InitializerFightCardsSubmit = SourceInitializer:extend()

function InitializerFightCardsSubmit:initSource(submit)
    local initializer = InitializerButton()
    initializer:initSource(submit)

    submit.x = love.graphics.getWidth()/2  - submit:getWidth()/2
    submit.y = love.graphics.getHeight()*0.80 - submit:getHeight()/2
    submit.renderConfig.origin.x = submit.x
    submit.renderConfig.origin.y = submit.y

    initializer:initSource(submit)
end

return InitializerFightCardsSubmit