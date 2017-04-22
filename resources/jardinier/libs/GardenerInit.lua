local GardenerInit = {}


	function Gardenerinit()
		-- "prop_fbibombplant",
--{ "melee@knife@streamed_variations", "victim_knife_front_takedown_variation_a"}, gardener is hit
--{ "melee@unarmed@streamed_core_fps", "long_-90_punch"},	franklin hit gardener

PlanteType = {
	"prop_plant_01a",
	"prop_plant_01b",
	"prop_plant_base_01",
	"prop_plant_base_02",
	"prop_plant_base_03",
	"prop_plant_cane_01a",
	"prop_plant_cane_01b",
	"prop_plant_cane_02a",
	"prop_plant_cane_02b",
	"prop_plant_clover_01",
	"prop_plant_clover_02",
	"prop_plant_fern_01a",
	"prop_plant_fern_01b",
	"prop_plant_fern_02a",
	"prop_plant_fern_02b",
	"prop_plant_fern_02c",
	"prop_plant_flower_01",
	"prop_plant_flower_02",
	"prop_plant_flower_03",
	"prop_plant_flower_04",
	"prop_plant_group_01",
	"prop_plant_group_02",
	"prop_plant_group_03",
	"prop_plant_group_04",
	"prop_plant_group_05",
	"prop_plant_group_05b",
	"prop_plant_group_05c",
	"prop_plant_group_05d",
	"prop_plant_group_06a",
	"prop_plant_group_06b",
	"prop_plant_group_06c",
	"prop_plant_int_02a",
	"prop_plant_int_02b",
	"prop_plant_int_05a",
	"prop_plant_int_05b",
	"prop_plant_int_06a",
	"prop_plant_int_06b",
	"prop_plant_int_06c",
	"prop_plant_paradise",
	"prop_plant_paradise_b"
}
--{ "amb@code_human_in_car_mp_actions@dance@bodhi@ds@base", "exit_fp"}, cut
--{ "veh@plane@lazer@front@ps@enter_exit", "d_locked"}, no tree
--{ "mini@strip_club@idles@bouncer@side_enter", "side_enter"}, videur entrer
--{ "veh@low@front_dsfps@base", "horn_outro"}, take one hand
--{ "amb@medic@standing@kneel@base", "base"}, acroupi
--{ "amb@prop_human_bbq@male@idle_a", "idle_b"}, BBQ
--{ "amb@prop_human_bum_bin@base", "base"}, penché avant
--{ "amb@prop_human_movie_bulb@base", "base"}, Cut up
--{ "amb@world_human_car_park_attendant@male@base", "base"}, graines
--{ "amb@world_human_cheering@male_a", "base"}, aplause
-- { "amb@world_human_const_drill@male@drill@base", "base"}, drill
--{ "amb@world_human_cop_idles@female@base", "base"}, bras croisé
--{ "amb@world_human_security_shine_torch@male@enter", "enter"}, prendre poche
--{ "amb@world_human_security_shine_torch@male@exit", "exit"}, renger poche
	PlantedTreeID = {}
	Plante = {}
	RandomObject = {}
	-- "prop_handrake" (petit rateau)
	-- "prop_cs_scissors" (ciseaux)

	---------------------------------------------------------------------------
	--				BLOWER POWER
	---------------------------------------------------------------------------		
	BlowerPower = 10   -- you can change the power
	blowerActif = false
	---------------------------------------------------------------------------	
	
	ObjPosX = 0.13
	ObjPosY = -0.01
	ObjPosZ = -0.00
	ObjRotX = -5.00
	ObjRotY = 174.00
	ObjRotZ = -48.00
	
	
	GardenerSkin = {
	{0,0,0,0},
	{0,0,1,0},
	{0,0,2,0},
	{0,1,0,0},
	{0,1,1,0},
	{0,1,2,0},

	{10,0,0,0},
	{10,0,1,0},
	{10,1,0,0},
	{10,1,1,0},
	{10,2,0,0},

	{3,0,0,0},
	{3,0,1,0},
	{3,0,2,0},
	{3,1,0,0},
	{3,1,1,0},
	{3,1,2,0},
	{3,1,3,0},
	{3,1,4,0},
	{3,1,5,0},

	{4,0,0,0},
	{4,0,1,0},
	{4,1,0,0},
	{4,1,1,0},
	{8,0,0,0}

	}	
	
	VarPedHead = 1
	VarPedUP = 7
	VarPedDOWN = 21
	
	CharSelected = false
	InCharSelection = false
	i = 0
	IterationPlant = 0
	
	blip1 = 0
	blip2 = 0
	blip3 = 0
	blip4 = 0
	blip5 = 0
	
	blipPay = 0
	blipCar = 0
	
	Mission_1_Checkpoint = 0
	Mission_2_Checkpoint = 0
	Mission_3_Checkpoint = 0
	Mission_4_Checkpoint = 0
	Mission_5_Checkpoint = 0
	
	MissionPayCheckpoint = 0
	
	PlantedTree = 0
	HedgeTrimmed = 0
	
	PlantInTrunk1 = 0
	PlantInTrunk2 = 0
	PlantInTrunk3 = 0
	
	Action = false
	
	model = 0
	---------------------------------------------------------------------------
	--				Trunk init
	---------------------------------------------------------------------------	
	TrunkSelect = 1
	NbrTreeInTrunk = 0
	NbrScisInTrunk = 1
	NbrBlowerInTrunk = 1
	CanOpenTrunk = false
	TrunkOpen = false
	---------------------------------------------------------------------------	
	
	modStarted = false
	MissionActif = false
	StartCheckpointInRange = false
	CarSpawned = false
	CarToSpawn = 0
	BossSpawned = false
	BossPed = 0
	
	---------------------------------------------------------------------------
	--				Object taken init
	---------------------------------------------------------------------------		
	Object_In_Hand = false
	TrimmerInHand = false
	BlowerInHand = false
	PlantInHand = false
	Object_Taken = 0
	
	---------------------------------------------------------------------------	
	CarSpawnCoordX = -498.25
	CarSpawnCoordY = -65.38
	CarSpawnCoordZ = 39.8

	Payed1 = false
	Payed2 = false
	Payed3 = false
	Payed4 = false
	Payed5 = false
	
	Mission_1_Done = false
	Mission_2_Done = false
	Mission_3_Done = false
	Mission_4_Done = false
	Mission_5_Done = false

	---------------------------------------------------------------------------
	--				Animations
	---------------------------------------------------------------------------	
		Grab_animCore = "amb@world_human_bum_freeway@male@base"
		Grab_anim = "base"

		Take_animCore = "amb@world_human_gardener_plant@male@base"
		Take_anim = "base"
		
		EmptyTree_animCore = "veh@plane@lazer@front@ps@enter_exit"
		EmptyTree_anim = "d_locked"
		
		TakeTree_animCore = "amb@prop_human_movie_bulb@base"
		TakeTree_anim = "base"

		Blower_animCore = "amb@world_human_gardener_leaf_blower@idle_a"
		Blower_anim = "idle_a"
	
		LawnMow_animCore = "timetable@gardener@lawnmow@"
		LawnMow_anim = "idle_b"
		
		Cut_animCore = "amb@code_human_in_car_mp_actions@dance@bodhi@ds@base"
		Cut_anim = "exit_fp"
		
		
		HedgeCut_animCore = "weapons@machinegun@"
		HedgeCut_anim = "fire_med"		

	---------------------------------------------------------------------------	
	--				Hash names
	---------------------------------------------------------------------------		
	GardenerHash = GAMEPLAY.GET_HASH_KEY("S_M_M_GARDENER_01")
	CarHash = GAMEPLAY.GET_HASH_KEY("bison3")
	BossHash = GAMEPLAY.GET_HASH_KEY("S_M_M_GARDENER_01")
	PlantHash = GAMEPLAY.GET_HASH_KEY("prop_plant_int_02a")	
	Plant2Hash = GAMEPLAY.GET_HASH_KEY("prop_plant_int_02a")
	BlowerHash = GAMEPLAY.GET_HASH_KEY("prop_leaf_blower_01")
	LeafHash = GAMEPLAY.GET_HASH_KEY("prop_cs_leaf")
	TrimmerHash = GAMEPLAY.GET_HASH_KEY("prop_hedge_trimmer_01")
	LawnHash = GAMEPLAY.GET_HASH_KEY("prop_lawnmower_01")
	ObjHash = PlantHash
	
	---------------------------------------------------------------------------
	--				The Mighty Bush Location 1
	---------------------------------------------------------------------------		
	BossPositionX = -510.8
	BossPositionY = -53.05
	BossPositionZ = 42.12
	
		
	CharInitX = -517.317
	CharInitY = -66.406
	CharInitZ = 40.836
	---------------------------------------------------------------------------
	--				The Mighty Bush Location 2
	---------------------------------------------------------------------------	
	InitPosition2X = -1567.02
	InitPosition2Y = -233.88
	InitPosition2Z = 49.47

	---------------------------------------------------------------------------
	--				First Checkpoint location
	---------------------------------------------------------------------------	
	MissionLocationX = -843.43
	MissionLocationY = 386.15
	MissionLocationZ = 87.3


	---------------------------------------------------------------------------
	--				Drill location
	---------------------------------------------------------------------------	
	DrillLocationX = -1141.166
	DrillLocationY = -1406.04
	DrillLocationZ = 4.54

	---------------------------------------------------------------------------
	--				Gate location
	---------------------------------------------------------------------------	
	GateLocationX = -844.016
	GateLocationY = 158.9
	GateLocationZ = 66.79
	
	IsGateOpen = false
	---------------------------------------------------------------------------
	--				Plants Location
	---------------------------------------------------------------------------	
	PlantX = -481.5
	PlantY = -63
	PlantZ = 39
	
	
	---------------------------------------------------------------------------
	--				Max number of tree for Mission 1
	---------------------------------------------------------------------------			
	MaxPlantedTree	= 3
	IsTreePlanted = false
	IsHedgeTrimmed = false
	LeafSpawned = false
	AreaCleanOfLeaf = 0
	MaxAreaToBlow = 2
	---------------------------------------------------------------------------
	--				Max number of Hedges to trimm for Mission 2
	---------------------------------------------------------------------------			
	MaxHedgeCut	= 4
	
	end


return GardenerInit