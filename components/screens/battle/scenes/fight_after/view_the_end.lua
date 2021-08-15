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

    local won = data.statistics[1].win and 1 or 2

    local text = game:create('text', { body = 'Player '..won..' won' })
    game:put(text, 5,9, 9,1)
    text:draw()
end

return BattleFightAfterViewTheEnd