local TrackedEnts = {
	[ "weapon_crowbar_hl1" ] = true,
	[ "weapon_glock_hl1" ] = true,
	[ "weapon_crossbow_hl1" ] = true,
	[ "weapon_handgrenade" ] = true,
	[ "weapon_mp5_hl1" ] = true,
	[ "weapon_shotgun_hl1" ] = true,
	
	[ "weapon_hl1_crowbar" ] = true,
	[ "weapon_hl1_glock" ] = true,
	[ "weapon_hl1_crossbow" ] = true,
	[ "weapon_hl1_handgrenade" ] = true,
	[ "weapon_hl1_mp5" ] = true,
	[ "weapon_hl1_shotgun" ] = true
}

local EntList = {}

hook.Add( "OnEntityCreated", "replace_hl1_wep", function( ent )
	if ( not ent:IsValid() or not TrackedEnts[ ent:GetClass() ] ) then return end
	
	if (ent:GetClass() == "weapon_crowbar_hl1" or ent:GetClass() == "weapon_hl1_crowbar") then
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_crowbar" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	elseif (ent:GetClass() == "weapon_glock_hl1" or ent:GetClass() == "weapon_hl1_glock") then
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_glock" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	elseif (ent:GetClass() == "weapon_crossbow_hl1" or ent:GetClass() == "weapon_hl1_crossbow") then
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_crossbow" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	elseif (ent:GetClass() == "weapon_handgrenade" or ent:GetClass() == "weapon_hl1_handgrenade") then
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_frag" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	elseif (ent:GetClass() == "weapon_mp5_hl1" or ent:GetClass() == "weapon_hl1_mp5") then
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_mp5" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	else
		timer.Simple( 0.1, function() 
			local wep = ents.Create( "arc9_hl1_spas12" )
			wep:SetPos( ent:GetPos() )
			wep:Spawn()
			ent:Remove()
		end )
	end
	
end )

local playerTable = {}

hook.Add( "DoPlayerDeath", "keep_wep", function( ply, _, __ )
	playerTable[ply:SteamID()] = {}
	local j = 1
	playerTable[ply:SteamID()]["weapons"]={}
	for i,v in ipairs(ply:GetWeapons()) do
		playerTable[ply:SteamID()]["weapons"][j] = v:GetClass()
		j=j+1
	end
	playerTable[ply:SteamID()]["ammo"] = ply:GetAmmo()
	print("OnDeath./n",table.ToString(playerTable, "playerTable", true))
end )

hook.Add( "PlayerLoadout", "keep_wep_give", function( ply )
	print("OnLoadout./n",table.ToString(playerTable, "playerTable", true))
	print(ply:SteamID())
	if ( playerTable[ply:SteamID()] ~= nil ) then
		for i,v in ipairs(playerTable[ply:SteamID()]["weapons"]) do
			ply:Give( v, true )
		end
		for i,v in pairs(playerTable[ply:SteamID()]["ammo"]) do
			ply:GiveAmmo( v, i, true )
		end
		playerTable[ply:SteamID()] = nil
		return true
	end
	print("Player has no stored loadout")
end )