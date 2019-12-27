
cGridSize = 32--格子的大小
cSceneWidth = 8 + 2
cSceneHeight = 18

function cGrid2Pos(x,y)-----格子位置到屏幕位置转换问题
	-- body
	local visibleSize = cc.Director:getInstance():getVisibleSize()
	local origin = cc.Director:getInstance():getVisibleOrigin()

	local finalX = origin.x + visibleSize.width*0.5 + x * cGridSize - cSceneWidth/2 * cGridSize
	local finalY = origin.y + visibleSize.height * 0.5 + y * cGridSize - cSceneHeight/2 * cGridSize

	return finalX,finalY
end
