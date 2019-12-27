

---基于Http网络通信客户端构建  服务器端已经建好直接使用

---定义常量
local BASE_URL = 'http://www.51work6.com/service/mynotes/WebService.php'
---查询之后修改，用于删除和修改
local selectedRowId = 1483
local json = require("json")
----create layer

local  function createLayer()
	-- body
	local layer = cc.Layer:create()
    local winSize = cc.Director:getInstance():getWinSize()-- 得到窗口大小  
    local margin = 40-- 间距  
 -- local function init(  )
 	-- body
	local pItemLabel1 = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt","Insert Data")
	local pItemMenu1 = cc.MenuItemLabel:create(pItemLabel1)
	
	-- 插入数据函数
	local function onMenuIsertCallBack( pSender )
		print("onMenuIsertCallBack")

		local data = string.format("email = %s&type = %s&action = %s&date = %s&content=%s","<1837058695@qq.com>","JSON","add","2013-09-08","Tony insert data")
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		xhr:open("POST",BASE_URL)

		local function onReadyStateChange( )
			-- body
			if xhr.readyState == 4 and xhr.status == 200 then
				local response = xhr.responseText
				print(response)
				local jsonObj = json.decode(response)
				local resultCode = jsonObj['ResultCode']
				if resultCode > 0 then 
					print("insert success....")
					else
						print(getErrorMesssge(resultCode))
				end
			end
		end 
		xhr:registerScriptHandler(onReadyStateChange)
		xhr:send(data)
	
	end 

	pItemMenu1:registerScriptTapHandler(onMenuIsertCallBack)

	local pItemLabel2 = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt"," Delete Data")
	local pItemMenu2 = cc.MenuItemLabel:create(pItemLabel2)

    --删除数据函数
	local function onMenuDeleteCallBack( pSender )
		 
		 print("onMenuDeleteCallBack")

		 local data = string.format("email = %s& type = %s& action = %s& id = %s",
		 	"<1837058695@qq.com>","JSON","remove",selectedRowId)
		 local  xhr = cc.XMLHttpRequest:new()
		 xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		 xhr:open("POST",BASE_URL)

		 local function onReadyStateChange(  )
		 	-- body
		 	if xhr.readyState == 4 and xhr.status == 200 then
				local response = xhr.responseText
				print(response)

				local jsonObj = json.decode(response)
				local resultCode = jsonObj['ResultCode']
				if resultCode > 0 then 
					print("delete success....")
					else
						print(getErrorMesssge(resultCode))
				end
			end
		 end
		 xhr:registerScriptHandler(onReadyStateChange)
		 xhr:send(data)
	end 

	pItemMenu2:registerScriptTapHandler(onMenuDeleteCallBack)

	local pItemLabel3 = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt","Update Data")
	local pItemMenu3 = cc.MenuItemLabel:create(pItemLabel3)
    
    --更新函数
	local function onMenuUpdateCallBack( pSender )
		-- body
		print("onMenuUpdateCallBack")

		local data = string.format("email = %s& type = %s& action = %s& content = %s& id = %s",
			"<1837058695@qq.com>","JSON","modify","2016-09-18","Tom modify data",selectedRowId)
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		xhr:open("POST",BASE_URL)

		local function onReadyStateChange(  )
		 	-- body
		 	if xhr.readyState == 4 and xhr.status == 200 then
				local response = xhr.responseText
				print(response)
			end
		 end
		 xhr:registerScriptHandler(onReadyStateChange)
		 xhr:send(data)

	end 
	pItemMenu3:registerScriptTapHandler(onMenuUpdateCallBack)

	local pItemLabel4 = cc.Label:createWithBMFont("res/Font/bitmapFontTest.fnt","Read Data")
	local pItemMenu4 = cc.MenuItemLabel:create(pItemLabel4)
    
    --查询数据函数
	local function onMenuReadCallBack( pSender )
		
		print("onMenuReadCallBack")

		local data = string.format("email = %s&type = %s&action = %s","<1837058695@qq.com>","JSON","query")
		local url = BASE_URL.."?"..data
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
		xhr:open("GET",url)
        ---回调函数
		local function onReadyStateChange(  )
			-- body

			if xhr.readyState == 4 and xhr.status == 200 then
				local response = xhr.responseText
			
				print("httpCallback",xhr.readyState,xhr.status,xhr.response)

				

				local jsonObj = json.decode(response)
				local  resultCode = jsonObj['ResultCode']
				if resultCode == 0 then
					print("read success")
					local jsonArray = jsonObj['Record']
					for i=1,table.getn(jsonArray) do
						print("-------------------------[%d]---------------------",i)
						local row = jsonArray[i]

						print("ID: %s",       row["ID"])
						print("CDate: %s",    row["CDate"])
						print("Content： %s", row["Content"])
						print("selectedRowId = %s", selectedRowId)
						selectedRowId = row["ID"]
					end
				else 
					print(getErrorMesssge(resultCode))

				end
			end

		end 
        
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()
	end 
	pItemMenu4:registerScriptTapHandler(onMenuReadCallBack)

	local mn = cc.Menu:create(pItemMenu1,pItemMenu2,pItemMenu3,pItemMenu4)
	-- mn:setPosition(cc.p(0,0))
	mn:alignItemsVertically()
	layer:addChild(mn)

	--节点回调
    local function onNodeEvent( eventName)
    	-- body
    	if "enter" == eventName then
    		-- init()
    		createLayer()
    	end
    end 
    ---注册层监听事件
     layer:registerScriptHandler(onNodeEvent)
 -- end
    return layer
end
local HttpTextScene = class("HttpTextScene",function (  )
	-- body
	local scene = cc.Scene:create()
	scene:addChild(createLayer())--添加层
	return scene
end)

return HttpTextScene
