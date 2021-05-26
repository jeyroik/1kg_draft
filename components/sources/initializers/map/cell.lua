local SourceInitializer = require 'components/sources/initializers/initializer'

InitializerMapCell = SourceInitializer:extend()

function InitializerMapCell:initSource(cell)
    cell.previous = cell.number
end

return InitializerMapCell