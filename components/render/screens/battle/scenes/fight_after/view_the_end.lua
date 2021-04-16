BattleFightAfterViewTheEnd = LayerView:extend()

function BattleFightAfterViewTheEnd:new(config)
    BattleFightAfterViewTheEnd.super.new(self, config)

    self.theEnd = 'theEnd'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightAfterViewTheEnd:render(data)
    local noticeImg = game.assets:getImage(self.theEnd)

    noticeImg:render(self.center.x-noticeImg:getWidth()/2, 120)
    love.graphics.print('The end', self.center.x-noticeImg:getWidth()/2+150, 140, 0,4,4)
end