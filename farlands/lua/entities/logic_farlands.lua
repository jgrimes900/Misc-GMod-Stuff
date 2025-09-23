AddCSLuaFile()

ENT.Type				= "point"
ENT.Base				= "base_gmodentity"

function ENT:KeyValue( key, value )
	
	if string.sub(key,1,4):lower() != "str_" then return end
	
	if(tonumber(string.sub(value, 1,3)) > 99)then
		self.Entity:SetNWInt( "tilesx", (self.Entity:GetNWInt( "tilesx" ) or 0) + 1 )
		self.Entity:SetNWInt( "tilex" .. self.Entity:GetNWInt( "tilesx" ) .. "_y", tonumber(string.sub(value, 5,7)) )
		
		self:StoreOutput("OnTilex" .. self.Entity:GetNWInt( "tilesx" ), key .. ",ForceSpawn")
		self:StoreOutput("OnCleanupTilex" .. self.Entity:GetNWInt( "tilesx" ), key .. "_cleanup,Trigger")
	elseif(tonumber(string.sub(value, 5,7)) > 99)then
		self.Entity:SetNWInt( "tilesy", (self.Entity:GetNWInt( "tilesy" ) or 0) + 1 )
		self.Entity:SetNWInt( "tiley" .. self.Entity:GetNWInt( "tilesy" ) .. "_x", tonumber(string.sub(value, 1,3)) )
		
		self:StoreOutput("OnTiley" .. self.Entity:GetNWInt( "tilesy" ), key .. ",ForceSpawn")
		self:StoreOutput("OnCleanupTiley" .. self.Entity:GetNWInt( "tilesy" ), key .. "_cleanup,Trigger")
	else
	
		self.Entity:SetNWInt( "tiles", (self.Entity:GetNWInt( "tiles" ) or 0) + 1 )
	
		self.Entity:SetNWInt( "tile" .. self.Entity:GetNWInt( "tiles" ) .. "_x", tonumber(string.sub(value, 1,3)) )
		self.Entity:SetNWInt( "tile" .. self.Entity:GetNWInt( "tiles" ) .. "_y", tonumber(string.sub(value, 5,7)) )
	
		self:StoreOutput("OnTile" .. self.Entity:GetNWInt( "tiles" ), key .. ",ForceSpawn")
		self:StoreOutput("OnCleanupTile" .. self.Entity:GetNWInt( "tiles" ), key .. "_cleanup,Trigger")
	
	end
end

function ENT:AcceptInput( inputName, activator, caller, data )
	if inputName:lower() == "east" then self.Entity:SetNWInt( "x", (self.Entity:GetNWInt( "x" ) or 0) + 1 )
	elseif inputName:lower() == "west" then self.Entity:SetNWInt( "x", (self.Entity:GetNWInt( "x" ) or 0) - 1 )
	elseif inputName:lower() == "north" then self.Entity:SetNWInt( "y", (self.Entity:GetNWInt( "y" ) or 0) + 1 )
	elseif inputName:lower() == "south" then self.Entity:SetNWInt( "y", (self.Entity:GetNWInt( "y" ) or 0) - 1 )
	elseif inputName:lower() == "init" then self.Entity:SetNWInt( "x", 0 ); self.Entity:SetNWInt( "y", 0 )
	else return end
	self.Entity:SearchTiles( inputName, activator, caller, data )
end

function ENT:SearchTiles( inputName, activator, caller, data )
	local lasttile = (self.Entity:GetNWInt( "LastTile" ) or 0)
	if not (lasttile == 0) then self:TriggerOutput("OnCleanupTile" .. lasttile, activator) end
	
	local x = self.Entity:GetNWInt( "x" ) or 0
	local y = self.Entity:GetNWInt( "y" ) or 0
	
	print("X:"..x.." | Y:"..y)
	
	self.Entity:Tilesx( inputName, activator, caller, data, y )
	self.Entity:Tilesy( inputName, activator, caller, data, x )
	
	for i = 1, self.Entity:GetNWInt( "tiles" ), 1 do
		if ( self.Entity:GetNWInt( "tile" .. i .. "_x" ) == x ) then
			if ( self.Entity:GetNWInt( "tile" .. i .. "_y" ) == y ) then
				self.Entity:SetNWInt( "LastTile", i )
				self:TriggerOutput("OnTile" .. i, activator)
				return
			end
		end
	end
	
	self.Entity:SetNWInt( "LastTile", 0 )
	
end

function ENT:Tilesx( inputName, activator, caller, data, y )
	
	local lasttilex1 = (self.Entity:GetNWInt( "LastTilex1" ) or 0)
	local lasttilex2 = (self.Entity:GetNWInt( "LastTilex2" ) or 0)
	if((lasttilex1 != 0) && (lasttilex2 != y))then self:TriggerOutput("OnCleanupTilex" .. lasttilex1, activator) end
	
	for i = 1, self.Entity:GetNWInt( "tilesx" ), 1 do
		if ( self.Entity:GetNWInt( "tilex" .. i .. "_y" ) == y ) then
			self.Entity:SetNWInt( "LastTilex1", i )
			self.Entity:SetNWInt( "LastTilex2", y )
			self:TriggerOutput("OnTilex" .. i, activator)
			return
		end
	end
	
	self.Entity:SetNWInt( "LastTilex1", 0 )
	self.Entity:SetNWInt( "LastTilex2", 0 )
	
end

function ENT:Tilesy( inputName, activator, caller, data, x )
	
	local lasttiley1 = (self.Entity:GetNWInt( "LastTiley1" ) or 0)
	local lasttiley2 = (self.Entity:GetNWInt( "LastTiley2" ) or 0)
	if((lasttiley1 != 0) && (lasttiley2 != x))then self:TriggerOutput("OnCleanupTiley" .. lasttiley1, activator) end
	
	if(lasttiley2 == x)then return end
	
	for i = 1, self.Entity:GetNWInt( "tilesy" ), 1 do
		if ( self.Entity:GetNWInt( "tiley" .. i .. "_x" ) == x ) then
			self.Entity:SetNWInt( "LastTiley1", i )
			self.Entity:SetNWInt( "LastTiley2", x )
			self:TriggerOutput("OnTiley" .. i, activator)
			return
		end
	end
	
	self.Entity:SetNWInt( "LastTiley1", 0 )
	self.Entity:SetNWInt( "LastTiley2", 0 )
	
end