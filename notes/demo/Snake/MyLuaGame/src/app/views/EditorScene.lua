
local EditorScene=class("EditorScene",cc.load("mvc").ViewBase)
   
 
  local Fence = require("app.Fence")
  local Block = require("app.Block")
  local BlockFactory = require("app.BlockFactory")
  
  
local cGridSize=35--格子大小
local scaleRate=1/display.contentScaleFactor

 function Grid2Pos(x,y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()--获取手机屏幕的可视尺寸
    local origin = cc.Director:getInstance():getVisibleOrigin()--获取手机屏幕原点坐标，在屏幕左上角
    
    local finalX = origin.x + visibleSize.width/2 + x*cGridSize*scaleRate
    local finalY = origin.y + visibleSize.height/2 + y*cGridSize*scaleRate
    
    return finalX,finalY 
 
end

local cMaxBlock = 3 -- 障碍物数目 
local cBound = 7

function EditorScene:onEnter()
    
	self.fence = Fence.new(cBound,self)---围墙
	
	--鼠标光标位置 初始化为左上角
 
	self.curX = 0
    self.curY = 0
	 
	self.curIndex = 0 -- 选择的物体序号
	
	self:SwithCursor(1)
	self:ProcessInput()
	self.blockFactory = BlockFactory.new(self)
	
end

---按键事件处理

function EditorScene:ProcessInput()
       
	local function keyboardPressed(keyCode,event)
	
	--up
	if keyCode == 28 then
	    print("up")
	self:MoveCursor(0,1)
	--down
    elseif keyCode == 29 then
        print("down") 
    self:MoveCursor(0,-1)
    --left 
	elseif keyCode == 26 then
        print("left")         
	self:MoveCursor(-1,0)
	--right 
	elseif keyCode == 27 then
	    print("right")
    self:MoveCursor(1,0)		
	
    --A--上一个
	elseif keyCode == 124 then
        print("上一个")         
	self:SwithCursor(-1)  
    --S--下一个
	elseif keyCode == 142 then
        print("下一个")         
	self:SwithCursor(1) 
				
	
    --W
	elseif keyCode == 146 then
        print("放置一个")
	self:Place() 
	--delete
	elseif keyCode == 23 then
        print("删除一个")         
	self:Delete() 		 
	--F3加载文件
	elseif keyCode == 49 then
        print("Loaded键")         
	self:Load()
	
    --F4保存文件
	elseif keyCode == 50 then
        print("save键")         
	self:Save()
        
	end		
end	
         
		local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(keyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
        
		local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
			 
end
 
 
 --上下左右移动光标
 function EditorScene:MoveCursor(deltaX,deltaY)
         


		print("[self.curX,self.curY]",self.curX,self.curY)
		print("[self.cur:SetPos]",self.curX + deltaX,self.curY + deltaY)
	self.cur:SetPos(self.curX + deltaX,self.curY + deltaY)
    self.curX = self.cur.x	
    self.curY = self.cur.y 
      
		
 end

---可以切换障碍物 delta=1为上一个，-1位下一个
function  EditorScene:SwithCursor(delta)
  
  if self.cur == nil then
    
    self.cur = Block.new(self)
	
  end

  local newIndex = self.curIndex + delta
  newIndex = math.max( newIndex,1)
  newIndex = math.min( newIndex,cMaxBlock)

  self.curIndex = newIndex
  self.cur:Set(newIndex)
  self.cur:SetPos(self.curX,self.curY)
  -- print("[self.cur.index]",self.cur.index)
  
  print("[block.sp]",str)
end

--放置一个物体
function EditorScene:Place()
  
  if self.blockFactory:Hit(self.cur.x,self.cur.y)then
  return
  end
  print("[ self.blockFactory:Add(self.curX,self.curY,self.cur.index)]",self.curX,self.curY,self.cur.index)
  self.blockFactory:Add(self.curX,self.curY,self.cur.index)

end

--删除一个物体
function EditorScene:Delete()
  
  self.blockFactory:Remove(self.curX,self.curY)  
    
end

--lua文件存盘F4
function EditorScene:Save()
  
  local f = assert(io.open("scene.lua","w"))
  
  f:write("return{\n")
  self.blockFactory:Save(f)
  f:write("}\n")
  
  f:close()
  
  print("saved")
   
  
end

--F3加载文件
function EditorScene:Load()
  
  local f = assert(dofile("scene.lua"))
  
  --加载文件之前先清除桌面上的物体
  self.blockFactory:Reset()
  
  for _,t in ipairs (f)do
     
     	 self.blockFactory:Add(t.x,t.y,t.index)
  
  end

  print("Loaded")
  
end
  
  
  

  

return EditorScene