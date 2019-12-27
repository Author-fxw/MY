local TitleScene=class("TitleScene",cc.load("mvc").ViewBase)

-- local function createStaticButton(node,imageName,x,y,callback)
-- print("[createStaticButton]",node,imageName,x,y,callback)
--    ccui.Button:create(imageName,imageName)
--    :onButtonClicked(callback)
--    :pos(x,y)
--    :addTo(node)
-- end


function TitleScene:onEnter()
        
    -- display.newSprite("bg.png")
    -- :move(display.cx,display.cy)
    -- :addTo(self,1)
    -- add background image
    --BG背景

    local layer = cc.Layer:create()
    --layer:addTo(self)
    self:addChild(layer)
    layer:addChild(display.newSprite("bg.png"):move(display.center))
    --按钮
    local startBtn = cc.Sprite:create("btn_option.png")
    
    startBtn:move(display.cx-200,display.bottom+80)
    layer:addChild(startBtn)
    local startBtn1 = cc.Sprite:create("btn_exit.png")
    
    startBtn1:move(display.cx,display.bottom+80)
    layer:addChild(startBtn1)
    local startBtn2 = cc.Sprite:create("btn_question.png")
    
    startBtn2:move(display.cx+200,display.bottom+80)
    layer:addChild(startBtn2)

    -- createStaticButton(self,"btn_option.png",display.cx,display.bottom+80,function()
    --     print("option")
    
    -- end)
    --开始按钮
    local function BtnCaback()
     
        print("BtnCaback")
        local s=require("app.views.GameScene"):new()
		print("[app.views.GameScene]",s)
        display.replaceScene(s,"fade",0.6,display.COLOR_BLACK)
		
    
	end
   
    local BtnItem=cc.MenuItemImage:create("btn_start.png","btn_start.png")
    BtnItem:setScale(0.8)
    BtnItem:registerScriptTapHandler(BtnCaback)
    BtnItem:setPosition(cc.p(display.cx,display.cy-100))

    local BtnMenu=cc.Menu:create(BtnItem)
    BtnMenu:setPosition(cc.p(0,0))
    layer:addChild(BtnMenu,2)
    --触摸事件
    local function touchBegan(touch, event)

    local node = event:getCurrentTarget()
    local location = node:convertToNodeSpace(touch:getLocation())
    local targetSize = node:getContentSize()
    local rect = cc.rect(0,0,targetSize.width, targetSize.height)
    if cc.rectContainsPoint(rect, location) then
        --node:setScale(0.5,0.5)
        if node==startBtn then
            print("设置按钮")
          
        elseif node==startBtn1 then
            print("退出按钮")
        elseif node==startBtn2 then
            print("问题")
        end
    end
    return true
end

local function touchMoved(touch, event)
    print("touchMoved")
    return false
end

local function touchEnded(touch, event)
    local node = event:getCurrentTarget()
    node:setScale(1,1)
    return true
end

local function touchCanceled(touch, event)
    print("touchCanceled")
    return false
end


     local listen = cc.EventListenerTouchOneByOne:create()
     listen:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
     listen:registerScriptHandler(touchMoved,cc.Handler.EVENT_TOUCH_MOVED)
     listen:registerScriptHandler(touchEnded,cc.Handler.EVENT_TOUCH_ENDED)
     listen:registerScriptHandler(touchCanceled,cc.Handler.EVENT_TOUCH_CANCELLED)

    --local eventDispatcher = self:getEventDispatcher()
     local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    --eventDispatcher:addEventListenerWithSceneGraphPriority(listen,self)
    local listen1 = listen:clone()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listen1,startBtn1)
    local listen2 = listen:clone()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listen2,startBtn2)


end




return TitleScene