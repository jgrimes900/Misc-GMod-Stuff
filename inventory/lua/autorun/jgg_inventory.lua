
AddCSLuaFile()

JGG = {}
JGG.Inventory = {}
JGG.InventoryUses = {
	item_sodacan = function() 
		local ply = LocalPlayer()
		if (JGG.Inventory.item_sodacan.amount > 0) and (ply:Health() < ply:GetMaxHealth()) then
			ply:SetHealth(ply:Health()+1)
			JGG.Inventory["item_sodacan"].amount = JGG.Inventory["item_sodacan"].amount - 1
			net.Start( "send_inventory_update" )
				net.WriteString("item_sodacan")
				net.WriteTable(JGG.Inventory["item_sodacan"])
				net.SendToServer()
		end
	end,
}

if ( SERVER ) then
	util.AddNetworkString( "send_inventory_update" )
	net.Receive( "send_inventory_update", function( len, ply )
		local id = net.ReadString()
		JGG.Inventory[id] = net.ReadTable()
		file.Write("jgg-inventory.json", util.TableToJSON(JGG.Inventory))
	end )
else
	net.Receive( "send_inventory_update", function( len, ply )
		local id = net.ReadString()
		JGG.Inventory[id] = net.ReadTable()
		file.Write("jgg-inventory.json", util.TableToJSON(JGG.Inventory))
	end )
end

hook.Add( "InitPostEntity", "JGG_Inventory_read", function()
	JGG.Inventory = util.JSONToTable(file.Read( "jgg-inventory.json" ) or "")
	--if not JGG.Inventory then JGG.Inventory = {} end
end )

--gameevent.Listen( "player_disconnect" )
--hook.Add( "player_disconnect", "JGG_Inventory_write", function( data )
--	print(util.TableToJSON(JGG.Inventory))
--	file.Write("jgg-inventory.json", util.TableToJSON(JGG.Inventory))
--end )

function addItem(k,v,i,current,window)
	local item = current:Add( "DPanel" )
	item:SetSize( window:GetWide() - 12, 16+8 )
	item:AlignTop(26*i)
	
	local icon = item:Add( "SpawnIcon" )
	icon:SetModel( v.model )
	icon:SetSize( 16, 16 )
	icon:AlignLeft(4)
	icon:AlignTop(4)
	
	name = item:Add( "DLabel" )
	name:SetPos( 24, 4 )
	name:SetText(v.name)
	name:SetColor( Color( 0, 0, 0) )
	name:SizeToContents()
	
	amount = item:Add( "DLabel" )
	amount:SetText("x"..v.amount)
	amount:SetColor( Color( 0, 0, 0) )
	amount:SizeToContents()
	amount:AlignRight(4)
	amount:AlignTop(4)
	amount.Think = function(self)
		if ("x"..JGG.Inventory[k].amount) ~= self:GetText() then
			amount:SetText("x"..JGG.Inventory[k].amount)
		end
	end
	
	if v.useable and JGG.InventoryUses[k] then
		local use = item:Add( "DButton" )
		use:SetText("Use")
		use:SetSize(24,16)
		use:AlignTop(4)
		use:MoveLeftOf( amount, 4 )
		use.DoClick = JGG.InventoryUses[k]
	end
end

