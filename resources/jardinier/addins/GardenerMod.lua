-- Gardener Mod made by IDEO
-- Version Alpha
-- Press F5 to activate
-- Press E to use
-- Press L to use Leaf BlowerForce

local GardenerMod = {}

Gardenerinit() -- Libs/GardenerInit.lua


	
function GardenerMod.unload()
end
function GardenerMod.init()

	GardenerMod.GUI_Trunk = Libs["GUITrunk"] -- Main, Parent window
	
	GardenerMod.GUI_Trunk.addButton("Small Tree",GardenerMod.TrunkTakeTree,nil,0,0.2,0.05,0.05)
	GardenerMod.GUI_Trunk.addButton("Hedge Trimmer",GardenerMod.TrunkTakeScis,nil,0,0.2,0.05,0.05)		
	GardenerMod.GUI_Trunk.addButton("Leaf Blower",GardenerMod.TrunkTakeBlower,nil,0,0.2,0.05,0.05)
	
	GardenerMod.GUI_Trunk.hidden =  true

	
	
	GardenerMod.GUI_Char = Libs["GUIChar"] -- Main, Parent window
	

	GardenerMod.GUI_Char.addButton("FACE",GardenerMod.ChangeHead,nil,0,0.2,0.05,0.05)
	GardenerMod.GUI_Char.addButton("SHIRT",GardenerMod.ChangeUp,nil,0,0.2,0.05,0.05)		
	GardenerMod.GUI_Char.addButton("PANTS",GardenerMod.ChangeDown,nil,0,0.2,0.05,0.05)
	GardenerMod.GUI_Char.addButton("OK",GardenerMod.Init_Mission_1,nil,0,0.2,0.05,0.05)
	
	GardenerMod.GUI_Char.hidden =  true		
	
end


--==================================================================================================================================================
--	MAIN LOOP
--==================================================================================================================================================
function GardenerMod.tick()

		local pid = PLAYER.PLAYER_PED_ID()
		local PedModel = PED.IS_PED_MODEL(pid, GardenerHash)
		InVehicle = PED.IS_PED_IN_ANY_VEHICLE(pid, false)
		
		CheckDeath()
		
--==================================================================================================================================================
--	GARDENER MOD ACTIF KEY
--==================================================================================================================================================	
	if(get_key_pressed(Keys.F5))then

		if(modStarted == false) then
		
			DrawText("~g~Gardener Mod~s~ by ~r~Ideo ~s~ Enabled")
			modStarted = true
			PED.SET_PED_AS_GROUP_MEMBER(pid, 1)
			--GardenerMod.teleport() -- to delete
			StartMod()
				
			wait (1000)

		else
		
			DrawText("~g~Gardener Mod~s~ by ~r~Ideo ~s~ Disabled")	
			StopMod()
			wait (1000)
			
		end
	end
--==================================================================================================================================================															
	
	
	
	
--==================================================================================================================================================
--	USE KEY : E
--==================================================================================================================================================		
	if(get_key_pressed(Keys.E))then

		if (modStarted == true and InVehicle == false) then
		
			if (CanOpenTrunk == true) then
			
				OpenTrunk()
				wait (100)	

			elseif(Object_In_Hand == false) then
			
				TakeClosestObject()
				wait (100)
				
			elseif (BlowerInHand == true) then

				if (blowerActif == false) then
					Walkable_Animation(Blower_animCore, Blower_anim)
					blowerActif = true
					wait (1000)
		
				else
					AI.CLEAR_PED_TASKS(pid)
					blowerActif = false
					wait (1000)
				end
			
			elseif(Action == false) then
			
				---------------------------------------------------------------------------
				--				If Mission 1
				---------------------------------------------------------------------------	
				if (Mission_1_Done == false) then
					
						PlanteArbre()
						wait (1000)
	
				---------------------------------------------------------------------------
				--				If Mission 2
				---------------------------------------------------------------------------	
				elseif (Mission_2_Done == false) then
				
						HedgeTrimmer()
						wait (1000)		
						
				---------------------------------------------------------------------------
				--				If Mission 3
				---------------------------------------------------------------------------	
				elseif (Mission_3_Done == false) then

				end				
				
			end
		end
	end
