function love.load()
    Object = require "vendor/rxi/classic"
	require "components/game"
	
	game = Game({
		assets = {
			base_path = 'assets/',
			importers = {
				{path = 'components/magic/importer'},
				{path = 'components/mutators/importer'},
				{path = 'components/render/screens/battle/scenes/fight_before/importer'},
				{path = 'components/render/screens/battle/scenes/fight/importer'},
				{path = 'components/render/screens/battle/scenes/fight_after/importer'}
			}
		},
		state = 'battle', -- choose start screen
		screens = {
			battle = {
				players = {
					{ name = 'Player1', x = 270, y = 250, health = 50, attack = 2, defense = 1, isHuman = true },
					{ name = 'Player2', x = 1540, y = 250, health = 50, attack = 2, defense = 1 }
				}
			}
		}
	})
	game:init()
	
	mouse = {x=0,y=0}
end

function love.update(dt)
	local screen = game:getCurrentScreen()
	screen:update(game, dt)
end

function love.draw()
	local screen = game:getCurrentScreen()
	screen:render(game)

	love.graphics.print(mouse.x..', '..mouse.y, mouse.x + 3, mouse.y-10)
end

function love.mousemoved( x, y, dx, dy, istouch )
	mouse.x, mouse.y = x,y

	local screen = game:getCurrentScreen()
	screen:mouseMoved(game, x, y, dx, dy, istouch)
end

function love.mousepressed(x,y,button,isTouch,presses)
	local screen = game:getCurrentScreen()
	screen:mousePressed(game, x, y, button, isTouch, presses)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit() 
	end

	local screen = game:getCurrentScreen()
	screen:keyPressed(game, key)
end


