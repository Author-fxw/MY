--[[  
=================  
XMLHttpRequestTest.lua  
http请求  
=================  
]]--  

require("json")  
  
local  function XMLHttpRequestLayer()  
  local layer = cc.Layer:create()-- 创建层  
  local winSize = cc.Director:getInstance():getWinSize()-- 得到窗口大小  
  local margin = 40-- 间距  
  local space  = 35-- 宽度  
  
  local function init()  
    local label = cc.Label:createWithTTF("XML Http Request Test", "res/fonts/hanyi.ttf", 28)-- 使用ttf文字格式的标签  
    label:setAnchorPoint(cc.p(0.5, 0.5))-- 设置锚点  
    label:setPosition(cc.p(winSize.width / 2, winSize.height - margin))-- 设置显示位置，宽度为屏幕的中间，高度为屏幕高度减去间距  
    layer:addChild(label, 0) -- 添加标签到层中  
    -- 显示返回码的标签  
    local labelStatusCode = cc.Label:createWithTTF("HTTP Status Code", "res/fonts/hanyi.ttf", 20)  
    labelStatusCode:setAnchorPoint(cc.p(0.5, 0.5))  
    labelStatusCode:setPosition(cc.p(winSize.width / 2,  winSize.height - margin - 6 * space))  
    layer:addChild(labelStatusCode)  
  
    local menuRequest = cc.Menu:create() -- 创建菜单  
    menuRequest:setPosition(cc.p(0,0))  
    layer:addChild(menuRequest) -- 添加菜单  
  
    --Get  
    local function onMenuGetClicked()  
      local xhr = cc.XMLHttpRequest:new() -- http请求  
      xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  为字符串
      xhr:open("GET", "http://httpbin.org/get") -- 打开链接  
  
      -- 状态改变时调用  
      local function onReadyStateChange()  
        -- 显示状态文本  
        local statusString = "Http Status Code:"..xhr.statusText  
        labelStatusCode:setString(statusString)  
        print(xhr.response)  
      end  
  
      -- 注册脚本回调方法  
      xhr:registerScriptHandler(onReadyStateChange)  
      xhr:send() -- 发送请求  
  
      labelStatusCode:setString("waiting...")  
    end  
  
    -- 测试Get的标签  
    local labelGet  = cc.Label:createWithTTF("Test Get", "res/fonts/hanyi.ttf", 22)  
    labelGet:setAnchorPoint(cc.p(0.5, 0.5))  
    local itemGet  =  cc.MenuItemLabel:create(labelGet) -- 菜单标签  
    itemGet:registerScriptTapHandler(onMenuGetClicked) -- 菜单点击事件  
    itemGet:setPosition(cc.p(winSize.width / 2, winSize.height - margin - space))  
    menuRequest:addChild(itemGet) -- 添加菜单项  
  
    --Post  
    local function onMenuPostClicked()  
      local xhr = cc.XMLHttpRequest:new() -- 新建一个XMLHttpRequest对象  
      xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 相应类型为字符串  
      xhr:open("POST", "http://httpbin.org/post")-- post方式  

      --post 请求回调
      local function onReadyStateChange()  
        labelStatusCode:setString("Http Status Code:"..xhr.statusText)  
        print(xhr.response)  
      end  
      -- 注册脚本方法回调  
      xhr:registerScriptHandler(onReadyStateChange)  
      xhr:send()-- 发送  
  
      labelStatusCode:setString("waiting...")  
    end  
  
    -- 测试Post的标签  
    local labelPost = cc.Label:createWithTTF("Test Post", "res/fonts/hanyi.ttf", 22)  
    labelPost:setAnchorPoint(cc.p(0.5, 0.5)) -- 设置锚点  
    local itemPost =  cc.MenuItemLabel:create(labelPost) -- 设置菜单项标签  
    itemPost:registerScriptTapHandler(onMenuPostClicked) -- 注册菜单项点击回调方法  
    itemPost:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 2 * space))  
    menuRequest:addChild(itemPost)  
  
    --Post Binary  
    local function onMenuPostBinaryClicked()  
      local xhr = cc.XMLHttpRequest:new()-- 新建一个XMLHttpRequest对象  
      xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_ARRAY_BUFFER --返回数据为字节流  
      xhr:open("POST", "http://httpbin.org/post") -- 打开Socket  
  
      -- 状态改变时调用  
      local function onReadyStateChange()  
        local response   = xhr.response -- 获得返回数据  
        local size     = table.getn(response) -- 获得返回数据大小  
        local strInfo = ""  
  
        for i = 1,size do  
          if 0 == response[i] then  
            strInfo = strInfo.."\'\\0\'"  
          else  
            strInfo = strInfo..string.char(response[i])  
          end  
        end  
        labelStatusCode:setString("Http Status Code:"..xhr.statusText)  
        print(strInfo)  
      end  
  
      -- 注册脚本方法回调  
      xhr:registerScriptHandler(onReadyStateChange)  
      xhr:send()-- 发送  
  
      labelStatusCode:setString("waiting...")  
    end  
  
    -- 测试使用Post请求方式发送字节流  
    local labelPostBinary = cc.Label:createWithTTF("Test Post Binary", "res/fonts/hanyi.ttf", 22)  
    labelPostBinary:setAnchorPoint(cc.p(0.5, 0.5))  
    local itemPostBinary = cc.MenuItemLabel:create(labelPostBinary)  
    itemPostBinary:registerScriptTapHandler(onMenuPostBinaryClicked)  
    itemPostBinary:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 3 * space))  
    menuRequest:addChild(itemPostBinary)  
  
    --Post Json  
    local function onMenuPostJsonClicked()  
      local xhr = cc.XMLHttpRequest:new() -- 新建一个XMLHttpRequest对象  
      xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON -- 响应类型为json数据类型  
      xhr:open("POST", "http://httpbin.org/post")-- POST方式  
  
      local function onReadyStateChange()  
        -- 显示状态码,成功显示200  
        labelStatusCode:setString("Http Status Code:"..xhr.statusText)  
        local response   = xhr.response -- 获得响应数据  
        local output = json.decode(response,1) -- 解析json数据  
        table.foreach(output,function(i, v) print (i, v) end)  
        print("headers are")  
        table.foreach(output.headers,print)  
      end  
  
      -- 注册脚本方法回调  
      xhr:registerScriptHandler(onReadyStateChange)  
      xhr:send()-- 发送请求  
  
      labelStatusCode:setString("waiting...")  
    end  
  
    -- 测试使用POST方式发送json的标签  
    local labelPostJson = cc.Label:createWithTTF("Test Post Json", "res/fonts/hanyi.ttf", 22)  
    labelPostJson:setAnchorPoint(cc.p(0.5, 0.5)) -- 锚点  
    local itemPostJson = cc.MenuItemLabel:create(labelPostJson) -- 菜单项标签  
    itemPostJson:registerScriptTapHandler(onMenuPostJsonClicked) -- 注册菜单项点击  
    itemPostJson:setPosition(cc.p(winSize.width / 2, winSize.height - margin - 4 * space))  
    menuRequest:addChild(itemPostJson)  
  end  
  
  
  -- 节点回调事件  
  local function onNodeEvent(eventName)  
    if "enter" == eventName then  
      init()  
    end  
  end  
    
  -- 注册层的监听回调事件  
  layer:registerScriptHandler(onNodeEvent)  
  
  return layer  
end  
local XMLHttpText = class("XMLHttpText",function (  )
	-- body
  local scene = cc.Scene:create() -- 创建场景  
  scene:addChild(XMLHttpRequestLayer()) -- 添加层  
  return scene  
end)

return XMLHttpText