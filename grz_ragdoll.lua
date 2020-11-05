-- MADE BY GRZ
ESX              = nil
local PlayerData = {}
Player = {
    Ragdoll = false
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('+ragdoll', function()
	Player.ragdoll = not Player.ragdoll
end, false)
RegisterKeyMapping('+ragdoll', 'S\'endormir / se réveiller', 'keyboard', 'j')
--RegisterKeyMapping('+ragdoll', 'Sleep / wake UP', 'keyboard', 'j') ENGLISH VERSION

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyPed = PlayerPedId()
        local entityAlpha = GetEntityAlpha(GetPlayerPed(-1))
        if entityAlpha < 100 then
            Citizen.Wait(0)
        else
            if Player.ragdoll and IsControlJustReleased(1, 22) or Player.ragdoll and IsControlJustReleased(1, 51) then
                Player.ragdoll = not Player.ragdoll
            end
            if Player.ragdoll then
                SetPedRagdollForceFall(plyPed)
                ResetPedRagdollTimer(PlayerPedId())
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
                ResetPedRagdollTimer(PlayerPedId())
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ou ~INPUT_JUMP~ pour ~b~vous relever~w~.")
                --ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ or ~INPUT_JUMP~ to ~b~stand UP~w~.") ENGLISH VERSION
            end
        end    
    end
end)