---@diagnostic disable: undefined-global
local cameraMale
local cameraFemale
local cameraEditor
local isMale = true
local up
local defaultZoom = 45.00
local left
local right
local down
local zoomin
local zoomout
local selectLeft
local selectRight
local selectEnter
local PromptGroup1 = GetRandomIntInRange(0, 0xffffff)
local PromptGroup2 = GetRandomIntInRange(0, 0xffffff)
T = Translation.Langs[Lang]

--GLOBALS
VORPcore = exports.vorp_core:GetCore()
InCharacterCreator = false
IsInCharCreation = false
FemalePed = nil
MalePed = nil
IsInSecondChance = false

--PROMPTS
CreateThread(function()
	local C = Config.keys
	local str = T.PromptLabels.promptsexMale
	selectLeft = PromptRegisterBegin()
	PromptSetControlAction(selectLeft, C.prompt_choose_gender_M.key) -- add to config
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(selectLeft, str)
	PromptSetEnabled(selectLeft, 1)
	PromptSetVisible(selectLeft, 1)
	PromptSetStandardMode(selectLeft, 1)
	PromptSetGroup(selectLeft, PromptGroup1)
	PromptRegisterEnd(selectLeft)

	local str = T.PromptLabels.promptsexFemale
	selectRight = PromptRegisterBegin()
	PromptSetControlAction(selectRight, C.prompt_choose_gender_F.key)
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(selectRight, str)
	PromptSetEnabled(selectRight, 1)
	PromptSetVisible(selectRight, 1)
	PromptSetStandardMode(selectRight, 1)
	PromptSetGroup(selectRight, PromptGroup1)
	PromptRegisterEnd(selectRight)


	local str = T.PromptLabels.promptselectConfirm
	selectEnter = PromptRegisterBegin()
	PromptSetControlAction(selectEnter, C.prompt_select_gender.key)
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(selectEnter, str)
	PromptSetEnabled(selectEnter, 0)
	PromptSetVisible(selectEnter, 1)
	PromptSetStandardMode(selectEnter, 1)
	PromptSetGroup(selectEnter, PromptGroup1)
	PromptRegisterEnd(selectEnter)
end)

function SetupCamera()
	local camera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, true)
	local pos = vector3(-562.15, -3776.22, 239.11)
	local rot = vector3(-4.71, 0.0, -93.14)
	SetCamParams(camera, pos, rot, 45.0, 0, 1, 1, 2, 1, 1, 0, 0)
	N_0x11f32bb61b756732(camera, 4.0)
	RenderScriptCams(true, false, 3000, true, true, 0)
	return camera
end

