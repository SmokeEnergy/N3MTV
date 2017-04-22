local GFunction = {}

--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- FUNCTIONS
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


--==================================================================================================================================================
--															START MOD FUNCTION
--==================================================================================================================================================	
function StartMod()	
	AUDIO.PLAY_SOUND_FRONTEND(-1, "Hit_out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
	
	SpawnPed(BossHash, BossPositionX, BossPositionY, BossPositionZ, -25)
	
	---------------------------------------------------------------------------
	--				Met un checkpoint
	---------------------------------------------------------------------------	
	MissionPayCheckpoint = GRAPHICS.CREATE_CHECKPOINT(45, BossPositionX, BossPositionY, BossPositionZ - 1, BossPositionX, BossPositionY, BossPositionZ, 3, 0, 255, 0, 255, 0)
	GRAPHICS.SET_CHECKPOINT_CYLINDER_HEIGHT(MissionPayCheckpoint, 1, 1, 1)
		
	---------------------------------------------------------------------------
	--				Affiche l'aide
	---------------------------------------------------------------------------	
	DrawText("Welcome to ~g~The Mighty Rush~s~ Go to the ~g~Waypoint~s~ to get the job")
		
	---------------------------------------------------------------------------
	--				Ajoute un point sur la map
	---------------------------------------------------------------------------	
	blipPay = UI.ADD_BLIP_FOR_COORD(BossPositionX, BossPositionY, BossPositionZ)
	UI.SET_BLIP_SPRITE(blipPay,  431)
	UI.SET_BLIP_COLOUR(blipPay, 2)	
	UI.SET_BLIP_ROUTE(blipPay, true)	
	wait(500)
			
end		
--==================================================================================================================================================	


--==================================================================================================================================================
--															teleport FUNCTION
--==================================================================================================================================================	
function teleport()
	local e = PLAYER.PLAYER_PED_ID()
	if(PED.IS_PED_IN_ANY_VEHICLE(e, false)) then
		e = PED.GET_VEHICLE_PED_IS_USING(e)
	end
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(e, InitPositionX, InitPositionY, InitPositionZ, false, false, true)
		wait(100)
end
--==================================================================================================================================================






--==================================================================================================================================================
--															CAR SPAWNER FUNCTION
--==================================================================================================================================================	
function SpawnCar(Hash, locX, locY, locZ, heading)

		
	if(CarToSpawn ~= 0) then 
		VEHICLE.DELETE_VEHICLE(CarToSpawn) 
		UI.REMOVE_BLIP(blipCar)
	end
	
	if (STREAMING.IS_MODEL_IN_CDIMAGE(Hash) and STREAMING.IS_MODEL_VALID(Hash)) then
		
		STREAMING.REQUEST_MODEL(Hash)	
		
		while (not STREAMING.HAS_MODEL_LOADED(Hash)) do wait (50) end
		
		CarToSpawn = VEHICLE.CREATE_VEHICLE(Hash, locX, locY, locZ, heading, false, true)
		VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(CarToSpawn)	
		--VEHICLE.SET_VEHICLE_DOOR_BREAKABLE(CarToSpawn, 5, false)
		VEHICLE.SET_VEHICLE_IS_STOLEN(CarToSpawn, false)		
	
		blipCar = UI.ADD_BLIP_FOR_ENTITY(CarToSpawn)
		UI.SET_BLIP_SPRITE(blipCar,  225)
		UI.SET_BLIP_COLOUR(blipCar, 2)	

		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
		wait(500)
	else
		print("Model hash not valid")
	end

end
--==================================================================================================================================================




--==================================================================================================================================================
--															PED SPAWNER FUNCTION
--==================================================================================================================================================	
function SpawnPed(Hash, locX, locY, locZ, heading)

	local pid = PLAYER.PLAYER_PED_ID()
	
	STREAMING.REQUEST_MODEL(Hash)	
	while (not STREAMING.HAS_MODEL_LOADED(Hash)) do wait (50) end
			
	BossPed = PED.CREATE_PED( 26, Hash, locX, locY, locZ, heading, false, true)
	PED.SET_PED_COMPONENT_VARIATION(BossPed, 0, 1, 0, 0)
	PED.SET_PED_AS_GROUP_MEMBER(BossPed, PLAYER.GET_PLAYER_GROUP(pid))
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)	
	
	STREAMING.REQUEST_ANIM_DICT("amb@world_human_cop_idles@female@base")
	while (not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_cop_idles@female@base")) do wait(50) end
	AI.TASK_PLAY_ANIM(BossPed,"amb@world_human_cop_idles@female@base", "base", 2.0, -2.0, -1, 1, 0, true, false, true)

	wait(500)
	
end
--==================================================================================================================================================




--==================================================================================================================================================
--															WAYPOINT DISTANCE CHECKER
--==================================================================================================================================================	

function Get_Checkpoint_Distance()
	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(loc.x, loc.y, loc.z, MissionLocationX, MissionLocationY, loc.z, true)
	return distance
end
--==================================================================================================================================================





--==================================================================================================================================================
--															OBJECT SPAWNER FUNCTION
--==================================================================================================================================================	
function SpawnObject(modelToSpawn)
	--local modelToSpawn = GAMEPLAY.GET_HASH_KEY(modelName)
	local LrandomX = math.random() * 2 - math.random() * 2 
	local LrandomY = math.random() * 2 - math.random() * 2
	
	if (STREAMING.IS_MODEL_IN_CDIMAGE(modelToSpawn) and STREAMING.IS_MODEL_VALID(modelToSpawn)) then
		STREAMING.REQUEST_MODEL(modelToSpawn)
		while (not STREAMING.HAS_MODEL_LOADED(modelToSpawn)) do wait(50) end
		local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 1.0, -0.3)
		local objToSpawn = OBJECT.CREATE_OBJECT(modelToSpawn, coords.x + LrandomX, coords.y + LrandomY, coords.z, true, false, true)
		OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(objToSpawn)
			
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelToSpawn)
		--ENTITY.SET_OBJECT_AS_NO_LONGER_NEEDED(objToSpawn)
		
		return objToSpawn
	else
		-- print("Model hash not valid (" .. modelName .. ", ".. tostring(modelToSpawn))
	end	
