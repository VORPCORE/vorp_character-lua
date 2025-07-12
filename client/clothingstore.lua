IsInClothingStore = false
local group       = GetRandomIntInRange(0, 0xffffff)
ShopType          = ""


local GetEntityCoords                  = GetEntityCoords
local DeleteEntity                     = DeleteEntity
local Wait                             = Wait
local UiPromptSetActiveGroupThisFrame  = UiPromptSetActiveGroupThisFrame
local UiPromptHasStandardModeCompleted = UiPromptHasStandardModeCompleted
local VarString                        = VarString

local function CreatePrompt(shopType)
    local str <const> = VarString(10, 'LITERAL_STRING', shopType.label)
    local prompt <const> = UiPromptRegisterBegin()
    UiPromptSetControlAction(prompt, shopType.input)
    UiPromptSetText(prompt, str)
    UiPromptSetEnabled(prompt, true)
    UiPromptSetVisible(prompt, true)
    UiPromptSetStandardMode(prompt, true)
    UiPromptSetGroup(prompt, group, 0)
    UiPromptRegisterEnd(prompt)
    return prompt
end


local function createBlips()
    for _, value in ipairs(ConfigShops.Locations) do
        if value.Blip.Enable then
            local blip <const> = BlipAddForCoords(1664425300, value.Prompt.Position.x, value.Prompt.Position.y, value.Prompt.Position.z)
            if value.Blip.Color then
                BlipAddModifier(blip, joaat(value.Blip.Color))
            end
            SetBlipSprite(blip, value.Blip.Sprite, true)
            SetBlipName(blip, value.Blip.Name)
            value.Blip.Entity = blip
        end
    end
end

local function createModel(model, position, index)
    LoadPlayer(model)
    local npc <const> = CreatePed(model, position.x, position.y, position.z, position.w, false, false, false, false)
    repeat Wait(0) until DoesEntityExist(npc)
    SetRandomOutfitVariation(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedCanBeTargetted(npc, false)
    SetEntityInvincible(npc, true)
    ConfigShops.Locations[index].Npc.Entity = npc
    if ConfigShops.Locations[index].Npc.Scenario then
        TaskStartScenarioInPlaceHash(npc, joaat(ConfigShops.Locations[index].Npc.Scenario), 0, true, 0, 0, false)
    end
    SetTimeout(1000, function()
        FreezeEntityPosition(npc, true)
    end)
end

CreateThread(function()
    if not ConfigShops.UseShops then
        return
    end

    repeat Wait(5000) until LocalPlayer.state.IsInSession
    createBlips()

    while true do
        local sleep = 1000

        if not IsInCharCreation and not IsInClothingStore then
            for index, value in ipairs(ConfigShops.Locations) do
                local coords <const> = GetEntityCoords(PlayerPedId())
                local distance <const> = #(coords - value.Prompt.Position)

                if distance < 100 then
                    if value.Npc.Enable and not value.Npc.Entity then
                        createModel(value.Npc.Model, value.Npc.Position, index)
                    end
                else
                    if value.Npc.Enable and value.Npc.Entity then
                        DeleteEntity(value.Npc.Entity)
                        value.Npc.Entity = nil
                    end
                end

                if distance < 5.0 then
                    for _, prompt in ipairs(value.TypeOfShop) do
                        if not prompt.promptHandle then
                            prompt.promptHandle = CreatePrompt(prompt)
                        end
                    end
                else
                    for _, prompt in ipairs(value.TypeOfShop) do
                        if prompt.promptHandle then
                            UiPromptDelete(prompt.promptHandle)
                            prompt.promptHandle = nil
                        end
                    end
                end

                if distance < 1.5 then
                    sleep = 0

                    local label <const> = VarString(10, 'LITERAL_STRING', value.Prompt.Label)
                    UiPromptSetActiveGroupThisFrame(group, label, 0, 0, 0, 0)
                    for _, prompt in ipairs(value.TypeOfShop) do
                        if UiPromptHasStandardModeCompleted(prompt.promptHandle, 0) then
                            local shopType <const> = prompt.type
                            if shopType == "secondchance" then
                                local result = Core.Callback.TriggerAwait("vorp_character:callback:CanPayForSecondChance")
                                if result then
                                    PrepareClothingStore(value, shopType)
                                end
                            else
                                PrepareClothingStore(value, shopType)
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

-- clean up
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for _, value in ipairs(ConfigShops.Locations) do
        if value.Blip.Entity and DoesBlipExist(value.Blip.Entity) then
            RemoveBlip(value.Blip.Entity)
        end
        if value.Npc.Entity and DoesEntityExist(value.Npc.Entity) then
            DeleteEntity(value.Npc.Entity)
        end
    end
end)


function PrepareClothingStore(value, shopType)
    ShopType = shopType
    DoScreenFadeOut(1000)
    repeat Wait(0) until IsScreenFadedOut()
    Core.instancePlayers(GetPlayerServerId(PlayerId()) + 4440)
    DisplayRadar(false)
    IsInClothingStore = true
    local Gender = IsPedMale(PlayerPedId()) and "male" or "female"
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), value.EditCharacter.Position.x, value.EditCharacter.Position.y, value.EditCharacter.Position.z, true, true, true, false)
    PlaceEntityOnGroundProperly(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), value.EditCharacter.Position.w)
    RegisterGenderPrompt() -- camera prompts register
    CreateThread(function()
        StartPrompts(value.CameraPosition)
    end)
    EnableCharCreationPrompts(true)
    local Clothing = OrganiseClothingData(Gender)
    SetEntityVisible(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)
    RenderScriptCams(true, true, 1000, true, true, 0)
    CreateThread(function()
        if value.DrawLight then
            DrawLight(value.CameraPosition.Position)
        end
    end)
    SetCachedClothingIndex()
    Wait(1000)
    TaskStandStill(PlayerPedId(), -1)
    DoScreenFadeIn(1000)
    LocalPlayer.state:set('PlayerIsInCharacterShops', true, true) -- this can be used in other resources to disable Huds or metabolism scripts apply effects etc
    repeat Wait(0) until IsScreenFadedIn()
    SetTimeout(1000, function()
        FreezeEntityPosition(PlayerPedId(), false)
    end)

    if shopType == "secondchance" then
        OpenCharCreationMenu(Clothing, value)
    elseif shopType == "clothing" then
        local result = Core.Callback.TriggerAwait("vorp_character:callback:GetOutfits")
        if result then
            OpenClothingMenu(Clothing, value, result)
        end
    elseif shopType == "hair" then
        OpenHairMenu(Clothing, value)
    elseif shopType == "makeup" then
        OpenMakeupMenu(Clothing, value)
    elseif shopType == "face" then
        OpenFaceMenu(Clothing, value)
    elseif ShopType == "lifestyle" then
        OpenLifeStyleMenu(Clothing, value)
    end
end
