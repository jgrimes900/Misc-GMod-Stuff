AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Zot-Gun"

SWEP.Spawnable 				= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 3

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/jgg/w_zotgun.mdl"
SWEP.ShowWorldModelAsItem = true
SWEP.VElements = {
	--["End"] = { type = "Model", model = "models/props/hr_massive/survival_loudspeaker/survival_loudspeaker.mdl", bone = "ValveBiped.Bip01", rel = "Handle", pos = Vector(2.5, 0, 3.599), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	--["Handle"] = { type = "Model", model = "models/tsbb/subnautica/pathfinder.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.5, 1.299, -4.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["Handle"] = { type = "Model", model = "models/weapons/jgg/w_zotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.5, 1.299, -4.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}
SWEP.WElements = {
	--["End"] = { type = "Model", model = "models/props/hr_massive/survival_loudspeaker/survival_loudspeaker.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(2.5, 0, 3.5), angle = Angle(15, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	--["Handle"] = { type = "Model", model = "models/tsbb/subnautica/pathfinder.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2, -3.6), angle = Angle(0, -15, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["Handle"] = { type = "Model", model = "models/weapons/jgg/w_zotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2, -3.6), angle = Angle(0, -15, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.ClipSize 		= 15
SWEP.Primary.Ammo 			= "Uranium"
SWEP.Primary.DefaultClip 	= 15  
SWEP.Primary.Automatic 		= true
SWEP.Primary.Delay			= 0.05

function SWEP:PlayWeaponSound( id )
	if id == "fire" then
		self:EmitSound( "weapons/shotgun/shotgun_fire"..math.random(6,7)..".wav")
	elseif id == "reload" then
		self:EmitSound( "weapons/shotgun/shotgun_reload"..math.random(1,3)..".wav")
	end
end