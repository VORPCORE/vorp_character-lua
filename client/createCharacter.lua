---@diagnostic disable: undefined-global
local isMale = true
local up
local left
local right
local down
local zoomin
local zoomout
local PromptGroup2 = GetRandomIntInRange(0, 0xffffff)
local Core = exports.vorp_core:GetCore()
T = Translation.Langs[Lang]
InCharacterCreator = false
IsInCharCreation = false
FemalePed = nil
MalePed = nil


function SetupCameraCharacterCreationSelect()
	local camera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, true)
	local pos = vec3(-562.15, -3776.22, 239.11)
	local rot = vec3(-4.71, 0.0, -93.14)
	SetCamParams(camera, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 45.0, 0, 1, 1, 2, 1, 1)
	SetCamFocusDistance(camera, 4.0)
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

	local cam = SetupCameraCharacterCreationSelect()
	local animscene = -1
	local peds = {}

	if Config.UseInitialAnimScene then
		animscene, peds = SetupAnimscene()
		LoadAnimScene(animscene)
		repeat Wait(0) until Citizen.InvokeNative(0x477122B8D05E7968, animscene)

		StartAnimScene(animscene)
	else
		peds = SelectionPeds()
	end

	DoScreenFadeIn(3000)
	repeat Wait(0) until IsScreenFadedIn()

	if Config.UseInitialAnimScene then
		repeat Wait(0) until Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animscene)
	end

	SetCamParams(cam, vec3(-562.15, -3776.22, 239.11), vec3(-4.71, 0.0, -93.14), 45.0, 0, 1, 1, 2, 1, 1)

	Wait(1000)
	Core.NotifyObjective('~INPUT_CREATOR_MENU_TOGGLE~' .. T.Other.GenderChoice .. '~INPUT_CREATOR_ACCEPT~', -1)
	SetCamFocusDistance(cam, 4.0)

	local char = 1
	while true do
		if IsControlJustPressed(0, `INPUT_CREATOR_MENU_TOGGLE`) then
			char = (char + 1) % 2
			local view = Config.Intro.views[char + 1]
			if view then
				SetCamParams(cam, view.pos.x, view.pos.y, view.pos.z, view.rot.x, view.rot.y, view.rot.z, view.fov, 1200, 1, 1, 2, 1, 1)
				SetCamFocusDistance(cam, 4.0)

				local transEnd = false
				SetTimeout(1200, function()
					transEnd = true
				end)

				while not transEnd do
					Wait(0)
				end
			end

			local sound = char == 1 and "gender_right" or "gender_left"
			PlaySoundFrontend(sound, "RDRO_Character_Creator_Sounds", true, 0);
		end

		if IsControlJustPressed(0, `INPUT_CREATOR_ACCEPT`) then
			PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0);
			break
		end

		Wait(0)
	end

	UiFeedClearChannel(3, true, false)
	local ped = peds[char + 1]
	local gender = IsPedMale(ped) and "Male" or "Female"



	if Config.UseInitialAnimScene then
		Citizen.InvokeNative(0xAB5E7CAB074D6B84, animscene, ("Pl_Start_to_Edit_%s"):format(gender))
		while not (Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) > 0.2) do
			Citizen.Wait(0)
		end
	else
		ClearPedTasksImmediately(ped)
		TaskGoStraightToCoord(ped, -558.79, -3780.17, 238.59, 1.0, -1, 183.2, 0)
		-- set camera to follow the ped for 1 second with a loop that will break after 1 second
		while true do
			PointCamAtEntity(cam, ped, 0.0, 0.0, 0.0, true)
			Wait(0)
			if GetScriptTaskStatus(ped, 0x7D8F4411, true) == 8 then
				break
			end
		end
	end

	SetCamParams(cam, vec3(-561.82, -3780.97, 239.08), vec3(-4.21, 0.0, -87.88), 30.0, 0, 1, 1, 2, 1, 1)
	N_0x11f32bb61b756732(cam, 1.0)


	if Config.UseInitialAnimScene then
		while not (N_0xd8254cb2c586412b(animscene) == 1) do
			Citizen.Wait(0)
		end
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) -- delete animscene
	end
	local model = gender == "Male" and "mp_male" or "mp_female"
	CreatePlayerModel(model, peds)
	RegisterGenderPrompt()
end


