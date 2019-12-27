

local TileScene = class("TileScene", cc.load("mvc").ViewBase)


function TileScene:onEnter( )
	-- body

	ccui.Button:create("block.png")
	:setPosition(display.cx,display.cy)
	:setScale(1.5)
	:setTitleText("开始")
	:addTo(self)
	:addTouchEventListener(function ( sender,event )
		-- body
		self:getApp():enterScene("MainScene")
	end)

	ccui.Button:create("block.png")
	:setPosition(display.cx,display.cy-50)
	:setScale(1.5)
	:setTitleText("退出")
	:addTo(self)
	:addTouchEventListener(function ( sender,event)
		-- body
		cc.Director:getInstance():endToLua()
		
	end)
end




return TileScene