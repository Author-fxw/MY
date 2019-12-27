
---敌人精灵类
local Enemy = class("Enemy",function (  )
	-- body
	return cc.Sprite:create()
end)

function Enemy.create(enemyType )
	-- body
	local sprite = Enemy.new(enemyType)
	return sprite
end

local size = cc.Director:getInstance():getWinSize()
-- local body = cc.PhysicsBody:create()
function Enemy:ctor(enemyType  )
	-- body
	---sprite Frame
	local enemyFrameName = EnemyName.Enemy_Stone
	---生命值
	local hitPointsTemp = 0
	---速度
	local velocityTemp = nil

	if enemyType       == EnemyTypes.Enemy_Stone then	
		enemyFrameName = EnemyName.Enemy_Stone
		hitPointsTemp  = Enemy_initialHitPoints.Enemy_Stone
		velocityTemp   = Sprite_Velocity.Enemy_Stone
	elseif	enemyType  == EnemyTypes.Enemy_1 then
		enemyFrameName = EnemyName.Enemy_1
		hitPointsTemp  = Enemy_initialHitPoints.Enemy_1
		velocityTemp   = Sprite_Velocity.Enemy_1
	elseif enemyType   == EnemyTypes.Enemy_2 then
		enemyFrameName = EnemyName.Enemy_2
		hitPointsTemp  = Enemy_initialHitPoints.Enemy_2
		velocityTemp   = Sprite_Velocity.Enemy_2
	elseif enemyType   == EnemyTypes.Enemy_Planet then
		enemyFrameName    = EnemyName.Enemy_Planet
		hitPointsTemp     = Enemy_initialHitPoints.Enemy_Planet
		velocityTemp      = Sprite_Velocity.Enemy_Planet	
	end

	self:setSpriteFrame(enemyFrameName)
	self:setVisible(false)

	---敌人的基本属性
	self.hitPoints = 0                  ---当前的生命值
	self.initHitPoints = hitPointsTemp  ---初始的生命值  
	self.velocityTemp = velocityTemp        ---初始的速度
	self.enemyType = enemyType          ---初始的敌人类型

	local body = cc.PhysicsBody:create()

	if enemyType == EnemyTypes.Enemy_Stone or enemyType == EnemyTypes.Enemy_Planet then
		body:addShape(cc.PhysicsShapeCircle:create(self:getContentSize().width / 2 - 5))
	elseif enemyType == EnemyTypes.Enemy_1 then
		local verts = {
			cc.p(-2.5, -45.75),
            cc.p(-29.5, -27.25),
            cc.p(-53, -0.25),
            cc.p(-34, 43.25),
            cc.p(28, 44.25),
            cc.p(55, -2.25),
		}
		body:addShape(cc.PhysicsShapePolygon:create(verts))
	elseif enemyType == EnemyTypes.Enemy_2 then
		local verts = {
		    cc.p(1.25, 32.25),
            cc.p(36.75, -4.75),
            cc.p(2.75, -31.75),
            cc.p(-35.75, -3.25),
		}
		body:addShape(cc.PhysicsShapePolygon:create(verts))
	end

    body:setCategoryBitmask(0x01)-- 设置物体类别掩码
    body:setCollisionBitmask(0x02)-- 设置物体碰撞掩码
    -- 以上保证，自己类别，不会碰撞爆炸
	body:setContactTestBitmask(0x01) -- 设置接触检测掩码
	self:setPhysicsBody(body)---蒋物体对象添加到敌人精灵上
  

    --  设置接触检测， 是为了，判断与飞机基础，调用爆炸函数
   local function update(delta)
        --    设置陨石与行星的旋转
        if enemyType == EnemyTypes.Enemy_Stone then
            self:setRotation(self:getRotation() - 0.5) -- 逆时针
        elseif enemyType == EnemyTypes.Enemy_Planet then
            self:setRotation(self:getRotation() + 1) --顺时针
        end
        -- 设置移动位置
		local x, y = self:getPosition()
		-- print("...xxxxxx,yyyyyyy",x,y,self.velocityTemp)
		self:setPosition(cc.p(x + self.velocityTemp.x * delta, y + self.velocityTemp.y * delta))
		-- self:setPosition(cc.p(x,display.cy))

        x, y = self:getPosition()
        if y + self:getContentSize().height / 2 < 0 then
            self:spawn()--
        end
    end
  
    self:scheduleUpdateWithPriorityLua(update, 0)
    function onNodeEvent(tag)---节点事件
        if tag == "exit" then
            self:unscheduleUpdate()
        end
    end
    self:registerScriptHandler(onNodeEvent)
    self:spawn()
end 


function Enemy:spawn()---重置位置
	local yPos = size.height + self:getContentSize().height / 2
	local xPos = math.random() * (size.width - self:getContentSize().width) + self:getContentSize().width / 2
	self:setPosition(cc.p(xPos, yPos))
	self:setAnchorPoint(cc.p(0.5, 0.5))

	self.hitPoints = self.initHitPoints
	self:setVisible(true)
end


return Enemy