IsInClothingStore = false
local PromptGroup <const> = GetRandomIntInRange(0, 0xffffff)
local SelectPrompt
ShopType = ""

CreateThread(function()
    local str = VarString(10, 'LITERAL_STRING', T.Inputs.press)
    SelectPrompt = UiPromptRegisterBegin()
    UiPromptSetControlAction(SelectPrompt, 0xC7B5340A)
    UiPromptSetText(SelectPrompt, str)
    UiPromptSetEnabled(SelectPrompt, true)
    UiPromptSetVisible(SelectPrompt, true)
    UiPromptSetStandardMode(SelectPrompt, true)
    UiPromptSetGroup(SelectPrompt, PromptGroup, 0)
    UiPromptRegisterEnd(SelectPrompt)
end)

function CreateBlips()
    for _, value in ipairs(ConfigShops.Locations) do
        if value.Blip.Enable then
            local blip = BlipAddForCoords(1664425300, value.Prompt.Position.x, value.Prompt.Position.y, value.Prompt.Position.z)
            if value.Blip.Color then
                BlipAddModifier(blip, joaat(value.Blip.Color))
            end
            SetBlipSprite(blip, value.Blip.Sprite, true)
            SetBlipName(blip, value.Blip.Name)
            value.Blip.Entity = blip
        end
    end
end

function CreateModel(model, position, index)
    LoadPlayer(model)
    local npc = CreatePed(model, position.x, position.y, position.z, position.w, false, false, false, false)
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

    repeat Wait(2000) until LocalPlayer.state.IsInSession

    CreateBlips()

    while true do
        local sleep = 1000

        if not IsInCharCreation and not IsInClothingStore then
            for index, value in ipairs(ConfigShops.Locations) do
                local coords = GetEntityCoords(PlayerPedId())
                local dist = #(coords - value.Prompt.Position)

                if dist < 100 then
                    if value.Npc.Enable and not value.Npc.Entity then
                        CreateModel(value.Npc.Model, value.Npc.Position, index)
                    end
                else
                    if value.Npc.Enable and value.Npc.Entity then
                        DeleteEntity(value.Npc.Entity)
                        value.Npc.Entity = nil
                    end
                end

                if dist < 1.5 then
                    sleep = 0
                    local label = VarString(10, 'LITERAL_STRING', value.Prompt.Label)
                    UiPromptSetActiveGroupThisFrame(PromptGroup, label, 0, 0, 0, 0)
                    if UiPromptHasStandardModeCompleted(SelectPrompt, 0) then
                        if value.TypeOfShop == "secondchance" then
                            local result = Core.Callback.TriggerAwait("vorp_character:callback:CanPayForSecondChance")
                            if result then
                                PrepareClothingStore(value)
                            end
                        else
                            PrepareClothingStore(value)
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
    for index, value in ipairs(ConfigShops.Locations) do
        if value.Blip.Entity then
            RemoveBlip(value.Blip.Entity)
        end
        if value.Npc.Entity then
            DeleteEntity(value.Npc.Entity)
        end
    end
end)


function PrepareClothingStore(value)
    DoScreenFadeOut(0)
    repeat Wait(0) until IsScreenFadedOut()
    ShopType = value.TypeOfShop
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
    if value.TypeOfShop == "secondchance" then
        OpenCharCreationMenu(Clothing, value)
    elseif value.TypeOfShop == "clothing" then
        local result = Core.Callback.TriggerAwait("vorp_character:callback:GetOutfits")
        if result then
            OpenClothingMenu(Clothing, value, result)
        end
    elseif value.TypeOfShop == "hair" then
        OpenHairMenu(Clothing, value)
    elseif value.TypeOfShop == "makeup" then
        OpenMakeupMenu(Clothing, value)
    elseif value.TypeOfShop == "face" then
        OpenFaceMenu(Clothing, value)
    elseif ShopType == "lifestyle" then
        OpenLifeStyleMenu(Clothing, value)
    end
end
