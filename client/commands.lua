---@diagnostic disable: undefined-global

local function toggleComp(hash, item)
	local __player = PlayerPedId()
	if Citizen.InvokeNative(0xFB4891BD7578CDC1, __player, hash) then
		Citizen.InvokeNative(0xD710A5007C2AC539, __player, hash, 0)
	else
		Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, item, false, false, false)
		Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, item, true, true, true)
	end
	UpdateVariation(__player)
end


for key, v in pairs(Config.commands) do
	RegisterCommand(v.command, function()
		print(key, CachedComponents[key])
		toggleComp(Config.HashList[key], CachedComponents[key])
	end, false)
end

RegisterCommand("rings", function()
	toggleComp(0x7A6BBD0B, CachedComponents.RingLh)
	toggleComp(0xF16A1D23, CachedComponents.RingRh)
end, false)


RegisterCommand("undress", function()
	local __player = PlayerPedId()
	for Category, Components in pairs(CachedComponents) do
		if Components ~= -1 then
			if Citizen.InvokeNative(0xFB4891BD7578CDC1, __player, Config.HashList[Category]) then
				Citizen.InvokeNative(0xD710A5007C2AC539, __player, Config.HashList[Category], 0)
			end
		end
	end
	UpdateVariation(__player)
end, false)

RegisterCommand("dress", function()
	local __player = PlayerPedId()
	for _, Components in pairs(CachedComponents) do
		if Components ~= -1 then
			Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Components, false, false, false)
			Citizen.InvokeNative(0xD3A7B003ED343FD9, __player, Components, true, true, false)
		end
	end
	UpdateVariation(__player)
end, false)

local BandanaOn = false
RegisterCommand('bandanaon', function(source, args, rawCommand)
	local player = PlayerPedId()
	if not BandanaOn then
		BandanaOn = true
		Citizen.InvokeNative(0xD3A7B003ED343FD9, player, CachedComponents.NeckWear, true, true)
		Citizen.InvokeNative(0xAE72E7DF013AAA61, player, 0, `BANDANA_ON_RIGHT_HAND`, 1, 0, -1.0)
		Wait(750)
	end
	Citizen.InvokeNative(0x66B957AAC2EAAEAB, player, CachedComponents.NeckWear, -1829635046, 0, true, 1)
	Citizen.InvokeNative(0xAAB86462966168CE, player, true)
	Citizen.InvokeNative(0xCC8CA3E88256E58F, player, false, true, true, true, false)
end, false)

RegisterCommand('bandanaoff', function(source, args, rawCommand)
	local player = PlayerPedId()
	if BandanaOn then
		BandanaOn = false
		Citizen.InvokeNative(0xAE72E7DF013AAA61, player, 0, `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1.0)
		Wait(750)
	end
	Citizen.InvokeNative(0x66B957AAC2EAAEAB, player, CachedComponents.NeckWear, `base`, 0, true, 1)
	Citizen.InvokeNative(0xAAB86462966168CE, player, true)
	Citizen.InvokeNative(0xCC8CA3E88256E58F, player, false, true, true, true, false)
end, false)


local sleeves = false
RegisterCommand("sleeves", function()
	if CachedComponents["Shirt"] == -1 then return end

	if not sleeves then
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Shirt,
			joaat("Closed_Collar_Rolled_Sleeve"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		sleeves = true
	else
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Shirt, joaat("base"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		sleeves = false
	end
end, false)

local sleeves2 = false
RegisterCommand("sleeves2", function()
	if CachedComponents.Shirt == -1 then return end
	if not sleeves2 then
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Shirt,
			joaat("open_collar_rolled_sleeve"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		sleeves2 = true
	else
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Shirt, joaat("base"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		sleeves2 = false
	end
end, false)

local tuck = false
RegisterCommand("tuck", function()
	if CachedComponents.Boots == -1 then return end
	if not tuck then
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Boots, -2081918609, 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		tuck = true
	else
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), CachedComponents.Boots, joaat("base"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		tuck = false
	end
end, false)
