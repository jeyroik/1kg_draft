local LayerView = require "components/screens/layers/layer_view"

GridView = LayerView:extend()

function GridView:new(config)
    GridView.super.new(self, config)
end

function GridView:render(data, scene)
    if scene.arguments['graphics__isOn'] then
        love.graphics.setColor({0.5, 0.5, 0.5})
        game.graphics:forEach(function(item, i, j) 
            love.graphics.rectangle('line', item.x, item.y, item.width, item.height)
            love.graphics.print(i..','..j, item.x+2, item.y+2)
            return true
        end)
        love.graphics.setColor({1,1,1,1})
        love.graphics.print(
            '['..love.graphics.getWidth()..','..love.graphics.getHeight()..'] '
            ..game.mouse.x..', '..game.mouse.y..' scale: '..game.translate.x..','..game.translate.y, 
            game.mouse.x+3, 
            game.mouse.y-10
        )
    end

    if scene.arguments['graphics__fps'] then
        love.graphics.print('[FPS: '..math.floor(60/game.fps/100)..']', 5, 5)
    end
end

return GridView