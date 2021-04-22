require "components/render/screens/landscape/scenes/main/view_map"
--require "components/render/screens/landscape/scenes/main/view_cities"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        LandscapeMainViewMap()
    }
    self.label = {}
    self.selected = ''
    self.translate = {
        x=0,
        y=0,
        start = {x=0,y=0},
        move = false
    }
end

function SceneMain:init(screen)

end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)

    if self.translate.move then
        self.translate.x = self.translate.x + (self.translate.start.x - x)
        self.translate.start.x = self.translate.start.x-(self.translate.start.x - x)

        self.translate.y = self.translate.y + (self.translate.start.y - y)
        self.translate.start.y = self.translate.start.y-(self.translate.start.y - y)
    end

    local map = game.assets:getMap('main')

    map:forEach('characters', function (char)
        if (char.number > 0) and char:isMouseOn(x, y) then
            if char.number ~= 46 then
                char:changeNumberTo(46)
            end
            game.assets:getCursor('hand'):setOn()
            return false
        else
            char:restoreNumber()
            game.assets:getCursor('hand'):reset()
            return true
        end
    end)

    self.label = {}

    local paddock = map:getObject('paddock')

    if paddock:isMouseOn(x, y) then
        self.label = TextOverlay({
            body = 'This is a paddock',
            x = x+5,
            y = y+5,
            overlay_mode = 'fill',
            overlay_color = {0,0,0,0.3},
            overlay_offset = 5,
            sx = 2,
            sy = 2
        })
        self.selected = 'paddock'
    end

    local city1 = map:getObject('city1')

    if city1:isMouseOn(x, y) then
        self.label = TextOverlay({
            body = 'This is a City1',
            x = x+5,
            y = y+5,
            overlay_mode = 'fill',
            overlay_color = {0,0,0,0.3},
            overlay_offset = 5,
            sx = 2,
            sy = 2
        })
        self.selected = 'city1'
    end

    map = nil
    paddock = nil
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)
    self.translate.move = true
    self.translate.start.x = x
    self.translate.start.y = y
end

function SceneMain:mouseReleased(screen, x, y, button, isTouch, presses)
    self.translate.move = false
end

function SceneMain:keyPressed(screen, key)
    if key == 'left' then
        self.translate.x = self.translate.x+10
    elseif key == 'right' then
        self.translate.x = self.translate.x-10
    elseif key == 'up' then
        self.translate.y = self.translate.y+10
    elseif key == 'down' then
        self.translate.y = self.translate.y-10
    end
end

function SceneMain:update(screen)

end