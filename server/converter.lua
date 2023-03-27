--[[ local ClotheComponents = {
    "Gunbelt",
    "Mask",
    "Holster",
    "Loadouts",
    "Coat",
    "Cloak",
    "EyeWear",
    "Bracelet",
    "Skirt",
    "Poncho",
    "Spats",
    "NeckTies",
    "Spurs",
    "Pant",
    "Suspender",
    "Glove",
    "Satchels",
    "GunbeltAccs",
    "CoatClosed",
    "Buckle",
    "RingRh",
    "Belt",
    "Accessories",
    "Shirt",
    "Gauntlets",
    "Chap",
    "NeckWear",
    "Boots",
    "Vest",
    "RingLh",
    "Hat",
    "Apron",
    "Dress",
    "Badge",
    "Armor",
    "bow",
    "Teeth"
} ]]
--RegisterNetEvent("vorp:SelectedCharacter", function(source, character)
--    local charid = character.charIdentifier
--    local steamid = character.identifier
--    local comps = json.decode(character.comps)
--    local hasNewComponents = false
--    local newComps = {}
--
--    for key, value in pairs(comps) do
--        if ClotheComponents[key] then
--            newComps[ClotheComponents[key]] = value
--        else
--            newComps[ClotheComponents[key]] = -1
--            hasNewComponents = true -- if true then needs update
--        end
--    end
--
--    -- will only update if theres missing component names
--    if next(newComps) and hasNewComponents then
--        print("Player Comps updated")
--        local parameters = { ['identifier'] = steamid,['charidentifier'] = charid,['compPlayer'] = json.encode(newComps) }
--        exports.oxmysql:execute(
--            "UPDATE characters SET compPlayer = @compPlayer WHERE identifier = @identifier AND charidentifier = @charidentifier",
--            parameters)
--    end
--
--    -- * Outfits for clothing stores
--    local newOutfits = {}
--    exports.oxmysql:execute('SELECT * FROM outfits WHERE charidentifier = ?', { charid }, function(result)
--        for i = 1, #result do
--            local comps_outfits = json.decode(result[i].comps)
--            local hasNewComponents1 = false
--            for key, comp in ipairs(comps_outfits) do
--                if ClotheComponents[comp] then
--                    if ClotheComponents[comp] then
--                        newOutifts[comp] = comp
--                    else
--                        newOutifts[comp] = -1
--                        hasNewComponents1 = true -- if true then needs update
--                    end
--                end
--            end
--
--            if next(newOutfits) and hasNewComponents1 then
--                local parameters = { ['identifier'] = steamid,['charidentifier'] = charid,['comps'] = json.encode(comps) }
--                exports.oxmysql:execute(
--                    "UPDATE outfits SET comps = @comps WHERE identifier = @identifier AND charidentifier = @charidentifier",
--                    parameters)
--            end
--        end
--    end)
--end)
