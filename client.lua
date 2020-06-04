ESX 	= nil
local	PlayerData 	= {}
local 	minute	= 60 -- 1 Saat / Hour
local	giftCount = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function CheckPay()
	Citizen.CreateThread(function()
		while giftCount == 0 do
			Citizen.Wait(60000 * minute) 
			giftCount = 1
			--TR
			TriggerEvent('chatMessage', "", {200, 50, 200}, "Hediye saatiniz geldi '/hediyeal' yazarak ikramiyenizi alabilirsiniz.")	
			--EN
			--TriggerEvent('chatMessage', "", {200, 50, 200}, "Your gift hour has arrived and you can receive your bonus by typing '/getgift'.")	
		end
	end)
end

--TR
RegisterCommand('hediyeal', function(source, args, rawCommand)
--EN
--RegisterCommand('getgift', function(source, args, rawCommand)
	if giftCount == 1 then
		TriggerServerEvent('gift:playerGift', GetPlayerServerId(PlayerId()))
		giftCount = 0
		CheckPay()
	else
		--TR
		TriggerEvent('chatMessage', "", {255, 255, 255}, "Hediye saatiniz henüz dolmamış.")
		--EN
		--TriggerEvent('chatMessage', "", {255, 255, 255}, "Your gift hour is not yet over.")
	end
end)

CheckPay()