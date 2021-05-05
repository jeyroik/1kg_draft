HookFullScreenImporter = AssetImporter:extend()

function HookFullScreenImporter:new()
    HookFullScreenImporter.super.new(self)

    self.images = {
        fullscreen_in = { path = 'fullscreen_in.png' },
        fullscreen_out = { path = 'fullscreen_out.png' }
    }
end

return HookFullScreenImporter