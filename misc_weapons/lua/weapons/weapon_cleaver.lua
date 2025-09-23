AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Cleaver"
SWEP.Spawnable 				= true
SWEP.Slot 					= 0
SWEP.SlotPos 				= 4

SWEP.HoldType = "melee"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/jgg/w_cleaver.mdl"
SWEP.ShowWorldModelAsItem = true
SWEP.VElements = {
	["model"] = { type = "Model", model = "models/props_lab/Cleaver.mdl", bone = "v_weapon.Knife_Handle", rel = "", pos = Vector(0, 0, 1.5), angle = Angle(-90, 0, -90), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["model"] = { type = "Model", model = "models/props_lab/Cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -0.5), angle = Angle(90, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Delay			= 0.5
SWEP.Primary.Damage			= 35
SWEP.Primary.ActivateDelay	= 0.2
SWEP.Primary.Automatic 		= true
SWEP.Primary.Anim			= ACT_VM_PRIMARYATTACK

SWEP.Melee					= true

function SWEP:PostDeploy()
	if SERVER then
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	end
end

function SWEP:PlayWeaponSound( id )
	if id == "swing" then
		self.Weapon:EmitSound( Sound( "weapons/cbar_miss1.wav" ), 100, math.random(70,100) )
	elseif (id == "hit_mat_"..MAT_ANTLION) or (id == "hit_mat_"..MAT_BLOODYFLESH) or (id == "hit_mat_"..MAT_FLESH) or (id == "hit_mat_"..MAT_ALIENFLESH) then
		self.Weapon:EmitSound( Sound( "hornet/ag_hornethit"..math.random(1,3)..".wav" ),100,math.random(90,110) )
	elseif string.sub(id,1,8) == "hit_mat_" then
		self.Weapon:EmitSound( Sound( "weapons/xbow_hit1.wav" ),100,math.random(90,110) )
	end
end
