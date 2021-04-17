BattleFightAfterViewStatistics = LayerView:extend()

function BattleFightAfterViewStatistics:new(config)
    BattleFightAfterViewStatistics.super.new(self, config)

    self.theEnd = 'theEnd'
    self.center = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight()/2}
end

function BattleFightAfterViewStatistics:render(data)
    local stats = data.statistics

    for i, player in pairs(stats) do
        local name = Text({ body = 'Player '..i, x = 0, y = 200, sx = 4*VisibleObject.globalScale, sy = 4*VisibleObject.globalScale})
        --name:setToCenter(true)
        if i == 1 then
            name:setToPart(3, 4, 8)
        else
            name:setToPart(7, 4, 8)
        end
        name:render()

        local damageTaken = Text({ body = 'Damage taken: '..player.damage_taken, sx = 2*VisibleObject.globalScale, sy = 2*VisibleObject.globalScale })
        damageTaken:stickToBottom(name)
        damageTaken:render()

        local damaged = Text({ body = 'Damaged: '..player.damaged, sx = 2*VisibleObject.globalScale, sy = 2*VisibleObject.globalScale})
        damaged:stickToBottom(damageTaken)
        damaged:render()

        local stones = Text({ body = 'Stones destroyed: '..player.stones, sx = 2*VisibleObject.globalScale, sy = 2*VisibleObject.globalScale})
        stones:stickToBottom(damaged)
        stones:render()

        local spells = Text({ body = 'Spells casted: '..player.spells, sx = 2*VisibleObject.globalScale, sy = 2*VisibleObject.globalScale})
        spells:stickToBottom(stones)
        spells:render()
    end
end