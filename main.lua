function love.load()
    Object = require "vendor/rxi/classic"
	require "components/game"
	
	game = Game({
		assets = {base_path = 'assets/'},
		state = 'battle', -- choose start screen
		screens = {
			battle = {
				scene = 'fight_start',
				board = {
					size = 5,
					deathPerc = 10,
					ultraDeathPerc = 20,
					stonesPerRound = 3
				},
				players = {
					Player({ name = 'Player1', x = 270, y = 250, health = 50, attack = 2, defense = 1, isHuman = true }),
					Player({ name = 'Player2', x = 1540, y = 250, health = 50, attack = 2, defense = 1 })
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


