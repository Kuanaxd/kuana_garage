-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local PlayerData = {}
local CurrentAction = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local times 					= 0
local userProperties = {}
local this_Garage = {}
local bilhete = false
local placa = ""
local vehi = ""
local locktime = false
local podespawn = false
local umavez = 0
local count = 0
local lastvehicle = nil
local checkcars = {
	[1] = {value = 0, model = "", plate = "", vehicle = {}},
	[2] = {value = 0, model = "", plate = "", vehicle = {}},
	[3] = {value = 0, model = "", plate = "", vehicle = {}},
	[4] = {value = 0, model = "", plate = "", vehicle = {}},
	[5] = {value = 0, model = "", plate = "", vehicle = {}},
	[6] = {value = 0, model = "", plate = "", vehicle = {}},
	[7] = {value = 0, model = "", plate = "", vehicle = {}},
	[8] = {value = 0, model = "", plate = "", vehicle = {}},
	[9] = {value = 0, model = "", plate = "", vehicle = {}},
	[10] = {value = 0, model = "", plate = "", vehicle = {}},
	[11] = {value = 0, model = "", plate = "", vehicle = {}},
	[12] = {value = 0, model = "", plate = "", vehicle = {}},
	[13] = {value = 0, model = "", plate = "", vehicle = {}},
	[14] = {value = 0, model = "", plate = "", vehicle = {}},
	[15] = {value = 0, model = "", plate = "", vehicle = {}},
	[16] = {value = 0, model = "", plate = "", vehicle = {}},
	[17] = {value = 0, model = "", plate = "", vehicle = {}},
	[18] = {value = 0, model = "", plate = "", vehicle = {}},
	[19] = {value = 0, model = "", plate = "", vehicle = {}},
	[20] = {value = 0, model = "", plate = "", vehicle = {}},
	[21] = {value = 0, model = "", plate = "", vehicle = {}},
	[22] = {value = 0, model = "", plate = "", vehicle = {}},
	[23] = {value = 0, model = "", plate = "", vehicle = {}},
	[24] = {value = 0, model = "", plate = "", vehicle = {}},
	[25] = {value = 0, model = "", plate = "", vehicle = {}},
	[26] = {value = 0, model = "", plate = "", vehicle = {}},
	[27] = {value = 0, model = "", plate = "", vehicle = {}},
	[28] = {value = 0, model = "", plate = "", vehicle = {}},
	[29] = {value = 0, model = "", plate = "", vehicle = {}},
	[30] = {value = 0, model = "", plate = "", vehicle = {}},
	[31] = {value = 0, model = "", plate = "", vehicle = {}},
	[32] = {value = 0, model = "", plate = "", vehicle = {}},
	[33] = {value = 0, model = "", plate = "", vehicle = {}},
	[34] = {value = 0, model = "", plate = "", vehicle = {}},
	[35] = {value = 0, model = "", plate = "", vehicle = {}},
	[36] = {value = 0, model = "", plate = "", vehicle = {}},
	[37] = {value = 0, model = "", plate = "", vehicle = {}},
	[38] = {value = 0, model = "", plate = "", vehicle = {}},
	[39] = {value = 0, model = "", plate = "", vehicle = {}},
	[40] = {value = 0, model = "", plate = "", vehicle = {}},
	[41] = {value = 0, model = "", plate = "", vehicle = {}},
	[42] = {value = 0, model = "", plate = "", vehicle = {}},
	[43] = {value = 0, model = "", plate = "", vehicle = {}},
	[44] = {value = 0, model = "", plate = "", vehicle = {}},
	[45] = {value = 0, model = "", plate = "", vehicle = {}},
	[46] = {value = 0, model = "", plate = "", vehicle = {}},
	[47] = {value = 0, model = "", plate = "", vehicle = {}},
	[48] = {value = 0, model = "", plate = "", vehicle = {}},
	[49] = {value = 0, model = "", plate = "", vehicle = {}},
	[50] = {value = 0, model = "", plate = "", vehicle = {}},
}

-- End Local
-- Initialise ESX

ESX = nil

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

