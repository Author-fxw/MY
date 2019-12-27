local Body=class("Body")
--node:是cocos2dx的重要父节点

-- local cGridSize=35--格子大小
-- local scaleRate=1/display.contentScaleFactor

-- local function Grid2Pos(x,y)
--     local visibleSize = cc.Director:getInstance():getVisibleSize()--获取手机屏幕的可视尺寸
--     local origin = cc.Director:getInstance():getVisibleOrigin()--获取手机屏幕原点坐标，在屏幕左上角
    
--     local finalX = origin.x + visibleSize.width/2 + x*cGridSize*scaleRate
--     local finalY = origin.y + visibleSize.height/2 + y*cGridSize*scaleRate
    
--     return finalX,finalY 
 
-- end


 function Body:ctor(snake,x,y,node,isHead)
    --print("[Body:ctor]", x, y)
    self.snake=snake
    self.X=x
    self.Y=y

    if isHead then   --根据是否是头部  使用图片来创建
        self.sp=cc.Sprite:create("head.png")
    else
        self.sp=cc.Sprite:create("body.png")
    end
    node:addChild(self.sp)--添加到父节点
    --print("[Body:ctor : before update call]", x, y)
    self:Update()

end



function Body:Update()--更新本身的位置
    print("[Body:Update]", self.X,self.Y)
    local posx,posy=Grid2Pos(self.X,self.Y)
    self.sp:setPosition(posx,posy)
end




return Body