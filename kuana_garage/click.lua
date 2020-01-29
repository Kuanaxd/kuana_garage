

local menuEnabled = false

RegisterNetEvent("ToggleActionmenu")
AddEventHandler("ToggleActionmenu", function()
	ToggleActionMenu()
end)

function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showPlayerKey = true
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerKey = false
		})
	end
end

RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerKey = false
	})
end)

Citizen.CreateThread(function()
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerKey = false
	})
end)

function killTutorialMenu()
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerKey = false
		})
		menuEnabled = false

end


RegisterNUICallback('close', function(data, cb)
  ToggleActionMenu()
  cb('ok')
end)

RegisterNUICallback('bt1', function(data, cb)
	TriggerServerEvent("kuana:svlock")
  	cb('ok')
end)

RegisterNUICallback('bt2', function(data, cb)
	TriggerServerEvent("kuana:svunlock")
  	cb('ok')
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
