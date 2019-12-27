
local player = class("player", cc.load("mvc").ViewBase) 
-- local player = class("player")
print("I am Warrior")

local hero =nil

-----根据传入的父节点初始化
function player:onEnter(  )
    -- body
    print("enter create_hero")
   

	 hero = cc.Sprite:create("res/ship01.png",cc.rect(0,0,60,43))

	hero:setPosition(display.cx,hero:getContentSize().height * 2.3)
	hero:addTo(self)

	-- ---播放主角的动画
	local frame1 = CCSpriteFrame:create("res/ship01.png",cc.rect(0,0,60,43))

	local frame2 = CCSpriteFrame:create("res/ship01.png",cc.rect(60,0,60,43))

	local  array = {frame1,frame2}


	local animation = cc.Animation:create()
	animation:addSpriteFrame(array)
	local animate = cc.Animate:create(animation)

	hero:runAction(cc.RepeatForever:create(animate))

   

end

return player