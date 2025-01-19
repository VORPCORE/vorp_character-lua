local function toggleComp(hash, item, key)
	IsPedReadyToRender()
	if IsMetaPedUsingComponent(hash) then
		RemoveTagFromMetaPed(hash)
		UpdatePedVariation()
		SetResourceKvp(tostring(item.comp), "true")
		TriggerEvent("vorp_character:Client:OnClothingRemoved", key, item.comp)
	else
		ApplyShopItemToPed(item.comp)
		UpdatePedVariation()
		if item.drawable then
			SetMetaPedTag(PlayerPedId(), item.drawable, item.albedo, item.normal, item.material, item.palette, item.tint0, item.tint1, item.tint2)
		end
		SetResourceKvp(tostring(item.comp), "false")
		TriggerEvent("vorp_character:Client:OnClothingAdded", key, item.comp)
	end
	UpdatePedVariation()
end

CreateThread(function()
	for key, v in pairs(Config.commands) do
		RegisterCommand(v.command, function()
			toggleComp(Config.HashList[key], CachedComponents[key], key)
			if key == "GunBelt" then
				toggleComp(Config.HashList.Holster, CachedComponents.Holster, key)
			end

			if key == "Vest" and IsMetaPedUsingComponent(Config.HashList.Shirt) then
				local item = CachedComponents.Shirt
				if item.drawable then
					SetTextureOutfitTints(PlayerPedId(), 'shirts_full', item)
				end
			end

			if key == "Coat" then
				if IsMetaPedUsingComponent(Config.HashList.Vest) then
					local item = CachedComponents.Vest
					if item.drawable then
						SetTextureOutfitTints(PlayerPedId(), 'vests', item)
					end
				end

				if IsMetaPedUsingComponent(Config.HashList.Shirt) then
					local item = CachedComponents.Shirt
					if item.drawable then
						SetTextureOutfitTints(PlayerPedId(), 'shirts_full', item)
					end
				end
			end
		end, false)
	end
end)

RegisterCommand("ringsL", function()
	if CachedComponents.RingLh.comp ~= -1 then
		return
	end
	toggleComp(0x7A6BBD0B, CachedComponents.RingLh, "RingLh")
end, false)

RegisterCommand("ringsR", function()
	if CachedComponents.RingRh.comp ~= -1 then
		return
	end
	toggleComp(0xF16A1D23, CachedComponents.RingRh, "RingRh")
end, false)

RegisterCommand("undress", function()
	if not next(CachedComponents) then
		return
	end
	IsPedReadyToRender()
	for Category, Components in pairs(CachedComponents) do
		if Components.comp ~= -1 then
			if IsMetaPedUsingComponent(Config.HashList[Category]) then
				RemoveTagFromMetaPed(Config.HashList[Category])
			end
		end
	end
	UpdatePedVariation()
end, false)

RegisterCommand("dress", function()
	if not next(CachedComponents) then
		return
	end
	IsPedReadyToRender()
	for _, Components in pairs(CachedComponents) do
		if Components.comp ~= -1 then
			ApplyShopItemToPed(Components.comp)
			UpdatePedVariation()
			if Components.drawable then
				SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material, Components.palette, Components.tint0, Components.tint1, Components.tint2)
			end
			UpdatePedVariation()
		end
	end
end, false)


