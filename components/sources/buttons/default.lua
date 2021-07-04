local Button = require 'components/sources/button'

ButtonDefault = Button:extend()

function ButtonDefault:new(config)
    config.path = {
        default  = 'menu_btn.png',
        hovered  = 'menu_btn.png',
        disabled = 'menu_btn.png',
        clicked  = 'menu_btn_pressed.png'
    }
    config.text_scale = 0.4
    config.border = 15
    config.effect = {
        path = 'components/sources/buttons/effects/frame'
    }
    config.mouseOn = function () 
        self.state = 'hovered'
        game.cursor:setOn()
    end
    config.mouseOut = function () 
        self.state = 'default'
        game.cursor:reset()
    end
   
    config.color = {0, 0.5, 0}
    config.name = config.name or self:getId()

    ButtonDefault.super.new(self, config)
end

return ButtonDefault