-- request char creator imaps
local function Setup()
	Citizen.InvokeNative(0x513F8AA5BF2F17CF, -561.4, -3782.6, 237.6, 50.0, 20)                                 -- loadshpere
	Citizen.InvokeNative(0x9748FA4DE50CCE3E, "AZL_RDRO_Character_Creation_Area", true, true)                   -- load sound
	Citizen.InvokeNative(0x9748FA4DE50CCE3E, "AZL_RDRO_Character_Creation_Area_Other_Zones_Disable", false, true) -- load sound
	RequestImapCreator()
	NetworkClockTimeOverride(10, 0, 0, 0, true)
	SetTimecycleModifier('Online_Character_Editor')
	StartPlayerTeleport(PlayerId(), -561.22, -3776.26, 239.16, 93.2, true, true, true, true)
	repeat Wait(0) until not IsPlayerTeleportActive()
	if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
		RequestCollisionAtCoord(-561.22, -3776.26, 239.16)
	end
	repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())
	local cam = SetupCamera()
	local animscene, peds = SetupAnimscene()
	LoadAnimScene(animscene)
	while not Citizen.InvokeNative(0x477122B8D05E7968, animscene) do
		Citizen.Wait(0)
	end

	StartAnimScene(animscene)
	DoScreenFadeIn(3000)
	repeat Wait(0) until IsScreenFadedIn()

	while not Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animscene) do
		Citizen.Wait(0)
	end

	SetCamParams(cam, vector3(-562.15, -3776.22, 239.11), vector3(-4.71, 0.0, -93.14), 45.0, 0, 1, 1, 2, 1, 1, 0, 0)
	N_0x11f32bb61b756732(cam, 4.0) -- set cam focus distance
	DisplayHud(true)
	exports[GetCurrentResourceName()]:_UI_FEED_POST_OBJECTIVE(-1,
		'~INPUT_CREATOR_MENU_TOGGLE~  to Choose gender, to accept press ~INPUT_CREATOR_ACCEPT~')
	local char = 1
	while true do
		if IsControlJustPressed(0, `INPUT_CREATOR_MENU_TOGGLE`) then
			char = (char + 1) % 2
			local view = Config.Intro["views"][char + 1]
			if view then
				SetCamParams(cam, view.pos, view.rot, view.fov, 1200, 1, 1, 2, 1, 1, 0, 0)
				N_0x11f32bb61b756732(cam, 4.0)

				local transEnd = false
				Citizen.SetTimeout(1200, function()
					transEnd = true
				end)

				while not transEnd do
					Citizen.Wait(0)
				end
			end
		end

		if IsControlJustPressed(0, `INPUT_CREATOR_ACCEPT`) then
			break
		end

		Citizen.Wait(0)
	end

	N_0xdd1232b332cbb9e7(3, 1, 0) -- clse ui feed
	local ped = peds[char + 1]
	local gender = (IsPedMale(ped) and "Male") or "Female"
	Citizen.InvokeNative(0xAB5E7CAB074D6B84, animscene, ("Pl_Start_to_Edit_%s"):format(gender))
	while not (Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) > 0.2) do
		Citizen.Wait(0)
	end

	SetCamParams(cam, vector3(-561.82, -3780.97, 239.08), vector3(-4.21, 0.0, -87.88), 30.0, 0, 1, 1, 2, 1, 1, 0, 0)
	N_0x11f32bb61b756732(cam, 1.0)

	while not (N_0xd8254cb2c586412b(animscene) == 1) do
		Citizen.Wait(0)
	end
	Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) -- delete animscene
	RegisterGenderPrompt()

	if gender ~= "Male" then
		CreatePlayerModel("mp_female", cameraFemale, peds)
	else
		CreatePlayerModel("mp_male", cameraMale, peds)
	end
end

RegisterNetEvent("vorpcharacter:startCharacterCreator")
AddEventHandler("vorpcharacter:startCharacterCreator", function()
	exports.weathersync:setSyncEnabled(false)
	ShowBusyspinnerWithText("Character creation Loading")
	Wait(500)
	InCharacterCreator = true
	Wait(2000)
	BusyspinnerOff()
	Setup()
end)

function RegisterGenderPrompt()
	local C = Config.keys
	local str = T.PromptLabels.promptUpDownCam
	down = PromptRegisterBegin()
	PromptSetControlAction(down, C.prompt_camera_ws.key)
	PromptSetControlAction(down, C.prompt_camera_ws.key2)
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(down, str)
	PromptSetEnabled(down, 0)
	PromptSetVisible(down, 0)
	PromptSetStandardMode(down, 1)
	PromptSetGroup(down, PromptGroup2)
	PromptRegisterEnd(down)


	str = T.PromptLabels.promptrotateCam
	right = PromptRegisterBegin()
	PromptSetControlAction(right, 0x7065027D)
	PromptSetControlAction(right, 0xB4E465B4)
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(right, str)
	PromptSetEnabled(right, 0)
	PromptSetVisible(right, 0)
	PromptSetHoldMode(right, false)
	PromptSetStandardMode(right, 0)
	PromptSetGroup(right, PromptGroup2)
	PromptRegisterEnd(right)

	str = T.PromptLabels.promptzoomCam
	zoomout = PromptRegisterBegin()
	PromptSetControlAction(zoomout, C.prompt_zoom.key)
	PromptSetControlAction(zoomout, C.prompt_zoom.key2)
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(zoomout, str)
	PromptSetEnabled(zoomout, 0)
	PromptSetVisible(zoomout, 0)
	PromptSetStandardMode(zoomout, 1)
	PromptSetGroup(zoomout, PromptGroup2)
	PromptRegisterEnd(zoomout)
