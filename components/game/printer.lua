Printer = Object:extend()
Printer.debugInfo = {}

function tprint (tbl, r, indent)
	indent = indent or ''
  for k, v in pairs(tbl) do
	if k ~= 'magic' then	
		r = r..'\n'..indent..k ..'='
		if type(v) == "table" then
		  r = tprint(v, r, indent .. '--')
		else
			if type(v) == 'boolean' then
				v = v and 'true' or 'false'
			end
			if type(v) ~= 'userdata' then
				r = r .. v
			else
				r = r .. 'userdata'
			end
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
	for _,msg in pairs(Printer.debugInfo) do
		info = info .. '\n'..msg
	end
	love.graphics.print(info, 0, 10)
end

function Printer:addDbg(msg)
	if type(msg) == 'table' then
		msg = self:printObject(msg, '')
	end
	table.insert(Printer.debugInfo, msg)
end

function Printer:flushDbg()
	Printer.debugInfo = {}
end