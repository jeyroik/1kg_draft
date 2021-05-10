local Source = require 'components/sources/source'

Grid = Source:extend()

function Grid:new(config)
    self.name = ''
    self.rows = 0
    self.columns = 0
    self.itemScale = 'auto'
    self.withBorder = false
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

function Grid:setItem(index, item)
    self.collection[index] = item
end

function Grid:remove(item)
    for i,selfItem in pairs(self.collection) do
        if selfItem.id == item.id then
            self.collection[i] = nil
        end
    end
end

function Grid:removeByClass(itemClass)
    for i,selfItem in pairs(self.collection) do
        if selfItem:is(itemClass) then
            self.collection[i] = nil
        end
    end
end

function Grid:replaceByClass(targetClass, newItem)
    for i,selfItem in pairs(self.collection) do
        if selfItem:is(targetClass) then
            self.collection[i] = newItem
            return true
        end
    end

    return false
end

function Grid:count(itemClass)
    local count = 0
    
    if itemClass then
        for _, item in pairs(self.collection) do
            if item:is(itemClass) then
                count = count + 1
            end
        end
    else
        count = #self.collection
    end

    return count
end

function Grid:findByClass(itemClass)
    for index, item in pairs(self.collection) do
        if item:is(itemClass) then
            return index
        end
    end

    return -1
end

function Grid:forEach(dispatcher, itemClass)
    local loop = function()
        for index, item in pairs(self.collection) do
            if not itemClass or item:is(itemClass) then
                local continue = dispatcher(item, index)
                if not continue then
                    return
                end
            end
        end
    end

    loop()
end

function Grid:draw()

    local x = self.x + self.margin.left
    local y = self.y + self.margin.top
    local itemWidth = self.cell.width - self.padding.left - self.padding.right
    local itemHeight = self.cell.height - self.padding.top - self.padding.bottom
    local row = 0
    local column = 0

    for _, item in pairs(self.collection) do
        if column == self.columns then
            row = row + 1
            column = 0
        end

        item.sx     = self.itemScale == 'auto' and (itemWidth/item:getWidth()) * self.sx or self.sx
        item.sy     = self.itemScale == 'auto' and (itemHeight/item:getHeight()) * self.sy or self.sy
        item.x      = x + self.cell.width*column + self.padding.left
        item.y      = y + self.cell.height*row   + self.padding.top
        item.radian = self.radian

        item:reload()
        item:render()
        column = column + 1
    end
    if self.withBorder then
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    end
end

function Grid:reload()
    InitializerGrid.initSource(self, self)
end

return Grid