Character = Card:extend()

function Character:new(config)
    self.name = ''
    self.description = ''
    self.health = 1
    self.attack = 0
    self.defense = 0
    self.skills = {}
    self.avatar = 1

    Character.super.new(self, config)
end