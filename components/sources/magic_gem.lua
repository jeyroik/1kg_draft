local ImageTitled = require 'components/sources/image_titled'

MagicGem = ImageTitled:extend()

function MagicGem:new(config)
    self.mana = 0
    self.power = 0
    self.amount = 0
    self.amountText = {}
    self.hovered = false
    self.magic = {}

    MagicGem.super.new(self, config)
end

function MagicGem:draw(mode)
    if mode == 'image' then
        MagicGem.super.draw(self, 'image')
    elseif mode == 'title' then
        local x, y = love.mouse.getPosition()
        MagicGem.super.draw(self, 'title')
    end

    local left = self.mana - self.amount
    local leftPerc = left/self.mana


    local overlay = game.resources:create('rectangle', {
        height = self.image.height * leftPerc,
        width = self.image.width,
        mode = 'fill',
        x = self.image.x,
        y = self.image.y,
        color = {0.5,0.5,0.5,0.7},
        sx = self.image.sx,
        sy = self.image.sy
    })

    overlay:draw()
end

function MagicGem:getName()
    return self.magic:getName()
end

function MagicGem:getTitle()
    return self.magic:getTitle()
end

function MagicGem:getType()
    return self.magic:getType()
end

function MagicGem:getMana()
    return self.mana
end

function MagicGem:getPower()
    return self.power
end

function MagicGem:getAmount()
    return self.amount
end

function MagicGem:incMagicParameter(parameter, inc)
    self[parameter] = self[parameter]+inc

    if self[parameter] < 0 then
        self[parameter] = 0
    end

    self.text:setBody(self.magic:getTitle() .. ': mana = '..self.mana..', power = '..self.power)
end

return MagicGem