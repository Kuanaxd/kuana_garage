RegisterServerEvent('kuana:debug')
RegisterServerEvent('kuana:modifystate')
RegisterServerEvent('kuana:pay')
RegisterServerEvent('kuana:payhealth')
RegisterServerEvent('kuana:logging')
RegisterServerEvent('kuana:checkbilhete')
RegisterServerEvent('kuana:checkCoords')
RegisterServerEvent('kuana:checkvehi')

ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Vehicle fetch

ESX.RegisterServerCallback('kuana:getVehicles', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, plate = v.plate})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('kuana:checkmoneysucata', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local preco = 2000

	if xPlayer.getMoney() >= preco then
		cb(true)
	else
		cb(false)
	end
end)


RegisterServerEvent('kuana:setVehicleOwnedPlayerId')
AddEventHandler('kuana:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'You have got a new car with plate ~g~' ..vehicleProps.plate..'!', vehicleProps.plate)

	end) 
end)

RegisterServerEvent('kuana:sucatamoney')
AddEventHandler('kuana:sucatamoney', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local preco = 2000
	
	xPlayer.removeMoney(preco)
end)


ESX.RegisterServerCallback('kuana:checkgroup', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}
	local result = MySQL.Sync.fetchAll(
	  'SELECT * FROM users WHERE identifier = @identifier',
	  {
		['@identifier'] = xPlayer.getIdentifier()
	  }
	)
	for i=1, #result, 1 do
		if result[i].group == 'superadmin' then
			cb(true)
		else
			cb(false)
		end
	end
end)

-- End vehicle fetch
-- Store & update vehicle properties

ESX.RegisterServerCallback('kuana:stockv',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate
	print(plate)
	
		for _,v in pairs(vehicules) do
			if(plate == plate)then
				local vehprop = json.encode(vehicleProps)
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = plate})
				isFound = true
				break
			end		
		end
	cb(isFound)
end)

-- End vehicle store
-- Change state of vehicle

AddEventHandler('kuana:modifystate', function(plate, state)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local state = state
	print('UPDATING STATE')
	print(plate)
	for _,v in pairs(vehicules) do
		MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
		break		
	end
end)

-- End state update
-- Get user properties

ESX.RegisterServerCallback('kuana:getOwnedProperties',function(source, cb)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local properties = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_properties WHERE owner=@identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data)
		for _,v in pairs(data) do
			table.insert(properties, v.name)
		end
		cb(properties)
	end)
end)

-- End user properties
-- Function to recover plates deprecated and removed.
-- Get list of vehicles already out

ESX.RegisterServerCallback('kuana:getOutVehicles',function(source, cb)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE state=@state",{['@state'] = false}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, vehicle)
		end
		cb(vehicules)
	end)
end)

-- End out list
-- Check player has funds

ESX.RegisterServerCallback('kuana:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)
-- End funds check
-- Withdraw money

AddEventHandler('kuana:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:showNotification', source, _U('you_paid')..' ' .. Config.Price)

end)

AddEventHandler('kuana:plate', function()

	

end)

-- End money withdraw
-- Find player vehicles

function getPlayerVehicles(identifier)
	
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = v.plate})
	end
	return vehicles
end

-- End fetch vehicles
-- Debug [not sure how to use this tbh]

AddEventHandler('kuana:debug', function(var)
	print(to_string(var))
end)

function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end

