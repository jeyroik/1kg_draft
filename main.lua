function love.load()
	require "bootstrap"

	game = Game(getGameConfig())
	game:init()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:render()
end

function love.mousemoved( x, y, dx, dy, isTouch )
	game:mouseMoved(x, y, dx, dy, isTouch)
end

function love.mousepressed(x,y,button,isTouch,presses)
	game:mousePressed(x, y, button, isTouch, presses)
end

function love.mousereleased( x, y, button, istouch, presses )
	game:mouseReleased(x, y, button, isTouch, presses)
end

function love.keypressed(key)
	-- todo: move to game
	if key == 'escape' then
		love.event.quit() 
	end

	game:keyPressed(key)
end

function love.textinput( text )
	game:textInput(text)
end

function love.quit()
	--love.filesystem.append('log.txt', '\n\n')
end

function getGameConfig()
	local config = nil--love.filesystem.read('config.json')
	
	--love.filesystem.append('log.txt', '\n[Start] ')
	
	if not config then
		config = require "resources/game"
		love.filesystem.write('config.json', json.encode(config))
	else
		config = json.decode(config)
	end
	
	return config
end
