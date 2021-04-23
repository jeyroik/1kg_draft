InitializerGrid = SourceInitializer:extend()

function InitializerGrid:initSource(grid)
    grid.cell.width = grid.width/grid.columns
    grid.cell.height = grid.height/grid.rows
end

return InitializerGrid