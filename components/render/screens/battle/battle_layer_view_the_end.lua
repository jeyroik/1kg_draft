BattleLayerViewTheEnd = LayerView:extend()

function BattleLayerViewTheEnd:new(config)


    BattleLayerViewTheEnd.super.new(self, config)

    self.theEnd = 'notice'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleLayerViewTheEnd:needRender(game, data)
    return data.theEndFlag
end

function BattleLayerViewTheEnd:render(game, data)
    local noticeImg = game.assets:getImage(self.theEnd)

    noticeImg:render(self.center.x-noticeImg:getWidth()/2, 120)
    love.graphics.print('The end', self.center.x-noticeImg:getWidth()/2+150, 140, 0,4,4)
end