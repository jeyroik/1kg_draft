local Initializer = require "components/game/initializer"
local Uuid        = require "components/game/uuid"
local Config      = require "components/game/config"

GameObject = Object:extend()
GameObject:implement(Config)
GameObject:implement(Uuid)
GameObject:implement(Initializer)

function GameObject:new(config)
    self.alias = 'unknown'
    self.id = self:getId()

    self:applyConfig(config)
end

return GameObject