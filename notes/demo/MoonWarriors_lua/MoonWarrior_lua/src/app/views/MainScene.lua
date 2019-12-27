
local MainScene = class("MainScene", cc.load("mvc").ViewBase) 
local player = require("app.player")

local bg01
local bg02

local director = cc.Director:sharedDirector()
local soundEngine = SimpleAudioEngine:getInstance()

function MainScene:onCreate()

  --  self.hero = player.new(self)

    -- add background image
        bg01 = cc.Sprite:create("res/bg01.jpg")
        bg01:setPosition(0,0)
        bg01:setAnchorPoint(cc.p(0,0))
        bg01:addTo(self)

        bg02 = cc.Sprite:create("res/bg01.jpg")
        bg02:setPosition(0,bg01:getPositionY() + bg01:getContentSize().height)
        bg02:setAnchorPoint(cc.p(0,0))
        bg02:addTo(self)


    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

---跑马灯
-- local braodWidth = 150 --跑马灯的长度 
--     local label = cc.Label:createWithSystemFont("关于--------------hahhahdasdfwetf,asdlfawefasf","Microsoft YaHei",25) 
--      :setPosition(cc.p(0,0)) 
--      :setAnchorPoint(cc.p(0,0)) 
--     local labelWidth = label:getContentSize().width 
--     local time = 3 -- 这里可以根据label多长动态计算时间 
--     local scrollViewLayer = cc.Layer:create():setPosition(cc.p(0,0)) 
--     scrollViewLayer:setContentSize(label:getContentSize()) 
 
--     local scrollView1 = cc.ScrollView:create() 
--     if nil ~= scrollView1 then 
--         scrollView1:setViewSize(cc.size(braodWidth, 100)) 
--         scrollView1:setPosition(cc.p(display.cx-50, display.cy+250)) 
--         scrollView1:setDirection(cc.SCROLLVIEW_DIRECTION_NONE ) 
--         scrollView1:setClippingToBounds(true) 
--         scrollView1:setBounceable(true)
--          scrollView1:setTouchEnabled(false) 
--     end 
--     scrollView1:addChild(label) 
--     self:addChild(scrollView1) 
 
--     -- if nil ~= scrollViewLayer_ then 
--     --     scrollView1:setContainer(scrollViewLayer) 
--     --     scrollView1:updateInset() 
--     -- end 
--     if labelWidth > braodWidth  then 

--      local leftAction = cc.MoveBy:create(time,cc.p(braodWidth -labelWidth ,0)) 
--      local rightAction = cc.MoveBy:create(time,cc.p(labelWidth - braodWidth,0)) 
--      local seqAction = cc.Sequence:create(leftAction,rightAction) 
--      label:runAction(cc.RepeatForever:create(seqAction)) 
  
--     end
--------------------- 
local function tick( )
	-- body

	---bg图片 滚动
	local speed = 5
	bg01:setPositionY(bg01:getPositionY() - speed)
	bg02:setPositionY(bg01:getPositionY() + bg01:getContentSize().height)

	if bg02:getPositionY() <= 0 then
		bg01:setPositionY(0)
	end

end 

cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,1.0/60.0,false)
soundEngine:playBackgroundMusic("res/Music/bgMusic.mp3",true)

-- -------------序列帧动画
    cc.SpriteFrameCache:getInstance():addSpriteFrames("explosion.plist")

    local sp = cc.Sprite:createWithSpriteFrameName("explosion_02.png")
    sp:setPosition(cc.p(display.cx,display.cy))
    sp:addTo(self)

    local animation = cc.Animation:create()
    for i = 1,4 do
    	local framname = string.format("explosion_%d.png",i)
    	print("framname + %s",framname)
    	local _frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(framname)
    	animation:addSpriteFrame(_frame)
    end

    animation:setDelayPerUnit(0.15)
    -- animation:setLoops(-1)
    animation:setRestoreOriginalFrame(true)

    local action = cc.Animate:create(animation)
 --   sp:runAction(cc.REPEAT_FOREVER(action))

end

return MainScene