--==================================================================================================================================================														




--modStarted = true
--==================================================================================================================================================
--	UTILITY FOR DEV KEY : H
--==================================================================================================================================================			
	if(get_key_pressed(Keys.H) and modStarted == true)then

	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)	
		RandomSpawner(LeafHash, 50, 10, location.x, location.y, location.z)
			--GardenerMod.testobject()

		wait(500)
	end
--==================================================================================================================================================	
	
	
	
--==================================================================================================================================================
--	DETACH KEY : G
--==================================================================================================================================================			
	if(get_key_pressed(Keys.G))then
		DetachObjectToHand()
		wait (1000)
		
	end
--==================================================================================================================================================	


	
--[[
	if(get_key_pressed(Keys.NumPad8))then
		ObjPosX = ObjPosX - 0.01
		GardenerMod.testobject()
		wait(50)
	end	
	
	if(get_key_pressed(Keys.NumPad2))then
		ObjPosX = ObjPosX + 0.01
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.NumPad4))then
		ObjPosY = ObjPosY - 0.01
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.NumPad6))then
		ObjPosY = ObjPosY + 0.01
		GardenerMod.testobject()
		wait(50)
	end			
	
	if(get_key_pressed(Keys.Subtract))then
		ObjPosZ = ObjPosZ - 0.01
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.Add))then
		ObjPosZ = ObjPosZ + 0.01
		GardenerMod.testobject()
		wait(50)
	end			
	

	
	
	if(get_key_pressed(Keys.NumPad7))then
		ObjRotX = ObjRotX - 1
		GardenerMod.testobject()
		wait(50)
	end	
	
	if(get_key_pressed(Keys.NumPad9))then
		ObjRotX = ObjRotX + 1
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.NumPad1))then
		ObjRotY = ObjRotY - 1
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.NumPad3))then
		ObjRotY = ObjRotY + 1
		GardenerMod.testobject()
		wait(50)
	end			
	
	if(get_key_pressed(Keys.NumPad0))then
		ObjRotZ = ObjRotZ - 1
		GardenerMod.testobject()
		wait(50)
	end		
	
	if(get_key_pressed(Keys.Multiply))then
		ObjRotZ = ObjRotZ + 1
		GardenerMod.testobject()
		wait(50)
	end	
--]]	

	
	

	if (blowerActif) then	
		BlowerForce()
	end

	if (not blowerActif and not InVehicle) then	
		TrunkAreaChecker()
	end
	
	if (modStarted and not StartCheckpointInRange) then
		GardenerMod.StartCheckpointChecker()
	end
	
	if (modStarted and Payed2 and not Payed3 and not IsGateOpen) then
		GateTrigger()
	end	

	
	
	if (PED.IS_PED_GETTING_INTO_A_VEHICLE(pid) and Object_In_Hand) then
		DetachObjectToHand()
	end
	
	GardenerMod.GUI_Trunk.tick()
	GardenerMod.GUI_Char.tick()
	
--==================================================================================================================================================
--	Trees in roof detach if hit
--==================================================================================================================================================			
	if(PED.IS_PED_IN_VEHICLE(pid, CarToSpawn, false) and NbrTreeInTrunk > 0)then
	
		VehicleHit()
		
	else
		Damage = 0
		Damage2 = 0
	end	

	
	if (IsTreePlanted) then
		GardenerMod.Mission_1_Next_Waypoint(PlantedTree)
		wait(100)
	end
	
	if (IsHedgeTrimmed) then
		GardenerMod.Mission_2_Next_Waypoint(HedgeTrimmed)
		wait(100)
	end
	

	
	if(not LeafSpawned and IsGateOpen and not Mission_3_Done) then
		GardenerMod.Mission_3_Next_Waypoint()
		wait(100)
	end
	
	if (LeafSpawned) then
		CheckLeafInRange(2.5)	
	end	
	
	
end




