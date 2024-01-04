--LOAD COMPS
function ApplyComponentToPed(ped, comp)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, comp, false, true, true)
    Citizen.InvokeNative(0x66b957aac2eaaeab, ped, comp, 0, 0, 1, 1) -- _UPDATE_SHOP_ITEM_WEARABLE_STATE
    Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
    UpdateVariation(ped)
end

function UpdateVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    IsPedReadyToRender()
end

function IsPedReadyToRender()
    Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId())
    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId()) do
        Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, PlayerPedId())
        Wait(0)
    end
end

---Remove all meta tags from ped
---@param ped number ped id
function RemoveMetaTags(ped)
    for _, tag in pairs(Config.HashList) do
        Citizen.InvokeNative(0xD710A5007C2AC539, ped, tag, 0)
        UpdateVariation(ped)
    end
end

--- set to all white if values are 0
---@param gender string ped gender
---@param skin table skin data
---@return table skin data
function SetDefaultSkin(gender, skin)
    local __data = {}
    for _, value in pairs(Config.DefaultChar[gender]) do
        for key, _ in pairs(value) do
            if key == "HeadTexture" then
                local headtext = joaat(value.HeadTexture[1])
                if headtext == skin.albedo then
                    __data = value
                    break
                end
            end
        end
    end

    if skin.HeadType == 0 then
        skin.HeadType = tonumber("0x" .. __data.Heads[1])
    end

    if skin.BodyType == 0 then
        skin.BodyType = tonumber("0x" .. __data.Body[1])
    end

    if skin.LegsType == 0 then
        skin.LegsType = tonumber("0x" .. __data.Legs[1])
    end

    if skin.Torso == 0 or nil then
        skin.Torso = tonumber("0x" .. __data.Body[1])
    end

    return skin
end

--CREATOR
function RemoveImaps()
    if IsImapActive(183712523) then
        RequestImap(183712523)
    end

    if IsImapActive(-1699673416) then
        RemoveImap(-1699673416)
    end

    if IsImapActive(1679934574) then
        RemoveImap(1679934574)
    end
end

function RequestImapCreator()
    if not IsImapActive(183712523) then
        RequestImap(183712523)
    end
    if not IsImapActive(-1699673416) then
        RequestImap(-1699673416)
    end
    if not IsImapActive(1679934574) then
        RequestImap(1679934574)
    end
end

function LoadPlayer(sex)
    if not HasModelLoaded(sex) then
        RequestModel(sex, false)
        repeat Wait(0) until HasModelLoaded(sex)
    end
end

function DeleteNpc(pedHandler)
    if pedHandler then
        while DoesEntityExist(pedHandler) do
            DeleteEntity(pedHandler)
            Wait(0)
        end
    end
end

TableHair = {}
function GetHair(gender, category)
    TableHair = {}
    for key, value in pairs(HairComponents[gender][category]) do
        for k, v in pairs(value) do
            if not TableHair[key] then
                TableHair[key] = {}
            end
            if TableHair[key] then
                TableHair[key][k] = v.hash
            end
        end
    end
end

function GetGender()
    if not IsPedMale(PlayerPedId()) then
        return "Female"
    end

    return "Male"
end

local textureId = -1
function toggleOverlayChange(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk,
                             palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var,
                             opacity, albedo)
    for k, v in pairs(Config.overlay_all_layers) do
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
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    if tx_id ~= 0 then
                        v.tx_id = Config.overlays_info[name][1].id
                    end
                else
                    v.var = 0
                    if tx_id ~= 0 then
                        v.tx_id = Config.overlays_info[name][tx_id].id
                    end
                end
                v.opacity = opacity
            end
        end
    end

    local ped = PlayerPedId()
    local gender = GetGender()
    local current_texture_settings = Config.texture_types[gender]

    if textureId ~= -1 then
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId)
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId)
    end

    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, current_texture_settings.normal,
        current_texture_settings.material)

    for k, v in pairs(Config.overlay_all_layers) do
        if v.visibility ~= 0 then
            local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal,
                v.tx_material, v.tx_color_type, v.tx_opacity, v.tx_unk)
            if v.tx_color_type == 0 then
                Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette)
                Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary,
                    v.palette_color_secondary, v.palette_color_tertiary)
            end

            Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var);
            Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity);
        end
    end

    while not Citizen.InvokeNative(0x31DC8D3F216D8509, textureId) do
        Citizen.Wait(0)
    end

    Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId)
    Citizen.InvokeNative(0x0B46E25761519058, ped, joaat("heads"), textureId)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

local function CreatePedAtCoords(model, coords)
    RequestModel(model, false)
    repeat Wait(0) until HasModelLoaded(model)
    local handle = CreatePed(model, coords.x, coords.y, coords.z, 0.0, false, false, false, false)
    repeat Wait(0) until DoesEntityExist(handle)
    SetModelAsNoLongerNeeded(model)
    return handle
end

