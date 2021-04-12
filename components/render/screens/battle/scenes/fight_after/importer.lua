BattleFightAfterImporter = AssetImporter:extend()

function BattleFightAfterImporter:new()
    BattleFightAfterImporter.super.new(self)

    self.fxs = {
        the_end = { path = "the_end.wav", mode = "static"}
    }
    self.images = {
        theEnd = 'notice.png'
    }
end

return BattleFightAfterImporter