-- End ESX Initialisation
--- Generate map blips



-- Private Blips

local function has_value (tab, val)
	for index, value in ipairs(tab) do
			if value == val then
					return true
			end
	end

	return false
end


-- End Private Blips
-- End map blip generation
-- Main menu

function OpenMenuGarage(PointType)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	if PointType == 'spawn' then
		table.insert(elements,{label = _U('list_vehicles'), value = 'list_vehicles'})
	end

	if PointType == 'comando' then
		table.insert(elements,{label = _U('list_vehicles'), value = 'list_vehicles1'})
	end

	if PointType == 'delete' then
		table.insert(elements,{label = _U('stock_vehicle'), value = 'stock_vehicle'})
	end

	if PointType == 'pound' then
		table.insert(elements,{label = "Veiculos Apreendidos", value = 'return_vehicle'})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'list_vehicles') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'list_vehicles1') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'stock_vehicle') then
				if bilhete == true then	
					StockVehicleMenu()
				else
					TriggerEvent('esx:showNotification', 'Tem de obter o Bilhete de Parque')
				end
			end
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu()
			end


		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end
	
-- Vehicle list

function ListVehiclesMenu()
	local elements = {}

	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			local plate = v.plate

    		if(v.state)then
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('garage')
    		else
    		labelvehicle = vehicleName.. ' (' .. plate .. ') Out of Garage'
    		end	
			table.insert(elements, {label =labelvehicle , value = v})
			
		end

	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
	end)
end

-- End vehicle list

function reparation(prix,vehicle,vehicleProps, health)
	
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ("..prix.."$)", value = 'yes'},
	}
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'delete_menu',
		{
			title    = _U('damaged_vehicle'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'yes') then
				ESX.TriggerServerCallback('kuana:payhealth', function(check)
					if check then
						SetVehicleEngineHealth(vehicle, 1000)
						TriggerServerEvent('garagem:fixcar', vehiclePropsn.plate, 1000)
						ESX.ShowNotification("You fixed your vehicle with ~g~success~w~.")
					else
						TriggerEvent('esx:showNotification', "You ~r~don't~w~ have enough ~g~money~w~")
					end
				end, prix)
			end
		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end
RegisterNetEvent('kuana:ranger')
AddEventHandler('kuana:ranger', function(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('kuana:modifystate', vehicleProps.plate, true)
	TriggerEvent('esx:showNotification', "O teu ~g~veiculo~w~ esta na tua garagem")
end)

-- Store vehicle

-- End story vehicle
--End main menu
--Vehicle spawn

RegisterNetEvent('kuana:checkcoordss')
AddEventHandler('kuana:checkcoordss', function(xx, yy, zz, hh, vidaa)
		local cods = {x = xx + 0, y = yy + 0, z= zz + 1}
		local hh    = hh + 0.0000000001
		local vidaa = vidaa + 0.0
		ESX.Game.SpawnVehicle(vehi.model, cods,hh, function(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehi)
			ESX.TriggerServerCallback('kuana:checklock', function(islock)
				if islock == true then
					SetVehicleDoorsLocked(callback_vehicle, 2)
				elseif islock == false then
					SetVehicleDoorsLocked(callback_vehicle, 1)
				end
			end, placa)
			SetVehRadioStation(callback_vehicle, "OFF")
			SetVehicleEngineHealth(callback_vehicle, vidaa)
		end)	
		ESX.ShowNotification("Your car is in the ~b~last location~w~ you parked or was ~b~seized~w~.")	
	TriggerServerEvent('kuana:modifystate', placa, false)
	
end)

--End vehicle spawn
--Spawn impounded vehicle

--End spawn impounded vehicle
--Marker action notifications




--End marker action notifications

function ReturnVehicleMenu()

	ESX.TriggerServerCallback('kuana:getOutVehicles', function(vehicles)

		local elements = {}

		for _,v in pairs(vehicles) do

			local hashVehicule = v.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate

    		labelvehicle = vehicleName..': ' ..plate
    	
			table.insert(elements, {label =labelvehicle, value = v})
			
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = "Veiculos apreendidos",
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			placa = data.current.value.plate
			TriggerServerEvent('kuana:modifystate', placa, true)
			TriggerEvent('esx:showNotification', "Car ~g~delivered~w~ to the ~b~owner~w~.")
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
		)	
	end)
end

-- Marker display

-- End marker display
-- Activate menu when in

-- End Activate menu when in
-- Controls/Keybinds

-- End Controls/Keybinds
--RegisterCommand('garage', function(source, args, rawCommand)
	--OpenMenuGarage('comando')
--end)
--RegisterCommand('mycars', function(source, args, rawCommand)
	--OpenMenuGarage('comando')
--end)

--RegisterCommand('spawnall', function(source, args, rawCommand)
	--if umavez == 0 then
		--ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			--for _,v in pairs(vehicles) do
				--Citizen.Wait(1000)
				--ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
					--local cods = {x = xx + 0, y = yy + 0, z= zz + 0}
					--local hh    = hh + 0.0000000001
					--local vidaa = vidaa + 0.0
					--ESX.Game.SpawnVehicle(v.vehicle.model, cods,hh, function(callback_vehicle)
						--ESX.Game.SetVehicleProperties(callback_vehicle, v.vehicle)
						--ESX.TriggerServerCallback('kuana:checklock', function(islock)
							--if islock == true then
								--SetVehicleDoorsLocked(callback_vehicle, 2)
							--elseif islock == false then
								--SetVehicleDoorsLocked(callback_vehicle, 1)
							--end
						--end, v.plate)
						--SetVehRadioStation(callback_vehicle, "OFF")
						--SetVehicleEngineHealth(callback_vehicle, vidaa)
						--count = count + 1
					 --checkcars[count].value = callback_vehicle
					 --checkcars[count].model = v.vehicle.model
					 --checkcars[count].plate = v.plate
					 --checkcars[count].vehicle = v.vehicle
					--end)
					--TriggerServerEvent('kuana:modifystate', v.plate, false)
				--end, v.plate)
			--end
		--end)
		--umavez = 1
	--end
