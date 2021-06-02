local InitializerImage = require 'components/sources/initializers/image'
local Image            = require 'components/sources/image'
local Text             = require 'components/sources/text'

InitializerButton = InitializerImage:extend()

function InitializerButton:initSource(button)
    button.source.images = {}

    button.source.images.default = Image({
        path = button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.hovered = Image({
        path = button.path.hovered or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.clicked = Image({
        path = button.path.clicked or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    button.source.images.disabled = Image({
        path = button.path.disabled or button.path.default,
        x = button.x, y = button.y, radian = button.radian, sx = button.sx, sy = button.sy
    })
    
    button:setSize(button.source.images.default.source:getWidth(), button.source.images.default.source:getHeight())
    
    local c = game.graphics:getItem(1,1)
    local btnWidthInCells = (button.width * button.sx) / c.width - 1
    local btnHeightInCells = 1

    button.source.text = Text({ 
        body = button.text, 
        x = button.x + c.width/2, 
        y = button.y + c.height/4
    })

    button.source.text.sx = (btnWidthInCells*c.width) / button.source.text.width
    button.source.text.sy = c.height / button.source.text.height

    self:setHooks(button)
end

function InitializerButton:setHooks(button)
    local hook = require 'components/sources/buttons/hooks/default'

    self:log('[InitializerButton:setHooks] set event "'
        ..'mousePressed.'..button.screenName..'.'..button.sceneName..'"'
        ..' | '..button.name..' - '..button.text
    )
    game.events:on('mousePressed.'..button.screenName..'.'..button.sceneName, hook({button = button}))
    game.events:on('mouseMoved.'..button.screenName..'.'..button.sceneName, hook({button = button}))
end

return InitializerButton