end
--==================================================================================================================================================




--==================================================================================================================================================
--															ATTACH OBJECT TO HAND FUNCTION
--==================================================================================================================================================	
function AttachObjectToHand(PosX, PosY, PosZ, RotX, RotY, RotZ)

	ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_Taken, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 57005), PosX, PosY, PosZ, RotX, RotY, RotZ, false, false, false, false, 2, true)

end
--==================================================================================================================================================


--==================================================================================================================================================
--															DETACH OBJECT TO HAND FUNCTION
--==================================================================================================================================================	
function DetachObjectToHand()

Action = true

	local pid = PLAYER.PLAYER_PED_ID()
	local vec = ENTITY.GET_ENTITY_FORWARD_VECTOR(pid)	
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)	
	
	local SpawnX = loc.x + (vec.x * 0.5)
	local SpawnY = loc.y + (vec.y * 0.5)
	local SpawnZ = loc.z + 0.5
	
	
	--Only for plants and Blower at the moment
	
	if (Object_In_Hand == true) then
	
			---------------------------------------------------------------------------
			--				play animation 
			---------------------------------------------------------------------------		
			AI.CLEAR_PED_TASKS(pid)
			Fix_Animation(Take_animCore, Take_anim)
			wait (500)
			ENTITY.DETACH_ENTITY(Object_Taken,true, true)
			ENTITY.SET_ENTITY_COLLISION(Object_Taken, false, false)
			AI.CLEAR_PED_TASKS(pid)
		
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_Taken, SpawnX, SpawnY, SpawnZ, false, false, true)
			OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(Object_Taken)
		
			Object_In_Hand = false
			TrimmerInHand = false
			PlantInHand = false 
			BlowerInHand = false
			blowerActif = false
			
			wait (100)
			ENTITY.SET_ENTITY_COLLISION(Object_Taken, true, false)

		
	end
	
Action = false

end
--==================================================================================================================================================



--==================================================================================================================================================
--															DETECT OBJECT FUNCTION
--==================================================================================================================================================	
function ObjectDetect(objHash)

		local pid = PLAYER.PLAYER_PED_ID()
		local PVec = ENTITY.GET_ENTITY_FORWARD_VECTOR(pid)	
		local PLoc = ENTITY.GET_ENTITY_COORDS(pid, nil)	
		local ID = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(PLoc.x + (PVec.x * 0.5), PLoc.y + (PVec.y * 0.5), PLoc.z, 1,objHash, false)
		local Detected = false
		
		if (ENTITY.IS_ENTITY_IN_ANGLED_AREA(ID, PLoc.x, PLoc.y, PLoc.z, PLoc.x + (PVec.x * 2), PLoc.y + (PVec.y * 2), PLoc.z, 45, false, false, 10) ) then
			Detected = true
		else
			Detected = false	
		end
		
		return ID, Detected
end



--==================================================================================================================================================
--															TAKE OBJECT FUNCTION
--==================================================================================================================================================	
function TakeClosestObject()

