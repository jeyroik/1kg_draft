Button = Source:extend()

function Button:new(config)
    self.text = ''
    self.text_scale = 0.7
    self.state = 'default'
    self.border = 0
    self.effect = 'position'
    self.scale = {
        mode = 'out'
    }
    self.color = {1,1,1}

    config.initializer = 'components/sources/initializers/button'

    Button.super.new(self, config)

    self.pressed = false
    self.effects = {
        color = function (text)
            if self.pressed then
                love.graphics.setColor(self.color)
            end
            text:render()
            if self.pressed then
                love.graphics.setColor({1,1,1})
            end
        end,
        position = function (text) text:render(0, self.pressed and self.border or -self.border) end,
        scale = function (text)
            local sx = text.sx
            local sy = text.sy
            local dx = 0
            local dy = 0
            if self.pressed then
                if self.scale.mode == 'in' then
                    sx = text.sx*2 or text.sx
                    sy = text.sx*2 or text.sy
                    dx = -text.width
                    dy = -text.height
                else
                    sx = text.sx/2 or text.sx
                    sy = text.sx/2 or text.sy
                    dx = text.width/2
                    dy = text.height/2
                end

            end
            text:render(dx, dy, 0, sx, sy)
        end
    }

    self:setSize(self.source.images.default:getWidth(), self.source.images.default:getHeight())
end

function Button:render()
    self.source.images[self.state]:render()
    self.effects[self.effect](self.source.text)
end

function Button:click()
    self.state = 'clicked'
    self.pressed = true
end

function Button:hover()
    self.state = 'hovered'
    game.assets:getCursor('hand'):setOn()
    self.pressed = true
end

function Button:released()
    self.state = 'default'
    self.pressed = false
end

function Button:setToCenter(xAxis, yAxis)
    Button.super.setToCenter(self, xAxis, yAxis)

    for _, img in pairs(self.source.images) do
        img:setToCenter(xAxis, yAxis)
    end

    self.source.text:setToCenterOfObject(self.source.images.default, true, true)
end

function Button:stepByY(dy)
    Button.super.stepByY(self, dy)
    for _, img in pairs(self.source.images) do
        img:stepByY(dy)
    end

    self.source.text:setToCenterOfObject(self.source.images.default, true, true)
end