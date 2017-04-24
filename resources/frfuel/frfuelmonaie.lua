fuel = 1.19 -- Fuel Cost, this could be made to randomise between 1.05 and 1.30 or something like that

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent('frfuel:fuelAdded')
AddEventHandler('frfuel:fuelAdded', function(amount)

    for k,v in ipairs(GetPlayers())do
        TriggerEvent("es:getPlayerFromId", k, function(user)
            if(tonumber(user.money) ~= 0)then

                local wallet = user.money

                local cost = fuel * amount

                TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Le prix de l'essence est de $" .. fuel)

                local new_wallet = wallet - round(cost)

                TriggerEvent("es:setPlayerData", source, "money", new_wallet, function(response, success)
                    TriggerClientEvent('es:activateMoney', source, new_wallet)

                    if(success)then
                        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You filled up with " .. round(amount) .. " litres of fuel")
                        TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Filling up today cost you $" .. round(cost))
                    end
                end)
            else

                TriggerClientEvent('chatMessage', -1, "911", {255, 0, 0}, GetPlayerName(source) .." has made off without paying for fuel and is now wanted")
                SetPlayerWantedLevel(source,  1,  false)

            end
        end)
    end

end)