Action = true

	if (Object_In_Hand == false) then

		local pid = PLAYER.PLAYER_PED_ID()
		
		local ClosestTreeID, TreeInRange = ObjectDetect(PlantHash)
		local ClosestBlowerID, BlowerInRange = ObjectDetect(BlowerHash)
		local ClosestTrimmerID, TrimmerInRange = ObjectDetect(TrimmerHash)
		
		if	(TreeInRange == true) then
			---------------------------------------------------------------------------
			--				Check if is planted tree 
			---------------------------------------------------------------------------	
			local CanTakePlant = true
			
			for k,v in pairs(PlantedTreeID) do 
			
				if ( ClosestTreeID == PlantedTreeID[k] ) then
						CanTakePlant = false
				end
			
			end
					

			if (ClosestTreeID ~= PlantInTrunk1 and ClosestTreeID ~= PlantInTrunk2 and ClosestTreeID ~= PlantInTrunk3 and CanTakePlant == true) then
			
				PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 0.5)
				---------------------------------------------------------------------------
				--				play animation 
				---------------------------------------------------------------------------		
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(Take_animCore, Take_anim)
				wait (500)
				
					
				---------------------------------------------------------------------------
				--															Prend Plante	
				---------------------------------------------------------------------------
				Object_Taken = ClosestTreeID
				AttachObjectToHand(0.0,0.4,-1.0, -20.0,0.0,-180.0)
				
				---------------------------------------------------------------------------
				--				play animation 
				---------------------------------------------------------------------------				
				AI.CLEAR_PED_TASKS(pid)	
				Walkable_Animation(Grab_animCore, Grab_anim)
				wait(100)
				
				PlantInHand = true		
				Object_In_Hand = true	
				
			end
			
		elseif 	(BlowerInRange == true) then
		
			---------------------------------------------------------------------------
			--				play animation 
			---------------------------------------------------------------------------		
			AI.CLEAR_PED_TASKS(pid)
			Fix_Animation(Take_animCore, Take_anim)
			wait (500)
				

					
			---------------------------------------------------------------------------
			--															Prend Plante	
			---------------------------------------------------------------------------
			Object_Taken = ClosestBlowerID
			AttachObjectToHand(0.14,0.02,0.0,-40.0,-40.0,0.0)
			
			AI.CLEAR_PED_TASKS(pid)	
				
			BlowerInHand = true		
			Object_In_Hand = true	
			
		elseif 	(TrimmerInRange == true) then
		
			---------------------------------------------------------------------------
			--				play animation 
			---------------------------------------------------------------------------		
			AI.CLEAR_PED_TASKS(pid)
			Fix_Animation(Take_animCore, Take_anim)
			wait (500)
					
			---------------------------------------------------------------------------
			--															Prend Plante	
			---------------------------------------------------------------------------
			Object_Taken = ClosestTrimmerID
			AttachObjectToHand(0.09,0.02,0.01,-121.0,181.0,187.0)
			
			AI.CLEAR_PED_TASKS(pid)	
				
			TrimmerInHand = true		
			Object_In_Hand = true	
		
		end	
	end	
	
Action = false

end
--==================================================================================================================================================		






--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ Vehicle ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■



