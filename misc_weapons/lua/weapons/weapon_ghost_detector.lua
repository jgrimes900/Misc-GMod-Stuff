AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Ghost Detector"
SWEP.Category 				= "Ghost Hunting"
SWEP.Purpose 				= "Picks up minor electromagnetic disterbances."

SWEP.Spawnable 				= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 1

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl" 

SWEP.DrawAmmo = false

SWEP.AutoIconAngle = Angle(15, 140, 0)

SWEP.VElements = {
	["light"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "element_name", pos = Vector(1, 0, 1.6), size = { x = 4, y = 4 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["element_name+"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.349, 0.33, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/filecabinet/file2", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 3, 0.5), angle = Angle(-10.5, -134.5, -143.5), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["element_name+"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.5, 0.469, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/filecabinet/file2", skin = 0, bodygroup = {} },
	["light"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(1.5, 0, 3), size = { x = 6, y = 6 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2.5, -1.5), angle = Angle(-165, 25, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Active = false
SWEP.Rendered = true

function SWEP:DetectGhost()
	if (not self.Active) then
		self:DetectGhostStart()
		timer.Simple( 4, function()
			self:DetectGhostEnd()
		end)
	end
end

function SWEP:DetectGhostStart()
	self.VElements["light"]["color"] = Color(255, 0, 0, 255)
	self.WElements["light"]["color"] = Color(255, 0, 0, 255)
	self:EmitSound(Sound("gh/keypadboop01.wav"), 100, 100)
	self.Active = true
end

function SWEP:DetectGhostEnd()
	self.VElements["light"]["color"] = Color(0, 255, 0, 255)
	self.WElements["light"]["color"] = Color(0, 255, 0, 255)
	self.Active = false
end

function SWEP:PreInitialize()

	util.PrecacheSound("gh/keypadboop01.wav")
	
	if SERVER then
		if (game.GetMap() == "gm_ghosthunt_2") or (game.GetMap() == "gm_ghosthunt_3") then
			self:SetName( "detector_physical" )
		end
	end
	
	hook.Add( "do_ghost_detector", self, function()
		if(not self.Rendered)then
			self:DetectGhost()
			self:CallOnClient("DetectGhost")
		end
	end)
	
	hook.Add( "do_ghost_detector_start", self, function()
		if(not self.Rendered) and (not self.Active) then
			self:DetectGhostStart()
			self:CallOnClient("DetectGhostStart")
		end
	end)
	
	hook.Add( "do_ghost_detector_end", self, function()
		if(not self.Rendered) and (self.Active) then
			self:DetectGhostEnd()
			self:CallOnClient("DetectGhostEnd")
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
		self.Owner:SetName(misc_weapons["player_name_override"]["ghost_detector"][game.GetMap()] or "")
	end
	self.Rendered = false
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end