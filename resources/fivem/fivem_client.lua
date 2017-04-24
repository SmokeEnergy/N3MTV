AddEventHandler('onClientMapStart', function()
	Citizen.Trace("ocms fivem\n")

	--exports.spawnmanager:setAutoSpawn(true)
	--exports.spawnmanager:forceRespawn() -- Force 

	-- The above are the default settings. This turns on autorespawn and will force
	-- A respawn to make you initially spawn once joining.



	-- For RPDeath we will set autoSpawn to false as we want the RPDeath mod
	-- To handle all deaths and respawning. We also need to initially spawn the player
    exports.spawnmanager:setAutoSpawn(false) -- Turns off autospawn.
    exports.spawnmanager:spawnPlayer()       -- Spawn the player like normal

    
    SetClockTime(24, 0, 0)
    PauseClock(true)
    Citizen.Trace("ocms fivem end\n")
end)