local function setInteriors(male)
	local interiorAtCoords = GetInteriorAtCoords(-561.8157, -3780.966, 239.0805)

	if IsValidInterior(interiorAtCoords) == 1 then
		if IsInteriorReady(interiorAtCoords) == 1 then
			if male then
				if IsInteriorEntitySetValid(interiorAtCoords, "mp_char_female_mirror") == 1 then
					if IsInteriorEntitySetActive(interiorAtCoords, "mp_char_female_mirror") then
						DeactivateInteriorEntitySet(interiorAtCoords, "mp_char_female_mirror", true);
					end
				end

				if IsInteriorEntitySetValid(interiorAtCoords, "mp_char_male_mirror") == 1 then
					if not IsInteriorEntitySetActive(interiorAtCoords, "mp_char_male_mirror") then
						ActivateInteriorEntitySet(interiorAtCoords, "mp_char_male_mirror", 0);
					end
				end
			else
				if IsInteriorEntitySetValid(interiorAtCoords, "mp_char_male_mirror") == 1 then
					if IsInteriorEntitySetActive(interiorAtCoords, "mp_char_male_mirror") then
						DeactivateInteriorEntitySet(interiorAtCoords, "mp_char_male_mirror", true);
					end
				end

				if IsInteriorEntitySetValid(interiorAtCoords, "mp_char_female_mirror") == 1 then
					if not IsInteriorEntitySetActive(interiorAtCoords, "mp_char_female_mirror") then
						ActivateInteriorEntitySet(interiorAtCoords, "mp_char_female_mirror", 0);
					end
				end
			end
		end
	end
end


RegisterNetEvent("vorpcharacter:startCharacterCreator")
AddEventHandler("vorpcharacter:startCharacterCreator", function()
	exports.weathersync:setSyncEnabled(false)
	ShutdownLoadingScreen()
	ShowBusyspinnerWithText(T.Other.spinnertext2)
	Wait(500)
	InCharacterCreator = true
	Wait(2000)
	BusyspinnerOff()
	Setup()
end)

function RegisterGenderPrompt()
	local C = Config.keys
	local str = T.PromptLabels.promptUpDownCam
	down = UiPromptRegisterBegin()
	UiPromptSetControlAction(down, C.prompt_camera_ws.key)
	UiPromptSetControlAction(down, C.prompt_camera_ws.key2)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(down, str)
	UiPromptSetEnabled(down, false)
	UiPromptSetVisible(down, false)
	UiPromptSetStandardMode(down, true)
	UiPromptSetGroup(down, PromptGroup2, 0)
	UiPromptRegisterEnd(down)


	str = T.PromptLabels.promptrotateCam
	right = UiPromptRegisterBegin()
	UiPromptSetControlAction(right, 0x7065027D)
	UiPromptSetControlAction(right, 0xB4E465B4)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(right, str)
	UiPromptSetEnabled(right, false)
	UiPromptSetVisible(right, false)
	UiPromptSetStandardMode(right, true)
	UiPromptSetGroup(right, PromptGroup2, 0)
	UiPromptRegisterEnd(right)

	str = T.PromptLabels.promptzoomCam
	zoomout = UiPromptRegisterBegin()
	UiPromptSetControlAction(zoomout, `INPUT_CURSOR_ACCEPT_HOLD`)
	UiPromptSetControlAction(zoomout, `INPUT_INSPECT_ZOOM`)
	str = VarString(10, 'LITERAL_STRING', str)
	UiPromptSetText(zoomout, str)
	UiPromptSetEnabled(zoomout, true)
	UiPromptSetVisible(zoomout, true)
	UiPromptSetStandardMode(zoomout, true)
	UiPromptSetGroup(zoomout, PromptGroup2, 0)
	UiPromptRegisterEnd(zoomout)
end

local function SetUpCameraCharacterMovement(x, y, z, heading, fov)
	DestroyAllCams(true)
	local cam <const> = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, -4.2146, -0.0007, heading, fov, true, 0)
	SetCamActive(cam, true)
	RenderScriptCams(true, false, 3000, true, false, 0)
	ShakeCam(cam, "HAND_SHAKE", 0.04)
	return cam
end


local function RotationToDirection(rot)
	local pitch <const> = math.rad(rot.x)
	local yaw <const>   = math.rad(rot.z)
	local cp <const>    = math.cos(pitch)
	return vector3(-math.sin(yaw) * cp, math.cos(yaw) * cp, math.sin(pitch))
end

