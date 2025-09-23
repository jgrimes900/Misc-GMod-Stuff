AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "EMF Detector"
SWEP.Category 				= "Ghost Hunting"
SWEP.Purpose 				= "Picks up a range of electromagnetic disterbances."

SWEP.Spawnable 				= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 2

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/phas/eqp_emf_reader.mdl"
SWEP.ShowWorldModelAsItem = true

SWEP.DrawAmmo = false

SWEP.AutoIconAngle = Angle(15, 140, 0)

SWEP.VElements = {
	["model"] = { type = "Model", model = "models/phas/eqp_emf_reader.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 3, -0.301), angle = Angle(132.078, -29.222, 78.311), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["emf1"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "model", pos = Vector(-4.1, 1.2, 1.1), size = { x = 1, y = 1 }, color = Color(110, 174, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["emf2"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "model", pos = Vector(-4.2, 0.6, 1.1), size = { x = 1, y = 1 }, color = Color(126, 255, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["emf3"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "model", pos = Vector(-4.25, 0, 1.1), size = { x = 1, y = 1 }, color = Color(255, 255, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["emf4"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "model", pos = Vector(-4.2, -0.601, 1.1), size = { x = 1, y = 1 }, color = Color(255, 169, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["emf5"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "model", pos = Vector(-4.1, -1.201, 1.1), size = { x = 1, y = 1 }, color = Color(255, 91, 70, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true}
}
SWEP.WElements = {
	["model"] = { type = "Model", model = "models/phas/eqp_emf_reader.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2.596, -3), angle = Angle(120, 0, 0), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["emf1"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "model", pos = Vector(-4.1, 1.2, 1.299), size = { x = 2, y = 2 }, color = Color(110, 174, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["emf2"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "model", pos = Vector(-4.2, 0.6, 1.299), size = { x = 2, y = 2 }, color = Color(126, 255, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["emf3"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "model", pos = Vector(-4.25, 0, 1.299), size = { x = 2, y = 2 }, color = Color(255, 255, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["emf4"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "model", pos = Vector(-4.2, -0.601, 1.299), size = { x = 2, y = 2 }, color = Color(255, 169, 105, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["emf5"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "model", pos = Vector(-4.1, -1.201, 1.299), size = { x = 2, y = 2 }, color = Color(255, 91, 70, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.Active = false
SWEP.Rendered = true
SWEP.DetectLevel = 0

function SWEP:DetectGhost(level, length)
	length = length or 4
	if isstring(level) then
		tbl = string.Split(level,":")
		level = tonumber(tbl[1])
		length = tonumber(tbl[2])
	end
	if (not self.Active) then
		self:DetectGhostStart(level)
		timer.Simple( length, function()
			self:DetectGhostEnd()
		end)
	end
end

function SWEP:DetectGhostStart(level)
	if isstring(level) then level = tonumber(level) end
	if self.DetectLevel ~= level then
		for i=1, level, 1 do
			self.VElements["emf"..i]["color"] = ColorAlpha( self.VElements["emf"..i]["color"], 255 )
			self.WElements["emf"..i]["color"] = ColorAlpha( self.VElements["emf"..i]["color"], 255 )
		end
		self:EmitSound(Sound("gh/keypadboop01.wav"), 100, (level*25)+50)
		self.DetectLevel = level
		self.Active = true
	end
end

function SWEP:DetectGhostEnd(level)
	if isstring(level) then level = tonumber(level) end
	level = level or 1
	for i=5, level, -1 do
		self.VElements["emf"..i]["color"] = ColorAlpha( self.VElements["emf"..i]["color"], 0 )
		self.WElements["emf"..i]["color"] = ColorAlpha( self.VElements["emf"..i]["color"], 0 )
	end
	self.DetectLevel = level-1
	if self.DetectLevel == 0 then
		self.Active = false
	end
end

function SWEP:PreInitialize()

	util.PrecacheSound("gh/keypadboop01.wav")
	
	hook.Add( "do_ghost_detector_scale", self, function(_, level, length)
		if(not self.Rendered)then
			self:DetectGhost(level, length or 4)
			self:CallOnClient("DetectGhost",tostring(level)..":"..tostring(length or 4))
		end
	end)
	
	hook.Add( "do_ghost_detector_scale_start", self, function(_, level)
		if(not self.Rendered)then
			self:DetectGhostStart(level)
			self:CallOnClient("DetectGhostStart",tostring(level))
		end
	end)
	
	hook.Add( "do_ghost_detector_scale_end", self, function(_, level)
		if(not self.Rendered)then
			self:DetectGhostEnd(level or 1)
			self:CallOnClient("DetectGhostEnd", tostring(level or 1))
		end
	end)

end

function SWEP:PostHolster()
	if SERVER then
		self.Owner:SetName("")
	end
	self.Rendered = true
end

function SWEP:PostDeploy()
	if SERVER then
		self.Owner:SetName(misc_weapons["player_name_override"]["ghost_detector_scale"][game.GetMap()] or "")
	end
	self.Rendered = false
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end