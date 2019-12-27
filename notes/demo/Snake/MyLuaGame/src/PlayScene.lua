local PlayScene = class("PlayScene",cc.load("mvc").ViewBase)




function PlayScene:ctor()

    display.newSprite("direction.png")
    :move(display.cx/3,display.cy/3)
    :addTo(self)
    ----返回按钮
    --local text = string.format("You killed %d bugs", self.gameView_:getKills())
    local lab= cc.Label:createWithSystemFont("返回", "Arial", 15)
    lab:move(display.cx/4,display.cy*3/4+300)
    lab:addTo(self,1)
    local playButton=cc.MenuItemImage:create("mud.png","mud.png")
    :onClicked(function()
        self:getApp():enterScene("MainScene")
    end)
    cc.Menu:create(playButton)
    :move(display.cx/4,display.cy*3/4+300)
    :addTo(self,0)
    
--    self:fileReadWrite()


end
function PlayScene:fileReadWrite()
    --- 创建文件夹
    --os.execute("md fxw")
    ---写文件
    -- local file=assert(io.open("fxw.txt","a") )
    -- file:write("happy-today")
    -- -关闭文件
    -- file:close()
    -- -读文件
    -- local file=io.open("fxw.txt","a")
    -- print("我在读")
    -- print(file:read('*lines'))
    -- file:close()
end
return PlayScene