end

local function StartCam(x, y, z, heading, zoom)
	Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId())
	DestroyAllCams(true)
	local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, -11.32719, 0.0, heading, zoom, true, 0)
	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true, 0)
end

local z_position = 239.44
local heading = 93.2
local zoom = 45.00

local function adjustHeading(amount)
	heading = heading + amount
	SetPedDesiredHeading(PlayerPedId(), heading)
end

function AdjustZoom(amount)
	zoom = zoom + amount
	StartCam(-560.1333, -3780.923, z_position, -90.96693, zoom)
end

function StartPrompts()
	while IsInCharCreation do
		Wait(0)

		local label = CreateVarString(10, "LITERAL_STRING", T.PromptLabels.CamAdjustments)
		PromptSetActiveGroupThisFrame(PromptGroup2, label)

		if IsControlPressed(2, Config.keys.prompt_camera_rotate.key) then --right
			adjustHeading(-5.0)
		end

		if IsControlPressed(2, Config.keys.prompt_camera_rotate.key2) then -- left
			adjustHeading(5.0)
		end

		if IsControlPressed(2, Config.keys.prompt_camera_ws.key) then -- up
			z_position = math.min(z_position + 0.02, 240.0)
			StartCam(-560.1333, -3780.923, z_position, -90.96693, zoom)
		end

		if IsControlPressed(2, Config.keys.prompt_camera_ws.key2) then -- down
			z_position = math.max(z_position - 0.02, 237.70)
			StartCam(-560.1333, -3780.923, z_position, -90.96693, zoom)
		end

		if IsControlPressed(2, Config.keys.prompt_zoom.key) then -- zoom out
			AdjustZoom(4.0)
		end

		if IsControlPressed(2, Config.keys.prompt_zoom.key2) then --zoom in
			AdjustZoom(-4.0)
		end
	end
end

function DefaultPedSetup(ped, male)
	local compEyes
	local compBody
	local compHead
	local compLegs

	if male then
		compEyes = 612262189
		compBody = tonumber("0x" .. Config.DefaultChar.Male[1].Body[1])
		compHead = tonumber("0x" .. Config.DefaultChar.Male[1].Heads[1])
		compLegs = tonumber("0x" .. Config.DefaultChar.Male[1].Legs[1])
	else
		Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 7, true) -- female sync
		compEyes = 928002221
		compBody = tonumber("0x" .. Config.DefaultChar.Female[1].Body[1])
		compHead = tonumber("0x" .. Config.DefaultChar.Female[1].Heads[1])
		compLegs = tonumber("0x" .. Config.DefaultChar.Female[1].Legs[1])
	end
	Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 3, true) -- outfits
	IsPedReadyToRender(ped)
	PlayerSkin.HeadType = compHead
	PlayerSkin.BodyType = compBody
	PlayerSkin.LegsType = compLegs
	PlayerSkin.Eyes = compEyes
end

function EnableCharCreationPrompts(boolean)
	PromptSetEnabled(up, boolean)
	PromptSetVisible(up, boolean)
	PromptSetEnabled(down, boolean)
	PromptSetVisible(down, boolean)
	PromptSetEnabled(left, boolean)
	PromptSetVisible(left, boolean)
	PromptSetEnabled(right, boolean)
	PromptSetVisible(right, boolean)
	PromptSetEnabled(zoomin, boolean)
	PromptSetVisible(zoomin, boolean)
	PromptSetEnabled(zoomout, boolean)
	PromptSetVisible(zoomout, boolean)
end

