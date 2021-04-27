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

function MagicGem:render(mode, dx, dy, radian, sx, sy)
    if mode == 'image+amount' then
        MagicGem.super.render(self, 'image', dx, dy, radian, sx, sy)
        local amountText = Text({
            x = self.amountText.x,
            y = self.amountText.y,
            sx = self.amountText.sx,
            sy = self.amountText.sy,
            body = self.amount
        })
        amountText:render(dx, dy, radian, sx, sy)
    elseif mode == 'title' then
        local x, y = love.mouse.getPosition()
        MagicGem.super.render(self, 'title', x+20, y)
    end
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