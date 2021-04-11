SceneFightStart = Scene:extend()

function SceneFightStart:new(config)
    self.fx = ''

    SceneFightStart.super.new(self, config)

    self.views = {

    }
end

function SceneFightStart:init(game, screen)
    game.assets:addImage('fs__btn', 'menu_btn')
    game.assets:addImage('fs__btn_pressed', 'menu_btn_pressed')
end