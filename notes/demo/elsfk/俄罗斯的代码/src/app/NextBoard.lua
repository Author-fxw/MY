
require("app.Common")

local Block = require("app.Block")
local  NextBoard = class("NextBoard")

local BoardSize = 4


local function makeKey( x,y )
	-- body
	return x * 1000 + y 
end 



---初始化下一个方块
function NextBoard:ctor( node )
	-- body

	self.map = {}

	for x = 0, BoardSize - 1 do

		for y = 0, BoardSize - 1 do
			
			local posX,posY = cGrid2Pos(x + cSceneWidth + 1,y + cSceneHeight - 4)---提示块的位置偏移

			local sp = cc.Sprite:create("box.png")
			sp:setPosition(posX,posY)
			node:addChild(sp)
			sp:setVisible(false)

            self.map[makeKey(x,y)] = sp
		end
	end
end

function NextBoard:Next(  )
	-- body
	local style 

	if style == nil then
		style = RandomStyle()
	else
		style = self.nextStyle
	end
	self.nextStyle = RandomStyle()

	self:Clear()
 
	-- RawPlace(self.nextStyle,1,self,-1,4)

	return style   

end

function NextBoard:Clear(  )
	-- body
	for y = 0, BoardSize - 1 do 
		
		self:ClearLine(y)
	end
end

function NextBoard:Set( x,y,value )
	-- body
	local sp  = self.map[makeKey(x,y)]
	if sp == nil then
		return
	end

	sp:setVisible(value)

end


function NextBoard:Get( x,y )
	-- body
	local sp  = self.map[makeKey(x,y)]
	if sp == nil then
		return false
	end

	return sp:isVisible()
end


--
function NextBoard:ClearLine( y )
	-- body

	for x =0,BoardSize -1 do

		self:Set(x,y,false)
	end
end



return NextBoard









