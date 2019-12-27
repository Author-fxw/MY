local AboutScene = class("AboutScene", cc.load("mvc").ViewBase)



function AboutScene:onEnter( )
	-- body
self:init()
end

function AboutScene:init()
	-- body

	---背景图片
	display.newSprite("res/loading.png")
	:setAnchorPoint(0,0)
	:setScaleY(1.2)
	:setPosition(0,0)
	:addTo(self)

	---标题
	local title = cc.Sprite:create("res/menuTitle.png",cc.rect(0,34,100,36))
	title:setPosition(display.cx,display.cy + 150)
	:addTo(self)

	  cc.Label:createWithSystemFont("Helloc Body", "arial", 20)
      :setPosition(display.cx,display.cy)
      :addTo(self)

	local text = [[
		his showcase utilizes many features from Cocos2d-html5 engine, including: Parallax background, tilemap, actions, ease, frame animation, schedule, Labels, keyboard Dispatcher, Scene Transition. 
    Art and audio is copyrighted by Enigmata Genus Revenge, you may not use any copyrigted material without permission. This showcase is licensed under GPL. 
	]]
  
--[[	local about = ui.newTTFLabel({
		text = text,
		font = "Arial", 
		size = 14,
		align = display.TEXT_ALIGN_LEFT,
        dimensions = ui.size(display.width * 0.90, 0)
    })
    about:setPosition(display.cx, display.cy - 20)
    about:setAnchorPoint(0.5, 0.5)
	self:addChild(about)--]]

	--go back按钮
	ccui.Button:create("res/goback.png")
	:setTitleText("go back")
	:setPosition(display.cx,display.cy-50)
	:addTo(self)
    :addTouchEventListener(function(sender,event)
    	self:getApp():enterScene("MainScene")


end)
   
end

return AboutScene