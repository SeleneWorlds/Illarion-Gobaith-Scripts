-- INSERT INTO triggerfields VALUES (60,55,101,'triggerfield.noobia_door');
-- INSERT INTO triggerfields VALUES (61,55,101,'triggerfield.noobia_door');
-- INSERT INTO triggerfields VALUES (62,55,101,'triggerfield.noobia_door');
-- INSERT INTO triggerfields VALUES (63,55,101,'triggerfield.noobia_door');

local common = require("base.common")

local M = {}

function M.MoveToField(Character)
    if Character:getQuestProgress(2) == 49 then
		common.InformNLS(Character,
		"Um eine Türe zu öffnen oder zu schließen, benutze einfach die Türe.",
		"To open or close a door, just use the door.")
		Character:setQuestProgress(2,50);
	end
end

return M
