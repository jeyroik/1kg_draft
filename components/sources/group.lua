Group = Source:extend()

function Group:new(config)
    self.items = {}
    self.attachItems = false
    self.fromAssets = false

    config.initializer = config.initializer or 'components/sources/initializers/group'

    Group.super.new(self, config)
end

function Group:addItem(alias, item)
    self.items[alias] = item
end

function Group:removeItem(alias)
    self.items[alias] = nil
end

function Group:move(x, y)
    self.x = x
    self.y = y

    self:forEach(function(alias, item) 
        item.x = self.x + item.x
        item.y = self.y + item.y
    end)
end

function Group:forEach(dispather)
    local loop = function() 
        for alias, item in pairs(self.items) do
            local continue = dispather(alias, item)

            if not continue then
                return
            end
        end
    end

    loop()
end