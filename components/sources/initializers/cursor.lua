InitializerCursor = SourceInitializer:extend()

function InitializerCursor:initSource(cursor)
    cursor.source = love.mouse.getSystemCursor(cursor.path)
end

return InitializerCursor