InitializerImageTitled = SourceInitializer:extend()

function InitializerImageTitled:initSource(icon)
    icon.image = Image(icon.image)
    icon.text = TextOverlay(icon.text)
end

return InitializerImageTitled