--==================================================================================================================================================
--															Open trunk FUNCTION
function OpenTrunk()

	Action = true
	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)	
	
	if (Object_In_Hand == true) then
	
		--				Open trunk
		---------------------------------------------------------------------------		
		VEHICLE.SET_VEHICLE_DOOR_OPEN(CarToSpawn, 5, false, false)

		--				play animation
		---------------------------------------------------------------------------		
		Walkable_Animation(Grab_animCore, Grab_anim)
		wait(500)

	
		--				Check the model of object
		---------------------------------------------------------------------------		
		local HandObjectModel = ENTITY.GET_ENTITY_MODEL(Object_Taken)
		
		---------------------------------------------------------------------------
		--	OBJECT IS A PLANT
		---------------------------------------------------------------------------	
		if (HandObjectModel == PlantHash) then
		
			STREAMING.REQUEST_MODEL(PlantHash)
			while (not STREAMING.HAS_MODEL_LOADED(PlantHash)) do wait (50) end
			NbrTreeInTrunk = NbrTreeInTrunk + 1	
			
			if(NbrTreeInTrunk == 1) then
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(TakeTree_animCore, TakeTree_anim)
				wait(1000)
				AI.CLEAR_PED_TASKS(pid)
				PlantInTrunk1 = OBJECT.CREATE_OBJECT_NO_OFFSET(PlantHash, loc.x, loc.y, loc.z, false, true, false)
				ENTITY.ATTACH_ENTITY_TO_ENTITY(PlantInTrunk1, CarToSpawn, 30, -0.9, -2, 1.6, 0, 90, 0, false, false, false, false, 2, true)
				PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 1)
				
			elseif (NbrTreeInTrunk == 2) then
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(TakeTree_animCore, TakeTree_anim)
				wait(1000)
				AI.CLEAR_PED_TASKS(pid)			
				PlantInTrunk2 = OBJECT.CREATE_OBJECT_NO_OFFSET(PlantHash, loc.x, loc.y, loc.z, false, true, false)
				ENTITY.ATTACH_ENTITY_TO_ENTITY(PlantInTrunk2, CarToSpawn, 30, -0.9, -1, 1.6, 0, 90, 0, false, false, false, false, 2, true)
				PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 1)
				
			elseif (NbrTreeInTrunk == 3) then
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(TakeTree_animCore, TakeTree_anim)
				wait(1000)
				AI.CLEAR_PED_TASKS(pid)			
				PlantInTrunk3 = OBJECT.CREATE_OBJECT_NO_OFFSET(PlantHash, loc.x, loc.y, loc.z, false, true, false)
				ENTITY.ATTACH_ENTITY_TO_ENTITY(PlantInTrunk3, CarToSpawn, 30, -0.9, 0, 1.6, 0, 90, 0, false, false, false, false, 2, true)
				PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 1)

							
			else
				NbrTreeInTrunk = NbrTreeInTrunk - 1	
				DrawText("The car is full of trees")
				goto CLOSE
				
			end	
			
		---------------------------------------------------------------------------
		--	OBJECT IS A SCISOR
		---------------------------------------------------------------------------				
		elseif (HandObjectModel == TrimmerHash) then
			PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 1)
			NbrScisInTrunk = NbrScisInTrunk + 1	
			
		---------------------------------------------------------------------------
		--	OBJECT IS A LEAF BLOWER
		---------------------------------------------------------------------------				
		elseif (HandObjectModel == BlowerHash) then
			PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 1)
			NbrBlowerInTrunk = NbrBlowerInTrunk + 1
			
		end

		--				Delete object
		---------------------------------------------------------------------------			
		OBJECT.DELETE_OBJECT(Object_Taken)
		
		AI.CLEAR_PED_TASKS(pid)	
		
		--VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(CarToSpawn, pid, false)
		

		TrunkOpen = false
		Object_In_Hand = false
		BlowerInHand = false
		PlantInHand = false
		TrimmerInHand = false
		blowerActif = false
		
		:: CLOSE ::		
					--				Close trunk
		---------------------------------------------------------------------------		
		VEHICLE.SET_VEHICLE_DOOR_SHUT(CarToSpawn, 5, false)	

	else
	---------------------------------------------------------------------------
	--																		TAKING OBJECT IN TRUNK
	---------------------------------------------------------------------------	

		--				Open trunk
		---------------------------------------------------------------------------		
		VEHICLE.SET_VEHICLE_DOOR_OPEN(CarToSpawn, 5, false, false)
		
		
		--				play animation
		---------------------------------------------------------------------------		
		Walkable_Animation(Grab_animCore, Grab_anim)
		wait(500)

		if ( TrunkSelect == 0) then
		
			AI.CLEAR_PED_TASKS(pid)
			--goto TrunkMenu
			
		elseif ( TrunkSelect == 1) then
			PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 0.5)
			if (NbrTreeInTrunk > 0) then
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(TakeTree_animCore, TakeTree_anim)
				wait(1000)
				AI.CLEAR_PED_TASKS(pid)
				Walkable_Animation(Grab_animCore, Grab_anim)
				if (NbrTreeInTrunk == 1) then
					OBJECT.DELETE_OBJECT(PlantInTrunk1)
				elseif (NbrTreeInTrunk == 2) then
					OBJECT.DELETE_OBJECT(PlantInTrunk2)
				elseif (NbrTreeInTrunk == 3) then
					OBJECT.DELETE_OBJECT(PlantInTrunk3)
				end
				
			
				---------------------------------------------------------------------------
				--															Prend Plante	
				---------------------------------------------------------------------------
				Object_Taken = SpawnObject(PlantHash)
				ENTITY.SET_ENTITY_COLLISION(Object_Taken, false, false)
				AttachObjectToHand(0.0,0.4,-1.0,-20.0,0.0,-180.0)
				PlantInHand = true
				NbrTreeInTrunk = NbrTreeInTrunk - 1
				Object_In_Hand = true
				
			else
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(EmptyTree_animCore, EmptyTree_anim)
				DrawText("Here is no trees in the trunk")
				wait (2000)
				AI.CLEAR_PED_TASKS(pid)
				
			end
		elseif ( TrunkSelect == 2) then
		
			if (NbrScisInTrunk > 0) then
			
			--	ObjPosX = 0.13
			--	ObjPosY = -0.01
			--	ObjPosZ = -0.00
			--	ObjRotX = -5.00
			--	ObjRotY = 174.00
			--	ObjRotZ = -48.00
			
				ObjPosX = 0.09
				ObjPosY = 0.02
				ObjPosZ = 0.01
				ObjRotX = -121
				ObjRotY = 181
				ObjRotZ = 187
				
				AI.CLEAR_PED_TASKS(pid)
				
				---------------------------------------------------------------------------
				--															Prend Ciseaux	
				---------------------------------------------------------------------------
				Object_Taken = SpawnObject(TrimmerHash)
				ENTITY.SET_ENTITY_COLLISION(Object_Taken, false, false)
				AttachObjectToHand(0.09,0.02,0.01,-121.0,181.0,187.0)
				TrimmerInHand = true
				NbrScisInTrunk = NbrScisInTrunk - 1
				Object_In_Hand = true
			else
			
				DrawText("Here is no Scisor in the trunk")
				AI.CLEAR_PED_TASKS(pid)
				
			end
				
		elseif ( TrunkSelect == 3) then
			PLAYER._SET_MOVE_SPEED_MULTIPLIER(pid, 0.5)
			if (NbrBlowerInTrunk > 0) then	
			
				
				AI.CLEAR_PED_TASKS(pid)
				---------------------------------------------------------------------------
				--															Prend Blower	
				---------------------------------------------------------------------------			
				Object_Taken = SpawnObject(BlowerHash)
				ENTITY.SET_ENTITY_COLLISION(Object_Taken, false, false)
				AttachObjectToHand(0.14,0.02,0.0,-40.0,-40.0,0.0)
				BlowerInHand = true
				NbrBlowerInTrunk = NbrBlowerInTrunk - 1
				Object_In_Hand = true
				
			else
			
				DrawText("Here is no Leaf Blower in the trunk")
				AI.CLEAR_PED_TASKS(pid)
				
			end
		end
		

		--				Close trunk
		---------------------------------------------------------------------------		
		VEHICLE.SET_VEHICLE_DOOR_SHUT(CarToSpawn, 5, false)		

	
	end

	Action = false