Clothing = {}
function CreatePlayerModel(model, cam, peds)
	local Gender = "male"
	PlayerSkin.sex = model
	PlayerSkin.albedo = joaat("mp_head_mr1_sc08_c0_000_ab")
	isMale = true

	if model == 'mp_female' then
		isMale = false
		Gender = "female"
		PlayerSkin.sex = model
		PlayerSkin.albedo = joaat("mp_head_fr1_sc08_c0_000_ab")
	end
	DoScreenFadeOut(0)
	repeat Wait(0) until IsScreenFadedOut()
	for key, value in pairs(peds) do
		DeleteEntity(value)
	end
	SetEntityCoords(PlayerPedId(), -558.3258, -3781.111, 237.60, true, true, true, false) -- set player to start creation
	SetEntityHeading(PlayerPedId(), 93.2)
	LoadPlayer(model)
	SetPlayerModel(PlayerId(), joaat(model), false)
	SetModelAsNoLongerNeeded(model)
	Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), false, true, true, true, false)
	RenderScriptCams(false, true, 3000, true, true, 0)
	Wait(1000)
	DefaultPedSetup(PlayerPedId(), isMale)
	Wait(1000)
	IsInCharCreation = true
	RegisterGenderPrompt()
	CreateThread(StartPrompts)
	EnableCharCreationPrompts(true)
	for category, value in pairs(Data.clothing[Gender]) do
		local categoryTable = {}

		for _, v in pairs(value) do
			local typeTable = {}

			for _, va in pairs(v) do
				local hash = va.hashname
				local hex = va.hash

				table.insert(typeTable, { hash = hash, hex = hex })
			end

			table.insert(categoryTable, typeTable)
		end
		Clothing[category] = categoryTable
	end

	Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F1F01E5, 0)        -- remove meta tag
	Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), true, true, true, false) -- update variation
	SetEntityVisible(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)
	Citizen.InvokeNative(0x25ACFC650B65C538, PlayerPedId(), 1.0) -- scale
	SetCamActive(cameraEditor, true)
	RenderScriptCams(true, true, 1000, true, true, 0)
	CreateThread(function()
		while IsInCharCreation do
			Wait(0)
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end)
	Wait(2000)
	SetClockTime(10, 00, 0)
	SetTimecycleModifier('Online_Character_Editor')
	DoScreenFadeIn(3000)
	repeat Wait(0) until IsScreenFadedIn()

	OpenCharCreationMenu(Clothing)
end

RegisterNetEvent('vorp_character:Server:SecondChance', function(skin, comps)
	DoScreenFadeOut(3000)
	Wait(3000)
	IsInSecondChance = true
	local Gender = "male"
	if skin.sex == "mp_female" then
		Gender = "female"
	end
	PlayerSkin = skin
	PlayerClothing = comps
	local instanced = GetPlayerServerId(PlayerId()) + 456565
	VORPcore.instancePlayers(math.floor(instanced))
	RequestImapCreator()
	RegisterGenderPrompt()
	CreateThread(StartPrompts)
	EnableCharCreationPrompts(true)
	IsInCharCreation = true

	SetEntityCoords(PlayerPedId(), -558.3258, -3781.111, 237.60, true, true, true, false) -- set player to start creation
	SetEntityHeading(PlayerPedId(), 93.2)
	Wait(1000)
	cameraEditor = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -560.1333, -3780.923, 239.44,
		-11.32719, 0.0, -90.96, defaultZoom, false, 0)
	Wait(1000)
	SetCamActive(cameraEditor, true)
	RenderScriptCams(true, true, 1000, true, true, 0)

	Clothing = {}

	for category, value in pairs(Data.clothing[Gender]) do
		local categoryTable = {}

		for _, v in pairs(value) do
			local typeTable = {}

			for _, va in pairs(v) do
				local hash = va.hashname
				local hex = va.hash

				table.insert(typeTable, { hash = hash, hex = hex })
			end

			table.insert(categoryTable, typeTable)
		end
		Clothing[category] = categoryTable
	end
	DoScreenFadeIn(3000)
	CreateThread(function()
		while IsInCharCreation do
			Wait(0)
			FreezeEntityPosition(PlayerPedId(), false)
			--DrawLightWithRange(-560.1646, -3782.066, 238.5975, 250, 250, 250, 7.0, 130.0)
		end
	end)
	PrepareMusicEvent("MP_CHARACTER_CREATION_START")
	TriggerMusicEvent("MP_CHARACTER_CREATION_START")
	OpenCharCreationMenu(Clothing)
end)
