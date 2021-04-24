InitializerGrid = SourceInitializer:extend()

function InitializerGrid:initSource(grid)
    grid.cell.width = (grid.width-grid.margin.left-grid.margin.right)/grid.columns
    grid.cell.height = (grid.height-grid.margin.top-grid.margin.bottom)/grid.rows
end

return InitializerGrid