--==================================================================================================================================================
--															Trunck area CHECKER FUNCTION
function TrunkAreaChecker()

	local pid = PLAYER.PLAYER_PED_ID()
	
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local PlayerForwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(pid)		
	local PlayerX = location.x + (PlayerForwardVector.x * 1)
	local PlayerY = location.y + (PlayerForwardVector.y * 1)
	local PlayerZ = location.z	
	
	
	local Vehlocation = ENTITY.GET_ENTITY_COORDS(CarToSpawn, nil)	
	local VehicleForwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(CarToSpawn)	
	local TrunkX = Vehlocation.x - (VehicleForwardVector.x * 2)
	local TrunkY = Vehlocation.y - (VehicleForwardVector.y * 2)
	local TrunkZ = Vehlocation.z	
	
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(PlayerX, PlayerY, PlayerZ, TrunkX, TrunkY, TrunkZ, true)
	if(distance < 1.2) then
		CanOpenTrunk = true
		
		if (Object_In_Hand == false) then
			GardenerMod.GUI_Trunk.hidden = false
		end

	else
		CanOpenTrunk = false
		GardenerMod.GUI_Trunk.hidden =  true

	end
	
end	
--==================================================================================================================================================







function GardenerMod.testobject()


local modelToSpawn = TrimmerHash
		OBJECT.DELETE_OBJECT(Object_Taken)
		STREAMING.REQUEST_MODEL(modelToSpawn)
		while (not STREAMING.HAS_MODEL_LOADED(modelToSpawn)) do wait(50) end
		local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 1.0, -0.3)
		Object_Taken = OBJECT.CREATE_OBJECT(modelToSpawn, coords.x, coords.y, coords.z, true, false, true)
		OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(objToSpawn)
			
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelToSpawn)

		ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_Taken, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 57005), ObjPosX, ObjPosY, ObjPosZ, ObjRotX, ObjRotY, ObjRotZ, false, false, false, false, 2, true)

end



--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- Character creation
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

function GardenerMod.CharCreator()

	InCharSelection = true

	CAM.DO_SCREEN_FADE_OUT(2000)
	wait(2000)

	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)
	---------------------------------------------------------------------------
	--				Teleporte
	---------------------------------------------------------------------------		
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pid, CharInitX, CharInitY, CharInitZ, false, false, true)
	ENTITY.SET_ENTITY_ROTATION(pid, 0, 0, 175, 0, false)	
	
	---------------------------------------------------------------------------
	--				Change le model
	---------------------------------------------------------------------------
	STREAMING.REQUEST_MODEL(GardenerHash)
	while (not STREAMING.HAS_MODEL_LOADED(GardenerHash)) do
		wait (50)
	end
	PLAYER.SET_PLAYER_MODEL(player,GardenerHash)
	PED.SET_PED_DEFAULT_COMPONENT_VARIATION(player)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(GardenerHash)
	
	---------------------------------------------------------------------------
	--				Time and weather
	---------------------------------------------------------------------------		
	TIME.SET_CLOCK_TIME(6,0,0)
	--GAMEPLAY.SET_WEATHER_TYPE_NOW("THUNDER")


	Fix_Animation("amb@world_human_cop_idles@female@base", "base")
	
	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)	
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)	
	cam1 = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", location.x, location.y - 2,location.z, 0, 0, 0, 50,true, 1) 
	CAM.RENDER_SCRIPT_CAMS(true, false, cam1, true, false)
	
	CAM.DO_SCREEN_FADE_IN(2000)	
	wait(2000)
	

	GardenerMod.GUI_Char.hidden =  false
end
function GardenerMod.ChangeHead()

	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)	
	
	PED.SET_PED_COMPONENT_VARIATION(pid, GardenerSkin[VarPedHead][1], GardenerSkin[VarPedHead][2], GardenerSkin[VarPedHead][3], GardenerSkin[VarPedHead][4])

	if (VarPedHead == 6) then
		VarPedHead = 1
	else
		VarPedHead = VarPedHead + 1
	end
	

