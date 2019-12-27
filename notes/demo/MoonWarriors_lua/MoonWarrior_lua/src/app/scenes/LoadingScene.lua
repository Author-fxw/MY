----游戏加载场景
local LoadingScene = class("LoadingScene", cc.load("mvc").ViewBase)
require ("SystemConst")

local frameCache = cc.SpriteFrameCache:getInstance()
local textureCache = cc.Director:getInstance():getTextureCache()
function LoadingScene:onEnter()
    print("111111111111")
 
    frameCache:addSpriteFrames("res/texture/loading_texture.plist")
    local bg = cc.TMXTiledMap:create("res/large/map/red_bg.tmx")
    bg:addTo(self)

    local logo  = cc.Sprite:createWithSpriteFrameName("logo.png")
    logo:addTo(self)
    logo:setScale(0.8)
    logo:setPosition(cc.p(display.cx,display.cy))

    local sp = cc.Sprite:createWithSpriteFrameName("loding4.png")
    sp:addTo(self)
    sp:setScale(0.6)
    sp:setPosition(cc.p(display.cx,display.cy/3))
    
    ---loading animation
    local animation = cc.Animation:create()
    for i=1,4 do
        
        local frameName = string.format("loding%d.png",i)
        print("frameName=%s",frameName)
        local spframe = frameCache:getSpriteFrameByName(frameName)
        animation:addSpriteFrame(spframe)
    end
    animation:setDelayPerUnit(0.5)
    animation:setRestoreOriginalFrame(true)
    local action = cc.Animate:create(animation)
    sp:runAction(cc.RepeatForever:create(action))
    ---异步加载纹理缓存
    local function loadingTextureCallBack(texture  )
        -- body
        frameCache:addSpriteFrames("res/texture/LostRoutes_Texture.plist")
        print("loading texture ok ")
       
        ---初始化music
        AudioEngine.preloadMusic(bg_music_1)
        AudioEngine.preloadMusic(bg_music_2)
        ---init effect  
        AudioEngine.preloadEffect(sound_2)
        AudioEngine.preloadEffect(sound_1)

        --self:getApp():enterScene("HomeScene")
        local scene = require("app.scenes.HomeScene")
        local homescene = scene.create()
        cc.Director:getInstance():pushScene(homescene)

        --    local HomeScene = require("scenes.HomeScene")
    end 

    textureCache:addImageAsync(texture_res,loadingTextureCallBack)



end


return LoadingScene