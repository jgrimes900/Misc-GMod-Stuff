AddCSLuaFile()

SWEP.Base					= "weapon_jgg_base"
SWEP.PrintName 				= "Barnacle Fly" -- Maybe should be renamed. I'm not sure if I like this name.
SWEP.Spawnable 				= true
SWEP.Slot 					= 5 -- Slot 6 for tools
SWEP.SlotPos 				= 3

-- HoldType, VeiwModel and WorldModel are just placeholders.
SWEP.HoldType = "knife"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ShowViewModel = true -- This doesn't work properly, needs to be fixed in the base
SWEP.ShowWorldModel = true

SWEP.Primary.Delay			= 1.0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Anim			= ACT_VM_SECONDARYATTACK

SWEP.Melee					= true  -- Kind of pointless, but might be useful metadata for other scripts

function SWEP:PostDeploy()
	if SERVER then
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	end
end

-- Primary attack spawns a barnacle above the player, waits 0.5 seconds for the player to get grabbed, then removes the barnacle. This triggers a bug in monseter_barnacle where it will grab the player and let them fly around.
-- I know I could just set the player's movetype to fly, but this way is more fun.
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local pos = self.Owner:GetPos() + Vector(0, 0, 150)
    local ent = ents.Create("monster_barnacle")
    ent:SetPos(pos)
    ent:Spawn()
    ent:Activate()
    timer.Simple(0.5, function()
        if IsValid(ent) then
            self:OnBarnicleGrabPly(ent)
        end
    end)
end

-- Secondary attack sets the player's movetype back to walk if they are currently flying. This only half fixes the gliched state, as the player still can't be grabbed by npc_barnacle again until they respawn. monster_barnacle works fine, though.
function SWEP:SecondaryAttack()
    if(self.Owner:GetMoveType() == MOVETYPE_FLY)then
        self.Owner:SetMoveType(MOVETYPE_WALK)
    end
end

-- This should honestly be merged into SWEP:PrimaryAttack()
function SWEP:OnBarnicleGrabPly(ent)
    if SERVER then
        ent:Remove()
    end
end