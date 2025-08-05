local PromptGroup <const> = GetRandomIntInRange(0, 0xffffff)
local DeletePrompt
local SelectPrompt
local GoBackPrompt
local selectedChar        = 1 
local myChars             = {}
local textureId           = -1
local MaxCharacters
local mainCam
local LastCam
local random
local canContinue         = false
local MalePed
local FemalePed
local characterChosen = false
local MenuData            = exports.vorp_menu:GetMenuData()
Core                      = exports.vorp_core:GetCore() 
Custom                    = nil
Peds                      = {}
CachedSkin                = {}
CachedComponents          = {}
T                         = Translation.Langs[Lang]
CHARID                    = nil
local width, _            = GetCurrentScreenResolution()  

local imgPath             = "<img style='max-height:450px;max-width:280px;float: center;'src='nui://" .. GetCurrentResourceName() .. "/images/%s.png'>"
local img                 = "<img style='margin-top: 10px;margin-bottom: 10px; margin-left: -10px;'src='nui://" .. GetCurrentResourceName() .. "/images/%s.png'>"
local Divider             = "<br><br><br><br><br>" .. img:format("divider_line") .. "<br>"
local SubTitle            = "<span style='font-size: 25px;'>" .. T.MenuCreation.subtitle1 .. "<br><br></span>"
local fontSize            = "18px"

if width <= 1920 then
	imgPath = "<img style='max-height:200px;max-width:200px;float: center;'src='nui://" .. GetCurrentResourceName() .. "/images/%s.png'>"
	Divider = "<br>" .. img:format("divider_line")
	SubTitle = T.MenuCreation.subtitle1
	fontSize = "13px"
end

--PROMPTS
CreateThread(function()
	local str = T.PromptLabels.promptdeleteCurrent
	DeletePrompt = UiPromptRegisterBegin()
	UiPromptSetControlAction(DeletePrompt, Config.keys.prompt_delete.key)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(DeletePrompt, str)
	UiPromptSetEnabled(DeletePrompt, Config.AllowPlayerDeleteCharacter)
	UiPromptSetVisible(DeletePrompt, Config.AllowPlayerDeleteCharacter)
	UiPromptSetHoldMode(DeletePrompt, 5000)
	UiPromptSetGroup(DeletePrompt, PromptGroup, 0)
	UiPromptRegisterEnd(DeletePrompt)

	str = T.PromptLabels.promptselectConfirm
	SelectPrompt = UiPromptRegisterBegin()
	UiPromptSetControlAction(SelectPrompt, Config.keys.prompt_select.key)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(SelectPrompt, str)
	UiPromptSetEnabled(SelectPrompt, true)
	UiPromptSetVisible(SelectPrompt, true)
	UiPromptSetStandardMode(SelectPrompt, true)
	UiPromptSetGroup(SelectPrompt, PromptGroup, 0)
	UiPromptRegisterEnd(SelectPrompt)

	str = T.PromptLabels.promptback
	GoBackPrompt = UiPromptRegisterBegin()
	UiPromptSetControlAction(GoBackPrompt, Config.keys.prompt_Back.key)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(GoBackPrompt, str)
	UiPromptSetEnabled(GoBackPrompt, true)
	UiPromptSetVisible(GoBackPrompt, true)
	UiPromptSetStandardMode(GoBackPrompt, true)
	UiPromptSetGroup(GoBackPrompt, PromptGroup, 0)
	UiPromptRegisterEnd(GoBackPrompt)
end)


--EVENTS
RegisterNetEvent("vorpcharacter:spawnUniqueCharacter", function(myChar)
	myChars = myChar
	CharSelect()
end)

RegisterNetEvent("vorpcharacter:selectCharacter")
AddEventHandler("vorpcharacter:selectCharacter", function(myCharacters, mc, rand)
	if #myCharacters < 1 then
		return TriggerEvent("vorpcharacter:startCharacterCreator")
	end

	CreateThread(function()
		while not characterChosen do
			SetAmbientAnimalDensityMultiplierThisFrame(0.0)
			SetAmbientHumanDensityMultiplierThisFrame(0.0)
			SetAmbientPedDensityMultiplierThisFrame(0.0)
			SetScenarioHumanDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0)
			SetVehicleDensityMultiplierThisFrame(0.0)
			Wait(0)
		end
		characterChosen = false
	end)
	
	random = rand
	myChars = myCharacters
	MaxCharacters = mc
	DoScreenFadeOut(0)
	repeat Wait(0) until IsScreenFadedOut()
	StartSwapCharacters()
end)


