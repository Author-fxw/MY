
local HelpScene = class("HelpScene",function (  )
	-- body
	return cc.Scene:create()
end)

function HelpScene:ctor()
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
function HelpScene.create(  )
	-- 吧crealayer添加到场景上面
	local scene = HelpScene.new()
	scene:addChild(scene:createLayer())
	return scene
end

local size = cc.Director:getInstance():getWinSize()
local default = cc.UserDefault:getInstance()

function HelpScene:createLayer(  )
	-- 初始化层
    print("HelpScene init")
	local layer = cc.Layer:create()
      local bg = cc.TMXTiledMap:create("res/large/map/red_bg.tmx")
      bg:setScale(0.5)
      layer:addChild(bg)

      local top = cc.Sprite:createWithSpriteFrameName("help.page.png")
      top:setScale(0.5)
      top:setPosition(cc.p(size.width/2,size.height - top:getContentSize().height/4))
      layer:addChild(top)

      ---ok Menu Event
      local function menuCallBack( sender )
      	-- body
      	---play effect
      	if default:getBoolForKey(SOUND_KEY) then
      		AudioEngine.playEffect(sound_1)
      	end

      	cc.Director:getInstance():popScene()
      end
      ---ok Menu Item
      local okNormal = cc.Sprite:createWithSpriteFrameName("button.ok.png")
      local okSelected = cc.Sprite:createWithSpriteFrameName("button.ok-on.png")
      local okMenuItem = cc.MenuItemSprite:create(okNormal,okSelected)
      okMenuItem:registerScriptTapHandler(menuCallBack)

      local menu = cc.Menu:create(okMenuItem)
      menu:setPosition(cc.p(size.width/4,20))
      menu:setScale(0.5)
      layer:addChild(menu)

	return layer
end


function HelpScene:onEnter()
    print("HelpScene onEnter")

end
function HelpScene:onEnterTransitionFinish()
    print("HelpScene onEnterTransitionFinish")

end
function HelpScene:onExit()
    print("HelpScene onExit")
end
function HelpScene:onExitTransitionStart()
    print("HelpScene onExitTransitionStart")
end
function HelpScene:cleanup()
    print("HelpScene onCleanup")
end

return HelpScene