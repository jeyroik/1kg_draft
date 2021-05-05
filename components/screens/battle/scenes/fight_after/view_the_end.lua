local LayerView = require "components/screens/layers/layer_view"

BattleFightAfterViewTheEnd = LayerView:extend()

function BattleFightAfterViewTheEnd:new(config)
    BattleFightAfterViewTheEnd.super.new(self, config)

    self.theEnd = 'theEnd'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightAfterViewTheEnd:render(data)
    local endImg = game.assets:getImage(self.theEnd)
    endImg:setToPart(3, 2)
    endImg:render()

    local won = data.statistics[1].win and 1 or 2

    local text = Text({ body = 'Player '..won..' won', sx = 4, sy = 4})
    text:setToCenterOfObject(endImg, true, true)
    text:render()
end