local Initializer = require "components/game/initializer"
local Uuid        = require "components/game/uuid"
local Config      = require "components/game/config"

GameObject = Object:extend()
GameObject:implement(Config)
GameObject:implement(Uuid)
GameObject:implement(Initializer)

function GameObject:new(config)
    self.name         = 'unknown'
    self.id           = self:getId()
    self.gridRow      = 0
    self.gridColumn   = 0
    self.screenName   = ''
    self.sceneName    = ''

    self:applyConfig(config)
end

function GameObject:put(object, row, column, width, height)
    game.graphics:put(object, row, column, width, height)
end

function GameObject:log(message)
    if game.debugOn then
        love.filesystem.append('log.txt', '\n'..message)
    else
        love.filesystem.append('log2.txt', '\nDegub is off')
    end
end

function GameObject:trace(message, data)
    message = message or ''
    
    if data then
        self:log(message..': '..json.encode(data))
    end

    self:log(debug.traceback(message))
end

function GameObject:getEventName(event)
    return event .. '.' .. self.name
end

return GameObject