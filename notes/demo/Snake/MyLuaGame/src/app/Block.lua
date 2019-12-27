local Block = class("Block")


 function Grid2Pos(x,y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()--获取手机屏幕的可视尺寸
    local origin = cc.Director:getInstance():getVisibleOrigin()--获取手机屏幕原点坐标，在屏幕左上角
    
    local finalX = origin.x + visibleSize.width/2 + x*cGridSize*scaleRate
    local finalY = origin.y + visibleSize.height/2 + y*cGridSize*scaleRate
    
    return finalX,finalY 
 
end

local cGridSize=35--格子大小
local scaleRate=1/display.contentScaleFactor

local rowBound = 5
local cBound   = 5

function Block:ctor(node)
      
    self.node = node
    
end


--设置当前的障碍物 index = 123 根据自己障碍物图片的数量
function Block:Set(index)
     
        if index ~= nil then
         	
	    self.node:removeChild(self.sp)
	    end
	 
    self.index = index 
	self.sp = display.newSprite(string.format("block%d.png",index))--转换图片地址
	self.node:addChild(self.sp)
	
	
end

--设置位置
function Block:SetPos(x,y)
         
        local rbound = rowBound - 1
        local cbound = cBound   - 1		
	    
	    local posx,posy = Grid2Pos(x,y)
		
		self.sp:setPosition(posx,posy)
		--print("[self.sp:setPosition(posx,posy)]",)
		self.x = x
        self.y = y 
		
end


-- 清除对象
function Block:Clear()
          
	     self.node:removeChild(self.sp)  
 
end

---位置重合
function Block:CheckBlockCollide(x,y)
      
		   if x == self.x and y == self.y then
		   
			 return true
			end
            
			return false
end
return Block