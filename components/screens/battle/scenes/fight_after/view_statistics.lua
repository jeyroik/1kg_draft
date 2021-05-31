local LayerView = require "components/screens/layers/layer_view"

BattleFightAfterViewStatistics = LayerView:extend()

function BattleFightAfterViewStatistics:new(config)
    BattleFightAfterViewStatistics.super.new(self, config)

    self.theEnd = 'theEnd'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightAfterViewStatistics:draw(data)
    local stats = data.statistics

    for i, player in pairs(stats) do
        local name = Text({ body = 'Player '..i, x = 0, y = 200, sx = 4, sy = 4})
        --name:setToCenter(true)
        if i == 1 then
            name:setToPart(3, 4, 8)
        else
            name:setToPart(7, 4, 8)
        end
        name:draw()

        local damageTaken = Text({ body = 'Damage taken: '..player.damage_taken, sx = 2, sy = 2 })
        damageTaken:stickToBottom(name)
        damageTaken:draw()

        local damaged = Text({ body = 'Damaged: '..player.damaged, sx = 2, sy = 2})
        damaged:stickToBottom(damageTaken)
        damaged:draw()

        local stones = Text({ body = 'Stones destroyed: '..player.stones, sx = 2, sy = 2})
        stones:stickToBottom(damaged)
        stones:draw()

        local spells = Text({ body = 'Spells casted: '..player.spells, sx = 2, sy = 2})
        spells:stickToBottom(stones)
        spells:draw()
    end
end

return BattleFightAfterViewStatistics