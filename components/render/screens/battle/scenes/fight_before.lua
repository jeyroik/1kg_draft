require "components/render/screens/battle/scenes/fight_before/view_background"
require "components/render/screens/battle/scenes/fight_before/view_settings_mode"

SceneFightBefore = Scene:extend()

function SceneFightBefore:new(config)
    SceneFightBefore.super.new(self, config)

    self.name = 'fight_before'
    self.views = {
        BattleFightBeforeViewSettingsMode()
    }
end

function SceneFightBefore:init(screen)
    screen:addViewLayers(
        { BattleFightBeforeViewBackground( {image = 'board_background'} ) },
        'scene_before'
    )

    game.assets:getButton('pl1'):setToCenter(true)
    game.assets:getButton('pl1'):stepByY(50)

    game.assets:getButton('pl2'):setToCenter(true)
    game.assets:getButton('pl2'):stepByY(50)
    game.assets:getButton('pl2'):stepByY(20)
end

function SceneFightBefore:mouseMoved(screen, x, y, dx, dy, isTouch)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) then
        if pl1.state == 'default' then
            pl1:hover()
        end
    elseif pl2:isMouseOn(x, y) then
        if pl2.state == 'default' then
            pl2:hover()
        end
    else
        if pl1.state ~= 'default' then
            pl1:released()
        end

        if pl2.state ~= 'default' then
            pl2:released()
        end

        game.assets:getCursor('hand'):reset()
    end
end

function SceneFightBefore:mousePressed(screen, x, y, button, isTouch, presses)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')
    local data = screen:getData()
    local modeIsChosen = false

    if pl1:isMouseOn(x, y) then
        pl1:click()
        data.mode = 1
        modeIsChosen = true
        self:prepare1Player(data)
    elseif pl2:isMouseOn(x, y) then
        pl2:click()
        data.mode = 2
        modeIsChosen = true
        self:prepare2Players(data)
    end

    if modeIsChosen then
        screen:changeSceneTo('fight')
    end
end

function  SceneFightBefore:prepare1Player(layerData)
    local cardDefault = game.assets:getQuads('chars')
    local current = layerData:getCurrentPlayer()

    current:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardTreeElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardLifeElemental({width = cardDefault.width, height = cardDefault.height}))

    local next = layerData:getNextPlayer()
    next.isHuman = false
end

function  SceneFightBefore:prepare2Players(layerData)
    local cardDefault = game.assets:getQuads('chars')

    local current = layerData:getCurrentPlayer()
    current:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardTreeElemental({width = cardDefault.width, height = cardDefault.height}))
    current:addCard(CardLifeElemental({width = cardDefault.width, height = cardDefault.height}))
    current.isHuman = true

    local next = layerData:getNextPlayer()
    next:addCard(CardFireElemental({width = cardDefault.width, height = cardDefault.height}))
    next:addCard(CardTreeElemental({width = cardDefault.width, height = cardDefault.height}))
    next:addCard(CardLifeElemental({width = cardDefault.width, height = cardDefault.height}))
    next.isHuman = true
end

function SceneFightBefore:mouseReleased(screen, x, y, button, isTouch, presses)

    local pl1 = game.assets:getButton('pl1')
    local pl2 = game.assets:getButton('pl2')

    if pl1:isMouseOn(x, y) and pl1.pressed == true then
        pl1:released()
    elseif pl2:isMouseOn(x, y) and pl2.pressed == true then
        pl2:released()
    end
end

function SceneFightBefore:update(screen)
    --game.assets:getButton('pl1'):setToCenter(true)
    --game.assets:getButton('pl2'):setToCenter(true)
end