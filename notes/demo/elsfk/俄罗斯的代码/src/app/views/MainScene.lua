
local MainScene = class("MainScene", cc.load("mvc").ViewBase)


local Scene = require("app.Scene")
local Block = require("app.Block")

local NextBoard = require("app.NextBoard")
-- require"Common"

function MainScene:onEnter()
    --add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)
        :setVisible(false)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx-300, display.cy + 200)
        :addTo(self)
        :setVisible(true)

        ---使用菜单项创建 button
        local button = cc.MenuItemImage:create("block.png","block.png")
        
        :onClicked(function ( )
          -- body
            print("点击了按钮")
            self:getApp():enterScene("NextScene")
        end)
        cc.Menu:create(button)
       -- :setTitleText("按钮")
        :setPosition(cc.p(display.cx-300,display.cy))
        :addTo(self)


        --使用Button创建
        ccui.Button:create("block.png")
        :setScale(1.5)
        :setTitleText("按钮")
        :setTitleColor(cc.c3b(0,255,0))
        :setPosition(cc.p(display.cx-300,display.cy+100))
        :addTo(self)

        :addTouchEventListener(function (sender,eventType )
            -- body
            print ("qqqqqqqqqqqqqqq")

            self:getApp():enterScene("NextScene")

        end)

        self.scene = Scene.new(self)
        
        self.board = NextBoard.new(self)

        --self.b = Block.new(self.scene,1)
        
        self:Gen()--重新生成
        -- self.b:Place()---方块放置
        self:ProcessInput()

        local Tick = function (  )---刷新函数
            -- body
            if self.pasueGame then
                return 
            end

            if not self.b:Move(0,-1) then
                self:Gen()
            else
              --  self.b:Clear()--移动正常清除当前快
               
                while self.scene:CheckAndSweep() > 0 do
                    
                    self.scene:Shift()
                end

            end

            self.b:Place()

        end

       cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick,0.3,false)
        
end

----新位置重新生成
function MainScene:Gen( )
    -- body

    local style = self.board:Next()
     print("2222222222",style)

    self.b = Block.new (self.scene,style)
    
    if not self.b:Place() then---如果放不下的话

        ---game over
        self.scene:Clear()

    end
end


---按键事件
function MainScene:ProcessInput()
----------
    local listener = cc.EventListenerKeyboard:create()

    local keyState = {}

    listener:registerScriptHandler(function (keyCode,event )
        -- body

        keyState[keyCode] = true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)

    listener:registerScriptHandler(function ( keyCode,event )
        -- body
        keyState[keyCode] = nil

        ----W
        if keyCode == 146 then
            print("W键")

            self.b:Rotate()
        ----P
        elseif keyCode == 139 then
            print("P键")
            self.pasueGame = not self.pasueGame
        end

    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

--刷新函数
    local inputTick = function ()
        -- body
        for keyCode,v in pairs(keyState) do
            

            ---s
            if keyCode == 142 then
                print("sssssss")
                self.b:Move(0,-1)
               
            end

            ---a
            if keyCode == 124 then
                print("aaaaaaaaaaaaaa")
                self.b:Move(-1,0)
               
            end

            ---d
            if keyCode == 127 then
                print("dddddddddddddd")
                self.b:Move(1,0)
               
            end

        end
    end

 -----定时器
 cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick,0.3,false)
end




return MainScene
