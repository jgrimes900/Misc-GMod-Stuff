AddCSLuaFile()

portal1_achevments = {}
css_achevments = {}
spawnlock = {}

spawnlock["CantDoThat"] = function(ply, achievment, game)
	ply:SendLua('notification.AddLegacy("You need to achieve \\"'..achievment..'\\" in '..game..' to do that", NOTIFY_ERROR, 4);surface.PlaySound("buttons/button10.wav")')
end
spawnlock["CantDoThat_Skin"] = function(ply, achievment, game, skin)
	notification.AddLegacy("You need to achieve \""..achievment.."\" in "..game.." to use \""..skin.."\" skin", NOTIFY_ERROR, 4)
	surface.PlaySound("buttons/button10.wav")
end

CreateConVar( "sv_spawnlock_hub", "0", FCVAR_CHEAT )

gameevent.Listen( "player_activate" )
hook.Add("player_activate", "get_achevments_for_player", function( data )
	timer.Simple( 0.5, function()
		id64 = Player( data.userid ):SteamID64()
		portal1_achevments[id64] = {}
		http.Fetch( "http://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/?appid=400&key=5E91B443F7BF56CFAB699B9B77865009&steamid=" .. id64, function(body,code,headers)
			local achevment_data = util.JSONToTable( body )
			if (achevment_data["playerstats"]["success"]) then
				for _,v in ipairs(achevment_data["playerstats"]["achievements"]) do
					portal1_achevments[tostring(achevment_data["playerstats"]["steamID"])][v["apiname"]] = v["achieved"]
				end
			end
		end, function( reason )
			print("no data : "..reason)
		end)
		css_achevments[id64] = {}
		http.Fetch( "http://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/?appid=240&key=5E91B443F7BF56CFAB699B9B77865009&steamid=" .. id64, function(body,code,headers)
			local achevment_data = util.JSONToTable( body )
			if(achevment_data["playerstats"]["success"]) then
				for _,v in ipairs(achevment_data["playerstats"]["achievements"]) do
					css_achevments[tostring(achevment_data["playerstats"]["steamID"])][v["apiname"]] = v["achieved"]
				end
			end
		end, function( reason )
			print("no data : "..reason)
		end)
	end)
end)


hook.Add("PlayerSpawnProp", "limit_by_achevments", function( ply, model )
	if GetConVar( "sv_spawnlock_hub" ):GetBool() then return true end
	if portal1_achevments[ply:SteamID64()] == {} then
		print("they dont exsist")
		return true
	end
	if ( model == "models/props/metal_box.mdl" and portal1_achevments[ply:SteamID64()]["PORTAL_LONGJUMP"] == 0 ) then
		spawnlock.CantDoThat(ply,"Long Jump","Portal")
		return false
	end
	if ( model == "models/props/radio_reference.mdl" and portal1_achevments[ply:SteamID64()]["PORTAL_TRANSMISSION_RECEIVED"] == 0 ) then
		spawnlock.CantDoThat(ply,"Transmission Received","Portal")
		return false
	end
	if ( model == "models/props/sphere.mdl" and portal1_achevments[ply:SteamID64()]["PORTAL_INFINITEFALL"] == 0 ) then
		spawnlock.CantDoThat(ply,"Terminal Velocity","Portal")
		return false
	end
	return true
end)

hook.Add( "AddToolMenuCategories", "CustomCategory", function()
	spawnmenu.AddToolCategory( "Utilities", "Skins", "#Skins" )
end )

if CLIENT then
	CreateClientConVar("ghost_radio_skin", "Default", true, false)
	CreateClientConVar("sodacan_skin", "Default", true, false)
end

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Utilities", "Skins", "Weapon Skins", "#Weapon Skins", "", "", function( panel )
		panel:ClearControls()
		
		local AppList = vgui.Create( "DListView", f )
		AppList:Dock( FILL )
		AppList:SetHeight(AppList:GetDataHeight()*16+AppList:GetHeaderHeight())
		AppList:SetMultiSelect( false )
		AppList:AddColumn( "Weapon" )
		AppList:AddColumn( "Skin" )

		AppList:AddLine( "ghost_radio", "Default" )
		AppList:AddLine( "ghost_radio", "Portal" )
		AppList:AddLine( "ghost_radio", "CSS" )
		AppList:AddLine( "sodacan", "Default" )
		AppList:AddLine( "sodacan", "CSS" )
		AppList:AddLine( "sodacan", "Kobold Kare" )
		AppList:AddLine( "sodacan", "Coca-Cola" )
		AppList:AddLine( "sodacan", "Pepsi" )

		AppList.OnRowSelected = function( lst, index, pnl )
			if CLIENT then
				local var = GetConVar( pnl:GetColumnText( 1 ).."_skin" )
				var:SetString( pnl:GetColumnText( 2 ) )
			end
		end
		
		panel:AddItem(AppList)
		-- Add stuff here
	end )
end )