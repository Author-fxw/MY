

--矩形围墙

local Fence = class("Fence")
    
--墙壁的生成
  function Fence:fenceGenerator(node,bound,callback)
	    
		for i = -bound ,bound do
		    
			local sp = cc.Sprite:create("fence.png")
			local posx,posy = callback(i)
			sp:setPosition(posx,posy)
			node:addChild(sp)
            
			table.insert(self.fenceSpArray,sp)
			
		end
	
	end
	
	
--围墙的初始化	
function Fence:ctor(bound,node)
    
	self.bound = bound
	self.node  = node
	self.fenceSpArray = {}
	
	--up
	self:fenceGenerator(node,bound,function(i)
	    
		--SetCollide(i,bound,{type = "fence"})
	    return Grid2Pos(i,bound)
	
	end)
	--down
	self:fenceGenerator(node,bound,function(i)
	     
		--SetCollide(i,-bound,{type = "fence"})
	    return Grid2Pos(i,-bound)
	
	end)
	
	--left
	self:fenceGenerator(node,bound,function(i)
	     
		--SetCollide(-bound,i,{type = "fence"})
	    return Grid2Pos(-bound,i) 
		
	end)
	--right
    self:fenceGenerator(node,bound,function(i)
	    
		--SetCollide(bound,i,{type = "fence"})
	    return Grid2Pos(bound,i)  
	
	end)	
	

end

---墙壁碰撞检测
function Fence:CheckFenceCollide(x,y)
    
	return	x == self.bound or x == -self.bound or y == self.bound or y == -self.bound 
    

end

--移除围墙
function Fence:Reset()
     
	    for _,sp in ipairs(self.fenceSpArray)do
	 
            self.node:removeChild(sp)
             			 	 
	    end
	      	 
end


return Fence 