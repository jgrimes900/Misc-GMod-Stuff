concommand.Add( "remove_held_weapon", function(ply)
	ply:GetActiveWeapon():Remove()
end)