Button = Source:extend()

function Button:new(config)
    config = config or {}

    self.name = ''
    self.text = ''
    self.text_scale = 1
    self.state = 'default'
    self.border = 0
    self.scale = {
        mode = 'out'
    }
    self.color = {1,1,1}
    self.effect = {
        path = 'components/sources/buttons/effects/frame'
    }
    self.parent = {}

    config.alias = config.alias or 'button'
    config.initializer = config.initializer or 'components/sources/initializers/button'

    Button.super.new(self, config)

    self:initializeOne('effect')

    self.pressed = false
end


function Button:reload()
    local ini = InitializerButton({})
    ini:initSource(self)
end

function Button:draw()
    self.source.images[self.state]:draw()
    self.effect:draw(self)
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