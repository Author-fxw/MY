local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)





function PlayScene:ctor(  )
	-- body
    --绘制框
	-- local rect = cc.DrawNode:create() 
 --    :setPosition(display.cx,display.cy)

 --    :setIgnoreAnchorPointForPosition(false)

	-- :setAnchorPoint(cc.p(0.5,0.5))
	-- :addTo(self)
	-- :drawRect(cc.p(0,0),cc.p(300,300),cc.c4f(1.0,0,0,1.0))

	-- local a = rect:getAnchorPoint()

	-- print("aaaaaaaaaa",a.x,a.y)
    --绘制第一个点
	-- local dot = cc.DrawNode:create()
	-- :addTo(rect)
	-- :setPosition(50,50)
	-- dot:drawDot(cc.p(0,0),15,cc.c4f(1,1,1,1))
    ---绘制第二个点
  --[[   local dot = cc.DrawNode:create()
	:addTo(self)
	:setPosition(display.cx,display.cy)

	dot:drawDot(cc.p(0,0),15,cc.c4f(1,1,1,1))
		local angle = 0
	self:getScheduler():scheduleScriptFunc(function (  )--]]
		-- 框的旋转
		--rect:rotate(rect:getRotation()+1)
		
		---点的旋转
   --[[     dot:setPositionX(display.cx + math.cos(angle)*100)
		dot:setPositionY(display.cy + math.sin(angle)*100)--]]
		-- dot:setPosition(display.cx+math.sin(angle)*100,display.cy+math.cos(angle)*100)
	--[[	angle = angle + 1--]]


		-- local p = dot:convertToWorldSpace(cc.p(0,0))
		-- print("px,py",p.x,p.y)

	-- end,0.1,false)
	   local sp =  display.newSprite("box.png")
        :move(display.center)
        :addTo(self)
        :setScale(0.5)
        :setVisible(true)


	---使用向量控制小球的移动
	local dir = cc.p(math.random(-1,1),math.random(-1,1))
	cc.pNormalize(dir)

	local point = cc.DrawNode:create()
	:addTo(self)
	:drawDot(cc.p(0,0),15,cc.c4f(1,1,1,1))
	


	self:getScheduler():scheduleScriptFunc(function (  )
		-- body
		local px,py = point:getPosition()
		if px <0 or px> display.width then
			dir.x = dir.x * -1
		elseif py<0 or py >display.height then
			dir.y = dir.y * -1
		end

		--计算一个sp与小球方向向量
	local spx,spy= sp:getPosition() 
	local pointx,pointy= point:getPosition()

	-- cc.pNormalize(dir2)

	--旋转弧度
	local hd = math.atan2(spy-pointy,spx-pointx)
	--转成角度
	 local angle = hd * 180/math.pi
		---sp旋转
		sp:rotate(angle)

		
    point :setPosition(
     	px + dir.x* 50,
     	py + dir.y* 50

     	)
     print("[dirx,diry]",dir.x ,dir.y )

	end,0.1,false)
     
     print("----------")
     local x = math.atan2(5-3,5-3)---计算两点间连线的倾斜角
     print("弧度",x)
     x = x*180/math.pi
     print("角度",x)

end

return PlayScene