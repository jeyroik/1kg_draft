InitializerDeck = SourceInitializer:extend()

function InitializerDeck:initSource(deck)
    for i=1,deck.count do
        deck:add(deck.blank(deck.blankConfig))
        deck.items[i] = {
            blank = true
        }
    end
    InitializerGrid.initSource(self, deck)
end

return InitializerDeck