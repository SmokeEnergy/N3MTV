local GUIChar = {}
GUIChar.GUI = {}
GUIChar.buttonCount = 0
GUIChar.loaded = false
GUIChar.selection = 0
GUIChar.time = 0
GUIChar.hidden = false
function GUIChar.addButton(name, func,args, xmin, xmax, ymin, ymax)
	--print("Added Button"..name )
	GUIChar.GUI[GUIChar.buttonCount +1] = {}
	GUIChar.GUI[GUIChar.buttonCount +1]["name"] = name
	GUIChar.GUI[GUIChar.buttonCount+1]["func"] = func
	GUIChar.GUI[GUIChar.buttonCount+1]["args"] = args
	GUIChar.GUI[GUIChar.buttonCount+1]["active"] = false
	GUIChar.GUI[GUIChar.buttonCount+1]["xmin"] = xmin
	GUIChar.GUI[GUIChar.buttonCount+1]["ymin"] = ymin * (GUIChar.buttonCount + 0.01) +0.02
	GUIChar.GUI[GUIChar.buttonCount+1]["xmax"] = xmax 
	GUIChar.GUI[GUIChar.buttonCount+1]["ymax"] = ymax 
	GUIChar.buttonCount = GUIChar.buttonCount+1
end


function GUIChar.unload()
end
function GUIChar.init()

	GUIChar.loaded = true
end
function GUIChar.tick()
	if(not GUIChar.hidden)then
		if( GUIChar.time == 0) then
			GUIChar.time = GAMEPLAY.GET_GAME_TIMER()
		end
		if((GAMEPLAY.GET_GAME_TIMER() - GUIChar.time)> 100) then
			GUIChar.updateSelection()
		end	
		GUIChar.renderGUI()	
		if(not GUIChar.loaded ) then
			GUIChar.init()	 
		end
	end
end

function GUIChar.updateSelection() 
	if(get_key_pressed(Keys.NumPad2)) then 
		if(GUIChar.selection < GUIChar.buttonCount -1  )then
			GUIChar.selection = GUIChar.selection +1
			GUIChar.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad8) )then
		if(GUIChar.selection > 0)then
			GUIChar.selection = GUIChar.selection -1
			GUIChar.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad5)) then
		if(type(GUIChar.GUI[GUIChar.selection +1]["func"]) == "function") then
			GUIChar.GUI[GUIChar.selection +1]["func"](GUIChar.GUI[GUIChar.selection +1]["args"])
		else
			print(type(GUIChar.GUI[GUIChar.selection]["func"]))
		end
		GUIChar.time = 0
	end
	local iterator = 0
	for id, settings in ipairs(GUIChar.GUI) do
		GUIChar.GUI[id]["active"] = false
		if(iterator == GUIChar.selection ) then
			GUIChar.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function GUIChar.renderGUI()
	 GUIChar.renderButtons()
end
function GUIChar.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	GRAPHICS.DRAW_RECT(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function GUIChar.renderButtons()
	
	for id, settings in pairs(GUIChar.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {42,63,17,255}
		
		if(settings["active"]) then
			boxColor = {107,158,44,255}
		end
		UI.SET_TEXT_FONT(0)
		UI.SET_TEXT_SCALE(0.0, 0.35)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_CENTRE(true)
		UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		UI._DRAW_TEXT(settings["xmin"]+ 0.05, (settings["ymin"] - 0.0125 ))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUIChar.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end
return GUIChar