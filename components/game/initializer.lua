Initializer = Object:extend()

function Initializer:initializeOne(name)
    local class = require(self[name].path)
    self[name .. '__config'] = self[name]
    self[name] = class(self[name])
end

function Initializer:initializeMany(name, byAlias)
    local initialized = {}

    if #self[name] == 0 then
        if self.alias and (self.alias ~= 'unknown') then
            --love.filesystem.append('log.txt', '\n[Initializer:initializeMany():] '..self.alias..' empty states')
        end
        return
    end
    
    for i = 1, #self[name] do
        local class = require(self[name][i].path)
        local alias = byAlias and self[name][i].alias or i
        if self.alias and (self.alias ~= 'unknown') then
            --love.filesystem.append('log.txt', '\n[Initializer:initializeMany():] '..self.alias..' state "'..alias..'" initialized.')
        end
        initialized[alias] = class(self[name][i])
    end

    self[name .. '__config'] = self[name]
    self[name] = initialized
    --love.filesystem.append('log.txt', '\n[Initializer:initializeMany():] initialized "'..name..'"')
    
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