--end)

--RegisterCommand('seizedcars', function(source, args, rawCommand)
--	if PlayerData.job.name == "police" then
--		OpenMenuGarage('pound')
--	else
--		ESX.ShowNotification("You need to be a ~b~cop~w~ to do that.")
--	end
--end)

--RegisterCommand('park', function(source, args, rawCommand)
--	ped = GetPlayerPed(-1)
--	local vehicle = 0
--	if IsPedInAnyVehicle(ped) then
--		vehicle = GetVehiclePedIsUsing(ped)
--		local model = GetEntityModel(vehicle)
--		local x,y,z = table.unpack(GetEntityCoords(vehicle))
--		local headings = GetEntityHeading(vehicle)
--		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
--		local engineHealth  = GetVehicleEngineHealth(vehicle)
--		ESX.ShowNotification("You saved your vehicle with ~g~success~w~.")
--		TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
--	else
--		ESX.ShowNotification("You need to be inside of your vehicle.")
--	end
--end)

RegisterCommand('estacionar', function(source, args, rawCommand)
    ped = GetPlayerPed(-1)
    local vehicle = 0
    if IsPedInAnyVehicle(ped) then
        vehicle = GetVehiclePedIsUsing(ped)
        local model = GetEntityModel(vehicle)
        local x,y,z = table.unpack(GetEntityCoords(vehicle))
        local headings = GetEntityHeading(vehicle)
        local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
        local engineHealth  = GetVehicleEngineHealth(vehicle)
        ESX.ShowNotification("You saved your vehicle with ~g~success~w~.")
        TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
        Citizen.SetTimeout(600000, function()
            ESX.Game.DeleteVehicle(vehicle)
        end)
    else
        ESX.ShowNotification("You need to be inside of your vehicle.")
    end
end)

