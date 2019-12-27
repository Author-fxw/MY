
local GamePlayScene = class("GamePlayScene",function (  )
	-- body
	-- return cc.Scene:create()
	local scene = cc.Scene:createWithPhysics()
	scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)-----调试模式
	scene:getPhysicsWorld():setGravity(cc.p(0,0))-----物理世界设置为不受重力影响
	return scene
end)

function GamePlayScene.create(  )
	-- body
	local scene = GamePlayScene.new()
	return scene
end
local size = cc.Director:getInstance():getWinSize()
local defaults = cc.UserDefault:getInstance()

require ("SystemConst")
local Enemy = require("app.sprite.Enemy")
local Fighter = require("app.sprite.Fighter")
local Bullet = require("app.sprite.Bullet")
local touchFighterlistener
local contactListener
local scheduler = cc.Director:getInstance():getScheduler()
local schedulerId = nil
local score = 0 ----玩家分数
local scorePlaceholder = 0 ----得分值

function GamePlayScene:ctor( )
	-- body
	print("GamePlayScene init")
	self:addChild(self:createInitBGLayer())
	--场景生命周期事件
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

	-- ---创建物理世界的边界，创建node，把创建的物理body添加到node，然后node再添加到物理世界中
	-- local size = display.size
	-- local body = cc.PhysicsBody:createEdgeBox(size,cc.PHYSICSBODY_MATERIAL_DEFAULT,2)----参数（边界大小、材质、边缘像素值）
    --       body:setCategoryBitmask(0x01)-- 设置物体类别掩码
    --       body:setCollisionBitmask(0x02)-- 设置物体碰撞掩码
    --       -- 以上保证，自己类别，不会碰撞爆炸
	--       body:setContactTestBitmask(0x01) 
    -- local edgeNode = display.newNode()
    -- edgeNode:setPosition(size.width/2,size.height/2)
    -- edgeNode:setPhysicsBody(body)
    -- self:addChild(edgeNode)

end

---创建背景layer
function GamePlayScene:createInitBGLayer(  )
	-- body
	print("GamePlayScene bg layer init")
	local bglayer = cc.Layer:create()
	local bg = cc.TMXTiledMap:create("res/large/map/blue_bg.tmx")
	bglayer:addChild(bg,0,GameSceneNodeTag.BatchBackground)

	---放置发光粒子背景
	local ps = cc.ParticleSystemQuad:create("res/particle/light.plist")
	ps:setPosition(cc.p(size.width/2,size.height/2))
	bglayer:addChild(ps,0,GameSceneNodeTag.BatchBackground)---参数（ 节点对象、 优先级、 Tag）

	---添加背景精灵 sprite1
	local sp1 = cc.Sprite:createWithSpriteFrameName("gameplay.bg.sprite-1.png")
	sp1:setPosition(cc.p(-50,-50))
	bglayer:addChild(sp1,0,GameSceneNodeTag.BatchBackground)

	local act1 = cc.MoveBy:create(20,cc.p(500,600))
	local act2 = act1:reverse()
	local sq1 = cc.Sequence:create(act1,act2)
	sp1:runAction(cc.RepeatForever:create(cc.EaseExponentialInOut:create(sq1)))

	---添加背景精灵 sprite2
	local sp2 = cc.Sprite:createWithSpriteFrameName("gameplay.bg.sprite-2.png")
	sp2:setPosition(cc.p(size.width,0))
	bglayer:addChild(sp2,0,GameSceneNodeTag.BatchBackground)

    -----背景精灵移动
	local act3= cc.MoveBy:create(10,cc.p(-500,600))
	local act4 = act3:reverse()
	local sq2= cc.Sequence:create(act3,act4)
	sp2:runAction(cc.RepeatForever:create(cc.EaseExponentialInOut:create(sq2)))


return  bglayer
end

----创建mainlayer 层 
function GamePlayScene:createLayer()
	   mainLayer = cc.Layer:create()
	     ---暂停菜单回调
  
