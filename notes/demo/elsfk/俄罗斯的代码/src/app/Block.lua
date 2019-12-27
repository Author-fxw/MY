



--[[
方块的类型有七种
1 1 1 
  1
  
  1
1 1
  1 
  ...
]]
local Block = class("Block")

local cBlockArray = {

----使用四维数组

	{--T类型
		{
			{1,1,1,0},
			{0,1,0,0},
			{0,0,0,0},
			{0,0,0,0},
		},
		{
			{0,1,0,0},
			{1,1,0,0},
			{0,1,0,0},
			{0,0,0,0},
		},
		{
			{0,0,0,0},
			{1,1,1,0},
			{0,1,0,0},
			{0,0,0,0},
		},
		{
			{0,1,0,0},
			{0,1,1,0},
			{0,1,0,0},
			{0,0,0,0},
		},

	},

	--方块类型
	{
		{
			{0,1,1,0},
			{0,1,1,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},
	},

	--S型
	{
		{
			{0,1,1,0},
			{1,1,0,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},
		{
			{0,1,0,0},
			{0,1,1,0},
			{0,0,1,0},
			{0,0,0,0},
			
		},

	},

	---Z字型
	{
		{
			{1,1,0,0},
			{0,1,1,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},
		{
			{0,1,1,0},
			{1,1,0,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},

	},

	---I型
	{
		initOffset = 1,
		{
			{0,1,0,0},
			{0,1,0,0},
			{0,1,0,0},
			{0,1,0,0},
			
		},
		{
			{0,0,0,0},
			{1,1,1,1},
			{0,0,0,0},
			{0,0,0,0},
			
		},
	},

	---L型
	{
		initOffset = 1,
		{
			{0,1,0,0},
			{0,1,0,0},
			{0,1,1,0},
			{0,0,0,0},
			
		},
		{
			{0,0,0,0},
			{1,1,1,0},
			{1,0,0,0},
			{0,0,0,0},
			
		},
		{
			{1,1,0,0},
			{0,1,0,0},
			{0,1,0,0},
			{0,0,0,0},
			
		},
		{
			{0,0,1,0},
			{1,1,1,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},
		{
			{0,1,0,0},
			{0,1,0,0},
			{0,1,1,0},
			{0,0,0,0},
			
		},


	},

	---J型
	{
		initOffset = 1,
		{
			{0,0,0,0},
			{1,1,1,0},
			{0,0,1,0},
			{0,0,0,0},
			
		},
		{
			{0,1,0,0},
			{0,1,0,0},
			{1,1,0,0},
			{0,0,0,0},
			
		},
		{
			{1,0,0,0},
			{1,1,1,0},
			{0,0,0,0},
			{0,0,0,0},
			
		},
		{
			{0,1,1,0},
			{0,1,0,0},
			{0,1,0,0},
			{0,0,0,0},
			
		},
	},

}

--随机一种样式
function RandomStyle(  )
	-- body
	return math.random(1,#cBlockArray)

end

local InitXOffset = cSceneWidth/2-3 ---初始位置 X 的偏移

function Block:ctor( scene,index)
 	-- body


    -----初始位置
 	self.x = InitXOffset
 	self.y = cSceneHeight

 	self.scene = scene
 	self.index = index
 	self.trans = 1

 	local offset = cBlockArray[index].initOffset---块类型的偏移值为1 表明四维数组的第一行全部为空
 	if offset then 
 		self.y = self.y + offset---将该块的上移一个位置
 	end

 	----一层一层获取思维数组的data 先取块的类型，再取块的变换类型
 	function IterateBlock(index,trans,callback )---遍历方块
 		-- body
        
 		local BlockTypeArray = cBlockArray[index]---取一种形状
 		local BlockTransType = BlockTypeArray[trans] ---变形
		print("--------------",BlockTransType)
 		for y = 1 , #BlockTransType do
 			
 			local xdata = BlockTransType[y]

 			for x = 1 ,#xdata do  --# 字符串取长度，table取数量
 				
 				local data = xdata[x]

 				if not callback(x,y,data == 1 ) then
					 return false
				 end
 			end

 		end

 		return true
 	end 

function RawPlace( index,trans,scene,newX,newY )--方块的放置在游戏场景
 		-- body
   print("[ RawPlace( index,trans,scene,newX,newY )]",index,trans,scene,newX,newY )
 		local result = {}

 		if IterateBlock (index,trans,function ( x,y,b )--遍历块
			 -- body
			 print("[IterateBlock (index,trans,function ( x,y,b )--遍历块]",index,trans,x,y,b)
 			if  b then
 			
 				local finaX = newX + x
 				local finaY = newY - y
                print("finaX,finaY",finaX,  finaY)
 				if scene:Get(finaX,finaY)then---在场景中找能否放这个方块，如果不能就返回false
 					return false
 				end

 				table.insert( result,{x = finaX, y = finaY } )

 			end

 			return true
 		end) then

 			for k,v in ipairs(result) do
 				
 				scene:Set(v.x,v.y,true)

 			end
 			return true
 		end

 	end
 
end

function Block:Move(deltaX,deltaY)--方块的移动
	-- body
	--先清除--偏移--放置
	self:Clear() 

	local x = self.x + deltaX
	local y = self.y + deltaY

	
	if RawPlace(self.index,self.trans,self.scene,x,y)then
		print("[if RawPlace(self.index,self.trans,self.scene,x,y)then]",self.index,self.trans,self.scene, x,y)
		self.x = x
		self.y = y
		return true

	else
		self:Place()
		return false
	end
end

function Block:Rotate()--方块的变形 旋转
	-- body

	local offset = cBlockArray[self.index].initOffset
	if offset and self.y == 0 then---在底部禁止旋转
		return
	end 
------先清除 旋转 再放置
	   self:Clear()

	local transArray = cBlockArray[self.index]

	local trans = self.trans + 1
	if trans > #transArray then
		trans = 1
	end

	if RawPlace(self.index,trans,self.scene,self.x,self.y)then
		 
		 self.trans =trans
	else
		 self:Place()
	end

end

function Block:Place(  )---把方块直接放上去
	-- body
	return  RawPlace(self.index,self.trans,self.scene,self.x,self.y)

end

function Block:Clear()
	-- body

	IterateBlock(self.index,self.trans,function (x,y,b)
		-- body
		local finaX = self.x + x
		local finaY = self.y - y

		if b then
			self.scene:Set(finaX,finaY,false)
		end

		return true

	end)

end



return Block