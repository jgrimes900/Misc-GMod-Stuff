AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Ghostbox"
SWEP.Category 				= "Ghost Hunting"
SWEP.Purpose 				= "Picks up more threatning ghosts."

SWEP.Spawnable 				= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 3

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/props_lab/reciever01d.mdl"
SWEP.ShowWorldModelAsItem = true

SWEP.AutoIconAngle = Angle(10, 105, 10)
SWEP.ViewModelBoneMods = {
	["medkit_bone"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -35) },
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-35, 0, 0) }
}

SWEP.VElements = {
	["light"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "element_name", pos = Vector(5.5, -1, -0.301), size = { x = 2, y = 2 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["element_name"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "medkit_bone", rel = "", pos = Vector(-0.201, -0.519, 0), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["light"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(6.5, -1, -0.5), size = { x = 6, y = 6 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["element_name"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.5, 6.5, 0), angle = Angle(-113.377, -143.767, -5.844), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.Rendered = true
SWEP.Active = false

function SWEP:DetectGhost()
	if (not self.Active) then
		self:DetectGhostStart()
		timer.Simple( 3.5, function()
			self:DetectGhostEnd()
		end)
	end
end

function SWEP:DetectGhostStart()
	if (not self.Active) then
		self.VElements["light"]["color"] = Color(255, 0, 0, 255)
		self.WElements["light"]["color"] = Color(255, 0, 0, 255)
		self:EmitSound(Sound("gh/radio_beep_01.wav"), 100, 100)
		self.Active = true
		timer.Simple( 0.5, function()
			timer.Create( "ghostbox"..self.Owner:SteamID(), 1, 0, function()
				if(not self.Rendered)then
					self:PlayWarning()
					self:CallOnClient("PlayWarning")
				end
			end)
		end)
	end
end

function SWEP:DetectGhostEnd()
	self.VElements["light"]["color"] = Color(0, 255, 0, 255)
	self.WElements["light"]["color"] = Color(0, 255, 0, 255)
	self.Active = false
	timer.Remove("ghostbox"..self.Owner:SteamID())
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end

function SWEP:PreInitialize()

	util.PrecacheSound("gh/radio_beep_01.wav")
	util.PrecacheSound("gh/ghostbox_beep_01.wav")
	
	if SERVER then
		if (game.GetMap() == "gm_ghosthunt_2") or (game.GetMap() == "gm_ghosthunt_3") then
			self:SetName( "detector_physical" )
		end
	end
	
	hook.Add( "do_ghostbox", self, function()
		if(not self.Rendered)then
			self:DetectGhost()
			self:CallOnClient("DetectGhost")
		end
	end)
	
	hook.Add( "do_ghostbox_start", self, function()
		if(not self.Rendered)then
			self:DetectGhostStart()
			self:CallOnClient("DetectGhostStart")
		end
	end)
	
	hook.Add( "do_ghostbox_end", self, function()
		if(not self.Rendered)then
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
		self.Owner:SetName(misc_weapons["player_name_override"]["ghostbox"][game.GetMap()] or "")
	end
	self.Rendered = false
end

function SWEP:OnRemove()
	timer.Remove("ghostbox"..self.Owner:SteamID())
	self:Holster()
end