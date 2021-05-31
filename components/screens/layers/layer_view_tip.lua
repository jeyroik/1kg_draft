local LayerView = require "components/screens/layers/layer_view"

LayerViewTip = LayerView:extend()

function LayerViewTip:draw(data)
    if data.tip.x then
        local tipImg = game.assets:getImage('tip')

        --self:addDbg(self:printObject(tipImg, ''))

        if tipImg:getWidth()*data.tip.sx + data.tip.x > love.graphics.getWidth() then
            data.tip.x = data.tip.x-tipImg:getWidth()*data.tip.sx
        end
        tipImg.x = data.tip.x
        tipImg.y = data.tip.y
        tipImg.alias = 'tip'

        tipImg:draw()
        love.graphics.print(data.tip.text, data.tip.x+30, data.tip.y+30, 0, 2*tipImg.sx,2*tipImg.sy)

        if data.tip.icons then
            for _,icon in pairs(data.tip.icons) do
                love.graphics.draw(
                        icon.image.source,
                        tipImg.x+icon.xd*tipImg.sx,
                        tipImg.y+tipImg:getHeight()-icon.image.source:getHeight()*tipImg.sy-icon.image.source:getHeight()*tipImg.sy/2,
                        0,
                        0.5*tipImg.sx,
                        0.5*tipImg.sy
                )
                love.graphics.print(
                        icon.text,
                        tipImg.x+icon.xd*tipImg.sx+icon.image.source:getWidth()*0.5*tipImg.sx + 5,
                        tipImg.y+tipImg:getHeight()-icon.image.source:getHeight()*tipImg.sy-icon.image.source:getHeight()*tipImg.sy/2,
                        0,
                        2*tipImg.sx,
                        2*tipImg.sy)
            end
        end

    end
end

return LayerViewTip