

local MainScene=class("MainScene",cc.load("mvc").ViewBase)

function MainScene:ctor(app, name, ...)
    self.super.ctor(self, app)
    print("MainScene function ctor")
    display.newSprite("HelloWorld.png")
    :move(display.center)
    :addTo(self,0)
    local function BtnCaback()
        print("start")
       --local s=require("app.views.TitleScene").new()
        self:getApp():enterScene("GameScene",nil,"Random",1.5)
  
        --display.replaceScene(s,"fade",0.6,display.COLOR_BLACK)
        -- body
    end
    local startItme=cc.MenuItemImage:create("btn_start.png","btn_start.png")
    startItme:setPosition(cc.p(display.cx,display.cy/3))
    startItme:registerScriptTapHandler(BtnCaback)

    local startmenubtn=cc.Menu:create(startItme)
    startmenubtn:move(display.cx,display.cy/3)
    --startmenubtn:addTo(self,1)
    startmenubtn:setPosition(cc.p(0,0))
    self:addChild(startmenubtn,1)

    local label=cc.Label:createWithSystemFont("hello lua","Arial",40)
    label:move(display.cx,display.cy+200)
    label:addTo(self,2)
--    print(self.init)
   -- self:init()
    
end

function MainScene:init()
    print("MainScene function init")

end




return MainScene
