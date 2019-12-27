local Snake=class("Snake")

local Body= require("app.Body")

 require("app.AppleFactory")
local cInitLen = 2--初始长度

function Snake:ctor(node)--构造函数
    
    self.BodyArray={}--蛇身对象数组
    self.node=node
    self.MoveDir="left"

    for i = 1, cInitLen do
        self:Grow(i==1)
    end
end


--取出蛇尾
function Snake:GetTailGrild()

    if #self.BodyArray==0 then---设置蛇头的位置在（0，0）
       
	   return 0,0
        
    end
    local tail=self.BodyArray[#self.BodyArray]
    return tail.X,tail.Y
   
end

--取蛇头

function Snake:GetHeadGrid()
    
	if #self.BodyArray == 0 then
	
	    return nil
	end
	local head = self.BodyArray[1]
	
	return head.X,head.Y
	
end

--蛇变长
function Snake:Grow(isHead)


    local tailX,tailY = self:GetTailGrild()
    --print("[Body.new",self,tailX,tailY,self.node,isHead)

    local body = Body.new(self,tailX,tailY,self.node,isHead)

    table.insert(self.BodyArray,body)


end


--根据方向改变坐标
local function OffsetGrildByDir(x,y,dir)
    print("[Snake:OffsetGrildByDir]", x,y,dir)
    if dir=="left" then

        return x - 1, y
    
    elseif dir == "right"then

        return x + 1, y
    
    elseif dir == "up"then

        return x, y + 1

    elseif dir == "down"then

        return x, y - 1

    end
    
    --print("unknown dir",dir)
    
    return x, y

end


--设置方向
function Snake:setDir(dir)
     
	 -- local hvTable = {
		-- ["left"] = "h",
		-- ["right"] = "h",
		 -- ["up"] = "v",
		 -- ["down"] = "v",
	  -- }
	-- --水平 垂直 互斥
	 -- if hvTable[dir] == hvTable[self.MoveDir]then
	   -- return 
	-- else
       self.MoveDir = dir
	   --取出蛇头
	   
	   local head = self.BodyArray[1]
	   
	   --顺时针旋转，初始方向向左
	   local rotTable = {
	     
		 ["left"] = 0,
		 ["up"] = 90,
		 ["right"] = 180,
		 ["down"] = -90,
 	     
	   }
	   --让精灵图片旋转，以改变显示
	   
	   head.sp:setRotation(rotTable[self.MoveDir])
   
     -- end
end


--根据移动方向来更新蛇身的移动，根据BodyArray最后一个元素开始向前移动
function Snake:Update()
    
    if #self.BodyArray == 0 then
        return

    end
    for i = #self.BodyArray,1,-1 do

        local body = self.BodyArray[i]

        print("[Snake:Update() before ]", body.X,body.Y,self.MoveDir)
        if i == 1  then--蛇头的位置与方向，得到一个新的位置存放蛇头
            body.X,body.Y = OffsetGrildByDir(body.X,body.Y,self.MoveDir)
            
        else --身体的其他部分，取前一个元素，后面的元素移到前面的位置

            local front = self.BodyArray[i-1]
            body.X,body.Y = front.X,front.Y
        end
        print("[Snake:Update() after ]", body.X,body.Y)
        body:Update()
    
            
    end
        


end


--小蛇吃到自己
function Snake:CheckSelfCollide()

	 

    if #self.BodyArray < 2 then
          
        return 
    end		 

    local headX,headY = self:GetHeadGrid()
	 
	 for i = 2, #self.BodyArray do
	        
		local body = self.BodyArray[i]
		
        if headX == body.X and headY == body.Y then
        print("[headX,headY]",headX,headY )
		
		return true
        end
    
	end
	
end

--死亡
function Snake:Kill()
    
	for _, body in ipairs(self.BodyArray)do
	    
		self.node:removeChild(body.sp)
	
	end

end 

--死亡特效
function Snake:Blink(callback)
     
	for index, body in ipairs(self.BodyArray)do
         
		    local blink = cc.Blink:create(3,4)--三秒闪烁五次
		
		if index == 1 then 
		    
		    local a = cc.Sequence:create(blink,cc.CallFunc:create(callback))--序列动作回调
			
		    body.sp:runAction(a)
			
		else 
			
		     body.sp:runAction(blink)
		end

	end	

end


return Snake