RegisterNetEvent("vorpcharacter:updateCache")
AddEventHandler("vorpcharacter:updateCache", function(skin, comps)
	if skin then
		if type(skin) == "table" then
			CachedSkin = skin
		else
			CachedSkin = json.decode(skin)
		end
	end

	if comps then
		if type(comps) == "table" then
			CachedComponents = UpdateCache(comps)
		else
			CachedComponents = UpdateCache(json.decode(comps))
		end
	end
	local newComps = GetNewCompOldStructure(CachedComponents)
	TriggerServerEvent("vorpcharacter:setPlayerCompChange", CachedSkin, newComps)
end)


RegisterNetEvent("vorpcharacter:savenew")
AddEventHandler("vorpcharacter:savenew", function(comps, skin)
	if comps then
		if type(comps) == "table" then
			CachedComponents = UpdateCache(comps)
		else
			CachedComponents = UpdateCache(json.decode(comps))
		end
	end

	if skin then
		local skinz
		if type(skin) == "table" then
			skinz = skin
		else
			skinz = json.decode(skin)
		end
		for k, v in pairs(skinz) do
			if CachedSkin[k] then
				CachedSkin[k] = v
			end
		end
	end
	local newComps = GetNewCompOldStructure(CachedComponents)
	TriggerServerEvent("vorpcharacter:setPlayerCompChange", CachedSkin, newComps)
end)


--FUNCTIONS
local function LoadFaceFeatures(ped, skin)
	for _, value in pairs(Config.FaceFeatures) do
		for _, v in pairs(value) do
			if skin[v.comp] and skin[v.comp] ~= 0 then
				SetCharExpression(ped, v.hash, skin[v.comp])
			end
		end
	end
end

local function ApplyAllComponents(category, value, ped, set)
	if value.comp == -1 then
		return
	end

	local status = not set and "false" or GetResourceKvpString((tostring(value.comp)):format(CHARID or 0))
	if status == "true" then
		return RemoveTagFromMetaPed(Config.ComponentCategories[category])
	end

	ApplyShopItemToPed(value.comp, ped)

	if category ~= "Boots" then
		UpdateShopItemWearableState(ped, `base`)
	end

	Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
	UpdatePedVariation(ped)
	IsPedReadyToRender(ped)

	if value.palette ~= 0 then
		local TagData = GetMetaPedData(category == "Boots" and "boots" or category, ped)
		if TagData then
			local palette = (value.palette ~= 0) and value.palette or TagData.palette
			local tint0 = (value.tint0 ~= 0) and value.tint0 or TagData.tint0
			local tint1 = (value.tint1 ~= 0) and value.tint1 or TagData.tint1
			local tint2 = (value.tint2 ~= 0) and value.tint2 or TagData.tint2

			SetMetaPedTag(ped, TagData.drawable, TagData.albedo, TagData.normal, TagData.material, palette, tint0, tint1, tint2)
			if IsPedAPlayer(ped) and CachedComponents[category] then
				CachedComponents[category].drawable = TagData.drawable
				CachedComponents[category].albedo = TagData.albedo
				CachedComponents[category].normal = TagData.normal
				CachedComponents[category].material = TagData.material
				CachedComponents[category].palette = palette
			end
		end
	end
end

function LoadComps(ped, components, set)
	for category, value in pairs(components) do
		ApplyAllComponents(category, value, ped, set)
	end
	ApplyAllComponents("Shirt", components.Shirt, ped, set)
	ApplyAllComponents("Vest", components.Vest, ped, set)
	ApplyAllComponents("Boots", components.Boots, ped, set)

	UpdatePedVariation(ped)
end

---Remove all meta tags from ped
local function removeMetaTags(ped)
	for _, tag in pairs(Config.ComponentCategories) do
		RemoveTagFromMetaPed(tag, ped)
		UpdatePedVariation(ped)
	end
end

-- if values are 0 then we need to make everything same color
local function setDefaultSkin(gender, skin)
	for _, value in pairs(Config.DefaultChar) do
		local albedo = joaat(value.Albedo[1]:format(gender))
		if albedo == skin.albedo then
			-- work arround to fix Torso
			for _, v in pairs(value.Body) do
				if skin.Torso > 0 then
					if joaat(v:format(gender)) ~= skin.Torso then
						skin.Torso = joaat(v:format(gender))
						break
					end
				end
			end

			if skin.HeadType and skin.HeadType == 0 then
				skin.HeadType = joaat(value.Heads[1]:format(gender))
			end

			if skin.BodyType and skin.BodyType == 0 then
				skin.BodyType = joaat(value.Body[1]:format(gender))
			end

			if skin.LegsType and skin.LegsType == 0 then
				skin.LegsType = joaat(value.Legs[1]:format(gender))
			end

			if skin.Torso and skin.Torso == 0 then
				skin.Torso = joaat(value.Body[1]:format(gender))
			end
			break
		end
	end

	return skin
