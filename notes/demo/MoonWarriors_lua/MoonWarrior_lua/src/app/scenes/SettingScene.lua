
-- local SettingScene = class("SettingScene", cc.load("mvc").ViewBase)
----游戏设置层
local size = cc.Director:getInstance():getWinSize()
local default = cc.UserDefault:getInstance()

local SettingScene = class("SettingScene",function (  )
	-- body
	return cc.Scene:create()
end)

function SettingScene:ctor()
    local function onNodeEvent(event)
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

function SettingScene.create()
    --print("hello create lua")
    local _SettingScene = SettingScene.new()
    _SettingScene:addChild(_SettingScene:createLayer())
    return _SettingScene
end

-- function SettingScene:onEnter( )
-- 	-- body
-- self:createLayer()
-- end
function SettingScene:createLayer( )
	-- body
	print("SettingScene onEnter")

	local layer = cc.Layer:create()
	-- layer:addTo(self)

	local bg = cc.TMXTiledMap:create("res/large/map/red_bg.tmx")
	layer:addChild(bg)

	local top = cc.Sprite:createWithSpriteFrameName("setting.page.png")
	top:setScale(0.5)
	top:setPosition(cc.p(size.width/2,size.height - top:getContentSize().height/4))
	layer:addChild(top)

	---音效
	local soundOnSprite    = cc.Sprite:createWithSpriteFrameName("check-on.png")
	local soundOffSprite   = cc.Sprite:createWithSpriteFrameName("check-off.png")
	local soundOnMenuItem  = cc.MenuItemSprite:create(soundOnSprite,soundOnSprite)
	local soundOffMenuItem = cc.MenuItemSprite:create(soundOffSprite,soundOffSprite)

--------effect callback
	local function menuSoundToggleCallBack( sender )
		-- 设置音效
		 if default:getBoolForKey(SOUND_KEY, false) then
            default:setBoolForKey(SOUND_KEY, false)
        else
            default:setBoolForKey(SOUND_KEY, true)
            AudioEngine.playEffect(sound_1)
        end
	end 
	local soundToggleMenuItem = cc.MenuItemToggle:create(soundOnMenuItem,soundOffMenuItem)
	soundToggleMenuItem:registerScriptTapHandler(menuSoundToggleCallBack)---菜单注册点击事件

--------music callback
	local function menuMusicToggleCallBack(sender )
		-- 设置音乐
		if default:getBoolForKey(MUSIC_KEY,false) then
			default:setBoolForKey(MUSIC_KEY,false)
			AudioEngine.stopMusic(true)
		else
			default:setBoolForKey(MUSIC_KEY,true) 
			AudioEngine.playMusic(bg_music_2,true)
		end
		if default:getBoolForKey(SOUND_KEY) then
		   AudioEngine.playEffect(sound_1)
	    end
	end

	---music menu
	local musicOnSprite    = cc.Sprite:createWithSpriteFrameName("check-on.png")
	local musicOffSprite   = cc.Sprite:createWithSpriteFrameName("check-off.png")
	local musicOnMenuItem  = cc.MenuItemSprite:create(musicOnSprite,musicOnSprite)
	local musicOffMenuItem = cc.MenuItemSprite:create(musicOffSprite,musicOffSprite)
     
	local musicToggleMenuItem = cc.MenuItemToggle:create(musicOnMenuItem,musicOffMenuItem)
	musicToggleMenuItem:registerScriptTapHandler(menuMusicToggleCallBack)
	-- musicToggleMenuItem:setTag(HomeMenuActionTypes.MenuItemSetting)
    local menu = cc.Menu:create(soundToggleMenuItem,musicToggleMenuItem)
    menu:setPosition(cc.p(size.width/2 + 70,size.height/2 + 100))
    
    menu:alignItemsVerticallyWithPadding(8)
    layer:addChild(menu)

    ---OK-call back
    local function menuOkCallBack( sender )
    	-- body
    	cc.Director:getInstance():popScene()
    	if default:getBoolForKey(SOUND_KEY) then
    		AudioEngine.playEffect(sound_1)
    	end
    end 
    ---ok menu
    local okNormal = cc.Sprite:createWithSpriteFrameName("button.ok.png")
    local okSelected = cc.Sprite:createWithSpriteFrameName("button.ok-on.png")
    local okMenuItem = cc.MenuItemSprite:create(okNormal,okSelected)
    okMenuItem:registerScriptTapHandler(menuOkCallBack)

	local ok = cc.Menu:create(okMenuItem)
	ok:setScale(0.5)
    ok:setPosition(cc.p(size.width/4,30))
    layer:addChild(ok)
    
    ---设置音月 音效选中的状态 可有可无
    if default:getBoolForKey(MUSIC_KEY,false) then
    	musicToggleMenuItem:setSelectedIndex(0)
    else
    	musicToggleMenuItem:setSelectedIndex(1)
    end
    if default:getBoolForKey(SOUND_KEY,false) then
    	soundToggleMenuItem:setSelectedIndex(0)
    else
    	soundToggleMenuItem:setSelectedIndex(1)
    end

return layer

end

function SettingScene:onEnter()
    print("SettingScene onEnter")

end
function SettingScene:onEnterTransitionFinish()
    print("SettingScene onEnterTransitionFinish")

end
function SettingScene:onExit()
    print("SettingScene onExit")
end
function SettingScene:onExitTransitionStart()
    print("SettingScene onExitTransitionStart")
end
function SettingScene:cleanup()
    print("SettingScene onCleanup")
end

return SettingScene