end
--==================================================================================================================================================


--==================================================================================================================================================
--															Vehicle Hit FUNCTION
function VehicleHit()
	local pid = PLAYER.PLAYER_PED_ID()
	local Damage = VEHICLE.GET_VEHICLE_BODY_HEALTH(PED.GET_VEHICLE_PED_IS_IN(pid, false))
	wait(10)
	local Damage2 = VEHICLE.GET_VEHICLE_BODY_HEALTH(PED.GET_VEHICLE_PED_IS_IN(pid, false))
	--print ("Damage :" .. Damage)
	--print ("Damage2 :" .. Damage2)
	if (Damage2 < (Damage - 50)) then
	
		if (NbrTreeInTrunk == 3) then
			DrawText("OH MY GOD ! The trees are broken")
			ENTITY.DETACH_ENTITY(PlantInTrunk1,true, true)
			ENTITY.DETACH_ENTITY(PlantInTrunk2,true, true)
			ENTITY.DETACH_ENTITY(PlantInTrunk3,true, true)
		elseif (NbrTreeInTrunk == 2) then
			DrawText("OH MY GOD ! The trees are broken")
			ENTITY.DETACH_ENTITY(PlantInTrunk1,true, true)
			ENTITY.DETACH_ENTITY(PlantInTrunk2,true, true)
		elseif (NbrTreeInTrunk == 1) then
			DrawText("OH MY GOD ! The tree is broken")
			ENTITY.DETACH_ENTITY(PlantInTrunk1,true, true)				
		end
		DrawText("Be carefull, you have some expensive stuff in the car!")
		NbrTreeInTrunk = 0
		AUDIO._PLAY_AMBIENT_SPEECH1(PLAYER.PLAYER_PED_ID(), "GENERIC_CURSE_HIGH", "SPEECH_PARAMS_FORCE")
		--print ("hit")
		--print ("Damage :" .. Damage)
		--print ("Damage2 :" .. Damage2)
	end
	
end
--==================================================================================================================================================

--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■





--==================================================================================================================================================
--															DRAW TEXT FUNCTION
--==================================================================================================================================================	
function DrawText(Text)
	UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")
	UI._ADD_TEXT_COMPONENT_STRING(Text)
	UI._DRAW_NOTIFICATION(false, true)
end
--==================================================================================================================================================



