AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Radio"
SWEP.Category 				= "Ghost Hunting"
SWEP.Purpose 				= "Always playing on a certain frequency."

SWEP.Spawnable 				= true

SWEP.Slot 					= 3
SWEP.SlotPos 				= 1

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/weapons/w_medkit.mdl"

SWEP.Active = false

SWEP.AutoIconAngle = Angle(-90, 0, -90)
SWEP.ViewModelBoneMods = {
	["medkit_bone"] = { scale = Vector(1, 1, 1), pos = Vector(0, 6.48, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["radio"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "medkit_bone", rel = "", pos = Vector(1.557, 4.675, -3.636), angle = Angle(90, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["radio"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.518, 8.831, 3.635), angle = Angle(-162.469, 15.194, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Skins = {
	["Default"] = {
		["ViewModelBoneMods"] = {
			["medkit_bone"] = { scale = Vector(1, 1, 1), pos = Vector(0, 6.48, 0), angle = Angle(0, 0, 0) }
		},
		["VElements"] = {
			["radio"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "medkit_bone", rel = "", pos = Vector(1.557, 4.675, -3.636), angle = Angle(90, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["radio"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.518, 8.831, 3.635), angle = Angle(-162.469, 15.194, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["Portal"] = {
		["ViewModelBoneMods"] = {
			["medkit_bone"] = { scale = Vector(1, 1, 1), pos = Vector(0, 3, 1), angle = Angle(0, 0, 0) }
		},
		["VElements"] = {
			["element_name"] = { type = "Model", model = "models/props/radio_reference.mdl", bone = "medkit_bone", rel = "", pos = Vector(0.5, 3, -0.5), angle = Angle(90, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["element_name"] = { type = "Model", model = "models/props/radio_reference.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 5.714, 1.557), angle = Angle(180, 24.545, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	},
	["CSS"] = {
		["ViewModelBoneMods"] = {
			["medkit_bone"] = { scale = Vector(1, 1, 1), pos = Vector(1.899, 3.099, 1), angle = Angle(0, 0, 0) }
		},
		["VElements"] = {
			["radio"] = { type = "Model", model = "models/props/cs_office/radio.mdl", bone = "medkit_bone", rel = "", pos = Vector(0.5, 3.5, -0.5), angle = Angle(-90, 90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		},
		["WElements"] = {
			["radio"] = { type = "Model", model = "models/props/cs_office/radio.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 7.791, 2.599), angle = Angle(-157.793, 30, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
	}
}

function SWEP:DetectGhost()
	if (not self.Active) then
		self:DetectGhostStart()
		self:RadioVoice("gh/static.wav")
		timer.Simple( 15, function()
			self:DetectGhostEnd()
		end)
	end
end

function SWEP:DetectGhostStart()
	if (not self.Active) then
		self:StopSound( "music/mirame_radio_thru_wall.wav" )
		self.Active = true
	end
end

function SWEP:DetectGhostEnd()
	self:EmitSound("music/mirame_radio_thru_wall.wav",nil,nil, 0.1)
	self.Active = false
end

function SWEP:RadioVoice(path)
	self:EmitSound(Sound(path), 100, 100)
end

function SWEP:RadioVoiceEnd(path)
	self:StopSound(Sound(path))
end

function SWEP:PreInitialize()

	util.PrecacheSound("gh/radio_beep_01.wav")
	util.PrecacheSound("gh/ghostbox_beep_01.wav")
	util.PrecacheSound("gh/static.wav")
	
	hook.Add( "do_ghostradio", self, function()
		if(not self.Rendered)then
			self:DetectGhost()
			self:CallOnClient("DetectGhost")
		end
	end)
	
	hook.Add( "do_ghostradio_off", self, function()
		if(not self.Rendered)then
			self:DetectGhostStart()
			self:CallOnClient("DetectGhostStart")
		end
	end)
	
	hook.Add( "do_ghostradio_on", self, function()
		if(not self.Rendered)then
			self:DetectGhostEnd()
			self:CallOnClient("DetectGhostEnd")
		end
	end)
	
	hook.Add( "do_ghostradio_voice", self, function(_,Sound)
		if(not self.Rendered)then
			self:RadioVoice(Sound)
			self:CallOnClient("RadioVoice",Sound)
		end
	end)
	
	hook.Add( "do_ghostradio_voice_stop", self, function(_,Sound)
		if(not self.Rendered)then
			self:RadioVoiceEnd(Sound)
			self:CallOnClient("RadioVoiceEnd",Sound)
		end
	end)
	
end

function SWEP:HandleSkins()
	local is_hub = GetConVar( "sv_spawnlock_hub" ):GetBool()
	if IsValid(self.Owner) then
		local var = GetConVar( "ghost_radio_skin" )
		local set_skin = var:GetString()
		if (set_skin=="Portal") then
			if ((portal1_achevments[self.Owner:SteamID64()]["PORTAL_TRANSMISSION_RECEIVED"] == 1) or (not is_hub)) then
				self.Skin = "Portal"
			else
				spawnlock.CantDoThat_Skin(self.Owner,"Transmission Received","Portal",set_skin)
			end
		elseif (set_skin=="CSS") then
			if ((css_achevments[self.Owner:SteamID64()]["WIN_MAP_CS_OFFICE"] == 1) or (not is_hub)) then
				self.Skin = "CSS"
			else
				spawnlock.CantDoThat_Skin(self.Owner,"Office Map Veteran","Counter-Strike: Source",set_skin)
			end
		else
			self.Skin = "Default"
		end
	end
end

function SWEP:PostHolster()
	if SERVER then
		self:StopSound( "music/mirame_radio_thru_wall.wav" )
		self.Rendered = true
		self.Owner:SetName("")
	end
	self.Rendered = true
	if self.dinosaur and self.Active then
		self:RadioVoiceEnd(self.dinosaur)
		self:DetectGhostEnd()
	end
end

function SWEP:PostDeploy()
	if SERVER then
		timer.Simple( 0, function()
			self:EmitSound("music/mirame_radio_thru_wall.wav",nil,nil, 0.1)
		end)
		self.Rendered = false
		self.Owner:SetName(misc_weapons["player_name_override"]["ghost_radio"][game.GetMap()] or "")
	end
end


function SWEP:Think()
	if (string.sub(game.GetMap(), 1, 11) == "testchmb_a_") or (string.sub(game.GetMap(), 1, 8) == "escape_0") then
		if game.GetMap() == "testchmb_a_00" then
			if (self.Owner:GetPos():DistToSqr( Vector(-511, -928, 207) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur1.wav")
					self.dinosaur = "ambient/dinosaur1.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(-996, -257, 640) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur2.wav")
					self.dinosaur = "ambient/dinosaur2.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_01" then
			if (self.Owner:GetPos():DistToSqr( Vector(96, 160, -51) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur3.wav")
					self.dinosaur = "ambient/dinosaur3.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(-663, 632, 921) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur4.wav")
					self.dinosaur = "ambient/dinosaur4.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_02" then
			if (self.Owner:GetPos():DistToSqr( Vector(-828, 192, 64) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur5.wav")
					self.dinosaur = "ambient/dinosaur5.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(962, 833, 512) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur6.wav")
					self.dinosaur = "ambient/dinosaur6.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_03" then
			if (self.Owner:GetPos():DistToSqr( Vector(322, 2, -81) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur7.wav")
					self.dinosaur = "ambient/dinosaur7.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(-479, 226, 1280) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur8.wav")
					self.dinosaur = "ambient/dinosaur8.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_04" then
			if (self.Owner:GetPos():DistToSqr( Vector(-641, 127, 64) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur9.wav")
					self.dinosaur = "ambient/dinosaur9.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_05" then
			if (self.Owner:GetPos():DistToSqr( Vector(64, 655, 28) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur10.wav")
					self.dinosaur = "ambient/dinosaur10.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_06" then
			if (self.Owner:GetPos():DistToSqr( Vector(674, 162, 314) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur11.wav")
					self.dinosaur = "ambient/dinosaur11.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_07" then
			if (self.Owner:GetPos():DistToSqr( Vector(-192, -382, 226) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur12.wav")
					self.dinosaur = "ambient/dinosaur12.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(223, -609, 1344) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur13.wav")
					self.dinosaur = "ambient/dinosaur13.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_08" then
			if (self.Owner:GetPos():DistToSqr( Vector(-540, 129, 192) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur14.wav")
					self.dinosaur = "ambient/dinosaur14.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_09" then
			if (self.Owner:GetPos():DistToSqr( Vector(383, 1792, 64) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur15.wav")
					self.dinosaur = "ambient/dinosaur15.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_10" then
			if (self.Owner:GetPos():DistToSqr( Vector(-1856, -2945, -302) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur16.wav")
					self.dinosaur = "ambient/dinosaur16.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(-205, 1210, 65) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur17.wav")
					self.dinosaur = "ambient/dinosaur17.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_11" then
			if (self.Owner:GetPos():DistToSqr( Vector(-506, 709, 64) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur18.wav")
					self.dinosaur = "ambient/dinosaur18.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_13" then
			if (self.Owner:GetPos():DistToSqr( Vector(1505, -192, 0) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur19.wav")
					self.dinosaur = "ambient/dinosaur19.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_14" then
			if (self.Owner:GetPos():DistToSqr( Vector(75, 162, 954) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur20.wav")
					self.dinosaur = "ambient/dinosaur20.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(2624, 894, 960) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur21.wav")
					self.dinosaur = "ambient/dinosaur21.wav"
				end
			elseif (self.Owner:GetPos():DistToSqr( Vector(-1158, -384, 3392) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur22.wav")
					self.dinosaur = "ambient/dinosaur22.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "testchmb_a_15" then
			if (self.Owner:GetPos():DistToSqr( Vector(787, 366, 832) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur23.wav")
					self.dinosaur = "ambient/dinosaur23.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "escape_00" then
			if (self.Owner:GetPos():DistToSqr( Vector(781, 435, -255) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur24.wav")
					self.dinosaur = "ambient/dinosaur24.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "escape_01" then
			if (self.Owner:GetPos():DistToSqr( Vector(-727, 1442, -467) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur25.wav")
					self.dinosaur = "ambient/dinosaur25.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		elseif game.GetMap() == "escape_02" then
			if (self.Owner:GetPos():DistToSqr( Vector(4220, 637, 64) ) <= 100^2) then
				if not self.Active then
					self:DetectGhostStart()
					self:RadioVoice("ambient/dinosaur26.wav")
					self.dinosaur = "ambient/dinosaur26.wav"
				end
			elseif self.Active then
				self:RadioVoiceEnd(self.dinosaur)
				self:DetectGhostEnd()
			end
		end
	end
end


function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end
