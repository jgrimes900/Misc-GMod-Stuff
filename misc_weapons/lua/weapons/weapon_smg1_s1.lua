AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "SMG1 s1"
SWEP.Category 				= "Half-Life 2"
SWEP.Spawnable 				= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 1

SWEP.ViewModelFOV = 50

if CLIENT then
--	SWEP.WepSelectIcon = surface.GetTextureID( "weapons/sod_icon-gun" )
end

SWEP.HoldType = "smg"
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1_s1.mdl"
SWEP.ShowWorldModelAsItem = true
SWEP.VElements = {
	["Stupid Gun"] = { type = "Model", model = "models/weapons/w_smg1_s1.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(-0.7, 0, 3.5), angle = Angle(90, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["Stupid Gun"] = { type = "Model", model = "models/weapons/w_smg1_s1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0, -3.701), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.ClipSize 		= 50
SWEP.Primary.Ammo 			= "SMG1"
SWEP.Primary.DefaultClip 	= 50  
SWEP.Primary.Automatic 		= true
SWEP.Primary.BulletData		= {3, 3, 0.05}
SWEP.Primary.Delay			= 0.075

function SWEP:PlayWeaponSound( id )
	if id == "fire" then
		self:EmitSound( "weapons/smg1/smg1_fire1.wav")
	elseif id == "reload" then
		self:EmitSound( "weapons/smg1/smg1_reload.wav")
	end
end