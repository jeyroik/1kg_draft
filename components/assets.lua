Assets = Object:extend()
Assets:implement(Config)

-- @param string basePath base path for assets
-- @return void
function Assets:new(config)
	self.basePath = 'assets/'
	self:applyConfig(config)
end

-- @return void
function Assets:init()
	-- Инициализация всех необходимых ресурсов
	self.fx = {
		-- alias = fx
		merge = love.audio.newSource(self.basePath .. "merge.wav", "static"),
		damage = love.audio.newSource(self.basePath .. "damage.wav", "static"),
		move = love.audio.newSource(self.basePath .. "move.wav", "static"),
		skill = love.audio.newSource(self.basePath .. "skill.wav", "static"),
		skill_not = love.audio.newSource(self.basePath .. "skill_not.wav", "static"),
		the_end = love.audio.newSource(self.basePath .. "the_end.wav", "static"),
		chars = love.graphics.newImage(self.basePath .. "chars.jpg"),
		gems = {}
	}
	
	self.fx.move:setVolume(0.1)
	self.fx.skill_not:setVolume(0.5)
	
	self.images = {
		-- alias = image
		notice = love.graphics.newImage(self.basePath .. "notice.png"),
		tip = love.graphics.newImage(self.basePath .. "tip.png"),
		background = love.graphics.newImage(self.basePath .. "board.png"),
		chars = love.graphics.newImage(self.basePath .. "chars.jpg"),
		gems = {}
	}
	
	self.quads = {
		chars = {}
	}
	
	for i=1, 12 do
		self.images.gems['c'..math.pow(2, i)] = love.graphics.newImage(self.basePath .. "gem"..math.pow(2, i)..".png")
	end
	
	charsQuads = {}

    --We need the full image width and height for creating the quads
    local imageWidth = self.images.chars:getWidth()
    local imageHeight = self.images.chars:getHeight()

    charWidth = (imageWidth / 7) - 2
    charHeight = (imageHeight / 5) - 2

    for i=0,5 do
        for j=0,7 do
            table.insert(self.quads.chars, love.graphics.newQuad(1 + j * (charWidth + 4), 1 + i * (charHeight + 2), charWidth, charHeight, imageWidth, imageHeight))
        end
    end
	
	
	self.misc = {
		-- alias = table
		card = {
			width = charWidth,
			height = charHeight
		}
	}

	self.cursors = {
		hand = love.mouse.getSystemCursor("hand")
	}

	self.mutators = {
		self_health = MutatorSelfHealth(),
		enemy_health = MutatorEnemyHealth()
	}
end

-- @param string name alias of a fx 
-- @return void
function Assets:playFx(name)
	if self.fx[name] then
		love.audio.stop(self.fx[name])
		love.audio.play(self.fx[name])
	end
end

-- @param string name alias of an image
-- @return Image|nil image, nil|string error
function Assets:getImage(name)
	if self.images[name] then
		return Image({source = self.images[name]}), nil
	end
	
	return nil, 'Unknown image "' .. name .. '"'
end

function Assets:getMisc(name)
	return self.misc[name]
end

function Assets:getCursor(name)
	return self.cursors[name]
end

function Assets:getMutator(name)
	return self.mutators[name]
end

function Assets:addImage(alias, path)
	self.images[alias] = love.graphics.newImage(self.basePath .. path)
end

function Assets:removeImage(alias)
	self.images[alias] = nil
end