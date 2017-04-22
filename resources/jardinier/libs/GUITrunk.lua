local GUITrunk = {}
GUITrunk.GUI = {}
GUITrunk.buttonCount = 0
GUITrunk.loaded = false
GUITrunk.selection = 0
GUITrunk.time = 0
GUITrunk.hidden = false
function GUITrunk.addButton(name, func,args, xmin, xmax, ymin, ymax)
	--print("Added Button"..name )
	GUITrunk.GUI[GUITrunk.buttonCount +1] = {}
	GUITrunk.GUI[GUITrunk.buttonCount +1]["name"] = name
	GUITrunk.GUI[GUITrunk.buttonCount+1]["func"] = func
	GUITrunk.GUI[GUITrunk.buttonCount+1]["args"] = args
	GUITrunk.GUI[GUITrunk.buttonCount+1]["active"] = false
	GUITrunk.GUI[GUITrunk.buttonCount+1]["xmin"] = xmin
	GUITrunk.GUI[GUITrunk.buttonCount+1]["ymin"] = ymin * (GUITrunk.buttonCount + 0.01) +0.02
	GUITrunk.GUI[GUITrunk.buttonCount+1]["xmax"] = xmax 
	GUITrunk.GUI[GUITrunk.buttonCount+1]["ymax"] = ymax 
	GUITrunk.buttonCount = GUITrunk.buttonCount+1
end
function GUITrunk.unload()
end
function GUITrunk.init()

	GUITrunk.loaded = true
end
function GUITrunk.tick()
	if(not GUITrunk.hidden)then
		if( GUITrunk.time == 0) then
			GUITrunk.time = GAMEPLAY.GET_GAME_TIMER()
		end
		if((GAMEPLAY.GET_GAME_TIMER() - GUITrunk.time)> 100) then
			GUITrunk.updateSelection()
		end	
		GUITrunk.renderGUI()	
		if(not GUITrunk.loaded ) then
			GUITrunk.init()	 
		end
	end
end

function GUITrunk.updateSelection() 
	if(get_key_pressed(Keys.NumPad2)) then 
		if(GUITrunk.selection < GUITrunk.buttonCount -1  )then
			GUITrunk.selection = GUITrunk.selection +1
			GUITrunk.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad8) )then
		if(GUITrunk.selection > 0)then
			GUITrunk.selection = GUITrunk.selection -1
			GUITrunk.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad5)) then
		if(type(GUITrunk.GUI[GUITrunk.selection +1]["func"]) == "function") then
			GUITrunk.GUI[GUITrunk.selection +1]["func"](GUITrunk.GUI[GUITrunk.selection +1]["args"])
		else
			print(type(GUITrunk.GUI[GUITrunk.selection]["func"]))
		end
		GUITrunk.time = 0
	end
	local iterator = 0
	for id, settings in ipairs(GUITrunk.GUI) do
		GUITrunk.GUI[id]["active"] = false
		if(iterator == GUITrunk.selection ) then
			GUITrunk.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function GUITrunk.renderGUI()
	 GUITrunk.renderButtons()
end
function GUITrunk.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	GRAPHICS.DRAW_RECT(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function GUITrunk.renderButtons()
	
	for id, settings in pairs(GUITrunk.GUI) do
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
		GUITrunk.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end
return GUITrunk