uSettings = {}

-- Change this to the salary you want civilians to have.
uSettings.baseSalary = 800

-- At what interval do you want to give salaries, (minutes and type -1 for no salary.)
uSettings.salaryInterval = 2

-- How much money do you want people to start with
uSettings.startingMoney = 5000

-- Do you want pvp enabled
uSettings.pvpEnabled = true

-- Do you want people to lose their job if they die
uSettings.loseJobOnDeath = false

-- Want the chop shops enabled (selling random vehicles)
uSettings.enableChopshops = true

-- Spawn areas, to change a spawn area do: "/changearea AREAKEY"
uSettings.spawnAreas = {
	["sandyshores"] = {
		["name"] = "Sandy Shores",
		["spawns"] = {
			{["x"] = -1037.74060058594, ["y"] = -2737.81567382813, ["z"] = 20.1692905426025}
		}
	}
}

-- Default spawn area
uSettings.defaultArea = uSettings.spawnAreas.sandyshores

