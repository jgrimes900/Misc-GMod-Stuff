AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Screwdriver"
SWEP.Spawnable 				= true
SWEP.Slot 					= 0
SWEP.SlotPos 				= 3

SWEP.HoldType = "knife"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.VElements = {
	["Screwdriver"] = { type = "Model", model = "models/tech_crategibs.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(0, -0.5, 3), angle = Angle(-24.546, -180, -94.676), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[0] = 7} }
}
SWEP.WElements = {
	["Screwdriver"] = { type = "Model", model = "models/tech_crategibs.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.799, -1.5), angle = Angle(24.545, 180, 94.675), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[0] = 7} }
}

SWEP.Primary.Delay			= 0.5
SWEP.Primary.Damage			= 25
SWEP.Primary.ActivateDelay	= 0.3
SWEP.Primary.Automatic 		= true
SWEP.Primary.Anim			= ACT_VM_SECONDARYATTACK

SWEP.Melee					= true

function SWEP:PostDeploy()
	if SERVER then
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	end
end

function SWEP:PlayWeaponSound( id )
	if id == "swing" then
		self.Weapon:EmitSound( Sound( "weapons/cbar_miss1.wav" ), 100, math.random(80,110) )
	elseif (id == "hit_mat_"..MAT_ANTLION) or (id == "hit_mat_"..MAT_BLOODYFLESH) or (id == "hit_mat_"..MAT_FLESH) or (id == "hit_mat_"..MAT_ALIENFLESH) then
		self.Weapon:EmitSound( Sound( "hornet/ag_hornethit"..math.random(1,3)..".wav" ),100,math.random(90,110) )
	elseif string.sub(id,1,8) == "hit_mat_" then
		self.Weapon:EmitSound( Sound( "weapons/xbow_hit1.wav" ),100,math.random(90,110) )
	end
end

