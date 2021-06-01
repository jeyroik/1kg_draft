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
    config.hover = function () 
        self.state = 'hovered'
        game.assets:getCursor('hand'):draw() 
    end
    config.click = function () 
        self.state = 'clicked'
        self.pressed = true
    end
    config.release = function () 
        self.state = 'default'
        game.assets:getCursor('hand'):reset() 
    end
    config.color = {0, 0.5, 0}

    ButtonDefault.super.new(self, config)
end

return ButtonDefault