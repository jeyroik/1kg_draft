InitializerIcon = SourceInitializer:extend()

function InitializerIcon:initSource(icon)
    icon.image = Image(icon.image)
    icon.text = Text(icon.text)
end

return InitializerIcon