---[[测试physics]]
    -- local oneSprite = display.newSprite("res/HelloWorld.png")
    -- -- local oneBody = cc.PhysicsBody:createBox(oneSprite:getContentSize(),cc.PHYSICSBODY_MATERIAL_DEFAULT,cc.p(0,0))  --矩形刚体
    -- local oneBody = cc.PhysicsBody:createCircle(25,cc.PHYSICSBODY_MATERIAL_DEFAULT,cc.p(0,0))      --圆形刚体   
    --  oneSprite:setPhysicsBody(oneBody)
    --  oneSprite:setPosition(cc.p(display.cx,display.cy))
    --  oneSprite:setScale(0.5)
    --  mainLayer:addChild(oneSprite)
    -- -- 添加陨石1
	local stone1 = Enemy.create(EnemyTypes.Enemy_Stone)

    mainLayer:addChild(stone1, 10, GameSceneNodeTag.Enemy)
    -- --添加行星
	local planet = Enemy.create(EnemyTypes.Enemy_Planet)
	planet:setScale(0.7)
    mainLayer:addChild(planet, 10, GameSceneNodeTag.Enemy)
    -- 添加敌机1
    local enemyFighter1 = Enemy.create(EnemyTypes.Enemy_1)
    mainLayer:addChild(enemyFighter1, 10, GameSceneNodeTag.Enemy)
    -- 添加敌机2
    local enemyFighter2 = Enemy.create(EnemyTypes.Enemy_2)
    mainLayer:addChild(enemyFighter2, 10, GameSceneNodeTag.Enemy)
    ---添加飞机
    fighter = Fighter.create("gameplay.fighter.png")
    fighter:setPosition(cc.p(size.width / 2, 90))
    fighter:setScale(0.5)
    mainLayer:addChild(fighter, 10, GameSceneNodeTag.Fighter)
    ----添加子弹
	 local function shootBulet()
		-- body
		if	 nil ~= fighter and fighter:isVisible() then
			local bullet =  Bullet.create("gameplay.bullet.png")
			mainLayer:addChild(bullet,0,GameSceneNodeTag.Bullet)
			bullet:showBulletFromFighter(fighter)
		end
	end
	
	
    -- 碰撞检测事件回调
    local function onContactBegin(contact)
        local spriteA = contact:getShapeA():getBody():getNode()
        local spriteB = contact:getShapeB():getBody():getNode()

        local enemy1 = nil
		----------------------------检测飞机与敌人的接触  start----------------------------------
		if spriteA:getTag() == GameSceneNodeTag.Fighter and
		   spriteB:getTag() == GameSceneNodeTag.Enemy then
			enemy1 = spriteB	
		end
		if spriteA:getTag() == GameSceneNodeTag.Enemy and
		   spriteB:getTag() == GameSceneNodeTag.Fighter then
			enemy1 = spriteA
		end
		if nil ~= enemy1 then
			print("enemy1 飞机与敌人发生了接触")
			self:handleFightCollidingWithEnemy(enemy1)
		end
		
	    ---------------------------- end------------------------------------

        --------------------------检测 炮弹与敌人的接触  start--------------------------------
        local enemy2 = nil
		if spriteA:getTag() == GameSceneNodeTag.Bullet and 
		   spriteB:getTag() == GameSceneNodeTag.Enemy then
            -- 不可见的炮弹不发生接触
            if spriteA:isVisible() == false then
                return false
            end
            -- 使得炮弹不可见
            spriteA:setVisible(false)
            -- spriteA = nil
            enemy2 = spriteB
        end
		if spriteB:getTag() == GameSceneNodeTag.Bullet and 
		   spriteA:getTag() == GameSceneNodeTag.Enemy then
            --不可见的炮弹不发生接触 
            if spriteB:isVisible() == false then
                return false
            end
            -- 使得炮弹不可见
            spriteB:setVisible(false)
            -- spriteB = nil
            enemy2 = spriteA
        end

		if nil ~= enemy2 then   ---发生了接触 
			
			self:handleBulletCollidingWithEnemy(enemy2)
			print("子弹与敌人发生了接触")
        end
        --------------------------检测 炮弹与敌人的接触 end----------------------------------
        return false
    end
    -- 接触事件检测
	local function touchBegan(touch, event)
		
        return true
    end
    local function touchMoved(touch, event)
        local node = event:getCurrentTarget()
        local currentPosX, currentPosY = node:getPosition()
        local diff = touch:getDelta()
        --- 移动当前按钮精灵的坐标位置
        node:setPos(cc.p(currentPosX + diff.x, currentPosY + diff.y))
	end
	----创建一个事件监听器onebyone为单点触摸
    touchFighterListener = cc.EventListenerTouchOneByOne:create()
    touchFighterListener:setSwallowTouches(true)---设置是否吞没，在ontouchbegan方法返回true时吞没
    touchFighterListener:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    touchFighterListener:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)

   local eventDispatcher =cc.Director:getInstance():getEventDispatcher()
      eventDispatcher :addEventListenerWithSceneGraphPriority(touchFighterListener, fighter)

     --创建接触事件监听器
    contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, 
	    cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
     ---添加监听器
        eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, mainLayer)

	 ----返回主页菜单回调
	   local function menuBackCallback( sender )
	   	  -- body
	   	  print("menuBackCallback")
			 cc.Director:getInstance():popScene()
	   	  if defaults:getBoolForKey(SOUND_KEY)then
	   	  	AudioEngine.playEffect(sound_1)
	   	  end
	   end 
	   -----继续游戏菜单回调
	   local function menuResumeCallback()
	   	 -- body
	   	 print("menuResumeCallback")
	   	 if defaults:getBoolForKey(SOUND_KEY)then
	   	 	AudioEngine.playEffect(sound_1)
	   	 end
	   	 mainLayer:resume()
	   	 schedulerId = nil
	   	 schedulerId = scheduler:scheduleScriptFunc(shootBulet,0.5,false)

	   	 ---层子节点 子弹继续
	   	 local pChildren = mainLayer:getChildren()

	   	 for i=1,#pChildren,1 do
	   	 	local child = pChildren[i]
	   	 	child:resume()

	   	 end
	   	 mainLayer:removeChild(menu)
	   end 
	   ----暂停游戏回调
	local function menuPauseCallback(sender )
	   	-- body
	   	print("menuPauseCallback")
	   	if defaults:getBoolForKey(SOUND_KEY)then
	   		AudioEngine.playEffect(sound_1)
	   end

	   ----暂停当前场景中的node
	   mainLayer:pause()
	   if(schedulerId ~=nil)then
	   	  scheduler:unscheduleScriptEntry(schedulerId)
	   end
	   ---layer zi jie dian pause
	   local pChildren = mainLayer:getChildren()
	   for i = 1, #pChildren, 1 do
	   	 local child = pChildren[i]
	   	 child:pause()
	   end
	  
	   
	   ---返回主菜单
	   local backNormal = cc.Sprite:createWithSpriteFrameName("button.back.png")
	   local backSelected = cc.Sprite:createWithSpriteFrameName("button.back-on.png")
	   local backMenuItem = cc.MenuItemSprite:create(backNormal,backSelected)
	   backMenuItem:registerScriptTapHandler(menuBackCallback)

	   ----继续游戏菜单
	   local resumeNormal = cc.Sprite:createWithSpriteFrameName("button.resume.png")
	   local resumeSelected = cc.Sprite:createWithSpriteFrameName("button.resume-on.png")
	   local resumeMenuItem = cc.MenuItemSprite:create(resumeNormal,resumeSelected)
	   resumeMenuItem:registerScriptTapHandler(menuResumeCallback)

	   menu =cc.Menu:create(backMenuItem,resumeMenuItem)
	   menu:alignItemsVertically()
	   menu:setPosition(cc.p(size.width/2,size.height/2))

	   mainLayer:addChild(menu,50,1000)
	end

	----初始化暂停按钮
	local pauseSrpite = cc.Sprite:createWithSpriteFrameName("button.pause.png")
	local pauseMenuItem = cc.MenuItemSprite:create(pauseSrpite,pauseSrpite)
	pauseMenuItem:registerScriptTapHandler(menuPauseCallback)

	local pauseMenu = cc.Menu:create(pauseMenuItem)
	pauseMenu:setPosition(cc.p(30,size.height-28))

	mainLayer:addChild(pauseMenu,300,999)
	
	schedulerId = scheduler:scheduleScriptFunc(shootBulet, 0.5, false)----进入场景时调用时间调度器
	
	self:updateStatusBarFight()
	self:updateStatusBarScore()
    return mainLayer
