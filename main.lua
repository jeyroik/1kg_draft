function love.load()
	require "game"
	
	game = Game({
		assets = {base_path = 'assets/'},
		state = 'battle', -- choose start screen
		screens = {
			battle = {
				board = {size = 5},
				players = {
					first = Player('Player1', 270, 250),
					second = Player('Player2', 1540, 250)
				}
			}
		}
	})
	game:init()
	
	mouse = {x=0,y=0}
end

function love.update(dt)
	game.screens.battle.board:move(game)
	game.screens.battle.board:addStone(game)
end

function love.draw()
	game:render()
	love.graphics.print(mouse.x..', '..mouse.y, mouse.x + 3, mouse.y-10)
end

function love.mousemoved( x, y, dx, dy, istouch )
	mouse.x, mouse.y = x,y
	
	local players = {}
	table.insert(players, game.screens.battle.battle:getCurrentPlayer())
	table.insert(players, game.screens.battle.battle:getNextPlayer())
	
	for i=1,2 do
		pl = players[i]
		for name, card in pairs(pl.cards) do
			if card.isMouseOn(x, y) then
				costMsg = ''
				icons = {}
				for magicName, amount in pairs(card.skill.cost) do
					table.insert(icons, {image=gemsImages[magicName], text=amount, xd=30, yd=180})
				end
				game.tip = {x=x, y=y, text='Player: ' ..i..'\n'..'Title: '..card.name .. '\n\nDescription: '..card.description..'\n\nCost: ', icons=icons}
				return
			else
				game.tip = {x=x, y=y, text=x .. ' < ' ..card.x ..' or '..x..' > ' .. (card.x+card.width) .. ' or '..y..' < '..card.y ..' or '..y..' > '..(card.y+card.height)}
				--game.tip = nil
				return
			end
		end
	end
end

function love.mousepressed(x,y,button,isTouch,presses)
	if not game.screens.battle.board.theEndFlag then
		local enemy = game.screens.battle.battle:getNextPlayer()
		local current = game.screens.battle.battle:getCurrentPlayer()
		
		for name, card in pairs(currentPlayer.cards) do
			if x >= card.x
			and x <= card.x + card.width 
			and y >= card.y 
			and y <= card.y+card.height then
				target = card.skill.toEnemy and enemy or currentPlayer
				local isEnough = isEnoughMana(card, currentPlayer.id)
				
				if isEnough then
					love.audio.stop(skillFx)
					love.audio.play(skillFx)
					for magicName, amount in pairs(card.skill.cost) do
						game.screens.battle.battle.magic[currentPlayer.id][magicName] = game.screens.battle.battle.magic[currentPlayer.id][magicName] - amount
					end
					for mutatorName, context in pairs(card.skill.mutators) do
						card:mutate(target, context)
					end
				else
					game.assets:playFx('skill_not')
				end
			end
		end
	end
end

function isEnoughMana(card, player)
	isEnough = true
	
	for magicName, amount in pairs(card.skill.cost) do
		if roundMagic[player][magicName] < amount then
			isEnough = false
			break
		end
	end
	
	return isEnough
end

function love.keypressed(key)
	if key == 'r' then
		generate()
	end
	
	if key == 'escape' then
		love.event.quit() 
	end
	
	if not game.screens.battle.board.theEndFlag then
		gr = {down = true, up=true, left=true, right=true}
		
		if gr[key] then
			game.assets:playFx('move')
			game.screens.battle.board.gravity = key
		end
	end
end

function attachCardsToPlayers()
	for i=1,2 do
		local cards = createSampleCards()
		local deltaY = 0
		local card = createAirElemental(players['p'..i].x, players['p'..i].y+deltaY)
		 players['p'..i]:addCard(card) 
	
	end
end

function createAirElemental(x,y)
	local skillSample = nil
	local cardSample = nil
	local cards = {}
	
	skillSample = Skill('Add health')
	skillSample:addMutator('health_change', {amount=1})
	skillSample.description = 'Add 1 health';
	skillSample:addCost('c2', 5)
	
	cardSample = Card('Air elemental', x, y)
	cardSample.description = 'Add 1 helth'
	cardSample.avatar = 1
	cardSample:addSkill(skillSample)
	
	return cardSample
end

function createSampleCards()
	local skillSample = nil
	local cardSample = nil
	local cards = {}
	
	skillSample = Skill('Add health')
	skillSample:addMutator('health_change', {amount=1})
	skillSample.description = 'Add 1 health';
	skillSample:addCost('c2', 5)
	
	cardSample = Card('Air elemental')
	cardSample.description = 'Add 1 helth'
	cardSample.avatar = 1
	cardSample:addSkill(skillSample)
	
	table.insert(cards, cardSample)
	
	skillSample = Skill('Decrease helth')
	skillSample:addMutator('health_change', {amount=-1})
	skillSample.description = 'Decrease enemy helth by 1';
	skillSample:addCost('c16', 2)
	skillSample.toEnemy = true
	
	cardSample = Card('Fire elemental')
	cardSample.description = 'Decrease enemy helth by 1'
	cardSample.avatar = 2
	cardSample:addSkill(skillSample)
	
	table.insert(cards, cardSample)
	
	return cards
end



