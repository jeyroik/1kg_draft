local ViewMap = require "components/screens/campaign_map/scenes/main/view_map"

SceneMain = Scene:extend()

function SceneMain:new(config)
    config.name = 'main'
    
    SceneMain.super.new(self, config)
    
    self.views = {
        ViewMap()
    }
    self.label = {}
    self.selected = ''
    self.map = {}
    
end

function SceneMain:initState(screen)
    local map = require 'components/screens/campaign_map/scenes/main/map'
    self.map = game.resources:create('map', map)
end

function SceneMain:mouseMoved(screen, x, y, dx, dy, isTouch)

    if game.translate.move then
        game.translate.x       = game.translate.x       + (game.translate.start.x - x)
        game.translate.start.x = game.translate.start.x - (game.translate.start.x - x)

        game.translate.y       = game.translate.y       + (game.translate.start.y - y)
        game.translate.start.y = game.translate.start.y - (game.translate.start.y - y)
    end

    self.map:forEach('characters', function (char)
        if (char.number > 0) and char:isMouseOn(x, y) then
            if char.number ~= 46 then
                char:changeNumberTo(46)
            end
            game.cursor:setOn()
            return false
        else
            char:restoreNumber()
            return true
        end
    end)

    self.label = {}

    self.map:forEachObject(function(mapObject)
        if mapObject:isMouseOn(x, y) then
            self.label = game.resources:create('text_overlay', {
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

    self.map:forEachObject(function(mapObject)
        if mapObject.name == 'city1' and mapObject:isMouseOn(x, y) then
            game.cursor:reset()
            local enemy = ModelPlayer(game.assets:getCharacter('fire_elemental'))
            for i=1,3 do
                table.insert(enemy.characters, game.assets:getCharacter('fire_elemental'))
            end
            
            game:changeStateTo(
                'campaign_before_battle',  
                {
                    location = 'Pervograd', 
                    enemy    = enemy
                }
            )
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