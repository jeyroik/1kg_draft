InitializerIcon = SourceInitializer:extend()

function InitializerIcon:initSource(icon)
    icon.image = Image(icon.image)
end

return InitializerIcon