--==================================================================================================================================================
--															WALKABLE ANIMATION FUNCTION
--==================================================================================================================================================	
function Walkable_Animation(Wanted_CoreAnim, Wanted_anim)

	local pid = PLAYER.PLAYER_PED_ID()
	
	STREAMING.REQUEST_ANIM_DICT(Wanted_CoreAnim)
	while (not STREAMING.HAS_ANIM_DICT_LOADED(Wanted_CoreAnim)) do wait(50) end
	AI.TASK_PLAY_ANIM(pid,Wanted_CoreAnim, Wanted_anim, 2.0, -2.0, -1, 49, 0, true, false, true)

end
--==================================================================================================================================================


--==================================================================================================================================================
--															FIX ANIMATION FUNCTION
--==================================================================================================================================================	
function Fix_Animation(Wanted_CoreAnim, Wanted_anim)

	local pid = PLAYER.PLAYER_PED_ID()
	
	STREAMING.REQUEST_ANIM_DICT(Wanted_CoreAnim)
	while (not STREAMING.HAS_ANIM_DICT_LOADED(Wanted_CoreAnim)) do wait(50) end
	AI.TASK_PLAY_ANIM(pid,Wanted_CoreAnim, Wanted_anim, 2.0, -2.0, -1, 1, 0, true, false, true)

end
--==================================================================================================================================================



--==================================================================================================================================================
--															RAGDOLL FUNCTION
--==================================================================================================================================================	
function Ragdoll(Ped, Time)
	local delay = Time * 100
	PED.SET_PED_TO_RAGDOLL(Ped, delay, 0, 0, TRUE, TRUE, TRUE)

end
--==================================================================================================================================================




--==================================================================================================================================================
--															DEATH CHECKER FUNCTION
--==================================================================================================================================================	
function CheckDeath()

    local pid = PLAYER.PLAYER_PED_ID()
    
	
    local modelTemp = ENTITY.GET_ENTITY_MODEL(pid)
    
    if (ENTITY.IS_ENTITY_DEAD(pid) or PLAYER.IS_PLAYER_BEING_ARRESTED(pid, true)) then

        if (modelTemp ~= GAMEPLAY.GET_HASH_KEY("player_zero") and modelTemp ~= GAMEPLAY.GET_HASH_KEY("player_one") and modelTemp ~= GAMEPLAY.GET_HASH_KEY("player_two")) then

			wait (2000)   
			StopMod()
			
		end
    end
	
end
--==================================================================================================================================================



--==================================================================================================================================================
--															Hedge-Trimmer FUNCTION
--==================================================================================================================================================	
function HedgeTrimmer()

Action = true

	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(loc.x, loc.y, loc.z, MissionLocationX, MissionLocationY, loc.z, true)
	---------------------------------------------------------------------------
	--				Si joueur a coté de location
	---------------------------------------------------------------------------	
	if (Get_Checkpoint_Distance() < 3 ) then
	
		if (TrimmerInHand == true) then
		
			if (Get_Checkpoint_Distance() < 0.7) then
				DrawText("You are too close")
			else
	
				---------------------------------------------------------------------------
				--				play animation 
				---------------------------------------------------------------------------		
				AI.CLEAR_PED_TASKS(pid)
				Fix_Animation(HedgeCut_animCore, HedgeCut_anim)
				wait(3000)
				AI.CLEAR_PED_TASKS(pid)
				
				---------------------------------------------------------------------------
				--				Next step 
				---------------------------------------------------------------------------		
				HedgeTrimmed = HedgeTrimmed + 1
				
				IsHedgeTrimmed = true
				
			end
			
		else
		
			local Randomtext = math.random(4)
			if (Randomtext == 0) then
				DrawText("Did you not forget something?")
			elseif (Randomtext == 1) then
				GardnerMod.DrawText("Come on Carlos!")
			elseif (Randomtext == 2) then
				DrawText("Will you cut this with your fingers ?")
			elseif (Randomtext == 3) then
				DrawText("You need to cut the hedges, take the tool in the car trunk")
			else
				DrawText("You dont have the Hedge Trimmer, take it in your car trunk")
			end
			
		end
	end
	
	Action = false
end



--==================================================================================================================================================
--															PLANT TREE FUNCTION
--==================================================================================================================================================	
function PlanteArbre()

