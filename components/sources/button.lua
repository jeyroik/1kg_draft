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
            text:draw(dx, dy, radian, sx, sy)
            if self.pressed then
                love.graphics.setColor({1,1,1})
            end
        end,
        position = function (text, dx, dy, radian, sx, sy)
            text:draw(dx, self.pressed and dy+self.border or dy-self.border, radian, sx, sy)
        end,
        scale = function (text, dx, dy, radian, sx, sy)
            sx = text.sx*sx
            sy = text.sy*sy

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
            text:draw(dx, dy, radian, sx, sy)
        end
    }

    self:setSize(self.source.images.default:getWidth(), self.source.images.default:getHeight())
end

function Button:reload()
    local ini = InitializerButton({})
    ini:initSource(self)
end

function Button:draw(dx, dy, radian, sx, sy)
    dx     = dx     + self.x
    dy     = dy     + self.y
    radian = radian * self.radian
    sx     = sx     * self.sx
    sy     = sy     * self.sy

    self.source.images[self.state]:draw(dx, dy, radian, sx, sy)
    self.effects[self.effect](self.source.text, dx, dy, radian, sx, sy)
end

function Button:click()
    self.state = 'clicked'
    self.pressed = true
end

function Button:hover()
    self.state = 'hovered'
    game.assets:getCursor('hand'):render()
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