list.Set( "DesktopWindows", "JGG_Inventory", {

	title		= "Inventory",
	icon		= "icon64/coin.png",
	width		= 400,
	height		= 800,
	onewindow	= true,
	init		= function( icon, window )
		
		-- Setup all the regular Context Menu App stuff
		window:SetTitle( "Inventory" )
		window:SetSize( math.min( ScrW() - 16, window:GetWide() ), math.min( ScrH() - 16, window:GetTall() ) )
		window:SetSizable( false )
		window:SetMinWidth( window:GetWide() )
		window:SetMinHeight( window:GetTall() )
		window:Center()
		
		local current = window:Add( "DScrollPanel" )
		current:Dock( FILL )
		
		local i=0
		for k, v in pairs( JGG.Inventory ) do
			addItem(k,v,i,current,window)
			i = i + 1
		end	
		
		-- TODO: I'll figure this out another time
		-- current.Think = function(self)
			-- local keys = {}
			-- for k,_ in pairs(JGG.Inventory) do
				-- table.insert(keys,k)
			-- end
			-- if self:ChildCount() < #keys then
				-- print(self:ChildCount().."|"..#keys)
				-- local childs = {}
				-- for _,v in pairs(self:GetChildren()) do
					-- childs[v:GetChild(1):GetText()] = true
				-- end
				-- local i = self:ChildCount()
				-- for _,v in ipairs(keys) do
					-- if not childs[v] then
						-- addItem(v,JGG.Inventory[v],i,self,window)
						-- i=i+1
					-- end
				-- end
			-- end
		-- end
		
	end
	
} )

hook.Add("PostCleanupMap", "JGG_Inventory_map_hook_cleanup", function()
	if SERVER then
		if (game.GetMap() == "gm_stelliferous") then
			if JGG.Inventory["stelliferous_secret_module"] then
				print(JGG.Inventory["stelliferous_secret_module"].amount)
				for k,v in pairs(ents.FindByName("secret_module_math_1")) do
					print(v)
					v:Fire("Add", JGG.Inventory["stelliferous_secret_module"].amount, 5)
				end
				--ent:Fire("add", 3, 5, Entity(1), Entity(1))
			end
		end
	end
end)

hook.Add( "OnEntityCreated", "JGG_Inventory_spawn_hook", function( ent )
	if SERVER then
		if ( ent:GetClass() == "item_sodacan" ) and ent:IsValid() then
			if JGG.Inventory["item_sodacan"] then
				JGG.Inventory["item_sodacan"].amount = JGG.Inventory["item_sodacan"].amount + 1
			else
				JGG.Inventory["item_sodacan"] = {model="models/can.mdl",name="Soda Can",amount=1,useable=true}
			end
			net.Start( "send_inventory_update" )
				net.WriteString("item_sodacan")
				net.WriteTable(JGG.Inventory["item_sodacan"])
				net.Broadcast()
		end
	end
end )

hook.Add("AcceptInput", "JGG_Inventory_map_hook", function(ent, input, activator, caller, value)
	if (ent:GetName() == "ootcss") then
		if JGG.Inventory["ootcss"] then
			JGG.Inventory["ootcss"].amount = JGG.Inventory["ootcss"].amount + 1
		else
			JGG.Inventory["ootcss"] = {model="models/balloons/balloon_star.mdl",name="One of the Castles Secret Stars!",amount=1}
		end
		net.Start( "send_inventory_update" )
			net.WriteString("ootcss")
			net.WriteTable(JGG.Inventory["ootcss"])
			net.Broadcast()
	end
	if (game.GetMap() == "gm_stelliferous") then
		if (ent:GetName() == "secret_deskkey_prop") then
			if JGG.Inventory["stelliferous_deskkey"] then
				JGG.Inventory["stelliferous_deskkey"].amount = JGG.Inventory["stelliferous_deskkey"].amount + 1
			else
				JGG.Inventory["stelliferous_deskkey"] = {model="models/lostcoast/fisherman/keys.mdl",name="Desk Key (Stelliferous)",amount=1}
			end
			net.Start( "send_inventory_update" )
				net.WriteString("stelliferous_deskkey")
				net.WriteTable(JGG.Inventory["stelliferous_deskkey"])
				net.Broadcast()
		end
		if (string.sub(ent:GetName(), 1, 27) == "secret_module_prop_inactive") then
			if JGG.Inventory["stelliferous_secret_module"] then
				JGG.Inventory["stelliferous_secret_module"].amount = JGG.Inventory["stelliferous_secret_module"].amount + 1
			else
				JGG.Inventory["stelliferous_secret_module"] = {model="models/props/stellif/stellif_module_01.mdl",name="Command Module",amount=1}
			end
			net.Start( "send_inventory_update" )
				net.WriteString("stelliferous_secret_module")
				net.WriteTable(JGG.Inventory["stelliferous_secret_module"])
				net.Broadcast()
		end
		if (string.sub(ent:GetName(), 1, 25) == "secret_module_prop_active") then
			if JGG.Inventory["stelliferous_secret_module"] then
				JGG.Inventory["stelliferous_secret_module"].amount = JGG.Inventory["stelliferous_secret_module"].amount - 1
			end
			net.Start( "send_inventory_update" )
				net.WriteString("stelliferous_secret_module")
				net.WriteTable(JGG.Inventory["stelliferous_secret_module"])
				net.Broadcast()
		end
		if (ent:GetName()== "secret_keycard_prop") then
			if JGG.Inventory["stelliferous_keycard"] then
				JGG.Inventory["stelliferous_keycard"].amount = JGG.Inventory["stelliferous_keycard"].amount + 1
			else
				JGG.Inventory["stelliferous_keycard"] = {model="models/props/stellif/stellif_keycard_1.mdl",name="Keycard (Stelliferous)",amount=1}
			end
			net.Start( "send_inventory_update" )
				net.WriteString("stelliferous_keycard")
				net.WriteTable(JGG.Inventory["stelliferous_keycard"])
				net.Broadcast()
		end
	elseif (game.GetMap() == "gm_everpine_mall") then
		if (ent:GetName() == "@balloonie") then
			if JGG.Inventory["everpine_collectable"] then
				JGG.Inventory["everpine_collectable"].amount = JGG.Inventory["everpine_collectable"].amount + 1
			else
				JGG.Inventory["everpine_collectable"] = {model="models/props_everpine/stores/utility/balloonicorn.mdl",name="Balloonicorn",amount=1}
			end
			net.Start( "send_inventory_update" )
				net.WriteString("everpine_collectable")
				net.WriteTable(JGG.Inventory["everpine_collectable"])
				net.Broadcast()
		end
	end
end)