Action = true

	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(loc.x, loc.y, loc.z, MissionLocationX, MissionLocationY, loc.z, true)
	---------------------------------------------------------------------------
	--				Si joueur a coté de location
	---------------------------------------------------------------------------	
	if (Get_Checkpoint_Distance() < 0.7) then
	
		if (PlantInHand == true) then

			Object_In_Hand = false
			PlantInHand = false
			
			local PlayerForwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(pid)		
			local SpawnX = loc.x + (PlayerForwardVector.x * 0.5)
			local SpawnY = loc.y + (PlayerForwardVector.y * 0.5)
			local SpawnZ = loc.z - 1.5		
			
			---------------------------------------------------------------------------			
			-- Delete tree in hand
			---------------------------------------------------------------------------	
			OBJECT.DELETE_OBJECT(Object_Taken)
			
			---------------------------------------------------------------------------
			--				Plante l'arbre
			---------------------------------------------------------------------------
			if (STREAMING.IS_MODEL_VALID(PlantHash)) then
			
				STREAMING.REQUEST_MODEL(PlantHash)
				while (not STREAMING.HAS_MODEL_LOADED(PlantHash)) do wait (50) end
				PlantedTreeID[IterationPlant] = OBJECT.CREATE_OBJECT_NO_OFFSET(PlantHash, SpawnX, SpawnY, SpawnZ, false, true, false)
				ENTITY.SET_ENTITY_COLLISION(PlantedTreeID[IterationPlant], false, false)
				
				IterationPlant = IterationPlant + 1
				

			end
			
			---------------------------------------------------------------------------
			--				play animation 
			---------------------------------------------------------------------------		
			AI.CLEAR_PED_TASKS(pid)
			AI.TASK_START_SCENARIO_IN_PLACE(pid,"WORLD_HUMAN_GARDENER_PLANT", 0, false)
			wait (3000)
			AI.CLEAR_PED_TASKS(pid)
			
			
			---------------------------------------------------------------------------
			--				Next step 
			---------------------------------------------------------------------------			
			PlantedTree = PlantedTree + 1
			
			IsTreePlanted = true
			
			--GardnerMod.Mission_1_Next_Waypoint(PlantedTree)
			
		else
		
			local Randomtext = math.random(3)
			if (Randomtext == 0) then
				DrawText("Did you not forget something?")
			elseif (Randomtext == 1) then
				DrawText("Come on Carlos!")
			elseif (Randomtext == 2) then
				DrawText("You need a tree, are you really a gardener ?")
			else
				DrawText("You need something to plant, maybe in the car trunk ?")
			end
		
		end

	end
	
	wait(1000)
	
Action = false

end
--==================================================================================================================================================




--==================================================================================================================================================
--															OPEN GATE MISSION FUNCTION
--==================================================================================================================================================	
function GateTrigger()


	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local distance = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(loc.x, loc.y, loc.z, GateLocationX, GateLocationY, GateLocationZ, true)
	---------------------------------------------------------------------------
	--				Si joueur a coté de location
	---------------------------------------------------------------------------	
	if (distance < 5) then
		CAM.DO_SCREEN_FADE_OUT(1000)
		wait(1000)
		
		OpenGate()
		
		CAM.DO_SCREEN_FADE_IN(1000)	
		wait(1000)
	end

end
--==================================================================================================================================================

function OpenGate()

	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	
	M_GateID = 49154
	M_GateHash = 2169543803
	M_GateX = -844.05
	M_GateY = 155.96
	M_GateZ = 66.03
	
	OBJECT.SET_STATE_OF_CLOSEST_DOOR_OF_TYPE(M_GateHash, location.x, location.y, location.z, true, 180, true)
	
	IsGateOpen = true
	
end
--==================================================================================================================================================
--															LEAF SPAWNER FUNCTION	
function RandomSpawner(Hash, Quantity, Ray, locX, locY, locZ)

	local pid = PLAYER.PLAYER_PED_ID()
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)	
	
	for i = 1, Quantity do

		local LrandomX = math.random() * Ray - math.random() * Ray
		local LrandomY = math.random() * Ray - math.random() * Ray
		RandomObject[i] = SpawnObject(Hash)	
	
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(RandomObject[i], locX + LrandomX, locY + LrandomY, locZ - 1, false, false, true)
		OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(RandomObject[i])
	end
	
end
--==================================================================================================================================================	



--==================================================================================================================================================
--															BLOWER FORCE FUNCTION
--==================================================================================================================================================	
function BlowerForce()
		
	local pid = PLAYER.PLAYER_PED_ID()
	local vec = ENTITY.GET_ENTITY_FORWARD_VECTOR(pid)	
	local loc = ENTITY.GET_ENTITY_COORDS(pid, nil)	
	local WantedObject = "prop_cs_leaf"
	local ObjetDetect = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(loc.x + (vec.x * 4), loc.y + (vec.y * 4), loc.z, 2, GAMEPLAY.GET_HASH_KEY(WantedObject), false)
	
	if (ENTITY.IS_ENTITY_IN_ANGLED_AREA(ObjetDetect, loc.x, loc.y, loc.z, loc.x + (vec.x * 10), loc.y + (vec.y * 10), loc.z, 5.785398, false, false, 10) ) then
		ENTITY.SET_ENTITY_VELOCITY(ObjetDetect, vec.x * BlowerPower,vec.y * BlowerPower,BlowerPower/5)
	end	
	
