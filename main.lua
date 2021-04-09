function love.load()
    Object = require "vendor/rxi/classic"
	require "components/game"
	
	game = Game({
		assets = {base_path = 'assets/'},
		state = 'battle', -- choose start screen
		screens = {
			battle = {
				board = {
					size = 5,
					deathPerc = 10,
					ultraDeathPerc = 20,
					stonesPerRound = 3
				},
				players = {
					Player({ name = 'Player1', x = 270, y = 250, health = 100, attack = 2, defense = 1 }),
					Player({ name = 'Player2', x = 1540, y = 250, health = 100, attack = 2, defense = 1 })
				}
			}
		}
	})
	game:init()
	
	mouse = {x=0,y=0}
end

function love.update(dt)
	local layer = game:getCurrentScreenLayerData()
	layer:update(game, dt)
end

function love.draw()
	local screen = game:getCurrentScreen()
	screen:render(game)

	love.graphics.print(mouse.x..', '..mouse.y, mouse.x + 3, mouse.y-10)
end

function love.mousemoved( x, y, dx, dy, istouch )
	mouse.x, mouse.y = x,y

	local layer = game:getCurrentScreenLayerData()
	layer:mouseMoved(game, x, y, dx, dy, istouch)
end

function love.mousepressed(x,y,button,isTouch,presses)
	local layer = game:getCurrentScreenLayerData()
	layer:mousePressed(game, x, y, button, isTouch, presses)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit() 
	end

	local layer = game:getCurrentScreenLayerData()
	layer:keyPressed(game, key)
end


