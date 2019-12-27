
local Fighter = class("Fighter",function (  )
	-- body
	return cc.Sprite:create()
end)

local size = cc.Director:getInstance():getWinSize()
local defaults = cc.UserDefault:getInstance()

function Fighter.create( spriteFrameName )---使用工厂函数创建fighter对象
	-- body
	local fighter = Fighter.new(spriteFrameName)
	return fighter
end

function Fighter:ctor(spriteFrameName )
	-- body
	self.hitPoints = Fighter_hitPoints---当前生命值
	self:setSpriteFrame(spriteFrameName)

----喷火特效在飞机尾部
	local ps = cc.ParticleSystemQuad:create("res/particle/fire.plist")
	ps:setPosition(cc.p(self:getContentSize().width/2,0))
	ps:setScale(0.7)
	self:addChild(ps)

	local verts = {
		cc.p(-43.5,15.5),
		cc.p(-23.5,33),
		cc.p(28.5,34),
		cc.p(48,17.5),
		cc.p(0,-39.5)
	}

	 local body = cc.PhysicsBody:createPolygon(verts)---创建多边形physicsbody
    body:setCategoryBitmask(0x01)
    body:setCollisionBitmask(0x02)
    body:setContactTestBitmask(0X01)
    self:setPhysicsBody(body)

end
function Fighter:setPos( newPosition )
	-- body
	local halfwidth = self:getContentSize().width/4
	local halfheight = self:getContentSize().height/4
	
	local pos_x = newPosition.x
	local pos_y = newPosition.y
----左右边界
	if pos_x < halfwidth then
		pos_x = halfwidth
	elseif pos_x > (size.width - halfwidth) then
		pos_x = size.width - halfwidth 
	end
----上下边界
	if pos_y < halfheight then
		pos_y = halfheight
	elseif pos_y > (size.height - halfheight)then
		pos_y = size.height - halfheight
	end
----重置位置和，锚点
	self:setPosition(cc.p(pos_x,pos_y))
	self:setAnchorPoint(cc.p(0.5,0.5))


end

return Fighter