end
--==================================================================================================================================================		

function CheckLeafInRange(Range)

	local pid = PLAYER.PLAYER_PED_ID()
	LeafInRange = OBJECT.IS_OBJECT_NEAR_POINT(LeafHash, MissionLocationX, MissionLocationY, MissionLocationZ, Range)
	if(not LeafInRange) then
		LeafSpawned = false
		AreaCleanOfLeaf = AreaCleanOfLeaf + 1	
		print("Clean")
	end
	
end

--==================================================================================================================================================
--															PAY FUNCTION
--==================================================================================================================================================	
function PayMission(givemoney)

	local pid = PLAYER.PLAYER_PED_ID()
	local bossDead = PED._IS_PED_DEAD(BossPed, true)
	
	if (bossDead == true)then
		---------------------------------------------------------------------------
		--				Boss is dead
		---------------------------------------------------------------------------	
		DrawText("Your boss is dead, try to found an other job")
		
	else
	
		---------------------------------------------------------------------------
		--				Paye
		---------------------------------------------------------------------------	
		DrawText("Congratulation gardener, here is your ~g~$" .. givemoney)
		
		local statname = "SP"..model.."_TOTAL_CASH"
		local hash = GAMEPLAY.GET_HASH_KEY(statname)
		local bool, val = STATS.STAT_GET_INT(hash, 0, -1)

		STATS.STAT_SET_INT(hash, val + givemoney, true)
		AUDIO.PLAY_SOUND_FRONTEND(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
		
		AUDIO._PLAY_AMBIENT_SPEECH1(pid, "GENERIC_THANKS", "SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL")
		
	end
	
end
--==================================================================================================================================================

function FranklinCutscene()

	CAM.DO_SCREEN_FADE_OUT(4000)
	wait(4000)	
	TIME.SET_CLOCK_TIME(12,0,0)
	local pid = PLAYER.PLAYER_PED_ID()
	local Hash = GAMEPLAY.GET_HASH_KEY("PLAYER_ONE")
	local locX = -846.17
	local locY = 177.84
	local locZ = 70
	
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pid, -832.93, 187.44, 72.31, false, false, true)
	ENTITY.SET_ENTITY_ROTATION(pid, 0, 0, 0, 0, false)
	Fix_Animation(Blower_animCore, Blower_anim)

	CAM.DO_SCREEN_FADE_IN(1000)	
	wait(1000)	
	
	STREAMING.REQUEST_MODEL(Hash)	
	while (not STREAMING.HAS_MODEL_LOADED(Hash)) do wait (50) end			
	Franklin = PED.CREATE_PED( 26, Hash, locX, locY, locZ, -90, false, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
	
	AI.TASK_FOLLOW_NAV_MESH_TO_COORD(Franklin, -833.62, 184.78, 71.89, 1, -1, 0, 0, 0)
	
	wait(9000)
	
	STREAMING.REQUEST_ANIM_DICT("melee@unarmed@streamed_core_fps")
	while (not STREAMING.HAS_ANIM_DICT_LOADED("melee@unarmed@streamed_core_fps")) do wait(50) end
	AI.TASK_PLAY_ANIM(Franklin,"melee@unarmed@streamed_core_fps", "long_-90_punch", 2.0, -2.0, -1, 1, 0, true, false, true)	

	wait(600)


	Fix_Animation("melee@unarmed@streamed_core_fps", "victim_stealth_kill_unarmed_non_lethal_b")

	wait(1500)
	AI.TASK_FOLLOW_NAV_MESH_TO_COORD(Franklin, locX, locY, locZ, 1, -1, 0, 0, 0)
	Ragdoll(pid, 50)
	CAM.DO_SCREEN_FADE_OUT(1000)
	wait(1000)
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionIn", 0, false)
	ENTITY.DELETE_ENTITY(Franklin)
	TIME.SET_CLOCK_TIME(20,0,0)
	Ragdoll(pid, 20)
	CAM.DO_SCREEN_FADE_IN(5000)	
	wait(5000)	
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionIn")
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionIn")
	GRAPHICS._START_SCREEN_EFFECT("MinigameTransitionOut", 0, false)
	wait (1000)
	GRAPHICS._STOP_SCREEN_EFFECT("MinigameTransitionOut")		
	AUDIO._PLAY_AMBIENT_SPEECH1(pid, "GENERIC_CURSE_HIGH", "SPEECH_PARAMS_FORCE")
	
end	
	
	

return GFunction