end

----处理子弹与敌人接触
function GamePlayScene:handleBulletCollidingWithEnemy(enemy2)
	-- body
	enemy2.hitPoints = enemy2.hitPoints - 1
	if enemy2.hitPoints <= 0 then
		---炮炸和音效
		local node  = mainLayer:getChildByTag(GameSceneNodeTag.ExplosionParticleSystem)
		if nil ~= node then
			self:removeChild(node)
		end
		local explosition = cc.ParticleSystemQuad:create("res/particle/explosion.plist")---炮炸
		explosition:setPosition(enemy2:getPosition())
		self:addChild(explosition,2,GameSceneNodeTag.ExplosionParticleSystem)
		if defaults:getBoolForKey(SOUND_KEY) then
			AudioEngine.playEffect(sound_2)----音效
		end
        -----判断接触的物体类型增加对应分数
		if enemy2.enemyType == EnemyTypes.Enemy_Stone then
			score = EnemyScores.Enemy_Stone + score
			scorePlaceholder = EnemyScores.Enemy_Stone + scorePlaceholder
		elseif enemy2.enemyType == EnemyTypes.Enemy_Planet then
			score = EnemyScores.Enemy_Planet + score
			scorePlaceholder = EnemyScores.Enemy_Planet + scorePlaceholder
		elseif enemy2.enemyType == EnemyTypes.Enemy_1 then
			score = EnemyScores.Enemy_1 + score
			scorePlaceholder = EnemyScores.Enemy_1 + scorePlaceholder
		elseif enemy2.enemyType == EnemyTypes.Enemy_2 then
			score = EnemyScores.Enemy_2 + score
			scorePlaceholder = EnemyScores.Enemy_2 + scorePlaceholder
		end 
		---每次得分支1000分，当前 生命值加 1 soceplaceholder 恢复为 0
		if scorePlaceholder >= 85 then
			-- body
			fighter.hitPoints = fighter.hitPoints + 1
			self:updateStatusBarFight() --- 更新状态栏中玩家的生命值
			scorePlaceholder = scorePlaceholder - 85
		end
		enemy2:setVisible(false)---设置敌人不可见
		enemy2:spawn() ----重置位置
		self:updateStatusBarScore()---更新状态栏中玩家的分值
	
	end