end

function LoadAll(gender, ped, pedskin, components, set)
	removeMetaTags(ped)
	IsPedReadyToRender(ped)
	ResetPedComponents(ped)
	local skin = setDefaultSkin(gender, pedskin)
	ApplyShopItemToPed(skin.HeadType, ped)
	ApplyShopItemToPed(skin.BodyType, ped)
	ApplyShopItemToPed(skin.LegsType, ped)
	ApplyShopItemToPed(skin.Eyes, ped)
	ApplyShopItemToPed(skin.Legs, ped)
	ApplyShopItemToPed(skin.Hair, ped)
	ApplyShopItemToPed(skin.Beard, ped)
	ApplyShopItemToPed(skin.Torso, ped)
	EquipMetaPedOutfit(skin.Waist, ped)
	EquipMetaPedOutfit(skin.Body, ped)
	Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
	LoadFaceFeatures(ped, skin)
	UpdatePedVariation(ped)
	IsPedReadyToRender(ped)
	LoadComps(ped, components, set)
	SetPedScale(ped, skin.Scale)
	UpdatePedVariation(ped)
	return skin
end

local function LoadCharacterSelect(ped, skin, components)
	local gender = skin.sex == "mp_male" and "M" or "F"
	LoadAll(gender, ped, skin, components, false)
	SetAttributeCoreValue(ped, 1, 100)
	SetAttributeCoreValue(ped, 0, 100)
end

