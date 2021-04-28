require "components/game/initializer"
require "components/game/printer"
require "components/game/uuid"
require "components/game/config"

GameObject = Object:extend()
GameObject:implement(Config)
GameObject:implement(Printer)
GameObject:implement(Uuid)
GameObject:implement(Initializer)

function GameObject:new(config)
    self.alias = 'unknown'
    self.id = self:getId()
    self.__state__ = ''
    self.__states__ = {}
    self.initialized = false

    self:applyConfig(config)
end

function GameObject:init()
    if not self.initialized then
        self:initStates()
        self.initialized = true
    else
        if self.alias ~= 'unknown' then
            love.filesystem.append('log.txt', '\n[GameObject:init():] '..self.alias..' already initialized')
        end
    end
end

function GameObject:initStates()
    self:initializeMany('__states__', true)
end

function GameObject:changeStateTo(stateName)
    self.__state__ = stateName
    local current = self:getCurrentState()
    if not current then
        love.filesystem.append('log.txt', '\n[GameObject:changeStateTo] stateName = '..stateName)
    end
    current:init(self)
end

function GameObject:getCurrentState()
    return self.__states__[self.__state__]
end