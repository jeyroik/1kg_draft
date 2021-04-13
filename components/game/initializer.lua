Initializer = Object:extend()

function Initializer:initializeOne(name)
    local class = require(self[name].path)
    self[name .. '__config'] = self[name]
    self[name] = class(self[name])
end

function Initializer:initializeMany(name, byAlias)
    local initialized = {}

    for i = 1, #self[name] do
        local class = require(self[name][i].path)
        local alias = byAlias and self[name][i].alias or i
        initialized[alias] = class(self[name][i])
    end

    self[name .. '__config'] = self[name]
    self[name] = initialized
end


function Initializer:initializePack(name)
    local initialized = {}

    for i=1, #self[name] do
        local row = self[name][i]
        initialized[i] = {}
        for j=1,#row do
            local class = require(row[j].path)
            initialized[i][j] = class(row[j])
        end
    end

    self[name .. '__config'] = self[name]
    self[name] = initialized
end