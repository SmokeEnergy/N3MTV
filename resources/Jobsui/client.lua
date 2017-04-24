---------------------------------- VAR ----------------------------------

local changeYourJob = {
  {title="Work'in Santos", colour=3, id=408, x=-266.94, y=-960.744, z=31.2231},
}

local jobs = {
  {name="Citoyen", id=1},
  {name="Eboueur", id=2},
  {name="Fermier", id=3},
  {name="Bucheron", id=4},
  {name="Mineur", id=5},
  {name="Electricien", id=6},
}

---------------------------------- FUNCTIONS ----------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

AddEventHandler('showNotify', function(notify)
  ShowAboveRadarMessage(notify)
end)

function IsNearJobs()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(changeYourJob) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 10) then
      return true
    end
  end
end

function menuJobs()
  MenuTitle = "Pole Emploi"
  ClearMenu()
  for _, item in pairs(jobs) do
    local nameJob = item.name
    local idJob = item.id
    Menu.addButton(nameJob,"changeJob",idJob)
  end
end

function changeJob(id)
  TriggerServerEvent("jobssystem:jobs", id)
end

-- RegisterNetEvent('jobssystem:updateJob')
-- AddEventHandler('jobssystem:updateJob', function(job)
	-- local nameJob = nameJob(id)
	-- SendNUIMessage({
		-- updateJob = true,
		-- job = nameJob
	-- })
-- end)

RegisterNetEvent('jobssystem:updateJob')
AddEventHandler('jobssystem:updateJob', function(nameJob)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		updateJob = true,
		job = nameJob,
        player = playerName
	})
end)
---------------------------------- CITIZEN ----------------------------------

Citizen.CreateThread(function()

    for _, info in pairs(changeYourJob) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (IsNearJobs() == true) then
      drawTxt('Appuyer sur ~g~H~s~ pour accéder au menu des métiers',0,1,0.5,0.8,0.6,255,255,255,255)
    if (IsControlJustPressed(1,Keys["H"]) and IsNearJobs() == true) then
      menuJobs()
      Menu.hidden = not Menu.hidden 
    end
  end
    Menu.renderGUI()
  end
end)