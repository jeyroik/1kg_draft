Button = Source:extend()

function Button:new(config)
    self.name = ''
    self.text = ''
    self.text_scale = 1
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
        color = function (text, dx, dy, radian, sx, sy)
            if self.pressed then
                love.graphics.setColor(self.color)
            end
            text:render(dx, dy, radian, sx, sy)
            if self.pressed then
                love.graphics.setColor({1,1,1})
            end
        end,
        position = function (text, dx, dy, radian, sx, sy) text:render(dx, self.pressed and dy+self.border or dy-self.border) end,
        scale = function (text, dx, dy, radian, sx, sy)
            local sx = text.sx*sx
            local sy = text.sy*sy
            local dx = dx
            local dy = dy
            if self.pressed then
                if self.scale.mode == 'in' then
                    sx = text.sx*2 or text.sx
                    sy = text.sx*2 or text.sy
                    dx = dx-text.width
                    dy = dy-text.height
                else
                    sx = text.sx/2 or text.sx
                    sy = text.sx/2 or text.sy
                    dx = dx+text.width/2
                    dy = dy+text.height/2
                end

            end
            text:render(dx, dy, 0, sx, sy)
        end
    }

    self:setSize(self.source.images.default:getWidth(), self.source.images.default:getHeight())
end

function Button:reload()
    local ini = InitializerButton({})
    ini:initSource(self)
end

function Button:render(dx, dy, radina, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or 0
    sx = sx or 1
    sy = sy or 1

    self.source.images[self.state]:render(dx, dy, radian, sx, sy)
    self.effects[self.effect](self.source.text, dx, dy, radian, sx, sy)
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
    game.assets:getCursor('hand'):reset()
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