--RegisterCommand('fixcar', function(source, args, rawCommand)
	--local ped = GetPlayerPed(-1)
	--if IsPedInAnyVehicle(ped) then
		--local playerVeh = GetVehiclePedIsIn(ped, false)
		--local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
		--ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			--for _,v in pairs(vehicles) do
				--if vehiclePropsn.plate == v.plate then
					--local engineHealth  = GetVehicleEngineHealth(playerVeh)
					--local fraisRep= math.floor((1000 - engineHealth)*10)	
					--if engineHealth < 1000 then
						--reparation(fraisRep,playerVeh,vehiclePropsn, engineHealth)
					--else
						--ESX.ShowNotification("You fixed your vehicle with ~g~success~w~.")
						--TriggerServerEvent('garagem:fixcar', vehiclePropsn.plate, 1000)
						--SetVehicleEngineHealth(playerVeh, 1000)
					--end
				--end
			--end
		--end)
	--else
		--ESX.ShowNotification("You ~g~need~w~ inside a vehicle.")
	--end
--end)


RegisterCommand('apre', function(source, args, rawCommand)
	ped = GetPlayerPed(-1)
	local vehicle = 0
	if PlayerData.job.name == "police" then
		if IsPedInAnyVehicle(ped) then
			vehicle = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(vehicle)
			local x,y,z = table.unpack(GetEntityCoords(vehicle))
			local headings = GetEntityHeading(vehicle)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local engineHealth  = GetVehicleEngineHealth(vehicle)
			ESX.ShowNotification("Veiculo apreendido com ~g~sucesso~w~.")
			TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
			ESX.Game.DeleteVehicle(vehicle)
		else
			ESX.ShowNotification("You need to be inside of a vehicle to seize it.")
		end
	else
		ESX.ShowNotification("You need to be a ~b~cop~w~ to do that.")
	end
end)


RegisterCommand('sucata', function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local veh = ESX.Game.GetVehiclesInArea(pos, 20000.0)
	local elements = {}
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
		for _,v in pairs(vehicles) do
			local hashVehicule = v.vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate
			labelvehicle = vehicleName.. ' (' .. plate .. ') '
			if v.state == false then			
				table.insert(elements, {label =labelvehicle , value = v})
			end
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'spawn_vehiclereload',
			{
				title    = _U('garage'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)
					for i=1, #veh, 1 do
						if veh then
							local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
							if vehiclePropsn.plate == data.current.value.plate then
								ESX.Game.DeleteVehicle(veh[i])
								break
							end
						end
					end
				TriggerServerEvent('kuana:modifystate', data.current.value.plate, true)
				menu.close()
			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end
		)	
	end)
end)


RegisterNetEvent('kuana:checkveh')
AddEventHandler('kuana:checkveh', function(xxx, yyy, zzz)
        local xxx = xxx + 0.0
        local zzz = zzz + 0.0
		local yyy = yyy + 0.0
				blipm = AddBlipForCoord(xxx, yyy, zzz)
        			
    				SetBlipSprite (blipm, 66)
    				SetBlipDisplay(blipm, 4)
    				SetBlipScale  (blipm, 0.8)
   					SetBlipColour (blipm, 59)
    				SetBlipAsShortRange(blipm, true)
    				BeginTextCommandSetBlipName("STRING")
    				AddTextComponentString("Lost Car")
					EndTextCommandSetBlipName(blipm)
end)

