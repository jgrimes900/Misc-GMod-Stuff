
AddCSLuaFile()
misc_weapons = {
	["supported_items"] = {
		["gamemode_ghosthunt"] = {
			["gm_ghostportal"] = {"ghost_radio","ghost_detector","ghost_detector_scale","ghostbox"},
			["gm_ghosthunt"] = {"ghost_radio","ghost_detector"},
			["gm_ghosthunt_2"] = {"ghost_detector","ghost_detector_scale","ghostbox"},
			["gm_ghosthunt_3"] = {"ghost_detector","ghost_detector_scale","ghostbox"}
		}
	},
	["player_name_override"] = {
		["ghost_detector"] = {
			["gm_ghosthunt_2"] = "detector_physical",
			["gm_ghosthunt_3"] = "detector_physical"
		},
		["ghost_detector_scale"] = {
			["gm_ghosthunt_2"] = "detector_physical",
			["gm_ghosthunt_3"] = "detector_physical"
		},
		["ghostbox"] = {
			["gm_ghosthunt_2"] = "detector_physical",
			["gm_ghosthunt_3"] = "detector_physical"
		},
		["ghost_radio"] = {
			["gm_ghosthunt"] = "ghostbox"
		}
	}
}

if game.GetMap() == "gm_ghostportal" then
	util.PrecacheSound("gh/datatransfmalevx01.wav")
	util.PrecacheSound("gh/short_breath_03.wav")
	util.PrecacheSound("ambient/levels/prison/radio_random4.wav")
end

local emf_level = 0
hook.Add( "InitPostEntity", "bullshit_ghosthunt_stuff", function()
	if ((game.GetMap() == "gm_ghosthunt_2") or (game.GetMap() == "gm_ghosthunt_3")) then
		for k,v in ipairs(ents.FindByClass("trigger_*")) do
			if v:GetKeyValues()["filtername"] == "detector_filter" then
				v:AddSpawnFlags(1)
			end
		end
	elseif (game.GetMap() == "gm_ghosthunt") then
		for k,v in ipairs(ents.FindByClass("trigger_*")) do
			if v:GetKeyValues()["filtername"] == "ghostbox_filter" then
				v:AddSpawnFlags(1)
			end
		end
	end
end)

