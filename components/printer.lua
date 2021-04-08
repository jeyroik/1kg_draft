Printer = Object:extend()
Printer.debugInfo = {}

function tprint (tbl, r)
  for k, v in pairs(tbl) do
	if k ~= 'magic' then	
		r = r..'\n'..k ..'='
		if type(v) == "table" then
		  r = tprint(v, r)
		else
		  r = r .. v
		end
	end
  end
  
  return r
end

function Printer:printObject(obj, r)
	return tprint(obj, r)
end

function Printer:printDbg()
	local info = ''
	for msg in pairs(Printer.debugInfo) do
		info = info .. '\n'..msg
	end
	love.graphics.print(info, 0, 10)
end

function Printer:addDbg(msg)
	Printer.debugInfo[msg] = true
end

function Printer:flushDbg()
	printer.debugInfo = {}
end