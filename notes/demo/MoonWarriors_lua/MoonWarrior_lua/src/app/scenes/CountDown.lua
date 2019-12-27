--[[
环绕倒计时类
start 开始倒计时
stop  终止倒计时
--]]
 
 
local CountDown = class("CountDown",function()
    return cc.Node:create()
end)
 
CountDown._Timer = nil
CountDown._Start = 0
CountDown._End = 100
CountDown._Duration = 0
CountDown._EndCallback = nil
 
--[[
resSprite   倒计时资源
duration    倒计时时间，默认0
st          开始百分比，默认0
ed          结束百分比，默认100
endCallback 回调，stop时调用
--]]

function CountDown:create(resSprite, duration, st, ed, endCallback)
    return CountDown.new(resSprite, duration, st, ed, endCallback)
end
 
function CountDown:ctor(resSprite, duration, st, ed, endCallback)
    if st ~= nil then
        self._Start = st
    end
    if ed ~= nil then
        self._End = ed
    end
 
    self._Timer = cc.ProgressTimer:create(resSprite)
    self._Timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)---扇形
    -- self._Timer:setBarChangeRate(cc.p(1,0))---条形进度条从右向左显示
    self._Timer:setPosition(cc.p(0,0))
    -- self._Timer:setReverseProgress(true)---反进度显示
    -- 0-->100 动画方向 逆时针
    self._Timer:setReverseDirection(true)
    -- 设置中心点
    -- self._Timer:setMidpoint(cc.p(0,1))
    self._Timer:setVisible(false)
 
    self:addChild(self._Timer)
 
    self._Duration = duration
    self._EndCallback = endCallback
end

function CountDown:start( time )
    if time == nil then
        time = self._Duration
    end
    
    self:stop(false, false)
 
    self._Timer:runAction( cc.Sequence:create( 
        cc.CallFunc:create(function( sender )
        self._Timer:setVisible(true)
            end),
        cc.ProgressFromTo:create(
            time, self._Start, self._End),
        cc.CallFunc:create(function( sender ) 
         self:stop() end) ) )
end

function CountDown:stop( isHide, isCallback )
    if isHide == nil then
        isHide = true
    end
    if isCallback == nil then
        isCallback = true
    end
 
    self._Timer:stopAllActions()
    if isHide then    
        self._Timer:setVisible(false)
    end
 
    if isCallback and self._EndCallback ~= nil then
        self._EndCallback()
    end
  
end
 
return CountDown
