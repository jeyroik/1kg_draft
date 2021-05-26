ModelPlayer = ModelCharacter:extend()

function ModelPlayer:new(config)
    config = config or {}

    self.isHuman = true
    self.magic = {
        air         = { power = 1, mana = 3 },
        water       = { power = 1, mana = 3 },
        tree        = { power = 1, mana = 3 },
        fire        = { power = 1, mana = 3 },
        life        = { power = 1, mana = 3 },
        air_ultra   = { power = 1, mana = 3 },
        water_ultra = { power = 1, mana = 2 },
        tree_ultra  = { power = 1, mana = 2 },
        fire_ultra  = { power = 1, mana = 2 },
        life_ultra  = { power = 1, mana = 1 }
    }

    self.characters = {} -- <char.name> = <char>
    self.teams = {
        __current__ = {}
    } -- <team.name> = {<char.name> = true, <char.name> = true, ...}

    config.health = config.health or 5
    config.attack = config.attack or 1

    ModelPlayer.super.new(self, config)
end

function ModelPlayer:addCharacter(name, character)
    self.characters[alias] = character
end

function ModelPlayer:getTeam(name)
    if not self.teams[name] then
        return {}
    end

    local team = {}

    for charName in pairs(self.teams[name]) do
        team[charName] = self.characters[charName]
    end

    return team
end

function ModelPlayer:setTeam(name, charsNames)
    self.teams[name] = charsNames
end

function ModelPlayer:removeFromTeam(teamName, charName)
    if self.teams[teamName] then
        self.teams[teamName][charName] = nil
    end
end

function ModelPlayer:addToTeam(teamName, charName)
    if self.teams[teamName] then
        self.teams[teamName][charName] = true
    else
        self:setTeam(teamName, {})
        self:addToTeam(teamName, charName)
    end
end

function ModelPlayer:getCurrentTeam()
    local current = self:getTeam('__current__')

    if #current == 0 then
        local count = 0
        local names = {}
        for name, char in pairs(self.characters) do
            if count < 3 then
                current[name] = char
                names[name] = true
                count = count + 1
            else
                break
            end
        end

        self:setTeam('__current__', names)
    end

    return current
end

return ModelPlayer