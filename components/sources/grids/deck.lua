Deck = Grid:extend()

function Deck:new(config)
    self.count = 0
    self.blank = Rectangle
    self.blankConfig = {}
    self.items = {}

    config.initializer = config.initializer or 'components/sources/initializers/grids/deck'

    Deck.super.new(self, config)
end

function Deck:isFilled()
    for i=1,self.count do
        if self.items[i].blank then
            return false
        end
    end
    return true
end

function Deck:fill(items)
    for _,toAdd in pairs(items) do
        for i=1, self.count do
            local item = self.items[i]
            if item.blank then
                self.collection[i] = toAdd
                self.items[i].blank = false
                break
            end
        end
    end
end

function Deck:fillFrom(deck)
    self:fill(deck.collection)
    deck:reset() --incorrect
end

function Deck:take(item)
    for i,selfItem in pairs(self.collection) do
        if selfItem.id == item.id then
            self.collection[i] = self.blank(self.blankConfig)
            self.items[i].blank = true
            break
        end
    end
end

function Deck:put(item)
    for i=1, #self.items do
        local selfItem = self.items[i]
        if selfItem.blank then
            self.collection[i] = item
            self.items[i].blank = false
            break
        end
    end
end

function Deck:reset()
    for i=1, self.count do
        self.items[i] = {blank = true}
        self.collection[i] = self.blank(self.blankConfig)
    end
end