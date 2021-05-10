SourceInitializer = Object:extend()

-- @param Source source
-- @return void
function SourceInitializer:initSource(source)

end

-- @param string path
-- @return string
function SourceInitializer:buildPath(path, source)
    return game.assets.basePath .. self:getPath(source) .. path
end

-- @return string
function SourceInitializer:getPath(source)
    return ''
end

return SourceInitializer