RegisterCommand('procarro', function(source, args, rawCommand)
		local placa = rawCommand:sub(10)
		local elements = {
					
		}
		if PlayerData.job ~= nil and PlayerData.job.name == "police" then
			if placa ~= "" then
				ESX.TriggerServerCallback('kuana:checkcarfind', function(vehicles)
					for _,v in pairs(vehicles) do
							local hashVehicule = v.vehicle.model
							local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
							local labelvehicle
							carname = ""..v.target..""
							local plate = v.plate

						
						table.insert(elements, {label ="Ver Dono" , value = "carowner"})
						table.insert(elements, {label ="Modelo: "..vehicleName , value = vehicleName})
						table.insert(elements, {label ="Placa: "..placa , value = "placa"})
						if v.lock == "nao" then
							table.insert(elements, {label ="Portas: Destrancadas" , value = "unlock"})
						elseif v.lock == "sim" then
							table.insert(elements, {label ="Portas: Trancadas" , value = "lock"})
						end
						if not blipmapa then
							table.insert(elements, {label ="Colocar no GPS" , value = "gps"})
						else
							table.insert(elements, {label ="Remover do GPS" , value = "gps2"})
						end
					end
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'findcar',
						{
							title    = "",
							align    = 'top-left',
							elements = elements,
						},
						function(data, menu)
				
							
							if data.current.value == 'gps' then
								blipmapa = true
								RemoveBlip(blipm)
								TriggerServerEvent('kuana:checkvehi', placa)
								menu.close()
							elseif data.current.value == 'gps2' then
								blipmapa = false
								RemoveBlip(blipm)
								menu.close()
							elseif data.current.value == 'carowner' then
								local elements3 = {

								}
								ESX.TriggerServerCallback('kuana:checkcarowner', function(owner)
									for _,v in pairs(owner) do
										table.insert(elements3, {label ="Nome: "..v.names , value = "name"})
										if v.sex == "M" then
											table.insert(elements3, {label ="Sexo: Homem" , value = "sex"})
										else
											table.insert(elements3, {label ="Sexo: Mulher" , value = "sex"})
										end
										table.insert(elements3, {label ="Altura: "..v.height.." cm" , value = "height"})
										table.insert(elements3, {label ="Voltar" , value = "back"})
									end

									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'findcarowner',
										{
											title    = "",
											align    = 'top-left',
											elements = elements3,
										},
										function(data2, menu2)
											if data2.current.value == "back" then
												menu2.close()
											end
										end,
										function(data2, menu2)
											menu2.close()											
										end
									)									
								end, carname)
							end
						end,
						function(data, menu)
							menu.close()
							
						end
					)
				end, placa)	
			else
				ESX.ShowNotification("~r~Comando errado~w~: /procarro [placa] ")
			end
		else
			ESX.ShowNotification("Precisas de ser da ~b~Policia~w~ para fazer isso.")
		end
end)
--[[
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('kuana:updateall')
	Citizen.Wait(30000)
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local veh = ESX.Game.GetVehiclesInArea(pos, 20000.0)
	local elements = {}
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
		for _,v in pairs(vehicles) do
			local hashVehicule = v.vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate	
			for i=1, #veh, 1 do
				if veh then
					local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
					if vehiclePropsn.plate == v.plate then
						podespawn = false
						break
					else
						podespawn = true
					end
				else
					podespawn = true
				end
			end
			if podespawn == true then
				ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
					local cods = {x = xx + 0, y = yy + 0, z= zz + 1}
					local hh    = hh + 0.0000000001
					local x = xx + 0
					local y = yy + 0
					local z = zz + 1
					local vidaa = vidaa + 0.0
					ESX.Game.SpawnVehicle(v.vehicle.model, cods,hh, function(callback_vehicle)
						SetVehicleProperties(callback_vehicle, v.vehicle)
						ESX.TriggerServerCallback('kuana:checklock', function(islock)
							if islock == true then
								SetVehicleDoorsLocked(callback_vehicle, 2)
							elseif islock == false then
								SetVehicleDoorsLocked(callback_vehicle, 1)
							end
						end, v.plate)
						SetVehRadioStation(callback_vehicle, "OFF")
						SetVehicleEngineHealth(callback_vehicle, vidaa)
					end)
					TriggerServerEvent('kuana:modifystate', v.plate, false)
				end, v.plate)
			end
		end
	end)