end

----处理飞机与敌人接触
function GamePlayScene:handleFightCollidingWithEnemy(enemy1)
	-- body
	self:removeChildByTag(GameSceneNodeTag.ExplosionParticleSystem)--yi chu li zi te xiao
	local explosition = cc.ParticleSystemQuad:create("res/particle/explosion.plist")
	explosition:setPosition(fighter:getPosition())
	self:addChild(explosition,2,GameSceneNodeTag.ExplosionParticleSystem)
	if defaults:getBoolForKey(SOUND_KEY)then
		AudioEngine.playEffect(sound_2)
	end
	
	----设置飞机消失
	fighter.hitPoints = fighter.hitPoints - 1
	----设置敌人消失
	enemy1:setVisible(false)
	enemy1:spawn()
	
	self:updateStatusBarFight()---更新飞机生命值
	-- fighter:setVisible(false)
	

	----飞机的生命值小于 = 0 执行 
	if fighter.hitPoints <= 0 then
		print("Game Over")
		local gameoverScene = require("app.scenes.GameOverScene")
		local scene = gameoverScene.create(score)
		local tsc = cc.TransitionFade:create(1.0,scene)
		cc.Director:getInstance():pushScene(tsc)
	else
		-----飞机发生接触生命值大于 0 则重置位置
		fighter:setPosition(cc.p(size.width/2,70))
		local ac1 = cc.Show:create()
		local ac2 = cc.FadeIn:create(1.0)
		local seq = cc.Sequence:create(ac1,ac2)
		fighter:runAction(seq)
	end
