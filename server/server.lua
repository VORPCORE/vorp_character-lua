local VorpCore
local MaxCharacters

TriggerEvent("getCore", function(core)
	VorpCore = core
	MaxCharacters = VorpCore.maxCharacters
	VorpCore.addRpcCallback("vorp_characters:getMaxCharacters", function(source, cb, args)
		cb(#MaxCharacters)
	end)
end)


AddEventHandler("vorp_SpawnUniqueCharacter", function(source)
	local User = VorpCore.getUser(source)
	local Characters = User.getUserCharacters
	local userCharacters = {}
	for _, characters in pairs(Characters) do
		local userChars = {
			charIdentifier = characters.charIdentifier,
			money = characters.money,
			gold = characters.gold,
			firstname = characters.firstname,
			lastname = characters.lastname,
			skin = json.decode(characters.skin),
			components = json.decode(characters.comps),
			coords = json.decode(characters.coords),
			isDead = characters.isdead
		}
		userCharacters[#userCharacters + 1] = userChars
	end
	TriggerClientEvent("vorpcharacter:spawnUniqueCharacter", source, userCharacters)
end)


RegisterServerEvent("vorp_CreateNewCharacter", function(source)
	TriggerClientEvent("vorpcharacter:startCharacterCreator", source)
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
		auxcharacter = {
			charIdentifier = character.charIdentifier,
			money = character.money,
			gold = character.gold,
			firstname = character.firstname,
			lastname = character.lastname,
			skin = json.decode(character.skin),
			components = json.decode(character.comps),
			coords = json.decode(character.coords),
			isDead = character.isdead
		}
		UserCharacters[#UserCharacters + 1] = auxcharacter
	end

	TriggerClientEvent("vorpcharacter:selectCharacter", _source, UserCharacters, MaxCharacters)
end)



VorpCore.addRpcCallback("vorp_characters:Client:GetComponents", function(source, cb, args)
	local character = VorpCore.getUser(source).getUserCharacters
	cb(json.decode(character.comps))
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
	print("Deleting character " .. charid)
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
			AddUserToWhitelistById.updateComps(json.encode(compsValues))
		end

		if skinValues then
			User.updateSkin(json.encode(skinValues))
		end
	end
end)