local bandanaOn = true
RegisterCommand('bandanaon', function(source, args, rawCommand)
	local player = PlayerPedId()
	local Components = CachedComponents.NeckWear
	local shirtComponents = CachedComponents.Shirt

	if Components.comp == -1 then return end
	bandanaOn = not bandanaOn

	if not bandanaOn then
		ApplyShopItemToPed(Components.comp)
		StartTaskItemInteraction(player, 0, joaat("BANDANA_ON_RIGHT_HAND"), 1, 0, -1.0)
		Wait(750)
		UpdateShopItemWearableState(Components.comp, -1829635046)
		if Components.drawable and Components.tint0 > 0 and Components.tint1 > 0 and Components.tint2 > 0 then
			SetTextureOutfitTints(PlayerPedId(), 94259016, Components)
		end

		UpdatePedVariation()
		LocalPlayer.state:set("IsBandanaOn", true, true)
		if shirtComponents.drawable and shirtComponents.tint0 > 0 and shirtComponents.tint1 > 0 and shirtComponents.tint2 > 0 then
			SetTextureOutfitTints(PlayerPedId(), 'shirts_full', shirtComponents)
		end
	else
		StartTaskItemInteraction(player, 0, joaat("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1.0)
		Wait(750)
		UpdateShopItemWearableState(Components.comp, joaat("base"))
		if Components.drawable and Components.tint0 > 0 and Components.tint1 > 0 and Components.tint2 > 0 then
			SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material, Components.palette, Components.tint0, Components.tint1, Components.tint2)
		end

		UpdatePedVariation()
		LocalPlayer.state:set("IsBandanaOn", false, true)
		if shirtComponents.drawable and shirtComponents.tint0 > 0 and shirtComponents.tint1 > 0 and shirtComponents.tint2 > 0 then
			SetTextureOutfitTints(PlayerPedId(), 'shirts_full', shirtComponents)
		end
	end
end, false)


local sleeves = true
RegisterCommand("sleeves", function(source, args)
	local Components = CachedComponents.Shirt
	if Components.comp == -1 then return end

	sleeves = not sleeves
	local wearableState = sleeves and joaat("base") or joaat("Closed_Collar_Rolled_Sleeve")
	UpdateShopItemWearableState(Components.comp, wearableState)

	if not sleeves and Components.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', Components)
	end

	if sleeves and Components.drawable then
		SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material,
			Components.palette, Components.tint0, Components.tint1, Components.tint2)
	end

	local value = not sleeves and "false" or "true"
	SetResourceKvp("sleeves", value)
	UpdatePedVariation()
end, false)

local collar = true
RegisterCommand("sleeves2", function(source, args)
	local Components = CachedComponents.Shirt
	if Components.comp == -1 then return end

	collar = not collar
	local wearableState = collar and joaat("base") or joaat("open_collar_rolled_sleeve")
	UpdateShopItemWearableState(Components.comp, wearableState)

	if not collar and Components.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'shirts_full', Components)
	end

	if collar and Components.drawable then
		SetMetaPedTag(PlayerPedId(), Components.drawable, Components.albedo, Components.normal, Components.material,
			Components.palette, Components.tint0, Components.tint1, Components.tint2)
	end

	local value = not collar and "false" or "true"
	SetResourceKvp("collar", value)
	UpdatePedVariation()
end, false)

local tuck = true
RegisterCommand("tuck", function(source, args)
	local ComponentB = CachedComponents.Boots
	if ComponentB.comp == -1 then return end
	local ComponentP = CachedComponents.Pant

	tuck = not tuck
	local wearableState = tuck and joaat("base") or -2081918609
	UpdateShopItemWearableState(ComponentB.comp, wearableState)

	if not tuck and ComponentP.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'pants', ComponentP)
	end
	if not tuck and ComponentB.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'boots', ComponentB)
	end


	if tuck and ComponentB.drawable then
		SetTextureOutfitTints(PlayerPedId(), 'pants', ComponentP)
	end

	local value = not tuck and "false" or "true"
	SetResourceKvp("tuck", value)
	UpdatePedVariation()
end, false)

function ApplyRolledClothingStatus()
	local value = GetResourceKvpString("sleeves")
	local value2 = GetResourceKvpString("collar")
	local value3 = GetResourceKvpString("tuck")
	if value == "true" then
		sleeves = false
		ExecuteCommand("sleeves")
	else
		sleeves = true
		ExecuteCommand("sleeves")
	end

	if value2 == "true" then
		collar = false
		ExecuteCommand("sleeves2")
	else
		collar = true
		ExecuteCommand("sleeves2")
	end

	if value3 == "true" then
		tuck = false
		ExecuteCommand("tuck")
	else
		tuck = true
		ExecuteCommand("tuck")
	end
end

RegisterCommand(Config.ReloadCharCommand, function(source, args, rawCommand)
	local __player = PlayerPedId()
	local hogtied = Citizen.InvokeNative(0x3AA24CCC0D451379, __player)
	local cuffed = Citizen.InvokeNative(0x74E559B3BC910685, __player)
	local dead = IsEntityDead(__player)

	if not Config.CanRunReload() then
		return
	end

	if not hogtied and not cuffed and not dead then
		if not next(CachedSkin) and not next(CachedComponents) then
			return
		end

		if args[1] ~= "" then
			Custom = args[1]
		end
		LocalPlayer.state:set("IsBandanaOn", false, true)
		LoadPlayerComponents(__player, CachedSkin, CachedComponents, false)
	end
end, false)