function StartPrompts(value)
	local baseX <const>        = value and value.Position.x or -561.8157
	local baseY <const>        = value and value.Position.y or -3780.966
	local baseZ <const>        = value and value.Position.z or 239.0805
	local heading              = value and value.Heading or -87.8802
	local maxUp <const>        = value and value.MaxUp or 239.55
	local maxDown <const>      = value and value.MaxDown or 238.0
	local zoomInRange <const>  = value and value.ZoomInRange or 2.5
	local zoomOutRange <const> = value and value.ZoomOutRange or 1.5
	local zoomStep <const>     = 0.05
	local vertStep <const>     = 0.01
	local cam <const>          = SetUpCameraCharacterMovement(baseX, baseY, baseZ, heading, 30.0)
	local rot <const>          = GetCamRot(cam, 2)
	local dir <const>          = RotationToDirection(rot)
	local base <const>         = vector3(baseX, baseY, baseZ)
	local forwardOffset        = 0
	local verticalOffset       = 0
	local minForward <const>   = -zoomOutRange
	local maxForward <const>   = zoomInRange
	local minVertical <const>  = maxDown - baseZ
	local maxVertical <const>  = maxUp - baseZ

	local TotalToPay           = ""

	while true do
		Wait(0)


		if IsInClothingStore and ShopType ~= "secondchance" then
			TotalToPay = T.Other.total .. GetCurrentAmmountToPay() .. "~q~ "
		end

		local label <const> = VarString(10, "LITERAL_STRING", TotalToPay .. T.PromptLabels.CamAdjustments)
		UiPromptSetActiveGroupThisFrame(PromptGroup2, label, 0, 0, 0, 0)

		if IsControlPressed(2, Config.keys.prompt_camera_rotate.key) then
			heading = heading - 1.5
			SetPedDesiredHeading(PlayerPedId(), heading)
		end

		if IsControlPressed(2, Config.keys.prompt_camera_rotate.key2) then
			heading = heading + 1.5
			SetPedDesiredHeading(PlayerPedId(), heading)
		end

		if IsControlPressed(2, Config.keys.prompt_camera_ws.key) then
			verticalOffset = math.min(verticalOffset + vertStep, maxVertical)
		end
		if IsControlPressed(2, Config.keys.prompt_camera_ws.key2) then
			verticalOffset = math.max(verticalOffset - vertStep, minVertical)
		end

		if IsControlPressed(2, `INPUT_INSPECT_ZOOM`) then
			forwardOffset = math.min(forwardOffset + zoomStep, maxForward)
		end
		if IsControlPressed(2, `INPUT_CONTEXT_ACTION`) then
			forwardOffset = math.max(forwardOffset - zoomStep, minForward)
		end

		local newPos = base + dir * forwardOffset + vector3(0, 0, verticalOffset)
		SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
		SetCamRot(cam, rot.x, rot.y, rot.z, 2)

	
		if not IsInCharCreation then
			if not IsInClothingStore then
				break
			end
		else
			if IsCharCreationFinished then
				break
			end
		end
	end

	DeleteAllPrompts()
	repeat Wait(0) until not IsInCharCreation and not IsInClothingStore
	DestroyCam(cam, false)
	RenderScriptCams(false, true, 500, true, true, 0)
end


function DefaultPedSetup(ped, male)
	local gender                = male and "M" or "F"
	HeadIndexTracker            = male and 8 or 1
	PlayerSkin.Eyes             = joaat(("CLOTHING_ITEM_%s_EYES_001_TINT_014"):format(gender))
	PlayerSkin.BodyType         = joaat(("CLOTHING_ITEM_%s_BODIES_UPPER_001_V_001"):format(gender))
	PlayerSkin.Body             = PlayerSkin.BodyType
	PlayerSkin.HeadType         = joaat(("CLOTHING_ITEM_%s_HEAD_00%d_V_001"):format(gender, HeadIndexTracker))
	PlayerSkin.LegsType         = joaat(("CLOTHING_ITEM_%s_BODIES_LOWER_001_V_001"):format(gender))
	PlayerSkin.albedo           = joaat(("MP_HEAD_%sR1_SC08_C0_000_AB"):format(gender))
	PlayerClothing.Teeth.comp   = joaat(("CLOTHING_ITEM_%s_TEETH_000"):format(gender))
	PlayerClothing.Gunbelt.comp = joaat(("CLOTHING_ITEM_%s_GUNBELT_000_TINT_001"):format(gender))
	PlayerSkin.Hair             = joaat(("CLOTHING_ITEM_%s_HAIR_001_BLONDE"):format(gender))

	SkinColorTracker            = 1

	if not male then
		IsPedReadyToRender()
		EquipMetaPedOutfitPreset(ped, 7)
		UpdatePedVariation()
	end

	if male then
		-- work around to fix skin on char creator
		IsPedReadyToRender()
		UpdateShopItemWearableState(-457866027, -425834297) -- fixes skin
		ApplyShopItemToPed(-218859683)                 -- might be boots cant remember
		ApplyShopItemToPed(PlayerClothing.Gunbelt.comp)
		UpdateShopItemWearableState(-218859683, -2081918609) -- fixes skin
		UpdatePedVariation()
	end

	PlayerSkin.sex                 = male and "mp_male" or "mp_female"
	PlayerSkin.eyebrows_visibility = 1
	PlayerSkin.eyebrows_tx_id      = 1
	PlayerSkin.eyebrows_opacity    = 1.0
	PlayerSkin.eyebrows_color      = 0x3F6E70FF

	ApplyOverlay("eyebrows", 1, 1, 1, 0, 0, 1.0, 0, 1, 0x3F6E70FF, 0, 0, 1, 1.0, PlayerSkin.albedo)

	IsPedReadyToRender()
	EquipMetaPedOutfitPreset(ped, 3)
	UpdatePedVariation()