end)--]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('givecarkeys', function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = nil
	end
	
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local platec = vehicleProps.plate
	

	local elements2 = {}

			ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

				for _,v in pairs(vehicles) do

					local hashVehicule = v.vehicle.model
						local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
						local platep = v.plate
						local labelvehicle = ""..vehicleName.." | Plate: " ..platep
						if platep == platec then
							table.insert(elements2, {label =labelvehicle , value = v})
						end
				end
				Citizen.Wait(1000)

			
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'sell_vehicle',
				{
					title    = "Sell Vehicles",
					align    = 'top-left',
					elements = elements2,
				},
				function(data, menu)
						menu.close()
						if IsPedInAnyVehicle(playerPed,  false) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification('No players nearby!')
							else
							ESX.ShowNotification('You are giving your car keys for vehicle with plate ~g~'..vehicleProps.plate..'!')
							TriggerServerEvent('kuana:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
							end
						else
							menu.close()
						end
				end,
				function(data, menu)
					menu.close()
					--CurrentAction = 'open_garage_action'
				end
			)	
			end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(1, 303) then
			local ped = GetPlayerPed(-1)
			local coords    = GetEntityCoords(ped)
			playerLastVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(playerLastVeh), 1)
			if IsPedInAnyVehicle(ped) then
				local playerVeh = GetVehiclePedIsIn(ped, false)
				local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
				ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
					for _,v in pairs(vehicles) do
						if vehiclePropsn.plate == v.plate then
							ESX.TriggerServerCallback('kuana:checklock', function(islock)
								if islock == false then
									SetVehicleDoorsLocked(playerVeh, 2)
									ESX.ShowNotification("O veiculo esta ~r~trancado~w~.")
									TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "lock", 1.0)
									TriggerServerEvent("garagem:lockvehi", vehiclePropsn.plate)
								elseif islock == true then
									SetVehicleDoorsLocked(playerVeh, 1)
									ESX.ShowNotification("O veiculo esta ~g~destrancado~w~.")
									TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "unlock", 1.0)
									TriggerServerEvent("garagem:lockvehia", vehiclePropsn.plate)
								end
							end, vehiclePropsn.plate)
						end
					end
				end)
			elseif distanceToVeh <= 10 then
				local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerLastVeh)
				ESX.TriggerServerCallback('kuana:checktrancado', function(fechara)
					if fechara == true then
						destrancar()
					elseif fechara == false then
						trancar()
					end
				end, vehiclePropsn.plate)
			end
			Citizen.Wait(1000)
		end
	end
end)