end

------显示玩家得分栏设置
function GamePlayScene:updateStatusBarScore(  )
	-- body
	mainLayer:removeChildByTag(GameSceneNodeTag.StatusBarScore)
	if score <= 0 then
		score = 0
	end
	local strScore = string.format(" %d ",score)
	local scorelable = cc.Label:createWithTTF(strScore,"res/fonts/hanyi.ttf",50)
	scorelable:setPosition(cc.p(size.width/2,size.height - 28))
	mainLayer:addChild(scorelable,20,GameSceneNodeTag.StatusBarScore)

end

-----显示状态栏中玩家的生命值
function GamePlayScene:updateStatusBarFight()
	----移除上次的精灵
	mainLayer:removeChildByTag(GameSceneNodeTag.StatusBarFighterNode)
	local fg = cc.Sprite:createWithSpriteFrameName("gameplay.life.png")
	fg:setPosition(cc.p(size.width - 60,size.height-28))
	mainLayer:addChild(fg,20,GameSceneNodeTag.StatusBarFighterNode)
     print("1111111111111111111111")
	--添加生命值
	mainLayer:removeChildByTag(GameSceneNodeTag.StatusBarFighterNode)

	if fighter.hitPoints < 0 then
		fighter.hitPoints = 0
	end

	local life = string.format(" %d ",fighter.hitPoints)
	local LifeLabel = cc.Label:createWithTTF(life,"res/fonts/hanyi.ttf",30)
	local fgx,fgy = fg:getPosition()
	LifeLabel:setPosition(cc.p(fgx + 35,fgy))
	mainLayer:addChild(LifeLabel,20,GameSceneNodeTag.StatusBarFighterNode)
end

function GamePlayScene:onEnter(  )----场景中除了背景层中的精灵外，还有很多精灵等在每次显示游戏场景时都要初始化，
	------我们把初始化放在onEnter，onEnterTransitionFinish，createrLayer里面实现。主要在onEnter里实现
	-- body
	print("GamePlayScene onEnter")
	self:addChild(self:createLayer())----初始话mainlayer 层
end

function GamePlayScene:onEnterTransitionFinish()
    print("GamePlayScene onEnterTransitionFinish")-----播放背景音乐
    if defaults:getBoolForKey(MUSIC_KEY) then
        AudioEngine.playMusic(bg_music_2, true)
    end
end

function GamePlayScene:onExit(  )
	-- body
	print("GamePlayScene onExit")
-- 	---STOP scheduler   ----退出游戏 停止调度
	if schedulerId ~= nil then
		scheduler:unscheduleScriptEntry(schedulerId)
	end
-- 	---注销触摸事件监听
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	if nil~= touchFighterlistener then
		eventDispatcher:removeEventListener(touchFighterlistener)
	end
	-----注销接触检测事件监听
	if contactListener ~= nil then
		eventDispatcher:removeEventListener(contactListener)
	end
-- 	---删除layer 节点 及其字节点
	mainLayer:removeAllChildren()
	mainLayer:removeFromParent()
	mainLayer = nil

end
function GamePlayScene:onExitTransitionStart()
    print("GamePlayScene onExitTransitionStart")
end
function GamePlayScene:cleanup()
    print("GamePlayScene cleanup")
end
return GamePlayScene