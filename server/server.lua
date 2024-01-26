---@diagnostic disable: undefined-global

local random = math.random(1, #Config.SpawnPosition)
local Core = exports.vorp_core:GetCore()
local MaxCharacters = Core.maxCharacters

function ConvertTable(comps, compTints)
	local NewComps = {}

	for k, comp in pairs(comps) do
		NewComps[k] = { comp = comp, tint0 = 0, tint1 = 0, tint2 = 0 }

		if compTints and compTints[k] and compTints[k][tostring(comp)] then
			local compTint = compTints[k][tostring(comp)]
			NewComps[k].tint0 = compTint.tint0 or 0
			NewComps[k].tint1 = compTint.tint1 or 0
			NewComps[k].tint2 = compTint.tint2 or 0
		end
	end

	return NewComps
end

function Checkmissingkeys(data, key)
	local switch = false
	if key == "skin" then
		for k, v in pairs(PlayerSkin) do
			if data[k] == nil then
				switch = true
				data[k] = v
			end
			if data.Eyes == 0 then
				switch = true
				if data.sex == "mp_male" then
					data.Eyes = 612262189
				else
					data.Eyes = 928002221
				end
			end
		end
		return data, switch
	end
	if key == "comps" then
		for k, v in pairs(PlayerClothing) do
			if data[k] == nil then
				data[k] = v.comp
			end
		end
		return data, switch
	end
end

local function UpdateDatabase(character)
	local json_skin = json.decode(character.skin)
	local json_comps = json.decode(character.comps)
	local compTints = json.decode(character.compTints)
	local skin, updateSkin = Checkmissingkeys(json_skin, "skin")
	local comps, updateComp = Checkmissingkeys(json_comps, "comps")

	if updateSkin then
		character.updateSkin((json.encode(skin)))
	end

	if updateComp then
		character.updateComps(json.encode(comps))
	end

	local NewComps = ConvertTable(comps, compTints)

	return skin, NewComps
end

function GetPlayerData(source)
	local User = Core.getUser(source)

	if not User then
		return false
	end
	local Characters = User.getUserCharacters


	local userCharacters = {}
	for _, characters in pairs(Characters) do
		local skin, comps = UpdateDatabase(characters)
		local userChars = {
			charIdentifier = characters.charIdentifier,
			money = characters.money,
			gold = characters.gold,
			firstname = characters.firstname,
			lastname = characters.lastname,
			skin = skin,
			components = comps,
			coords = json.decode(characters.coords),
			isDead = characters.isdead,
			job = characters.jobLabel or "Unemployed",
			grade = characters.jobGrade or "",
			group = characters.group or "",
			age = characters.age or "",
			nickname = characters.nickname or "",
			gender = characters.gender or "",
			charDesc = characters.charDescription or "",
		}
		userCharacters[#userCharacters + 1] = userChars
	end
	return userCharacters
end

RegisterServerEvent("vorp_CreateNewCharacter", function(source)
	local _source = source
	TriggerClientEvent("vorpcharacter:startCharacterCreator", _source)
end)


RegisterServerEvent("vorpcharacter:saveCharacter", function(data)
	local _source = source
	Core.getUser(_source).addCharacter(data)
	Wait(600)
	TriggerClientEvent("vorp:initCharacter", _source, Config.SpawnCoords.position, Config.SpawnCoords.heading, false)
	SetTimeout(3000, function()
		TriggerEvent("vorp_NewCharacter", _source)
	end)
end)

RegisterServerEvent("vorpcharacter:deleteCharacter", function(charid)
	local _source = source
	local User = Core.getUser(_source)
	User.removeCharacter(charid)
end)

RegisterServerEvent("vorp_CharSelectedCharacter")
AddEventHandler("vorp_CharSelectedCharacter", function(charid)
	local _source = source
	Core.getUser(_source).setUsedCharacter(charid)
end)


RegisterNetEvent("vorpcharacter:setPlayerCompChange", function(skinValues, compsValues)
	local _source = source
	local UserCharacter = Core.getUser(_source)
	if UserCharacter then
		local User = UserCharacter.getUsedCharacter
		if compsValues then
			User.updateComps(json.encode(compsValues))
		end

		if skinValues then
			User.updateSkin(json.encode(skinValues))
		end
	end
end)



AddEventHandler("vorp_character:server:SpawnUniqueCharacter", function(source)
	local userCharacters = GetPlayerData(source)
	if not userCharacters then
		return
	end
	TriggerClientEvent("vorpcharacter:spawnUniqueCharacter", source, userCharacters)
end)


RegisterServerEvent("vorp_character:server:GoToSelectionMenu")
AddEventHandler("vorp_character:server:GoToSelectionMenu", function(source)
	local _source = source
	if _source == nil then
		return
	end
	local UserCharacters = GetPlayerData(_source)

	if not UserCharacters then
		return
	end

	TriggerClientEvent("vorpcharacter:selectCharacter", _source, UserCharacters, MaxCharacters, random)
end)


Core.Callback.Register("vorp_characters:getMaxCharacters", function(source, cb)
	cb(#MaxCharacters)
end)

Core.Callback.Register("vorp_character:callback:PayToShop", function(source, callback, arguments)
	local _source = source
	local User = Core.getUser(_source)
	local character = User.getUsedCharacter
	local money = character.money
	local amountToPay = arguments.amount

	if money < amountToPay then
		SetTimeout(5000, function()
			Core.NotifyRightTip(_source, "You don't have enough money", 6000)
		end)
		return callback(false)
	end

	SetTimeout(5000, function()
		Core.NotifyRightTip(_source, "You paid $" .. amountToPay, 6000)
	end)

	character.removeCurrency(0, amountToPay)

	if arguments.skin then
		character.updateSkin((json.encode(arguments.skin)))
	end
	if arguments.comps then
		character.updateComps(json.encode(arguments.comps))
	end
	if arguments.compTints then
		character.updateCompTints(json.encode(arguments.compTints))
	end

	return callback(true)
end)

Core.Callback.Register("vorp_character:callback:CanPayForSecondChance", function(source, callback)
	local _source = source
	local User = Core.getUser(_source)
	local character = User.getUsedCharacter
	local money = character.money
	local amountToPay = ConfigShops.SecondChancePrice

	if money < amountToPay then
		Core.NotifyRightTip(_source, "You don't have enough money price is: $" .. ConfigShops.SecondChancePrice, 6000)
		return callback(false)
	end

	return callback(true)
end)

Core.Callback.Register("vorp_character:callback:PayForSecondChance", function(source, callback, data)
	local _source = source
	local User = Core.getUser(_source)

	if not User then
		return callback(false)
	end

	local character = User.getUsedCharacter
	local money = ConfigShops.SecondChanceCurrency == 0 and character.money or ConfigShops.SecondChanceCurrency == 1 and character.gold or ConfigShops.SecondChanceCurrency == 2 and character.rol
	local amountToPay = ConfigShops.SecondChancePrice

	if money < amountToPay then
		Core.NotifyRightTip(_source, "You don't have enough money price is: $" .. ConfigShops.SecondChancePrice, 6000)
		return callback(false)
	end

	if data.comps then
		character.updateComps(json.encode(data.comps))
	end

	if data.skin then
		character.updateSkin(json.encode(data.skin))
	end

	if data.compTints then
		character.updateCompTints(json.encode(data.compTints))
	end

	character.removeCurrency(0, amountToPay)
	return callback(true)
end)
