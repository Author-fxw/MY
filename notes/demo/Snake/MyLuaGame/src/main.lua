
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
    require("app.Myapp"):create():run()
    -- require("app.MyApp"):create{
    --     viewsRoot  = "app.views",
    --     defaultSceneName = "MainScene",
    -- }:run("MainScene")
    -- local scene=require("MainScene"):create()
    -- cc.Director.getInstance().runWithScene(scene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
