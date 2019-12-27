
--require("app.Common")

local Scene = class("Scene")


cGridSize = 32--每个格子的大小
cSceneWidth = 8 + 2--边框的宽度
cSceneHeight = 18--边框的高度

 function cGrid2Pos(x,y)---把格子转成最终渲染的位置
	-- body
	local visibleSize = cc.Director:getInstance():getVisibleSize()--获取屏幕可视尺寸
	local origin = cc.Director:getInstance():getVisibleOrigin()---屏幕的远点坐标在左上角

	local finalX = origin.x + visibleSize.width*0.5 + x * cGridSize - cSceneWidth/2 * cGridSize
	local finalY = origin.y + visibleSize.height * 0.5 + y * cGridSize - cSceneHeight/2 * cGridSize

	return finalX,finalY

	
end

--场景布局
---8*18
--[[

*        *
*        *
*        *
**********
 ]]


local function makeKey( x,y )
	-- body
	-- print("[makeKey (x,y)]",x * 1000 + y)

	return x * 1000 + y
	
end


function Scene:ctor(node)
	-- body

	self.map = {}

-----显示边框
	for x = 0, cSceneWidth - 1 do

		for y = 0, cSceneHeight - 1 do

			local posX, posY = cGrid2Pos(x,y)
			
			local sp  = cc.Sprite:create("apple.png")
		
			sp:setPosition(posX,posY)
		
			node:addChild(sp)
			local visible = (x == 0 or x == cSceneWidth - 1 ) or y == 0  ----控制边框的显示范围

			sp:setVisible(visible)

			self.map[makeKey(x,y)] = sp

		end
	end
end

--清除所在的行
function Scene:ClearLine( y )
	-- body

	for x = 1, cSceneWidth - 2 do

		self:Set(x,y,false)
	end

end


--清除所在的列
function Scene:Clear(  )
	-- body
	for y = 1, cSceneHeight - 1 do

		self.ClearLine(y)
	
	end
end

--
function Scene:Set( x,y,value )
	-- body

	local sp = self.map[makeKey(x,y)]---根据键获取值

	if sp == nil then
		return
	end

	sp:setVisible(value)

end

--
function Scene:Get( x,y )
	-- body
	
	local sp = self.map[makeKey(x,y)]

	if sp == nil then

		return
	end
	return sp:isVisible()
end

---如果一行不满返回false 反之返回true
function Scene:IsFullLine( y )
	-- body
	for x = 1, cSceneWidth - 2 do
		
		if not self:Get(x,y) then---如果获取不到的话
			return false
		end
		
	end
	

return true
end

---检查方块并清楚
 function Scene:CheckAndSweep(  )
 	-- body
 	local  count = 0
 	for y = 1 , cSceneHeight - 1 do
 	 	
 	 	if self:IsFullLine(y) then
 	 		self:ClearLine(y)
    
 	 		count = count + 1
print("被调用了",count)
 	 		break

		  end 	
	end
	
 return count 
end

function Scene:MoveDown( sy )
	-- body
	for y = sy,cSceneHeight - 1 do

		for x = 1,cSceneWidth - 2 do
			
			sefl:Set(x,y,self:Get( x ,y + 1))
		end
	end

end

--下移
function Scene:Shift(  )
	-- body
	for y = 1, cSceneHeight - 2 do
		
		if self:IsEmptyLine(y) and (not self:IsEmptyLine(y + 2)) then

			self:MoveDown(y)
		end
	end
end

----该行是否空行
function Scene:IsEmptyLine( y )
	-- body
	for x = 1, cSceneWidth - 2 do
		
		if self:Get(x,y)then
			return false
		end
	end

	return true
end



return Scene