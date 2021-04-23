Grid = Source:extend()

function Grid:new(config)
    self.rows = 0
    self.columns = 0
    self.padding = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0
    }
    self.margin = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0
    }

    self.cell = {
        width = 0,
        height = 0
    }

    self.collection = {}

    config.initializer = config.initializer or 'components/sources/initializers/grid'

    Grid.super.new(self, config)
end

function Grid:add(item)
    table.insert(self.collection, item)
end

function Grid:addCollection(items)
    for _, item in pairs(items) do
        self:add(item)
    end
end

function Grid:render(dx, dy, radian, sx, sy)
    dx = dx or 0
    dy = dy or 0
    radian = radian or 0
    sx = sx or 1
    sy = sy or 1


    local x = self.x + self.margin.left + dx
    local y = self.y + self.margin.top + dy
    local itemWidth = self.cell.width - self.padding.left - self.padding.right
    local itemHeight = self.cell.height - self.padding.top - self.padding.bottom
    local row = 0
    local column = 0

    for _, item in pairs(self.collection) do
        if column == self.columns then
            row = row + 1
            column = 0
        end

        item.sx = (itemWidth/item:getWidth()) * sx
        item.sy = (itemHeight/item:getHeight()) * sy
        item.x = x + self.cell.width*column + self.padding.left + dx
        item.y = y + self.cell.height*row   + self.padding.top  + dy
        item.radian = radian
        item:render()
        column = column + 1
    end
end