end
function GardenerMod.ChangeUp()

	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)	
	
	PED.SET_PED_COMPONENT_VARIATION(pid, GardenerSkin[VarPedUP][1], GardenerSkin[VarPedUP][2], GardenerSkin[VarPedUP][3], GardenerSkin[VarPedUP][4])

	if (VarPedUP == 20) then
		VarPedUP = 7
	else
		VarPedUP = VarPedUP + 1
	end
	
end
function GardenerMod.ChangeDown()

	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)	
	
	PED.SET_PED_COMPONENT_VARIATION(pid, GardenerSkin[VarPedDOWN][1], GardenerSkin[VarPedDOWN][2], GardenerSkin[VarPedDOWN][3], GardenerSkin[VarPedDOWN][4])

	if (VarPedDOWN == 25) then
		VarPedDOWN = 21
	else
		VarPedDOWN = VarPedDOWN + 1
	end
	
end

--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■



function GardenerMod.TrunkTakeTree()
	TrunkSelect = 1
	GardenerMod.GUI_Trunk.hidden =  true
	OpenTrunk()
	wait (100)
end
function GardenerMod.TrunkTakeScis()
	TrunkSelect = 2
	GardenerMod.GUI_Trunk.hidden =  true
	OpenTrunk()
	wait (100)
end
function GardenerMod.TrunkTakeBlower()
	TrunkSelect = 3
	GardenerMod.GUI_Trunk.hidden =  true
	OpenTrunk()
	wait (100)
end








--==================================================================================================================================================
--															MISSION CHECKER FUNCTION
--==================================================================================================================================================	
function GardenerMod.StartCheckpointChecker()	

	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(location.x, location.y, location.z, BossPositionX, BossPositionY, BossPositionZ, true)

	---------------------------------------------------------------------------
	--				Si joueur a coté de location
	---------------------------------------------------------------------------	
	if (distance < 3) then
	
		StartCheckpointInRange = true
		
		if (CharSelected == false and InCharSelection == false) then
			GardenerMod.CharCreator()
			wait (500)	
		else
		
			if ( MissionActif == false and CharSelected == true) then
		
				---------------------------------------------------------------------------
				--				Mission 1
				---------------------------------------------------------------------------
				if (Mission_1_Done == true and Payed1 == false) then
				
					Payed1 = true
					PayMission(10000)
					wait (1000)
					
				---------------------------------------------------------------------------
				--				Mission 2
				---------------------------------------------------------------------------				
				elseif (Mission_2_Done == false) then 

					GardenerMod.Init_Mission_2()
					wait (500)
					
				elseif (Mission_2_Done == true and Payed2 == false) then
				
					Payed2 = true
					PayMission(10000)
					wait (1000)

				---------------------------------------------------------------------------
				--				Mission 3
				---------------------------------------------------------------------------				
				elseif (Mission_3_Done == false) then 

					GardenerMod.Init_Mission_3()
					wait (500)
					
				elseif (Mission_3_Done == true and Payed3 == false) then
				
					Payed3 = true
					PayMission(10000)
					wait (1000)

				---------------------------------------------------------------------------
				--				END MISSION
				---------------------------------------------------------------------------				
				else
				
					DrawText("No more mission in this mod, Thanks for playing ~g~Gardener Mod~s~ by ~r~Ideo")	
					StopMod()
					wait(1000)
					
				end
			
			elseif ( MissionActif == true  and CharSelected == true) then
			
				AUDIO._PLAY_AMBIENT_SPEECH1(PLAYER.PLAYER_PED_ID(), "GENERIC_HI", "SPEECH_PARAMS_FORCE")
				---------------------------------------------------------------------------
				--				Affiche travaille non terminé
				---------------------------------------------------------------------------	
				DrawText("Finish your job to get paid")	
		
			end
		end
	StartCheckpointInRange = false
	end	


end
--==================================================================================================================================================






--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- MISSIONS INIT
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

