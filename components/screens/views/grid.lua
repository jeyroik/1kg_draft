GridView = LayerView:extend()

function GridView:new(config)
    GridView.super.new(self, config)
end

function GridView:render(data, scene)
    love.graphics.setColor({0.5, 0.5, 0.5})
    game.graphics:forEach(function(item, i, j) 
        love.graphics.rectangle('line', item.x, item.y, item.width, item.height)
        love.graphics.print(i..','..j, item.x+2, item.y+2)
        return true
    end)
    love.graphics.setColor({1,1,1,1})
end

return GridView