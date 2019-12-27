local GameScene=class("GameScene",cc.load("mvc").ViewBase)

local Snake=require("app.Snake")
--local Body=require("app.Body")
local AppleFactory = require("app.AppleFactory")
local Fence = require("app.Fence")
require("app.CollideManager")
local BlockFactory = require("app.BlockFactory")

local b = require("app.Block")

local cMoveSpeed=0.3
local cBound = 7


local cGridSize=35--格子大小
local scaleRate=1/display.contentScaleFactor

 function Grid2Pos(x,y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()--获取手机屏幕的可视尺寸
    local origin = cc.Director:getInstance():getVisibleOrigin()--获取手机屏幕原点坐标，在屏幕左上角
    
    local finalX = origin.x + visibleSize.width/2 + x*cGridSize*scaleRate
    local finalY = origin.y + visibleSize.height/2 + y*cGridSize*scaleRate
    
    return finalX,finalY 
 
end

--蛇方向判定
local function vector2Dir(x,y)

    if math.abs( x ) > math.abs( y ) then
        
        if x < 0 then
            
            return "left"
        else
            return "right"
        end
    else 
        if y < 0 then
            
            return "down"
        else

            return "up"
            
        end
    end
    
end

function GameScene:onEnter()
    
     
     self.CurrLevel=1
   	-- self.appleFactory = AppleFactory.new(cBound,self)
    -- self.snake=Snake.new(self)
    --self.snake=Body.new(nil,0,0,self,false)
    --self.snake=Body.new(nil,0,0,self,true)
	
    self:ProcessInput()
	self:ProcessKeyboardInput()
    self:CreateScoreBoard()
    self:Reset()
    self.b = b
   
    local tick=function()
          
        if self.stage == "running"then		
		 
            self.snake:Update()
		
            local headX,headY = self.snake:GetHeadGrid()
			
			local event = CheckCollide(headX,headY)
			
			if event ~= nil then
			
			    if event.Type == "fence" then
			     
				    self.stage = "dead"
				    self.snake:Blink(function()
				     
					self:Reset()
				     end)
				 
			
			   end
			
			end
			
        
            if self.appleFactory:CheckCollide(headX,headY) then--判断蛇头位置与苹果位置

             self.appleFactory:Generate()--苹果重生

             self.snake:Grow()--蛇身加长
			 
			 self.score = self.score + 1
			
			 self:SetScore(self.score)--分数加一
           
			 -- if self.score >=self.CurrLevel then
                   -- self:SetNexLevel()--达到分数要求进入下一关
 		
			   -- end
		   end
		
            if  --self.snake:CheckSelfCollide() then--蛇吃到自己
             
				 self.snake:CheckSelfCollide() 
				 or self.fence:CheckFenceCollide(headX,headY) 
				-- or self.blocks:Hit(headX,headY) 
				 then--蛇吃到自己或撞到墙壁/障碍物
				 
			     print("[self.b:CheckBlockCollide]",headX,headY)
			    self.stage = "dead"--蛇死亡状态
			
			    self.snake:Blink(function()
			    
				self:Reset()--重置
			 
			  end)
		
		    		
		    end
		end

     end--end tick
	 
	 --定时器
        cc.Director:getInstance():getScheduler():scheduleScriptFunc(
	 
	    tick,cMoveSpeed,false)

end

--游戏结束
function GameScene:Reset()
    
	if self.snake ~= nil then
	    self.snake:Kill() 
	end	
   
	if self.appleFactory ~= nil then
        self.appleFactory:Reset()
    end	
	
	if self.fence ~= nil then
        self.fence:Reset()
		
    end	
	---添加障碍物
	if self.blocks ~= nil then
        self.blocks:Reset()
		
    end	
	
	    self.blocks = BlockFactory.new(self)
		-- self.blocks:Add(0.5,0.5,1)
	    self:Load()--利用文件加载
         
		self.fence = Fence.new(cBound,self)--创建围墙
	   
	    self.appleFactory = AppleFactory.new(cBound,self)--创建苹果
	
        self.snake=Snake.new(self)--创建蛇
		
		self.stage = "running"--蛇的状态
		
		self.score = 0
		self:SetScore(self.score)--分数设置
	
end

---鼠标点击事件
function GameScene:ProcessInput()

    local function onTouchBegan(touch,event)

        local location = touch:getLocation()---触摸位置
        
        local visibleSize = cc.Director:getInstance():getVisibleSize()--获取屏幕尺寸
        local origin = cc.Director:getInstance():getVisibleOrigin()--获取屏幕原点

        local finalX = location.x - (origin.x + visibleSize.width/2)
        local finalY = location.y - (origin.y + visibleSize.height/2)

        --return finalX,finalY
        local dir = vector2Dir(finalX,finalY)

        self.snake:setDir(dir)--设置方向

    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

end

---键盘点击事件
function GameScene:ProcessKeyboardInput()
      
        local function keyboardPressed(keyCode,event)
             
			 --up or W
			if keyCode == 28 or keyCode == 146 then
			       
				print("up")
				self.snake:setDir("up")--蛇的移动方向
		     
			    -- down or S
			    elseif keyCode == 29 or keyCode == 142 then 
			     
				print("down")
				self.snake:setDir("down")
		
				--left or A
				elseif keyCode == 26 or keyCode == 124 then
				 
				 print("left")
				 self.snake:setDir("left")
				 
				 --right or D
				 elseif keyCode == 27 or keyCode == 127 then
				 
				 print("right")
				 self.snake:setDir("right")
			     
				 ---end
				 
				 --P
				 elseif keyCode == 139 then
				 print("P--暂停")
				 local director = cc.Director:getInstance()
				       
					   director:pause()---暂停
				 elseif keyCode == 141 then
				 local director = cc.Director:getInstance()
				  print("R--恢复")
					   director:resume()---恢复
				
			end  
		 
	 
		end		
	  
	local listener = cc.EventListenerKeyboard:create()
         listener:registerScriptHandler(keyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    local eventDispatcher = self:getEventDispatcher()
         eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)


end

--分数的显示
function GameScene:CreateScoreBoard()
     
	     display.newSprite("applesign.png")
         :align(display.CENTER,display.right-100,display.cy+150)
		 :addTo(self)
		 
		 --计分板
		 local ttfConfig = {}
		     
			 ttfConfig.fontFilePath = "arial.ttf"
			 ttfConfig.fontSize = 30
             
		 local score = cc.Label:createWithTTF(ttfConfig,"0")
          
		 score:setPosition(display.right-100,display.cy+80)
		 
		 self:addChild(score)
		 
		 self.scoreLable = score
	
end

--设置分数
function GameScene:SetScore(s)
     
	self.scoreLable:setString(string.format("%d",s))

end

---加载文件
function GameScene:Load()
  
  local f = assert(dofile(string.format("scene%d.lua",self.CurrLevel)))
  
  --加载文件之前先清除桌面上的物体
  self.blocks:Reset()
  
  for _,t in ipairs (f)do
     
     	 self.blocks:Add(t.x,t.y,t.index)
  
  end

  print("GameScene Loaded")
  
end

--
function GameScene:SetNexLevel()
   
   self.CurrLevel = self.CurrLevel + 1
   if self.CurrLevel>3 then
      
	  self.CurrLevel = 1
	            		
   end   
    self:Reset()

end

return GameScene