Initializer = Object:extend()

function Initializer:initializeOne(name)
    local class = require(self[name].path)
    self[name] = class(self[name])
end

function Initializer:initializeMany(name, byAlias)
    local initialized = {}

    for i = 1, #self[name] do
        local class = require(self[name][i].path)
        local alias = byAlias and self[name][i].alias or i
        initialized[alias] = class(self[name][i])
    end

    self[name] = initialized
end