RegisterCommand('garagem', function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local veh = ESX.Game.GetVehiclesInArea(pos, 20000.0)
	local elements = {}
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
		for _,v in pairs(vehicles) do
			local hashVehicule = v.vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate
			labelvehicle = vehicleName.. ' (' .. plate .. ') '	
			if v.state == false then		
				table.insert(elements, {label =labelvehicle , value = v})
			end
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'spawn_vehiclereload',
			{
				title    = _U('garage'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)
					for i=1, #veh, 1 do
						if veh then
							local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
							if vehiclePropsn.plate == data.current.value.plate then
								podespawn = false
								break
							else
								podespawn = true
							end
						else
							podespawn = true
						end
					end

					if podespawn == true then
						ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
							local cods = {x = xx + 0, y = yy + 0, z= zz + 1}
							local hh    = hh + 0.0000000001
							local x = xx + 0
							local y = yy + 0
							local z = zz + 1
							local vidaa = vidaa + 0.0
							local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), x, y, z, 1)
							if distanceToVeh <= 20000 then
								ESX.Game.SpawnVehicle(data.current.value.vehicle.model, cods,hh, function(callback_vehicle)
									SetVehicleProperties(callback_vehicle, data.current.value.vehicle)
									ESX.TriggerServerCallback('kuana:checklock', function(islock)
										if islock == true then
											SetVehicleDoorsLocked(callback_vehicle, 2)
										elseif islock == false then
											SetVehicleDoorsLocked(callback_vehicle, 1)
										end
									end, data.current.value.plate)
									SetVehRadioStation(callback_vehicle, "OFF")
									SetVehicleEngineHealth(callback_vehicle, vidaa)
								end)
								TriggerServerEvent('kuana:modifystate', data.current.value.plate, false)
								ESX.ShowNotification("O teu carro deu ~g~spawn~w~.")
							else
								ESX.ShowNotification("~r~Longe~w~ do carro.")
							end
						end, data.current.value.plate)
						menu.close()
				else
					ESX.ShowNotification("Tu ja deste ~g~spawn~w~ do teu carro.")
				end
			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end
		)	
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(ped) then
			lastvehicle = GetVehiclePedIsUsing(ped)
		else
			if lastvehicle ~= nil then
				local model = GetEntityModel(lastvehicle)
				local x,y,z = table.unpack(GetEntityCoords(lastvehicle))
				local headings = GetEntityHeading(lastvehicle)
				local vehicleProps = GetVehicleProperties(lastvehicle)
				local engineHealth  = GetVehicleEngineHealth(lastvehicle)
				TriggerServerEvent('garagem:apre', vehicleProps, x, y, z, headings, engineHealth)
				lastvehicle = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(ped, true))
		local distancia = GetDistanceBetweenCoords(x, y, z, -353.46, -116.15, 38.7)

		if distancia <= 10 then
			Drawing.draw3DText(-353.46, -116.15, 38.7 - 1, "[~g~Sucata~w~] ~n~ Clica ~g~E~w~ para ver os seus carros", 4, 0.2, 0.1, 255, 255, 255, 255)
			DrawMarker(27, -353.46, -116.15, 38.7 - 0.8, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			if distancia <= 2 and (IsControlJustReleased(1, 51)) then
				ESX.TriggerServerCallback('kuana:checkmoneysucata', function(check)
					if check == true then
						local pos = GetEntityCoords(ped)
						local veh = ESX.Game.GetVehiclesInArea(pos, 20000.0)
						local elements = {}
						ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
							for _,v in pairs(vehicles) do
								local hashVehicule = v.vehicle.model
								local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
								local labelvehicle
								local plate = v.plate
								labelvehicle = vehicleName.. ' (' .. plate .. ') '	
								if v.state == true then		
									table.insert(elements, {label =labelvehicle , value = v})
								end
							end
							ESX.UI.Menu.Open(
								'default', GetCurrentResourceName(), 'spawn_sucata',
								{
									title    = _U('garage'),
									align    = 'top-left',
									elements = elements,
								},
								function(data, menu)
										for i=1, #veh, 1 do
											if veh then
												local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
												if vehiclePropsn.plate == data.current.value.plate then
													ESX.Game.DeleteVehicle(veh[i])
													podespawn = true
													break
												else
													podespawn = true
												end
											else
												podespawn = true
											end
										end
					
										if podespawn == true then
											ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
												local cods = {x = -359.09, y = -115.3, z= 38.7}
												local hh    = hh + 0.0000000001
												local x = xx + 0
												local y = yy + 0
												local z = zz + 1
												local vidaa = vidaa + 0.0
												local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), x, y, z, 1)
													ESX.Game.SpawnVehicle(data.current.value.vehicle.model, cods,hh, function(callback_vehicle)
														SetVehicleProperties(callback_vehicle, data.current.value.vehicle)
														ESX.TriggerServerCallback('kuana:checklock', function(islock)
															if islock == true then
																SetVehicleDoorsLocked(callback_vehicle, 2)
															elseif islock == false then
																SetVehicleDoorsLocked(callback_vehicle, 1)
															end
														end, data.current.value.plate)
														SetVehRadioStation(callback_vehicle, "OFF")
														SetVehicleEngineHealth(callback_vehicle, 500)
														SetEntityHeading(callback_vehicle, 162.82)
													end)
													TriggerServerEvent('kuana:modifystate', data.current.value.plate, false)
													TriggerServerEvent('garagem:aprea', data.current.value.plate, -359.09, -115.3, 38.7, 162.82, 500)
													TriggerServerEvent('kuana:sucatamoney')
													ESX.ShowNotification("O teu carro deu ~g~spawn~w~.")
											end, data.current.value.plate)
											menu.close()
									else
										ESX.ShowNotification("Tu ja deste ~g~spawn~w~ do teu carro.")
									end
								end,
								function(data, menu)
									menu.close()
									--CurrentAction = 'open_garage_action'
								end
							)	
						end)
					else
						ESX.ShowNotification("Tu ~r~nao~w~ tens dinheiro suficiente.")
					end
				end)
			end
		end
	end
