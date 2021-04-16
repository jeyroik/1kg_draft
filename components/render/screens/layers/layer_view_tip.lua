LayerViewTip = LayerView:extend()

function LayerViewTip:render(data)
    if data.tip.x then
        local tipImg = game.assets:getImage('tip')

        --self:addDbg(self:printObject(tipImg, ''))

        if tipImg:getWidth()*data.tip.sx + data.tip.x > love.graphics.getWidth() then
            data.tip.x = data.tip.x-tipImg:getWidth()*data.tip.sx
        end
        tipImg:render(data.tip.x, data.tip.y, 0, data.tip.sx, data.tip.sy)
        love.graphics.print(data.tip.text, data.tip.x+30, data.tip.y+30, 0,2*data.tip.sx,2*data.tip.sy)

        if data.tip.icons then
            for _,icon in pairs(data.tip.icons) do
                love.graphics.draw(
                        icon.image.source,
                        data.tip.x+icon.xd,
                        data.tip.y+icon.yd,
                        0,
                        0.5*data.tip.sx,
                        0.5*data.tip.sy
                )
                love.graphics.print(
                        icon.text,
                        data.tip.x+icon.xd+5+icon.image:getWidth()*data.tip.sx/2,
                        data.tip.y+icon.yd,
                        0,
                        2*data.tip.sx,
                        2*data.tip.sy)
            end
        end

    end
end