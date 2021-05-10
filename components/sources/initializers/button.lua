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

    if button.parent.layers then
        self:setHooks(button)
    end
end

function InitializerButton:setHooks(button)
    local screen = button.parent

    if not screen:hasHook('buttons') then
        local hook = require 'components/sources/buttons/hooks/default'
        screen:catchEvent('mousePressed', 'after', hook({alias = 'buttons'}))
        screen:catchEvent('mouseMoved', 'after', hook({alias = 'buttons'}))
    end
    
    local hook = screen:getHook('buttons')
    hook:addButton(button.screenName, button.sceneName, button)
end

return InitializerButton