end)

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*14
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+1, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function trancar()
	local podekeys = false
	local ped = GetPlayerPed(-1)
	local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerLastVeh)
	--ANIMATION------------------------------
	RequestModel(GetHashKey("p_car_keys_01"))
	while not HasModelLoaded(GetHashKey("p_car_keys_01")) do
			Citizen.Wait(100)
	end
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do
			if v.plate == vehiclePropsn.plate then
				podekeys = true
			end
		end
		if podekeys then
			local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
			local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
			local netid = ObjToNet(micspawned)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(micspawned, ped, GetPedBoneIndex(ped, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
			ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()
				TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				SetVehicleDoorShut(playerLastVeh, 0, false)
				SetVehicleDoorShut(playerLastVeh, 1, false)
				SetVehicleDoorShut(playerLastVeh, 2, false)
				SetVehicleDoorShut(playerLastVeh, 3, false)
				SetVehicleDoorsLocked(playerLastVeh, 2)
				TriggerServerEvent("kofkof:addnotifyserver","info", "O veiculo esta <b><span style='color: red;'>trancado</span>.", 5000)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "lock", 1.0)
				SetVehicleLights(playerLastVeh, 2)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 0)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 2)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 0)
				TriggerServerEvent("garagem:lockvehi", vehiclePropsn.plate)
				Citizen.Wait(3000)
			end)
			ClearPedSecondaryTask(ped)
			DetachEntity(NetToObj(netid), 1, 1)
			DeleteEntity(NetToObj(netid))
		end
	end)
	------------------------------------------
end

function destrancar()
	local podekeys = false
	local ped = GetPlayerPed(-1)
	local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerLastVeh)
	--ANIMATION------------------------------
	RequestModel(GetHashKey("p_car_keys_01"))
	while not HasModelLoaded(GetHashKey("p_car_keys_01")) do
			Citizen.Wait(100)
	end
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do
			if v.plate == vehiclePropsn.plate then
				podekeys = true
			end
		end
		if podekeys then
			local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
			local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
			local netid = ObjToNet(micspawned)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(micspawned, ped, GetPedBoneIndex(ped, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
			ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()
				TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				Citizen.Wait(1000)
				SetVehicleDoorsLocked(playerLastVeh, 1)
				TriggerServerEvent("kofkof:addnotifyserver","info", "O veiculo esta <b><span style='color: green;'>destrancado</span>.", 5000)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "unlock", 1.0)
				SetVehicleLights(playerLastVeh, 2)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 0)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 2)
				Citizen.Wait(400)
				SetVehicleLights(playerLastVeh, 0)
				TriggerServerEvent("garagem:lockvehia", vehiclePropsn.plate)
				Citizen.Wait(3000)
			end)
			ClearPedSecondaryTask(ped)
			DetachEntity(NetToObj(netid), 1, 1)
			DeleteEntity(NetToObj(netid))
		end
	end)
	------------------------------------------
end




---------------------------------------------------------------------------------------------------------
GetVehicleProperties = function(vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)

        return vehicleProps
end

HandleCamera = function(garage, toggle)
    local Camerapos = Config.Garages[garage]["camera"]

    if not Camerapos then return end

	if not toggle then
		if cachedData["cam"] then
			DestroyCam(cachedData["cam"])
		end

		RenderScriptCams(0, 1, 750, 1, 0)

		return
	end

	if cachedData["cam"] then
		DestroyCam(cachedData["cam"])
	end

	cachedData["cam"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

	SetCamCoord(cachedData["cam"], Camerapos["x"], Camerapos["y"], Camerapos["z"])
	SetCamRot(cachedData["cam"], Camerapos["rotationX"], Camerapos["rotationY"], Camerapos["rotationZ"])
	SetCamActive(cachedData["cam"], true)

	RenderScriptCams(1, 1, 750, 1, 1)

	Citizen.Wait(500)
end



SetVehicleProperties = function(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    SetVehicleEngineHealth(vehicle, vehicleProps["engineHealth"] or 1000.0 + 0.0)
    SetVehicleBodyHealth(vehicle, vehicleProps["bodyHealth"] or 1000.0 + 0.0)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------

