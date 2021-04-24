Cursor = Source:extend()

function Cursor:new(config)
    self.isSet = false
    self.setter = ''
    config.initializer = 'components/sources/initializers/cursor'

    Cursor.super.new(self, config)
end

function Cursor:setOn(setter)
    love.mouse.setCursor(self.source)
    self.isSet = true
    self.setter = setter or 'unknown'
end

function Cursor:reset()
    love.mouse.setCursor()
    self.isSet = false
    self.setter = ''
end

function Cursor:isSetOn()
    return self.isSet
end

function Cursor:isSetter(name)
    return self.setter == name
end