AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Shotgun"
SWEP.Category 				= "Shadows of Doubt"
SWEP.Spawnable 				= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 1

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID( "weapons/sod_icon-gun" )
end

SWEP.HoldType = "shotgun"
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/sod/shotgun.mdl"
SWEP.ShowWorldModelAsItem = true
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/sod/shotgun.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(1.5, 1.5, -10), angle = Angle(90, -90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/weapons/sod/shotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 1.5, -2.5), angle = Angle(-6, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.ClipSize 		= 2
SWEP.Primary.Ammo 			= "Buckshot"
SWEP.Primary.DefaultClip 	= 2  
SWEP.Primary.Automatic 		= false
SWEP.Primary.BulletData		= {5, 5, 0.05}

function SWEP:PlayWeaponSound( id )
	if id == "fire" then
		self:EmitSound( "weapons/shotgun/shotgun_fire"..math.random(6,7)..".wav")
	elseif id == "reload" then
		self:EmitSound( "weapons/shotgun/shotgun_reload"..math.random(1,3)..".wav")
	end
end