--==================================================================================================================================================
--	Mission 1 ACTIF
--==================================================================================================================================================
function GardenerMod.Init_Mission_1()



	CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false)
	InCharSelection = false
	CharSelected = true
	GardenerMod.GUI_Char.hidden =  true
	
	AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
	AUDIO.PLAY_SOUND_FRONTEND(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", false)
	MissionActif = true
	UI.SET_BLIP_ROUTE(blipPay, false)	
	
	SpawnCar(CarHash, CarSpawnCoordX, CarSpawnCoordY, CarSpawnCoordZ, 180)
			
	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)
	AI.CLEAR_PED_TASKS(pid)	
	PED.SET_PED_CAN_SWITCH_WEAPON(pid, false)
	---------------------------------------------------------------------------
	--				Get Main character model (for pay function)
	---------------------------------------------------------------------------	
	if (PED.IS_PED_MODEL(pid, GAMEPLAY.GET_HASH_KEY("player_zero"))) then
		model = 0
	elseif (PED.IS_PED_MODEL(pid, GAMEPLAY.GET_HASH_KEY("player_one"))) then                                
		model = 1                                         
	elseif (PED.IS_PED_MODEL(pid, GAMEPLAY.GET_HASH_KEY("player_two"))) then
		model = 2
	end
	
	
	UI.REMOVE_BLIP(blip1)
	GRAPHICS.DELETE_CHECKPOINT(Mission_1_Checkpoint)
		
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionIn", 0, false)
	wait(2000)
	
	---------------------------------------------------------------------------
	--				Met un checkpoint
	---------------------------------------------------------------------------	
	Mission_1_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ - 1, MissionLocationX, MissionLocationY, MissionLocationZ, 1, 0, 255, 0, 255, 0)
	GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_1_Checkpoint, 1, 1, 1)
		
	---------------------------------------------------------------------------
	--				Ajoute un point sur la map
	---------------------------------------------------------------------------	
	blip1 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
	UI.SET_BLIP_COLOUR(blip1, 2)
	UI.SET_BLIP_ROUTE(blip1, true)	
	

	for i=0,12,1 do 
		Plante[i] = SpawnObject(PlantHash)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Plante[i], PlantX, PlantY+(i*0.6), PlantZ, false, false, true)
	end			
	
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionIn")
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionOut", 0, false)
	wait (1000)
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionOut")
	
	---------------------------------------------------------------------------
	--				Affiche l'aide
	---------------------------------------------------------------------------	
	DrawText("Hello Calos and welcome to The Mighty Bush!")
	DrawText("Show me your gardener skill, take trees, put in the car trunk and go plant some trees.")
	
end
--==================================================================================================================================================




--==================================================================================================================================================
--	Mission 2 ACTIF
--==================================================================================================================================================
function GardenerMod.Init_Mission_2()

	AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)	
	UI.SET_BLIP_ROUTE(blipPay, false)
	MissionActif = true
			
	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)
	
	UI.REMOVE_BLIP(blip2)
	GRAPHICS.DELETE_CHECKPOINT(Mission_2_Checkpoint)
		
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionIn", 0, false)
	wait(2000)

		
	---------------------------------------------------------------------------
	--				Mission 2 First Checkpoint location
	---------------------------------------------------------------------------	
	MissionLocationX = -820.303
	MissionLocationY = 422.976
	MissionLocationZ = 91.56	
	
	---------------------------------------------------------------------------
	--				Met un checkpoint
	---------------------------------------------------------------------------	
	Mission_2_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ - 1, MissionLocationX, MissionLocationY, MissionLocationZ, 3, 0, 255, 0, 255, 0)
	GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_2_Checkpoint, 1, 1, 1)
		
	---------------------------------------------------------------------------
	--				Affiche l'aide
	---------------------------------------------------------------------------	
	DrawText("Nice job Carlos, a cusomer need our help to trim the hedges, go to his house and do the job.")
		
	---------------------------------------------------------------------------
	--				Ajoute un point sur la map
	---------------------------------------------------------------------------	
	blip2 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
	UI.SET_BLIP_COLOUR(blip2, 2)
	UI.SET_BLIP_ROUTE(blip2, true)	
	
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionIn")
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionOut", 0, false)
	wait (1000)
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionOut")
end
--==================================================================================================================================================



