AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Soda"

SWEP.Spawnable 				= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 1

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/props_junk/PopCan01a.mdl"
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
}
SWEP.VElements = {
	["model"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -127.403, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["model"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(-25, -127.403, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Skins = {
	["Default"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -127.403, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(-25, -127.403, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["Kobold Kare"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/props_kk/sodacan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -66.624, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/props_kk/sodacan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(3.506, -5.844, -153.118), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["CSS"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/props_junk/garbage_sodacan01b_fullsheet.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -66.624, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/props_junk/garbage_sodacan01b_fullsheet.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(3.506, -5.844, -153.118), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["HL1"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/can.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.5, 1.5, 0), angle = Angle(90, -66.624, 180), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 5, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/can.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.5, 1.5, -1), angle = Angle(94.675, 106.363, 17.531), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 5, bodygroup = {} }
		}
	},
	["Coca-Cola"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/foodnhouseholditems/sodacan01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -66.624, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/foodnhouseholditems/sodacan01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(3.506, -5.844, -153.118), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["Pepsi"] = {
		["ViewModelBoneMods"] = {
			["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -55) }
		},
		["VElements"] = {
			["model"] = { type = "Model", model = "models/foodnhouseholditems/sodacan04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 2.5, 0), angle = Angle(0, -66.624, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["model"] = { type = "Model", model = "models/foodnhouseholditems/sodacan04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.099, 2.5, -1), angle = Angle(3.506, -5.844, -153.118), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	}
}

SWEP.DrawAmmo = false


function SWEP:HandleSkins()
	if IsValid(self.Owner) then
		local var = GetConVar( "sodacan_skin" )
		local set_skin = var:GetString()
		if (set_skin=="Kobold Kare") then
			self.Skin = "Kobold Kare"
		elseif (set_skin=="CSS") then
			if(css_achevments) then
				if ((css_achevments[self.Owner:SteamID64()]["WIN_MAP_CS_OFFICE"] == 1) or (not is_hub)) then
					self.Skin = "CSS"
				else
					spawnlock.CantDoThat_Skin(self.Owner,"Office Map Veteran","Counter-Strike: Source",set_skin)
				end
			else
				self.Skin = "CSS"
			end
		elseif (set_skin=="HL1") then
			self.Skin = "HL1"
		elseif (set_skin=="Coca-Cola") then
			self.Skin = "Coca-Cola"
		elseif (set_skin=="Pepsi") then
			self.Skin = "Pepsi"
		else
			self.Skin = "Default"
		end
	end
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end