function CharSelect()
	DoScreenFadeOut(0)
	repeat Wait(0) until IsScreenFadedOut()
	Wait(1000)
	local charIdentifier = myChars[selectedChar].charIdentifier
	CHARID = charIdentifier
	local nModel = tostring(myChars[selectedChar].skin.sex)
	CachedSkin = myChars[selectedChar].skin
	CachedComponents = myChars[selectedChar].components
	SetCachedSkin()
	TriggerServerEvent("vorp_CharSelectedCharacter", charIdentifier)
	RequestModel(nModel, false)
	repeat Wait(0) until HasModelLoaded(nModel)
	Wait(1000)
	SetPlayerModel(PlayerId(), joaat(nModel), false)
	SetModelAsNoLongerNeeded(nModel)
	Wait(1000)
	LoadPlayerComponents(PlayerPedId(), CachedSkin, CachedComponents)
	NetworkClearClockTimeOverride()
	FreezeEntityPosition(PlayerPedId(), false)
	SetEntityVisible(PlayerPedId(), true)
	SetPlayerInvincible(PlayerId(), false)
	SetEntityCanBeDamaged(PlayerPedId(), true)
	local coords = myChars[selectedChar].coords
	if not coords.x or not coords.y or not coords.z or not coords.heading then
		print("No coords found send back to original")
		coords = Config.SpawnCoords[math.random(#Config.SpawnCoords)].position
	end

	local playerCoords = vector3(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z))
	local heading = coords.heading
	local isDead = myChars[selectedChar].isDead
	TriggerEvent("vorp:initCharacter", playerCoords, heading, isDead) -- in here players will be removed from instance
	characterChosen = true
end

function StartSwapCharacters()
	ShowBusyspinnerWithText(T.Other.spinnertext)
	local options = Config.SpawnPosition[random].options
	exports.weathersync:setSyncEnabled(false)
	exports.weathersync:setMyWeather(options.weather.type, options.weather.transition, options.weather.snow)
	exports.weathersync:setMyTime(options.time.hour, 0, 0, options.time.transition, true)
	SetTimecycleModifier(options.timecycle.name)
	Citizen.InvokeNative(0xFDB74C9CC54C3F37, options.timecycle.strength)
	StartPlayerTeleport(PlayerId(), options.playerpos.x, options.playerpos.y, options.playerpos.z, 0.0, true, true, true, true)
	repeat Wait(0) until not IsPlayerTeleportActive()
	SetEntityCoords(PlayerPedId(), options.playerpos.x, options.playerpos.y, options.playerpos.z,false,false,false,false) -- sometimes it doesnt tp with devmode. so we enforce
	PrepareMusicEvent(options.music)
	Wait(100)
	TriggerMusicEvent(options.music)
	Wait(1000)

	if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
		RequestCollisionAtCoord(options.playerpos.x, options.playerpos.y, options.playerpos.z)
	end

	repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId()) == 1
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityVisible(PlayerPedId(), false)
	SetEntityInvincible(PlayerPedId(), true)

	Wait(1000)
	for key, value in pairs(myChars) do
		LoadPlayer(value.skin.sex)
		local data = Config.SpawnPosition[random].positions[key]
		if not data then
			return error("your config spawn locations doesnt have enough spawn locations you need to add: " .. #myChars .. "Spawn locations")
		end

		data.PedHandler = CreatePed(joaat(value.skin.sex), data.spawn.x, data.spawn.y, data.spawn.z, data.spawn.w, false, false, false, false)

		local start = GetGameTimer()
		repeat Wait(0) until DoesEntityExist(data.PedHandler) or GetGameTimer() - start > 5000
		if GetGameTimer() - start > 5000 then
			print("Failed to create peds")
			break
		end

		LoadCharacterSelect(data.PedHandler, value.skin, value.components)
		data.Cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", data.camera.x, data.camera.y, data.camera.z, data.camera.rotx, data.camera.roty, data.camera.rotz, data.camera.fov, false, 2)
		SetEntityInvincible(data.PedHandler, true)
		local randomScenario = math.random(1, #data.scenario[value.skin.sex])
		Citizen.InvokeNative(0x524B54361229154F, data.PedHandler, joaat(data.scenario[value.skin.sex][randomScenario]), -1, false, joaat(data.scenario[value.skin.sex][randomScenario]), -1.0, 0)
		Peds[#Peds + 1] = data.PedHandler
		SetPedCanBeTargetted(data.PedHandler, false)
	end

	mainCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", options.mainCam.x, options.mainCam.y, options.mainCam.z, options.mainCam.rotx, options.mainCam.roty, options.mainCam.rotz, options.mainCam.fov, false, 0)
	SetCamActive(mainCam, true)
	RenderScriptCams(true, false, 0, true, true, 0)
	repeat Wait(0) until IsCamActive(mainCam)
	Wait(2000)
	DoScreenFadeIn(2000)
	BusyspinnerOff()
	AnimpostfxPlay('PhotoMode_FilterGame06')
	repeat Wait(500) until IsScreenFadedIn()
	OpenMenuSelect()
end

local function finishSelection(boolean)
	MenuData.CloseAll()
	if boolean then
		DoScreenFadeOut(2000)
		repeat Wait(0) until IsScreenFadedOut()
	end
	Wait(1000)
	CreateThread(function()
		Wait(2000)
		for _, value in pairs(Peds) do
			DeleteEntity(value)
		end
		DestroyAllCams(true)
	end)
	Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
end


local function addNewelements(menu)
	menu.addNewElement({
		label = T.MainMenu.CreateNewSlot .. "<br>" .. "<span style ='opacity:0.6;'>" .. T.MainMenu.CreateNewCharT .. "</span>",
		value = "create",
		desc = imgPath:format("character_creator_appearance") .. "<br>" .. T.MainMenu.CreateNewChar .. "<br><br><br>" .. Divider .. T.MainMenu.CreateNewCharDesc
	})
end

local function createMainCam()
	local data = Config.SpawnPosition[random].options
	mainCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", data.mainCam.x, data.mainCam.y, data.mainCam.z, data.mainCam.rotx, data.mainCam.roty, data.mainCam.rotz, data.mainCam.fov, false, 2)
	SetCamActive(mainCam, true)
	RenderScriptCams(true, false, 0, true, true, 0)
end

local function DeleleteSelectedChaacter(menu)
	local dataConfig = Config.SpawnPosition[random].positions[selectedChar]
	DeleteEntity(dataConfig.PedHandler)

	for i, ped in ipairs(Peds) do
		if ped == dataConfig.PedHandler then
			table.remove(Peds, i)
			break
		end
	end

	TriggerServerEvent("vorpcharacter:deleteCharacter", myChars[selectedChar])
	table.remove(myChars, selectedChar)

	if #myChars == 0 or myChars == nil then
		TriggerEvent("vorpcharacter:startCharacterCreator")
		return finishSelection(false)
	end

	for i = selectedChar, #myChars do
		local currentData = Config.SpawnPosition[random].positions[i]
		local nextData = Config.SpawnPosition[random].positions[i + 1]

		if nextData and nextData.PedHandler then
			currentData.PedHandler = nextData.PedHandler
			currentData.Cam = nextData.Cam
			nextData.PedHandler = nil
			nextData.Cam = nil
		end
	end

	local lastPosition = Config.SpawnPosition[random].positions[#myChars + 1]
	if lastPosition then
		lastPosition.PedHandler = nil
		lastPosition.Cam = nil
	end

	createMainCam()
	PlaySoundFrontend('TITLE_SCREEN_EXIT', 'DEATH_FAIL_RESPAWN_SOUNDS', true, 0)
	AnimpostfxPlay("RespawnPulse01")
	SetCamActiveWithInterp(mainCam, dataConfig.Cam, 1500, 500, 500)
	SetCamFocusDistance(mainCam, 1.0)

	for key, value in pairs(menu.data.elements) do
		if value.value == "choose" and key == selectedChar then
			menu.removeElementByIndex(key, true)
		end
	end
	addNewelements(menu)
	menu.refresh()
end

local function GetCharacterDescDetails(value)
	local desc = "<table style='width: 100%; color: white; font-size: " .. fontSize .. "; margin-left: 50px; margin-right: auto;'>" .. "<span style='font-family:crock;'> </span>" .. ""
	desc       = desc .. "<tr>"
	desc       = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Job .. "</th>"
	desc       = desc .. "<td style='text-align: center;'>" .. value.job .. " " .. value.grade .. "</td>"
	desc       = desc .. "</tr>"
	desc       = desc .. "<tr>"
	desc       = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Group .. "</th>"
	desc       = desc .. "<td style='text-align: center;'>" .. value.group .. "</td>"
	desc       = desc .. "</tr>"
	desc       = desc .. "<tr>"
	desc       = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Gender .. "</th>"
	desc       = desc .. "<td style='text-align: center;'>" .. value.gender .. "</td>"
	desc       = desc .. "</tr>"
	desc       = desc .. "<tr>"
	desc       = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Age .. "</th>"
	desc       = desc .. "<td style='text-align: center;'>" .. value.age .. "</td>"
	desc       = desc .. "</tr>"
	desc       = desc .. "<tr>"
	desc       = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Money .. "</th>"
	desc       = desc .. "<td style='text-align: center;'>$ " .. value.money .. "</td>"
	desc       = desc .. "</tr>"
	if Config.ShowGold then
		desc = desc .. "<tr>"
		desc = desc .. "<th style='text-align: left; font-family:crock;'>" .. T.Other.Gold .. "</th>"
		desc = desc .. "<td style='text-align: center;'>* " .. value.gold .. "</td>"
	end
	desc = desc .. "</tr>"
	desc = desc .. "</table>"
	return desc
end




local WhileSwaping = false
function EnableSelectionPrompts(menu)
	CreateThread(function()
		WhileSwaping = false
		local label = VarString(10, 'LITERAL_STRING', T.PromptLabels.promptselectChar)
		while not WhileSwaping do
			UiPromptSetActiveGroupThisFrame(PromptGroup, label, 0, 0, 0, 0)

			if UiPromptHasHoldModeCompleted(DeletePrompt) then
				return DeleleteSelectedChaacter(menu)
			end

			if UiPromptHasStandardModeCompleted(SelectPrompt, 0) then
				WhileSwaping = true
				UiFeedClearChannel(3, true, false)
				AnimpostfxPlay("RespawnPulse01")
				PlaySoundFrontend("Ready_Up_Flash", "RDRO_In_Game_Menu_Sounds", true, 0)
				ClearPedTasks(PlayerPedId(), false, false)
				Wait(1000)
				AnimpostfxPlay('PhotoMode_FilterGame06')
				finishSelection(true)
				AnimpostfxStop('PhotoMode_FilterGame06')
				ClearTimecycleModifier()
				exports.weathersync:setSyncEnabled(true)
				CharSelect()
				WhileSwaping = false
				return
			end

			if UiPromptHasStandardModeCompleted(GoBackPrompt, 0) then
				UiFeedClearChannel(3, true, false)
				createMainCam()
				SetCamActiveWithInterp(mainCam, LastCam, 1500, 500, 500)
				SetCamFocusDistance(mainCam, 1.0)
				PlaySoundFrontend('TITLE_SCREEN_EXIT', 'DEATH_FAIL_RESPAWN_SOUNDS', true, 0)
				AnimpostfxPlay("RespawnPulse01")
				return
			end
			-- SET_BLOCKING_OF_NON_TEMPORARY_EVENTS_FOR_AMBIENT_PEDS_THIS_FRAME
			Citizen.InvokeNative(0x9911F4A24485F653, true)
			Wait(0)
		end
	end)
end

function OpenMenuSelect()
	MenuData.CloseAll()
	local elements = {}

	for key, value in ipairs(myChars) do
		if not Config.showchardesc then
			local desc = Divider .. T.MainMenu.NameDesc
			elements[#elements + 1] = {
				label = value.firstname .. " " .. value.lastname,
				value = "choose",
				desc = desc,
				char = value,
				index = key,
			}
		else
			local desc = GetCharacterDescDetails(value)
			elements[#elements + 1] = {
				label = value.firstname .. " " .. value.lastname .. "<br>" .. "<span style='opacity:0.6;'>" .. value.nickname .. "</span>",
				value = "choose",
				desc = imgPath:format("character_creator_appearance") .. "<br>" .. desc .. "<br>" .. value.charDesc .. Divider .. T.MainMenu.NameDesc,
				char = value,
				index = key,
			}
		end
	end

	for _ = 1, MaxCharacters - #myChars, 1 do
		elements[#elements + 1] = {
			label = T.MainMenu.CreateNewSlot .. "<br>" .. "<span style ='opacity:0.6;'>" .. T.MainMenu.CreateNewCharT .. "</span>",
			value = "create",
			desc = imgPath:format("character_creator_appearance") .. "<br><br>" .. T.MainMenu.CreateNewChar .. "<br><br>" .. Divider .. T.MainMenu.CreateNewCharDesc,
		}
	end

	AnimpostfxStop('PhotoMode_FilterGame06')
	AnimpostfxPlay("RespawnPulse01")
	PlaySoundFrontend("Ready_Up_Flash", "RDRO_In_Game_Menu_Sounds", true, 0)

	MenuData.Open('default', GetCurrentResourceName(), 'character_select',
		{
			title = T.MenuCreation.title1,
			subtext = SubTitle,
			align = Config.Align,
			elements = elements,
			itemHeight = "4vh",
		},

		function(data, menu)
			if (data.current.value == "choose") and not WhileSwaping then
				UiFeedClearChannel(3, true, false)
				WhileSwaping = true
				SetCamFocusDistance(mainCam, 4.0)
				selectedChar = data.current.index
				local dataConfig = Config.SpawnPosition[random].positions[selectedChar]
				local cam = dataConfig.Cam
				SetCamActiveWithInterp(cam, mainCam or LastCam, 1500, 500, 500)
				LastCam = cam
				SetCamMotionBlurStrength(cam, 30.0)
				SetCamFocusDistance(cam, 4.0)

				if IsCamActive(mainCam) then
					SetCamActive(mainCam, false)
					mainCam = nil
				end

				Wait(800)
				PlaySoundFrontend("TITLE_SCREEN_ENTER", "DEATH_FAIL_RESPAWN_SOUNDS", true, 0)
				repeat Wait(0) until not IsCamInterpolating(cam)
				AnimpostfxPlay('PedKill')
				EnableSelectionPrompts(menu)
			end

			if (data.current.value == "create") then
				UiFeedClearChannel(3, true, false)
				WhileSwaping = true
				AnimpostfxPlay('PhotoMode_FilterGame06')
				finishSelection(true)
				Wait(2000)
				AnimpostfxStop('PhotoMode_FilterGame06')
				TriggerEvent("vorpcharacter:startCharacterCreator")
			end
		end)
end

AddEventHandler("vorpcharacter:reloadafterdeath", function()
	local player = PlayerPedId()
	local getPedModel = GetEntityModel(player)
	local reload = false
	if getPedModel ~= joaat("mp_female") and getPedModel ~= joaat("mp_male") then
		print("Not a mp model")
		Wait(5000)
		LoadPlayer(joaat("CS_dutch"))
		SetPlayerModel(PlayerId(), joaat("CS_dutch"), false)
		IsPedReadyToRender(PlayerPedId())
		SetModelAsNoLongerNeeded(joaat("CS_dutch"))
		reload = true
	end

	if CachedSkin and CachedComponents then
		LoadPlayerComponents(PlayerPedId(), CachedSkin, CachedComponents, reload)
	end

	SetAttributeCoreValue(player, 0, 100)
	SetEntityHealth(player, 600, 1)
	SetAttributeCoreValue(player, 1, 100)
	RestorePedStamina(player, 1065330373)
end)



function LoadPlayerComponents(ped, skin, components, reload)
	local gender = skin.sex == "mp_male" and "Male" or "Female"
	local getPedModel = GetEntityModel(ped)

	if reload or getPedModel ~= joaat("mp_female") and getPedModel ~= joaat("mp_male") then
		local skinS = not Custom and getPedModel or Custom
		LoadPlayer(joaat(skinS))
		SetPlayerModel(PlayerId(), joaat(skinS), false)
		SetEntityFadeIn(ped)
		ped = PlayerPedId()
		SetModelAsNoLongerNeeded(joaat(skinS))
		Custom = nil
	end

	if skin.sex ~= "mp_male" then
		EquipMetaPedOutfitPreset(ped, 7)
	else
		EquipMetaPedOutfitPreset(ped, 4)
	end

	skin = LoadAll(gender, ped, skin, components, true)
	RegisterBodyIndexs(skin)
	ApplyRolledClothingStatus()
	FaceOverlay("beardstabble", skin.beardstabble_visibility, 1, 1, 0, 0, 1.0, 0, 1, skin.beardstabble_color_primary, 0, 0, 1, skin.beardstabble_opacity)
	FaceOverlay("hair", skin.hair_visibility, skin.hair_tx_id, 1, 0, 0, 1.0, 0, 1, skin.hair_color_primary, 0, 0, 1, skin.hair_opacity)
	FaceOverlay("scars", skin.scars_visibility, skin.scars_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.scars_opacity)
	FaceOverlay("spots", skin.spots_visibility, skin.spots_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.spots_opacity)
	FaceOverlay("disc", skin.disc_visibility, skin.disc_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.disc_opacity)
	FaceOverlay("complex", skin.complex_visibility, skin.complex_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.complex_opacity)
	FaceOverlay("acne", skin.acne_visibility, skin.acne_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.acne_opacity)
	FaceOverlay("ageing", skin.ageing_visibility, skin.ageing_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.ageing_opacity)
	FaceOverlay("freckles", skin.freckles_visibility, skin.freckles_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.freckles_opacity)
	FaceOverlay("moles", skin.moles_visibility, skin.moles_tx_id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skin.moles_opacity)
	FaceOverlay("shadows", skin.shadows_visibility, 1, 1, 0, 0, 1.0, 0, 1, skin.shadows_palette_color_primary, skin.shadows_palette_color_secondary, skin.shadows_palette_color_tertiary, skin.shadows_palette_id, skin.shadows_opacity)
	FaceOverlay("eyebrows", skin.eyebrows_visibility, skin.eyebrows_tx_id, 1, 0, 0, 1.0, 0, 1, skin.eyebrows_color, 0, 0, 1, skin.eyebrows_opacity)
	FaceOverlay("eyeliners", skin.eyeliner_visibility, skin.eyeliner_tx_id, 1, 0, 0, 1.0, 0, 1, skin.eyeliner_color_primary, 0, 0, skin.eyeliner_palette_id, skin.eyeliner_opacity)
	FaceOverlay("blush", skin.blush_visibility, skin.blush_tx_id, 1, 0, 0, 1.0, 0, 1, skin.blush_palette_color_primary, 0, 0, 1, skin.blush_opacity)
	FaceOverlay("lipsticks", skin.lipsticks_visibility, 1, 1, 0, 0, 1.0, 0, 1, skin.lipsticks_palette_color_primary, skin.lipsticks_palette_color_secondary, skin.lipsticks_palette_color_tertiary, skin.lipsticks_palette_id, skin.lipsticks_opacity)
	canContinue = true
	FaceOverlay("grime", skin.grime_visibility, skin.grime_tx_id, 0, 0, 0, 1.0, 0, 1, 0, 0, 0, 1, skin.grime_opacity)
	Wait(200)
	TriggerServerEvent("vorpcharacter:reloadedskinlistener")
	RemoveTagFromMetaPed(Config.ComponentCategories.AmmoPistol)
	SetPedScale(ped, CachedSkin.Scale)
end

function FaceOverlay(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk, palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var, opacity)
	visibility = visibility or 0
	tx_id = tx_id or 0
	palette_color_primary = palette_color_primary or 0
	opacity = opacity or 1.0

	for _, v in ipairs(Config.overlay_all_layers) do
		if v.name == name then
			v.visibility = visibility
			if visibility ~= 0 then
				v.tx_normal = tx_normal
				v.tx_material = tx_material
				v.tx_color_type = tx_color_type
				v.tx_opacity = tx_opacity
				v.tx_unk = tx_unk

				if tx_color_type == 0 then
					v.palette = Config.color_palettes[name][palette_id]
					v.palette_color_primary = palette_color_primary == 0 and 0x3F6E70FF or palette_color_primary
					v.palette_color_secondary = palette_color_secondary or 0
					v.palette_color_tertiary = palette_color_tertiary or 0
				end

				v.var = 0
				v.tx_id = tx_id == 0 and Config.overlays_info[name][1].id or Config.overlays_info[name][tx_id].id

				if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
					v.var = var or 0
					v.tx_id = Config.overlays_info[name][1].id
				end

				v.opacity = opacity == 0 and 1.0 or opacity

				if name == "grime" then
					v.visibility = 0
				end
			end
		end
	end

	if canContinue then
		canContinue = false
		CreateThread(StartOverlay)
	end
end

function StartOverlay()
	local current_texture_settings = Config.texture_types.Male

	if CachedSkin.sex ~= tostring("mp_male") then
		current_texture_settings = Config.texture_types.Female
	end

	if textureId ~= -1 then
		Citizen.InvokeNative(0xB63B9178D0F58D82, textureId) -- reset texture
		Citizen.InvokeNative(0x6BEFAA907B076859, textureId) -- remove texture
	end

	if CachedSkin.albedo and CachedSkin.albedo == 0 then
		CachedSkin.albedo = current_texture_settings.albedo
	end

	textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, CachedSkin.albedo, current_texture_settings.normal, current_texture_settings.material)
	for k, v in ipairs(Config.overlay_all_layers) do
		if v.visibility ~= 0 then
			local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity, v.tx_unk)
			if v.tx_color_type == 0 then
				Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette);                                                       -- apply palette
				Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary, v.palette_color_secondary, v.palette_color_tertiary) -- apply palette colours
			end
			Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var)                                                                -- apply overlay variant
			Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity)                                                            -- apply overlay opacity
		end
	end

	repeat Wait(0) until Citizen.InvokeNative(0x31DC8D3F216D8509, textureId)        -- wait till texture fully loaded

	Citizen.InvokeNative(0x0B46E25761519058, PlayerPedId(), joaat("heads"), textureId) -- apply texture to current component in category "heads"
	Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId)                             -- update texture
	IsPedReadyToRender()
	UpdatePedVariation()