function SetupAnimscene()
    local Male_MP = CreatePedAtCoords(`MP_MALE`, vector4(0.0, 0.0, 0.0, 0.0))
    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, Male_MP, 3, true)
    local Female_MP = CreatePedAtCoords(`MP_FEMALE`, vector4(0.0, 0.0, 0.0, 0.0))
    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, Female_MP, 3, true)

    local Sheriff = CreatePedAtCoords(`MP_U_M_O_BlWPoliceChief_01`, vector4(0.0, 0.0, 0.0, 0.0))
    Citizen.InvokeNative(0x283978A15512B2FE, Sheriff, true)
    AddEntityToAudioMixGroup(Sheriff, "rdro_character_creator_guard_group", 0.0)
    SetPedConfigFlag(Sheriff, 130, true)
    SetPedConfigFlag(Sheriff, 301, true)
    SetPedConfigFlag(Sheriff, 315, true)
    FreezeEntityPosition(Sheriff, true)

    local Deputy = CreatePedAtCoords(`CS_MP_MARSHALL_DAVIES`, vector4(0.0, 0.0, 0.0, 0.0))
    Citizen.InvokeNative(0x283978A15512B2FE, Deputy, true)
    AddEntityToAudioMixGroup(Deputy, "rdro_character_creator_guard_group", 0.0)
    SetPedConfigFlag(Deputy, 130, true)
    SetPedConfigFlag(Deputy, 301, true)
    SetPedConfigFlag(Deputy, 315, true)
    GiveWeaponToPed_2(Deputy, `WEAPON_REPEATER_CARBINE`, 100, true, false, 0, false, 0.5, 1.0, 752097756, false, 0.0, false)
    FreezeEntityPosition(Deputy, true)

    local animscene = CreateAnimScene("script@mp@character_creator@transitions", 0.25, "pl_intro", false, true)
    SetAnimSceneEntity(animscene, "Male_MP", Male_MP, 0)
    SetAnimSceneEntity(animscene, "Female_MP", Female_MP, 0)
    SetAnimSceneEntity(animscene, "Sheriff", Sheriff, 0)
    SetAnimSceneEntity(animscene, "Deputy", Deputy, 0)

    return animscene, { Male_MP, Female_MP, Sheriff, Deputy }
end

function SetupScenes(string)
    local animscene = CreateAnimScene("script@mp@character_creator@transitions", 0.25, string, false, true)
    SetAnimSceneEntity(animscene, GetGender() .. "_MP", PlayerPedId(), 0)
    LoadAnimScene(animscene)
    while not Citizen.InvokeNative(0x477122B8D05E7968, animscene) do
        Citizen.Wait(0)
    end
    return animscene
end

Config.Intro = {
    views = {
        {
            pos = vector3(-561.47, -3775.67, 239.16),
            rot = vector3(-9.35, 0.0, -90.05),
            fov = 35.0,
            focus = 4.0
        },
        {
            pos = vector3(-561.51, -3776.89, 239.15),
            rot = vector3(-9.65, 0.0, -90.33),
            fov = 35.0,
            focus = 4.0
        }
    }
}

-- players can find their mugh shots in their rockstars account
function TakePhoto()
    N_0x3c8f74e8fe751614()
    Citizen.InvokeNative(0xD45547D8396F002A)
    Citizen.InvokeNative(0xA15BFFC0A01B34E1)
    Citizen.InvokeNative(0xFA91736933AB3D93, true)
    Citizen.InvokeNative(0x8B3296278328B5EB, 2)
    Citizen.InvokeNative(0x2705D18C11B61046, false)
    Citizen.InvokeNative(0xD1031B83AC093BC7, "SetRegionPhotoTakenStat") -- I guess need create_var_string
    Citizen.InvokeNative(0x9937FACBBF267244, "SetDistrictPhotoTakenStat")
    Citizen.InvokeNative(0x8952E857696B8A79, "SetStatePhotoTakenStat")
    Citizen.InvokeNative(0x57639FD876B68A91, 0)
end

function DrawText3D(x, y, z, text, color)
    local r, g, b, a = 255, 255, 255, 255
    if color then
        r, g, b, a = table.unpack(color)
    end
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.4, 0.4)
        SetTextFontForCurrentCommand(25) -- font style
        SetTextColor(r, g, b, a)
        SetTextCentre(1)
        DisplayText(str, _x, _y)
        local factor = (string.len(text)) / 100 -- draw sprite size
        DrawSprite("feeds", "toast_bg", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 0, 0, 0, 200, false)
    end
end

function ShowBusyspinnerWithText(text)
    N_0x7f78cd75cc4539e4(CreateVarString(10, "LITERAL_STRING", text))
end

function GetName(Result)
    local splitString = {}
    for i in string.gmatch(Result, "%S+") do
        splitString[#splitString + 1] = i
    end

    if #splitString < 2 then
        return false
    end

    for _, word in ipairs(Config.BannedNames) do
        if string.find(splitString[1], word) or string.find(splitString[2], word) then
            return nil
        end
    end

    return splitString[1], splitString[2]
end
