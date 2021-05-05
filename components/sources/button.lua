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

    config.initializer = config.initializer or 'components/sources/initializers/button'

    Button.super.new(self, config)

    self.pressed = false
    self.effects = {
        frame = function(text)
            if self.pressed then
                self:drawSelection()
            end

            text:draw()
        end,
        color = function (text)
            if self.pressed then
                love.graphics.setColor(self.color)
            end
            text:draw()
            if self.pressed then
                love.graphics.setColor({1,1,1})
            end
        end,
        position = function (text)
            text:draw()
        end,
        scale = function (text)
            if self.pressed then
                if self.scale.mode == 'in' then
                    text.sx = text.sx*2 or text.sx
                    text.sy = text.sx*2 or text.sy
                    text.x = self.x-text.width
                    text.y = self.y-text.height
                else
                    text.sx = text.sx/2 or text.sx
                    text.sy = text.sx/2 or text.sy
                    text.x = dx+text.width/2
                    text.y = dy+text.height/2
                end

            end
            text:draw()
        end
    }
end


function Button:reload()
    local ini = InitializerButton({})
    ini:initSource(self)
end

function Button:draw()
    self.source.images[self.state]:draw()
    self.effects[self.effect](self.source.text)
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