end

-- work arround to fix scale issues
CreateThread(function()
	repeat Wait(2000) until LocalPlayer.state.IsInSession
	while true do
		local dead = IsEntityDead(PlayerPedId())
		if CachedSkin then
			local PlayerHeight = CachedSkin.Scale
			if PlayerHeight and not dead then
				SetPedScale(PlayerPedId(), PlayerHeight)
			end
		end
		Wait(1000)
	end
end)


AddEventHandler('onClientResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	if Config.DevMode then
		print("^3VORP Character Selector is in ^1DevMode^7 dont use in live servers")
		TriggerServerEvent("vorp_character:server:GoToSelectionMenu")
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

	for _, value in ipairs(Peds) do
		DeleteEntity(value)
	end

	ResetPedComponents(PlayerPedId())
	Citizen.InvokeNative(0xB63B9178D0F58D82, textureId) -- reset texture
	Citizen.InvokeNative(0x6BEFAA907B076859, textureId) -- remove texture
	DeleteEntity(MalePed)
	DeleteEntity(FemalePed)
	DoScreenFadeIn(100)
	RemoveImaps()
	Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
	MenuData.CloseAll()
	DestroyAllCams(true)
	UiFeedClearChannel(3, true, false)
	AnimpostfxStopAll()
	Citizen.InvokeNative(0x120C48C614909FA4, "AZL_RDRO_Character_Creation_Area", true)                  -- CLEAR_AMBIENT_ZONE_LIST_STATE
	Citizen.InvokeNative(0x9D5A25BADB742ACD, "AZL_RDRO_Character_Creation_Area_Other_Zones_Disable", true) -- CLEAR_AMBIENT_ZONE_LIST_STATE
	EnableControlAction(2, `INPUT_CREATOR_MENU_TOGGLE`, true)
	FreezeEntityPosition(PlayerPedId(), false)
end)

-- apply whistle data on character selected
RegisterNetEvent("vorp:SelectedCharacter", function(charid)
	CHARID = charid
	-- if it exists set is current values that were saved when player first made a character
	local whistleData <const> = GetResourceKvpString(("vorp_character_whistle_%s"):format(charid))
	if whistleData then
		local data <const> = json.decode(whistleData)
		local ped <const> = PlayerPedId()
		if data.pitch and data.pitch > 0 then
			SetWhistleConfigForPed(ped, "Ped.WhistlePitch", data.pitch)
		elseif data.clarity and data.clarity > 0 then
			SetWhistleConfigForPed(ped, "Ped.WhistleClarity", data.clarity)
		elseif data.style and data.style > 0 then
			SetWhistleConfigForPed(ped, "Ped.WhistleShape", data.style)
		end
	else
		if (WHISTLE.clarity and WHISTLE.clarity > 0) or (WHISTLE.pitch and WHISTLE.pitch > 0) or (WHISTLE.style and WHISTLE.style > 0) then
			SetResourceKvpNoSync(("vorp_character_whistle_%s"):format(charid), json.encode({
				clarity = WHISTLE.clarity,
				pitch = WHISTLE.pitch,
				style = WHISTLE.style
			}))
		end
	end
end)