--==================================================================================================================================================
--	Mission 3 ACTIF
--==================================================================================================================================================
function GardenerMod.Init_Mission_3()

	AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)	
	UI.SET_BLIP_ROUTE(blipPay, false)
	MissionActif = true
			
	local pid = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(pid)
	
	UI.REMOVE_BLIP(blip3)
	GRAPHICS.DELETE_CHECKPOINT(Mission_3_Checkpoint)
		
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionIn", 0, false)
	wait(2000)

		
	---------------------------------------------------------------------------
	--				Mission 3 First Checkpoint location
	---------------------------------------------------------------------------	
	
	MissionLocationX = GateLocationX
	MissionLocationY = GateLocationY
	MissionLocationZ = GateLocationZ	
	
	---------------------------------------------------------------------------
	--				Met un checkpoint
	---------------------------------------------------------------------------	
	Mission_3_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ - 2, MissionLocationX, MissionLocationY, MissionLocationZ, 6, 0, 255, 0, 255, 0)
	GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_3_Checkpoint, 2, 2, 2)
		
	---------------------------------------------------------------------------
	--				Affiche l'aide
	---------------------------------------------------------------------------	
	DrawText("Well done, now a very bizzare family need our help to clean his garden, dont wast time")
		
	---------------------------------------------------------------------------
	--				Ajoute un point sur la map
	---------------------------------------------------------------------------	
	blip3 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
	UI.SET_BLIP_COLOUR(blip3, 2)
	UI.SET_BLIP_ROUTE(blip3, true)	
	
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionIn")
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionOut", 0, false)
	wait (1000)
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionOut")
end
--==================================================================================================================================================



--==================================================================================================================================================
--															MISSION 1 WAYPOINT COUNT FUNCTION
--==================================================================================================================================================	
function GardenerMod.Mission_1_Next_Waypoint(WaypointCount)

	IsTreePlanted = false
	
	UI.REMOVE_BLIP(blip1)
	GRAPHICS.DELETE_CHECKPOINT(Mission_1_Checkpoint)
		
	if (WaypointCount == 1) then 
	
		MissionLocationX = -843.35
		MissionLocationY = 380.69
		MissionLocationZ = 87.3
		
	elseif  (WaypointCount == 2) then 
	
		MissionLocationX = -842.78
		MissionLocationY = 375.55
		MissionLocationZ = 87.3
		
	end	
		
	if  (WaypointCount < MaxPlantedTree) then 
		---------------------------------------------------------------------------
		--				Met un checkpoint
		---------------------------------------------------------------------------	
		Mission_1_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ - 1, MissionLocationX, MissionLocationY, MissionLocationZ, 1, 0, 255, 0, 255, 0)
		GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_1_Checkpoint, 1, 1, 1)
			
		---------------------------------------------------------------------------
		--				Ajoute un point sur la map
		---------------------------------------------------------------------------	
		blip1 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
		--UI.SET_BLIP_SPRITE(blip1,5 )
		UI.SET_BLIP_COLOUR(blip1, 2)
		
	else 
	
		MissionLocationX = 0
		MissionLocationY = 0
		MissionLocationZ = 0	
	
		AUDIO.PLAY_SOUND_FRONTEND(-1, "FocusOut", "HintCamSounds", true)
		DrawText("You have no more trees to plant, go back to your boss")
		UI.SET_BLIP_ROUTE(blip1, false)	
		UI.SET_BLIP_ROUTE(blipPay, true)	
		Mission_1_Done = true
		MissionActif = false
		
	end

end
--==================================================================================================================================================



