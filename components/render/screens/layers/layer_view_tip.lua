LayerViewTip = LayerView:extend()

function LayerViewtip:render(game, data)
    if data.tip.x then
        local tipImg = game.assets:getImage('tip')

        if tipImg:getWidth() + data.tip.x > love.graphics.getWidth() then
            data.tip.x = data.tip.x-tipImg:getWidth()
        end
        love.graphics.draw(tipImg, data.tip.x, data.tip.y)
        love.graphics.print(data.tip.text, data.tip.x+30, data.tip.y+30, 0,2,2)
        if data.tip.icons then

            for i,icon in pairs(data.tip.icons) do
                love.graphics.draw(icon.image, data.tip.x+icon.xd, data.tip.y+icon.yd, 0, 0.5, 0.5)
                love.graphics.print(icon.text, data.tip.x+icon.xd+5+icon.image:getWidth()/2, data.tip.y+icon.yd, 0,2,2)
            end
        end
    end
end