-- This could be maybe used for scars or stigmas - would be a good punishment for thieves imo

local M = {
	PlayerDescriptionsDE = nil,
	PlayerDescriptionsEN = nil,
	Init = nil
}

function M.AddPlayerDescription(id, textde, texten)
	table.insert(M.PlayerDescriptionsDE[id], textde);
	table.insert(M.PlayerDescriptionsEN[id], texten);
end

function M.InitPlayerDesc()

	if(M.Init == nil) then
		
		M.PlayerDescriptionsDE = {{}};
		M.PlayerDescriptionsEN = {{}};
		
		--AddPlayerDescription(PlayerID, TextDE, TextEN);
	
		M.Init = 1;
	end
end

return M
