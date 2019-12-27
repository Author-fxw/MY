

 Pos2EventMap = {}
 
 local function makePosKey(x,y)
     
	 return string.format("%d,%d",x,y)
 
 end
 
 
 function SetCollide(x,y,event)
    
    if event.Name ~= nil then
    
 	    for key,ev in pairs(Pos2EventMap)do
	     
		   if ev.Name == event.Name then
		     
			 Pos2EventMap[key] = nil
			 
		    end
		 	 
		end
	
	end
	 
	local key = makePosKey(x,y)
	    if  Pos2EventMap[key] ~= nil then
	     
		    return
	 
	    end
	 Pos2EventMap[key] = event
 
 end
 
 
 --建立碰撞
 function CheckCollide(x,y)
     
	return Pos2EventMap[makePosKey(x,y)]
 
 end
 
 --清空碰撞
 function ResetCollide()
     
	Pos2EventMap = {}
	 
 end