--==================================================================================================================================================
--															MISSION 2 WAYPOINT COUNT FUNCTION
--==================================================================================================================================================	
function GardenerMod.Mission_2_Next_Waypoint(WaypointCount)

	IsHedgeTrimmed = false
	UI.REMOVE_BLIP(blip2)
	GRAPHICS.DELETE_CHECKPOINT(Mission_2_Checkpoint)
		
	if (WaypointCount == 1) then 
	
		MissionLocationX = -829.6122
		MissionLocationY = 422.559
		MissionLocationZ = 91.565
		
	elseif  (WaypointCount == 2) then 
	
		MissionLocationX = -834.745
		MissionLocationY = 421.835
		MissionLocationZ = 91.564
		
	elseif  (WaypointCount == 3) then 
	
		MissionLocationX = -834.1337
		MissionLocationY = 417.018
		MissionLocationZ = 91.5657	
	
	end	
		
	if  (WaypointCount < MaxHedgeCut) then 
		---------------------------------------------------------------------------
		--				Met un checkpoint
		---------------------------------------------------------------------------	
		Mission_2_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ-1, MissionLocationX, MissionLocationY, MissionLocationZ, 3, 0, 255, 0, 255, 0)
		GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_2_Checkpoint, 1, 1, 1)
			
		---------------------------------------------------------------------------
		--				Ajoute un point sur la map
		---------------------------------------------------------------------------	
		blip2 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
		UI.SET_BLIP_COLOUR(blip2, 2)
		
	else 
	
		MissionLocationX = 0
		MissionLocationY = 0
		MissionLocationZ = 0	
		
		AUDIO.PLAY_SOUND_FRONTEND(-1, "FocusOut", "HintCamSounds", true)
		DrawText("You have no more Hedge to cut, go back to your boss")
		UI.SET_BLIP_ROUTE(blip2, false)	
		UI.SET_BLIP_ROUTE(blipPay, true)	
		Mission_2_Done = true
		MissionActif = false
		
	end

end
--==================================================================================================================================================




--==================================================================================================================================================
--															MISSION 3 WAYPOINT COUNT FUNCTION
--==================================================================================================================================================	
function GardenerMod.Mission_3_Next_Waypoint()

	for k,v in pairs(RandomObject) do 		
		OBJECT.DELETE_OBJECT(RandomObject[k])	
	end
	
	UI.REMOVE_BLIP(blip3)
	GRAPHICS.DELETE_CHECKPOINT(Mission_3_Checkpoint)	
		
	if (AreaCleanOfLeaf == 0) then
	
		MissionLocationX = -838.113
		MissionLocationY = 173.557
		MissionLocationZ = 69.23
		
		DrawText("Go to the garden and clean the leafs")	
		
	elseif  (AreaCleanOfLeaf == 1) then 
	
		MissionLocationX = -832.626
		MissionLocationY = 190.58
		MissionLocationZ = 72	
	
	end

	
	if  (AreaCleanOfLeaf < MaxAreaToBlow) then 
			
		LeafSpawned = true
		RandomSpawner(LeafHash, 200, 5, MissionLocationX, MissionLocationY, MissionLocationZ)
	
	
		Mission_3_Checkpoint = GRAPHICS.CREATE_CHECKPOINT(45, MissionLocationX, MissionLocationY, MissionLocationZ-1, MissionLocationX, MissionLocationY, MissionLocationZ, 6, 0, 255, 0, 255, 0)
		GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(Mission_3_Checkpoint, 2, 2, 2)
				
		---------------------------------------------------------------------------
		--				Ajoute un point sur la map
		---------------------------------------------------------------------------	
		blip3 = UI.ADD_BLIP_FOR_COORD(MissionLocationX, MissionLocationY, MissionLocationZ)
		UI.SET_BLIP_COLOUR(blip3, 2)
			
	else 
	
		MissionLocationX = 0
		MissionLocationY = 0
		MissionLocationZ = 0	
		
		FranklinCutscene()	
		
		AUDIO.PLAY_SOUND_FRONTEND(-1, "FocusOut", "HintCamSounds", true)
		DrawText("Oh shit , what happened !")
		UI.SET_BLIP_ROUTE(blip3, false)	
		UI.SET_BLIP_ROUTE(blipPay, true)	
		Mission_3_Done = true
		MissionActif = false		
	end

end
--==================================================================================================================================================