-- End debug
-- Return all vehicles to garage (state update) on server restart
-- End vehicle return
-- Pay vehicle repair cost
ESX.RegisterServerCallback('kuana:payhealth',function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

-- End repair cost
-- Log to the console

AddEventHandler('kuana:logging', function(logging)
	RconPrint(logging)
end)

-- End console log
AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'bilhete' then
		TriggerClientEvent('kuana:addbilhete', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'bilhete' and item.count < 1 then
		TriggerClientEvent('kuana:removebilhete', source)
	end
end)

AddEventHandler('kuana:checkbilhete', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem("bilhete", 1)

end)


RegisterServerEvent('garagem:save')
AddEventHandler('garagem:save', function(plate, x, y, z, headings, heal)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local state = true
	local h = headings
	local he = heal
	for _,v in pairs(vehicules) do
			--MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET x =@x WHERE plate=@plate",{['@x'] = x , ['@plate'] = plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET y =@y WHERE plate=@plate",{['@y'] = y , ['@plate'] = plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET z =@z WHERE plate=@plate",{['@z'] = z , ['@plate'] = plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET h =@h WHERE plate=@plate",{['@h'] = h , ['@plate'] = plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET health =@he WHERE plate=@plate",{['@he'] = he , ['@plate'] = plate})
		break		
	end
end)

RegisterServerEvent('garagem:fixcar')
AddEventHandler('garagem:fixcar', function(plate, heal)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local he = heal
	for _,v in pairs(vehicules) do
			MySQL.Sync.execute("UPDATE owned_vehicles SET health =@he WHERE plate=@plate",{['@he'] = he , ['@plate'] = plate})
		break		
	end
end)


AddEventHandler('kuana:checkvehi', function(plate)
			local src = source
			--local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
			local xx = MySQL.Sync.fetchScalar("SELECT x FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})		
			local yy = MySQL.Sync.fetchScalar("SELECT y FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})		
			local zz = MySQL.Sync.fetchScalar("SELECT z FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
			if xx ~= nil then		
				TriggerClientEvent('kuana:checkveh', src, xx, yy, zz)
			else
				TriggerClientEvent('esx:showNotification', src, "~r~Invalid~w~ plate.")
			end
end)

RegisterServerEvent('garagem:apre')
AddEventHandler('garagem:apre', function(vehiclePropsa, x, y, z, headings, he)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local h = headings
			MySQL.Sync.execute("UPDATE owned_vehicles SET x =@x WHERE plate=@plate",{['@x'] = x , ['@plate'] = vehiclePropsa.plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET y =@y WHERE plate=@plate",{['@y'] = y , ['@plate'] = vehiclePropsa.plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET z =@z WHERE plate=@plate",{['@z'] = z , ['@plate'] = vehiclePropsa.plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET h =@h WHERE plate=@plate",{['@h'] = h , ['@plate'] = vehiclePropsa.plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET health =@he WHERE plate=@plate",{['@he'] = he , ['@plate'] = vehiclePropsa.plate})
			MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehiclePropsa) , ['@plate'] = vehiclePropsa.plate})
end)

RegisterServerEvent('garagem:aprea')
AddEventHandler('garagem:aprea', function(pla, x, y, z, headings, he)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local h = headings
			MySQL.Sync.execute("UPDATE owned_vehicles SET x =@x WHERE plate=@plate",{['@x'] = x , ['@plate'] = pla})
			MySQL.Sync.execute("UPDATE owned_vehicles SET y =@y WHERE plate=@plate",{['@y'] = y , ['@plate'] = pla})
			MySQL.Sync.execute("UPDATE owned_vehicles SET z =@z WHERE plate=@plate",{['@z'] = z , ['@plate'] = pla})
			MySQL.Sync.execute("UPDATE owned_vehicles SET h =@h WHERE plate=@plate",{['@h'] = h , ['@plate'] = pla})
			MySQL.Sync.execute("UPDATE owned_vehicles SET health =@he WHERE plate=@plate",{['@he'] = he , ['@plate'] = pla})
end)

AddEventHandler('kuana:checkCoords', function(plate)
            --local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
            local xx = MySQL.Sync.fetchScalar("SELECT x FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
            local yy = MySQL.Sync.fetchScalar("SELECT y FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
            local zz = MySQL.Sync.fetchScalar("SELECT z FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
						local hh = MySQL.Sync.fetchScalar("SELECT h FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
						local hvida = MySQL.Sync.fetchScalar("SELECT health FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})

        TriggerClientEvent('kuana:checkcoordss', source, xx, yy, zz, hh, hvida)
end)

ESX.RegisterServerCallback('kuana:checkcoordsall', function(source, cb, plate)
	--local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
	local xx = MySQL.Sync.fetchScalar("SELECT x FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
	local yy = MySQL.Sync.fetchScalar("SELECT y FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
	local zz = MySQL.Sync.fetchScalar("SELECT z FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})        
	local hh = MySQL.Sync.fetchScalar("SELECT h FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
	local hvida = MySQL.Sync.fetchScalar("SELECT health FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})

	cb(xx, yy, zz, hh, hvida)
end)


RegisterServerEvent('kuana:updateall')
AddEventHandler('kuana:updateall', function()
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identifierr = xPlayer.getIdentifier()
		local vehicules = getPlayerVehicles(identifierr)
		local state = true
		for _,v in pairs(vehicules) do
			MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE owner=@dono",{['@state'] = state , ['@dono'] = xPlayer.getIdentifier()})	
		end
end)

RegisterServerEvent('garagem:lockvehi')
AddEventHandler('garagem:lockvehi', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local estado = "sim"
			MySQL.Sync.execute("UPDATE owned_vehicles SET lockcheck=@state WHERE plate=@plate",{['@state'] = estado , ['@plate'] = plate})
end)

RegisterServerEvent('garagem:lockvehia')
AddEventHandler('garagem:lockvehia', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local estado = "nao"
			MySQL.Sync.execute("UPDATE owned_vehicles SET lockcheck=@state WHERE plate=@plate",{['@state'] = estado , ['@plate'] = plate})
end)


ESX.RegisterServerCallback('kuana:checkquanti', function(source,cb, models)
  local modelcar = ""..models.."" 
  local quantidade = MySQL.Sync.fetchScalar("SELECT quantidade FROM vehicles WHERE model = @modelcar", {['@modelcar'] = modelcar}) 
  if quantidade > 0 then
    cb(true, quantidade)
  else
    cb(false, 0)
  end
end)

RegisterServerEvent('kuana:removequant')
AddEventHandler('kuana:removequant', function(quanti, model)
			MySQL.Sync.execute("UPDATE vehicles SET quantidade=@quanti WHERE model=@model",{['@quanti'] = quanti , ['@model'] = model})
end)

RegisterServerEvent('kuana:setlockvehicle')
AddEventHandler('kuana:setlockvehicle', function(plate, valor)
	local xPlayer = ESX.GetPlayerFromId(source)

			MySQL.Sync.execute("UPDATE owned_vehicles SET lockcheck =@lockcheck WHERE plate=@plate",{['@lockcheck'] = valor , ['@plate'] = plate})
end)

ESX.RegisterServerCallback('kuana:checklock',function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local checklocka = MySQL.Sync.fetchScalar("SELECT lockcheck FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate}) 
	
	if checklocka == "nao" then
		cb(false)
	elseif checklocka == "sim" then
		cb(true)
	end
end)

ESX.RegisterServerCallback('kuana:checkcarfind',function(source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			local owner = v.owner
			table.insert(vehicules, {vehicle = vehicle, state = v.state, lock = v.lockcheck, target = owner})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('kuana:checkcarowner',function(source, cb, target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = ""..target..""
	local name = {

	}

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			local first = ""..v.firstname
			local last  = ""..v.lastname
			local names = ""..first.." "..last
			local sex = ""
			if v.sex == "M" then
				sex = "Male"
			else
				sex = "Female"
			end
				
			table.insert(name, {names = names, sex = v.sex, height = v.height})
		end
		cb(name)
	end)
end)

AddEventHandler("playerDropped", function()
end)

RegisterServerEvent('kuana:svlock')
AddEventHandler('kuana:svlock', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("kuana:lock", xPlayer.source)
end)

RegisterServerEvent('kuana:svunlock')
AddEventHandler('kuana:svunlock', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("kuana:unlock", xPlayer.source)
end)


ESX.RegisterServerCallback('kuana:checktrancado', function(source, cb, platea)
	local xPlayer = ESX.GetPlayerFromId(source)

	local trancado = MySQL.Sync.fetchScalar("SELECT lockcheck FROM owned_vehicles WHERE plate = @plate", {['@plate'] = platea})       

	if trancado == "sim" then
		cb(true)
	elseif trancado == "nao" then
		cb(false)
	end
end)
