
-- local HomeScene = class("HomeScene", cc.load("mvc").ViewBase)
require ("SystemConst")
local CountDown = require("app.scenes.CountDown")
local size = cc.Director:getInstance():getWinSize()
local default = cc.UserDefault:getInstance()

local HomeScene = class("HomeScene", function()
    return cc.Scene:create()
end)

function HomeScene.create()
    print("hello create lua")
    local scene = HomeScene.new()
    scene:addChild(scene:createLayer())
    return scene
end
local run_logic =nil
function HomeScene:ctor()
    --场景生命周期
	local function onNodeEvent( event )
		-- body
		if	event == "enter" then
			self:onEnter()
		elseif event == "enterTransitionFinish" then
			self:onEnterTransitionFinish()
		elseif event == "exit" then
			self:onExit()
		elseif event == "exitTransitionStart"then
			self:onExitTransitionStart()
		elseif event == "cleanup"then
			self:cleanup()
		end

	end 
	self:registerScriptHandler(onNodeEvent)
end

function HomeScene:createLayer(  )
	-- body
	print("HomeScene onEnter")
	local layer = cc.Layer:create()
    self.time = 20

	local bg  = cc.TMXTiledMap:create("res/large/map/red_bg.tmx")
	layer:addChild(bg)
	local top = cc.Sprite:createWithSpriteFrameName("home-top.png")
	top:setScale(0.7)
	layer:addChild(top)
	top:setPosition(cc.p(size.width/2,size.height - top:getContentSize().height/3))
	local buttom = cc.Sprite:createWithSpriteFrameName("home-end.png")
	buttom:setScale(0.5)
	buttom:setPosition(cc.p(size.width/2,buttom:getContentSize().height/2))
	layer:addChild(buttom)

	
   ---添加环形倒计时定时器
   local timer = cc.Sprite:create("goback.png")
	local cd = CountDown:create(timer, 20, 0, 100, function (  )---资源文件，倒计时时间、开始百分比，结束百分比、计时结束回调函数
		print("CountDown end!=========")
			--倒计时结束停止更新
			print("停止更新")
		    if run_logic ~= nil then
			scheduler:unscheduleScriptEntry(run_logic)
			run_logic = nil
			layer:removeChild(timelabel)
		    end
    end)
	cd:setPosition(cc.p(200, 400))
	cd:setScale(4.0)
	layer:addChild(cd)
	cd:start()
   
    local function update()
		print("定时器刷新")
        layer:removeChild(timelabel)
        time = self.time
		time = time -1
		self.time = time
        local str = string.format( "%d",self.time)
		timelabel = cc.Label:createWithTTF(str,"res/fonts/hanyi.ttf",25)
		 timelabel:setColor(cc.c3b(0,255,0))
         timelabel:setPosition(cc.p(200,450))
        layer:addChild(timelabel,2)

     end
     scheduler = cc.Director:getInstance():getScheduler()
	 run_logic = scheduler:scheduleScriptFunc(update,1,false)

	local function MenuItmCallBack(tag,menu )
		-- body 
        --print("[tag]",tag)
            ---play effect 
			if default:getBoolForKey(SOUND_KEY,true) then
			AudioEngine.playEffect(sound_1)
		end
		if tag == HomeMenuActionTypes.MenuItemStart then
               print("开始")
			 -- self:getApp():enterScene("GamePlayScene")
			 local scene = require("app.scenes.GamePlayScene").create()
			 local ts = cc.TransitionCrossFade:create(1,scene)
			 cc.Director:getInstance():pushScene(ts)				
		end
		
		if tag == HomeMenuActionTypes.MenuItemSetting then
			--self:getApp():enterScene("SettingScene")
			local scene = require("app.scenes.SettingScene").create()
			local ts = cc.TransitionCrossFade:create(1,scene)
			cc.Director:getInstance():pushScene(ts)
		end
		
		if tag == HomeMenuActionTypes.MenuItemHelp then
			-- self:getApp():enterScene("HelpScene")
			local scene = require("app.scenes.HelpScene").create()
			local ts = cc.TransitionCrossFade:create(1,scene)
			cc.Director:getInstance():pushScene(ts)
		end
		
	end
	--添加开始游戏菜单
	local startSpriteNoraml = cc.Sprite:createWithSpriteFrameName("button.start.png")
	local startSpriteSelected = cc.Sprite:createWithSpriteFrameName("button.start-on.png")

    local startMenu = cc.MenuItemSprite:create(startSpriteNoraml,startSpriteSelected)
	startMenu:setTag(HomeMenuActionTypes.MenuItemStart)
	startMenu:setScale(0.5)
	startMenu:registerScriptTapHandler(MenuItmCallBack)

    ---setting MenuItem
	local settingSpriteNormal = cc.Sprite:createWithSpriteFrameName("button.setting.png")
	local settingSpriteSelected = cc.Sprite:createWithSpriteFrameName("button.setting-on.png")
	local settingMenu = cc.MenuItemSprite:create(settingSpriteNormal,settingSpriteSelected)
	settingMenu:registerScriptTapHandler(MenuItmCallBack)
	settingMenu:setTag(HomeMenuActionTypes.MenuItemSetting)
	settingMenu:setScale(0.5)
 
    ---help MenuItem  
	local helpSpriteNoraml = cc.Sprite:createWithSpriteFrameName("button.help.png")
	local helpSpriteSelected = cc.Sprite:createWithSpriteFrameName("button.help-on.png")
	local helpMenu = cc.MenuItemSprite:create(helpSpriteNoraml,helpSpriteSelected)
	helpMenu:registerScriptTapHandler(MenuItmCallBack)
	helpMenu:setTag(HomeMenuActionTypes.MenuItemHelp)
	helpMenu:setScale(0.5)
	

	local menu = cc.Menu:create(startMenu,settingMenu,helpMenu)
	menu:setPosition(display.cx,display.cy)
	menu:alignItemsVerticallyWithPadding(10)
	layer:addChild(menu)

	
   return layer
end

---scene life event 
function HomeScene:onEnterTransitionFinish(  )
	-- body
	print("HomeScene onEnterTransitionFinish")
-------进入场景切换音乐
	if default:getBoolForKey(MUSIC_KEY) then
		AudioEngine.playMusic(bg_music_1,true)
	end
end
function HomeScene:onExit(  )
	-- body
	print("HomeScene onExit")
end
function HomeScene:onExitTransitionStart(  )
	-- body
	print(" HomeScene onExitTransitionStart")
end
function HomeScene:cleanup(  )
	-- body
	print("HomeScene cleanup")
end


return HomeScene