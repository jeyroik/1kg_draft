function love.load()
	require "bootstrap"
	
	gw = love.graphics.getWidth()
	game = Game(getGameConfig())
	game:init()
	
	mouse = {x=0,y=0}
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:render()

	love.graphics.print(mouse.x..', '..mouse.y, mouse.x + 3, mouse.y-10)
	
	
end

function love.mousemoved( x, y, dx, dy, isTouch )
	mouse.x, mouse.y = x,y

	game:mouseMoved(x, y, dx, dy, isTouch)
end

function love.mousepressed(x,y,button,isTouch,presses)
	game:mousePressed(x, y, button, isTouch, presses)
end

function love.mousereleased( x, y, button, istouch, presses )
	game:mouseReleased(x, y, button, isTouch, presses)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit() 
	end

	game:keyPressed(key)
end

function love.quit()
	
end

function getGameConfig()
	local config = nil--love.filesystem.read('config.json')
	
	--love.filesystem.append('log.txt', '\n[Start]\n')
	
	if not config then
		config = require "resources/game"
		love.filesystem.write('config.json', json.encode(config))
	else
		config = json.decode(config)
	end
	
	return config
end
