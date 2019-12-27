
local AppleFactory=class("AppleFactory")

function AppleFactory:ctor(bound,node)
    
    self.bound = bound
    self.node = node

   

    math.randomseed(os.time())	
	
	self:Generate()
	


end

local function getPos(bound)
    
	return math.random(-bound,bound)
end 

--苹果的碰撞
function AppleFactory:CheckCollide(x,y)
     
	if x == self.appleX and y == self.appleY then
	
	   return true 
	end	  
        return false	
	
end


function AppleFactory:Generate()--生成苹果
     
	if self.appleSprite ~= nil then--销毁对象
	    
	    self.node:removeChild(self.appleSprite)
	end
		
	 
    
	local sp = cc.Sprite:create("apple.png")
	
	local genBoundLimit = self.bound - 1--苹果的生成范围限制
	local x,y = getPos(genBoundLimit),getPos(genBoundLimit)


	local finalX,finalY = Grid2Pos(x,y)

	 sp:setPosition(finalX,finalY)
	 self.node:addChild(sp)

	 self.appleX = x
	 self.appleY = y
	
	 self.appleSprite = sp  
	
end

---苹果的重生
function AppleFactory:Reset()
    
	self.node:removeChild(self.appleSprite)

end

function AppleFactory:getApplePos()
         
     return self.appleX,self.appleY
end

return AppleFactory


