local ViewMap = require "components/screens/campaign_map/scenes/main/view_map"

SceneMain = Scene:extend()

function SceneMain:new(config)
    SceneMain.super.new(self, config)

    self.name = 'main'
    self.views = {
        ViewMap()
    }
    self.label = {}
    self.selected = ''
end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)

    if game.translate.move then
        game.translate.x       = game.translate.x       + (game.translate.start.x - x)
        game.translate.start.x = game.translate.start.x - (game.translate.start.x - x)

        game.translate.y       = game.translate.y       + (game.translate.start.y - y)
        game.translate.start.y = game.translate.start.y - (game.translate.start.y - y)
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
            return true
        end
    end)

    self.label = {}

    map:forEachObject(function(mapObject)
        if mapObject:isMouseOn(x, y) then
            self.label = TextOverlay({
                body = mapObject.title..'\n'..mapObject.description,
                x = x+15-game.translate.x,
                y = y-game.translate.y,
                overlay_mode = 'fill',
                overlay_color = {0,0,0,0.3},
                overlay_offset = 5
            })
            self.selected = mapObject.name
            return false
        else
            return true
        end
    end)
end

function SceneMain:mousePressed(screen, x, y, button, isTouch, presses)
    game.translate.move    = true
    game.translate.start.x = x
    game.translate.start.y = y

    game.assets:getMap('main'):forEachObject(function(mapObject)
        if mapObject.name == 'city1' and mapObject:isMouseOn(x, y) then
            game.assets:getCursor('hand'):reset()
            game:changeStateTo('campaign_before_battle',  
                'Pervograd', {} )
            return false
        else
            return true
        end
    end)
end

function SceneMain:mouseReleased(screen, x, y, button, isTouch, presses)
    game.translate.move = false
end

function SceneMain:keyPressed(screen, key)
    if key == 'left' then
        game.translate.x = game.translate.x+10
    elseif key == 'right' then
        game.translate.x = game.translate.x-10
    elseif key == 'up' then
        game.translate.y = game.translate.y+10
    elseif key == 'down' then
        game.translate.y = game.translate.y-10
    end
end

function SceneMain:update(screen)

end

return SceneMain