end

function EnableCharCreationPrompts(boolean)
	UiPromptSetEnabled(up, boolean)
	UiPromptSetVisible(up, boolean)
	UiPromptSetEnabled(down, boolean)
	UiPromptSetVisible(down, boolean)
	UiPromptSetEnabled(left, boolean)
	UiPromptSetVisible(left, boolean)
	UiPromptSetEnabled(right, boolean)
	UiPromptSetVisible(right, boolean)
	UiPromptSetEnabled(zoomin, boolean)
	UiPromptSetVisible(zoomin, boolean)
	UiPromptSetEnabled(zoomout, boolean)
	UiPromptSetVisible(zoomout, boolean)
end

function DeleteAllPrompts()
	UiPromptDelete(up)
	UiPromptDelete(down)
	UiPromptDelete(left)
	UiPromptDelete(right)
	UiPromptDelete(zoomin)
	UiPromptDelete(zoomout)
end

function CreatePlayerModel(model, peds)
	local Gender = model == "mp_male" and "male" or "female"
	isMale = model == "mp_male" and true or false
	DoScreenFadeOut(10)
	repeat Wait(0) until IsScreenFadedOut()

	ShowBusyspinnerWithText(T.Other.spinnertext2)

	for _, value in pairs(peds) do
		DeleteEntity(value)
	end

	SetEntityCoordsAndHeading(PlayerPedId(), -558.5060302734375, -3781.050048828125, 237.60, 93.2, true, false, true)
	LoadPlayer(model)
	SetPlayerModel(PlayerId(), joaat(model), false)
	SetModelAsNoLongerNeeded(model)
	UpdatePedVariation(PlayerPedId())
	RenderScriptCams(false, true, 3000, true, true, 0)
	Wait(1000)
	DefaultPedSetup(PlayerPedId(), isMale)
	Wait(1000)
	IsInCharCreation = true
	IsCharCreationFinished = false
	RegisterGenderPrompt()
	CreateThread(function()
		StartPrompts()
	end)
	EnableCharCreationPrompts(true)
	Clothing = OrganiseClothingData(Gender)
	RemoveTagFromMetaPed(Config.ComponentCategories.Teeth)
	UpdatePedVariation(PlayerPedId())
	SetEntityVisible(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)
	SetPedScale(PlayerPedId(), 1.0)
	RenderScriptCams(true, true, 1000, true, true, 0)
	CreateThread(function()
		while IsInCharCreation do
			Wait(0)
			FreezeEntityPosition(PlayerPedId(), false)
			DrawLightWithRange(-560.1646, -3782.066, 238.5975, 250, 250, 250, 7.0, 30.0)
		end
	end)
	Wait(2000)
	ApplyDefaultClothing()
	SetFacialIdleAnimOverride(PlayerPedId(), "mood_normal_zoom", "FACE_HUMAN@GEN_MALE@BASE")
	ForcePedMotionState(PlayerPedId(), `MotionState_DoNothing`, false, 0, false)
	PrepareCreatorMusic()
	setInteriors(isMale)
	OpenCharCreationMenu(Clothing, false)
	BusyspinnerOff()
	DoScreenFadeIn(3000)
	repeat Wait(0) until IsScreenFadedIn()
end
