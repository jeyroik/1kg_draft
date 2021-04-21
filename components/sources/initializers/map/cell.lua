InitializerMapCell = SourceInitializer:extend()

function InitializerMapCell:initSource(cell)
    cell.previous = cell.number
end

return InitializerMapCell