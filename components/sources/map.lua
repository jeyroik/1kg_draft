require "components/sources/map/cell"
require "components/sources/map/object"
local Quads = require 'components/sources/quads'


Map = Quads:extend()

function Map:new(config)
    self.layers = {}
    self.map = {}

    self.objects = {}
    self.mapObjects = {}

    self.renderPath = {}
    self.totalWidth = 0
    self.totalHeight = 0

    config.initializer = config.initializer or 'components/sources/initializers/map'
    config.renderConfig = {
        scale = 'size_position',
        origin = {
            x = 1,
            y = 1,
            w = 400,
            h = 300
        }
    }
    Map.super.new(self, config)

    self.totalWidth = self.width * self.columns
    self.totalHeight = self.height * self.rows
end

function Map:draw()
    for i=1,#self.renderPath do
        local layerName = self.renderPath[i]
        self:forEach(layerName, function(cell)
            cell:draw()
            return true
        end)
    end

    love.graphics.print('dx = '..self.x..', dy = '..self.y..', sx = '..self.sx..', sy = '..self.sy, 50, 50)
end

function Map:forEach(layerName, dispatcher)
    local loop = function ()
        local layer = self.map[layerName]
        for _, columns in pairs(layer) do
            for _, cell in pairs(columns) do
                local continue = dispatcher(cell)
                if not continue then
                    return
                end
            end
        end
    end

    loop()
end

function Map:getObject(name)
    return self.mapObjects[name]
end

function Map:forEachObject(dispatcher)
    local loop = function()
        for _, mapObject in pairs(self.mapObjects) do
            local continue = dispatcher(mapObject)
            if not continue then
                return
            end
        end
    end

    loop()
end

function Map:isMouseOnObject(x, y, objectName)
    local object = self.objects[objectName]

    if not object then
        return false
    end

    for _, part in pairs(object.schema) do
        local row, column = part[1], part[2]
        local cell = self.map[object.layer][row][column]
        if cell and cell:isMouseOn(x, y) then
            return true
        end
    end

    return false
end

function Map:reload()
    local initializer = InitializerMap()
    initializer:initSource(self)
end

return Map