hook.Add("AcceptInput", "ghost_detector_map_hook", function(ent, input, activator, caller, value)
	if (game.GetMap() == "gm_ghostportal") then
		if (ent:GetName() == "keypadbloop") then
			hook.Call("do_ghost_detector")
			hook.Call("do_ghost_detector_scale",nil,math.random( 3 ))
		end
		if (ent:GetName() == "ghostboxsprite02") then
			if (value == "255 0 0") then
				hook.Call("do_ghostbox_start")
				hook.Call("do_ghost_detector_scale_start",nil,math.random( 4, 5 ))
			elseif (value == "0 255 0") then
				hook.Call("do_ghostbox_end")
				hook.Call("do_ghost_detector_scale_end")
			end
		end
		if (ent:GetName() == "radionoise01") and (input == "Volume") then
			if (value == "0") then
				hook.Call("do_ghostradio_off")
			elseif (value == "2") then
				hook.Call("do_ghostradio_on")
			end
		end
		if (ent:GetName() == "radionoise02") then
			if (input == "PlaySound") then
				hook.Call("do_ghostradio_voice",nil,"ambient/levels/prison/radio_random4.wav")
			elseif (input == "StopSound") or ((input == "Volume") and (value == 0)) then
				hook.Call("do_ghostradio_voice_stop",nil,"ambient/levels/prison/radio_random4.wav")
			end
		end
		if (ent:GetName() == "radionoise03") then
			if (input == "PlaySound") then
				hook.Call("do_ghostradio_voice",nil,"gh/static.wav")
			elseif (input == "StopSound") or ((input == "Volume") and (value == 0)) then
				hook.Call("do_ghostradio_voice_stop",nil,"gh/static.wav")
			end
		end
		if (ent:GetName() == "radionoise04") then
			if (input == "PlaySound") then
				hook.Call("do_ghostradio_voice",nil,"gh/datatransfmalevx01.wav")
			elseif (input == "StopSound") or ((input == "Volume") and (value == 0)) then
				hook.Call("do_ghostradio_voice_stop",nil,"gh/datatransfmalevx01.wav")
			end
		end
		if (ent:GetName() == "radionoise05") then
			if (input == "PlaySound") then
				hook.Call("do_ghostradio_voice",nil,"gh/short_breath_03.wav")
			elseif (input == "StopSound") or ((input == "Volume") and (value == 0)) then
				hook.Call("do_ghostradio_voice_stop",nil,"gh/short_breath_03.wav")
			end
		end
	elseif (game.GetMap() == "gm_ghosthunt") then
		if (ent:GetName() == "psy_radar_light") then
			if (value == "255 0 0") then
				hook.Call("do_ghost_detector_start")
			else
				hook.Call("do_ghost_detector_end")
			end
		end
		if (ent:GetName() == "ghostbox_sprite") then
			if (value == "255 0 0") then
				hook.Call("do_ghostradio_off")
			elseif (value == "0 255 0") then
				hook.Call("do_ghostradio_on")
			end
		end
		if (ent:GetName() == "ghostbox_static") then
			hook.Call("do_ghostradio_voice",nil,"ambient/levels/prison/radio_random2.wav")
		end
		if (ent:GetName() == "ghostbox_evp1") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp1_fake.wav")
		end
		if (ent:GetName() == "ghostbox_evp2") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp2_fake.wav")
		end
		if (ent:GetName() == "ghostbox_evp3") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp3_fake.wav")
		end
		if (ent:GetName() == "ghostbox_evp4") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp4_fake.wav")
		end
		if (ent:GetName() == "ghostbox_evp5") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp5_fake.wav")
		end
		if (ent:GetName() == "ghostbox_evp6") then
			hook.Call("do_ghostradio_voice",nil,"gm_ghosthunt/evp6_fake.wav")
		end
	elseif ((game.GetMap() == "gm_ghosthunt_2") or (game.GetMap() == "gm_ghosthunt_3")) then
		print(ent:GetName()	)
		if (ent:GetName() == "detector_sprite1") then
			print(input)
			if (input == "ShowSprite") then
				hook.Call("do_ghost_detector_scale_start",nil,1)
				hook.Call("do_ghost_detector_start")
			else
				hook.Call("do_ghost_detector_scale_end",nil,1)
				hook.Call("do_ghost_detector_end")
			end
		end
		if (ent:GetName() == "detector_sprite2") then
			if (input == "ShowSprite") then
				hook.Call("do_ghost_detector_scale_start",nil,2)
			else
				hook.Call("do_ghost_detector_scale_end",nil,2)
			end
		end
		if (ent:GetName() == "detector_sprite3") then
			if (input == "ShowSprite") then
				hook.Call("do_ghost_detector_scale_start",nil,3)
			else
				hook.Call("do_ghost_detector_scale_end",nil,3)
			end
		end
		if (ent:GetName() == "detector_sprite4") then
			if (input == "ShowSprite") then
				hook.Call("do_ghost_detector_scale_start",nil,4)
				hook.Call("do_ghostbox_start")
			else
				hook.Call("do_ghost_detector_scale_end",nil,4)
				hook.Call("do_ghostbox_end")
			end
		end
		if (ent:GetName() == "detector_sprite5") then
			if (input == "ShowSprite") then
				hook.Call("do_ghost_detector_scale_start",nil,5)
			else
				hook.Call("do_ghost_detector_scale_end",nil,5)
			end
		end
	end
end)


hook.Add("PlayerSpawn", "gamemode_weapon_spawn_hook", function(ply)
	if(gmod.GetGamemode().ThisClass == "gamemode_ghosthunt") and (misc_weapons["supported_items"]["gamemode_ghosthunt"][game.GetMap()]) and (ply:Team() == 1)then
		timer.Simple( 0, function()
			for _,v in ipairs(misc_weapons["supported_items"]["gamemode_ghosthunt"][game.GetMap()]) do
				ply:Give( "weapon_" .. v )
			end
		end)
	end
end)


