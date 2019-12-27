-- require("Cocos2d")
-- require("Cocos2dConstants")
require("SystemConst")

local size = cc.Director:getInstance():getWinSize()
local defaults = cc.UserDefault:getInstance()
local listener 

local GameOverScene = class("GameOverScene",function (  )
	-- body
	return cc.Scene:create()
end)

function GameOverScene.create( score )
	-- body
	local scene = GameOverScene.new(score)
	scene:addChild(scene:createLayer())
	return scene

end
function GameOverScene:ctor(score)
	-- body
	self.score = score

	----场景生命周期函数
	local function onNodeEvent(event)
		if event == "enter" then
			self:onEnter()
		elseif event == "enterTransitionFinish"then
			self:onEnterTransitionFinish()
		elseif event== "exit" then
			self:onExit()
		elseif event == "onExitTransitionStart"then
			self:onExitTransitionStart()
		elseif event == "cleanup"then
			self:cleanup()
		end
		
	end
	self:registerScriptHandler(onNodeEvent)
end
---create layer
function GameOverScene:createLayer()
	local layer  = cc.Layer:create()

	---add bg sprite
	local bg = cc.TMXTiledMap:create("res/large/map/red_bg.tmx")
	layer:addChild(bg)

	local top = cc.Sprite:createWithSpriteFrameName("gameover.page.png")
	top:setPosition(cc.p(size.width/2,size.height-60))
	top:setScale(0.5)
	layer:addChild(top)

	local defaults = cc.UserDefault:getInstance()
	local highScore = defaults:getIntegerForKey(HIGHSCORE_KEY,0)
	if highScore < self.score then
		highScore = self.score
		defaults:setIntegerForKey(HIGHSCORE_KEY,highScore)
	end

	local text = string.format( "%i points",highScore )
	local labHighScore = cc.Label:createWithTTF( "最高分：","res/fonts/hanyi.ttf",25)
	labHighScore:setColor(cc.c3b(75,255,255))
	-- labHighScore:setAnchorPoint(cc.p(0,0))
	-- local topX,topY = top:getPosition()
	labHighScore:setPosition(cc.p(size.width/2-80,size.height/2))
	layer:addChild(labHighScore)
	
	local labScore = cc.Label:createWithTTF(text,"res/fonts/hanyi.ttf",30 )
	labScore:setColor(cc.c3b(75,255,255))
	-- labScore:setAchorPoint(cc.p(0,0))
	-- local labHighScoreX,labHighScoreY = labHighScore:getPosition()
	-- labScore:setPosition(cc.p(labHighScoreX,labHighScoreY - 40))
    labScore:setPosition(cc.p(size.width/2 +50,size.height/2))
	layer:addChild(labScore)

	--接触事件回调函数
    local function touchBegan(touch, event)
        --播放音效
        if defaults:getBoolForKey(SOUND_KEY)  then
            AudioEngine.playEffect(sound_1)
        end
        cc.Director:getInstance():popScene()
        return false
    end

    --注册 触摸事件监听器
    listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    -- EVENT_TOUCH_BEGAN事件回调函数
    listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN)

    -- 添加 触摸事件监听器
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)



	return layer
end
function GameOverScene:onEnter(  )
	-- body
	print("onEnter")
end
function GameOverScene:onEnterTransitionFinish( ... )
	-- body
	print("onEnterTransitionFinish")
end
function GameOverScene:onExit( ... )

	-- 移除监听
	if listener~= nil then
		cc.Director:getInstance():getEventDispatcher():removeEventListener(listener)
	end
end
function GameOverScene:onExitTransitionStart( ... )
	-- body
	print("onExitTransitionStart")
end
function GameOverScene:cleanup( ... )
	-- body
	print("cleanup")
end
return GameOverScene