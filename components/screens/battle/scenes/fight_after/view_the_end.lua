local LayerView = require "components/screens/layers/layer_view"

BattleFightAfterViewTheEnd = LayerView:extend()

function BattleFightAfterViewTheEnd:new(config)
    BattleFightAfterViewTheEnd.super.new(self, config)

    self.theEnd = 'theEnd'
end

function BattleFightAfterViewTheEnd:draw(data)
    local img = game:create('image', {path = 'notice.png'})
    game:put(img, 4,6, 15,3)
    img:draw()

    local won = data.statistics[1].win and 'You won' or 'You loose'

    local text = game:create('text', { body = won })
    game:put(text, 5,10, 7,1)
    text:draw()

    local btn = game:create('button_default', {
        text = 'next',
        pointable = true,
        mousePressed = function()
            game:changeStateTo('campaign_map')
        end
    })
    game:put(btn, 17,12, 3,1)
    btn:draw()
end

return BattleFightAfterViewTheEnd