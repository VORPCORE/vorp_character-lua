local VorpCore
local MaxCharacters

TriggerEvent("getCore", function(core)
	VorpCore = core
	MaxCharacters = VorpCore.maxCharacters
	VorpCore.addRpcCallback("vorp_characters:getMaxCharacters", function(source, cb, args)
		cb(#MaxCharacters)
	end)
end)

RegisterServerEvent("vorp_CreateNewCharacter", function(source)
	TriggerClientEvent("vorpcharacter:startCharacterCreator", source)
end)


RegisterServerEvent("vorpcharacter:saveCharacter")
AddEventHandler("vorpcharacter:saveCharacter", function(skin, clothes, firstname, lastname)
	local _source = source
	local playerCoords = Config.SpawnCoords.position
	local playerHeading = Config.SpawnCoords.heading
	TriggerEvent("vorp_NewCharacter", _source)
	VorpCore.getUser(_source).addCharacter(firstname, lastname, json.encode(skin), json.encode(clothes))
	Wait(600)
	TriggerClientEvent("vorp:initCharacter", _source, playerCoords, playerHeading, false)
end)

RegisterServerEvent("vorpcharacter:deleteCharacter")
AddEventHandler("vorpcharacter:deleteCharacter", function(charid)
	local _source = source

	local User = VorpCore.getUser(_source)
	User.removeCharacter(charid)
end)

RegisterServerEvent("vorp_CharSelectedCharacter")
AddEventHandler("vorp_CharSelectedCharacter", function(charid)
	local _source = source
	VorpCore.getUser(_source).setUsedCharacter(charid)
end)

RegisterServerEvent("vorpcharacter:getPlayerSkin")
AddEventHandler("vorpcharacter:getPlayerSkin", function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	TriggerClientEvent("vorpcharacter:updateCache", _source, json.decode(Character.skin), json.decode(Character.comps))
end)


--* update Core , Core will update DB
RegisterNetEvent("vorpcharacter:setPlayerCompChange", function(skinValues, compsValues)
	local _source = source
	local UserCharacter = VorpCore.getUser(_source)
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




function Checkmissingkeys(data, key, gender)
	local switch = false
	if key == "skin" then
		for k, v in pairs(PlayerSkin) do
			if data[k] == nil then
				switch = true
				data[k] = v
			end
			if data["Eyes"] == 0 then
				switch = true
				if data["sex"] == "mp_male" then
					data["Eyes"] = 612262189
				else
					data["Eyes"] = 928002221
				end
			end
			if data["Hair"] == 0 and gender == "mp_female" then
				switch = true
				data["Hair"] = 1484585410 -- *add deafult characters hair so they are not bald to females.
			end
		end
		return data, switch
	end
	if key == "comps" then
		for k, v in pairs(PlayerClothing) do
			if data[k] == nil then
				data[k] = v
			end
			--* add component to body female so it doesnt show it with holes
			if data["Skirt"] == -1 and gender == "mp_female" then
				data["Skirt"] = -323977844
			end
			if data["Shirt"] == -1 and gender == "mp_female" then
				data["Shirt"] = -599669674
			end
			if data["Boots"] == -1 and gender == "mp_female" then
				data["Boots"] = 526124654
			end
		end
		return data, switch
	end
end

AddEventHandler("vorp_SpawnUniqueCharacter", function(source)
	local User = VorpCore.getUser(source)
	local Characters = User.getUserCharacters
	local userCharacters = {}
	for _, characters in pairs(Characters) do
		local skin, switch1 = Checkmissingkeys(json.decode(characters.skin), "skin")
		local comps, switch2 = Checkmissingkeys(json.decode(characters.comps), "comps")
		if switch1 then
			characters.updateSkin((json.encode(skin)))
		end
		if switch2 then
			characters.updateComps(json.encode(comps))
		end
		local userChars = {
			charIdentifier = characters.charIdentifier,
			money = characters.money,
			gold = characters.gold,
			firstname = characters.firstname,
			lastname = characters.lastname,
			skin = skin,
			components = comps,
			coords = json.decode(characters.coords),
			isDead = characters.isdead
		}
		userCharacters[#userCharacters + 1] = userChars
	end
	TriggerClientEvent("vorpcharacter:spawnUniqueCharacter", source, userCharacters)
end)

RegisterServerEvent("vorp_GoToSelectionMenu")
AddEventHandler("vorp_GoToSelectionMenu", function(source)
	local _source = source
	if _source == nil then
		print("Source is nil")
		return
	end

	local characters = VorpCore.getUser(_source).getUserCharacters
	local auxcharacter
	local UserCharacters = {}

	for _, character in pairs(characters) do
		local skin, switch1 = Checkmissingkeys(json.decode(character.skin), "skin")
		local comps, switch2 = Checkmissingkeys(json.decode(character.comps), "comps")

		if switch1 then
			character.updateSkin((json.encode(skin)))
		end
		if switch2 then
			character.updateComps(json.encode(comps))
		end

		auxcharacter = {
			charIdentifier = character.charIdentifier,
			money = character.money,
			gold = character.gold,
			firstname = character.firstname,
			lastname = character.lastname,
			skin = skin,
			components = comps,
			coords = json.decode(character.coords),
			isDead = character.isdead
		}
		UserCharacters[#UserCharacters + 1] = auxcharacter
	end

	TriggerClientEvent("vorpcharacter:selectCharacter", _source, UserCharacters, MaxCharacters)
end)