--==================================================================================================================================================
--															STOP MOD FUNCTION
--==================================================================================================================================================	
function StopMod()

	CAM.RENDER_SCRIPT_CAMS(false, false, 3000, true, false)
	
	local pid = PLAYER.PLAYER_PED_ID()
	PED.SET_PED_CAN_SWITCH_WEAPON(pid, true)
	local modelTemp = GAMEPLAY.GET_HASH_KEY("player_zero")

    STREAMING.REQUEST_MODEL(modelTemp)
            
     while (not STREAMING.HAS_MODEL_LOADED(modelTemp)) do wait(50) end
                
    PLAYER.SET_PLAYER_MODEL(PLAYER.PLAYER_ID(), modelTemp)
    PED.SET_PED_DEFAULT_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID())
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelTemp)
			

	if (blip1 > 0) then
		UI.REMOVE_BLIP(blip1)
	end
	if (blip2 > 0) then
		UI.REMOVE_BLIP(blip2)
	end
	if (blip3 > 0) then
		UI.REMOVE_BLIP(blip3)
	end
	if (blipPay > 0) then
		UI.REMOVE_BLIP(blipPay)
	end
	if (blipCar > 0) then
		UI.REMOVE_BLIP(blipCar)
	end
	
	blip1 = 0
	blip2 = 0
	blipPay = 0
	blipCar = 0

	if (Mission_1_Checkpoint > 0) then
		GRAPHICS.DELETE_CHECKPOINT(Mission_1_Checkpoint)
	end
	if (Mission_2_Checkpoint > 0) then
		GRAPHICS.DELETE_CHECKPOINT(Mission_2_Checkpoint)
	end
	if (Mission_3_Checkpoint > 0) then
		GRAPHICS.DELETE_CHECKPOINT(Mission_3_Checkpoint)
	end
	if (MissionPayCheckpoint > 0) then
		GRAPHICS.DELETE_CHECKPOINT(MissionPayCheckpoint)	
	end
	
	if (MissionActif == true and Mission_1_Done == false) then
		for i=0,12,1 do 
		OBJECT.DELETE_OBJECT(Plante[i])
		end	
	end
	
	if(NbrTreeInTrunk == 1) then
	
		OBJECT.DELETE_OBJECT(PlantInTrunk1)	

	elseif (NbrTreeInTrunk == 2) then
	
		OBJECT.DELETE_OBJECT(PlantInTrunk1)	
		OBJECT.DELETE_OBJECT(PlantInTrunk2)

	elseif (NbrTreeInTrunk == 3) then
	
		OBJECT.DELETE_OBJECT(PlantInTrunk1)	
		OBJECT.DELETE_OBJECT(PlantInTrunk2)
		OBJECT.DELETE_OBJECT(PlantInTrunk3)
		
	end		

	Mission_1_Checkpoint = 0
	Mission_2_Checkpoint = 0
	Mission_3_Checkpoint = 0
	MissionPayCheckpoint = 0
	
	PlantedTree = 0
	HedgeTrimmed = 0
	AreaCleanOfLeaf = 0	
	
	Action = false
	
	CharSelected = true
	GardenerMod.GUI_Char.hidden =  true
	
	---------------------------------------------------------------------------
	--				Trunk init
	---------------------------------------------------------------------------	
	TrunkSelect = 1
	NbrTreeInTrunk = 0
	NbrScisInTrunk = 1
	NbrBlowerInTrunk = 1
	CanOpenTrunk = false
	---------------------------------------------------------------------------	
	
	modStarted = false
	MissionActif = false
	StartCheckpointInRange = false
	CarSpawned = false
	
	if (CarToSpawn > 0) then
		VEHICLE.DELETE_VEHICLE(CarToSpawn) 
	end
	CarToSpawn = 0
	BossSpawned = false
	
	if(	BossPed > 0) then
		ENTITY.DELETE_ENTITY(BossPed)
	end
	BossPed = 0
	
	---------------------------------------------------------------------------
	--				Object taken init
	---------------------------------------------------------------------------		
	Object_In_Hand = false
	TrimmerInHand = false
	BlowerInHand = false
	PlantInHand = false
	LeafSpawned = false
	Object_Taken = 0
	blowerActif = false	

	Payed1 = false
	Payed2 = false
	Payed3 = false
	Mission_1_Done = false
	Mission_2_Done = false		
	Mission_3_Done = false	
	IsGateOpen = false
			
end

return GardenerMod