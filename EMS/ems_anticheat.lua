-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                           ANTICHEAT                                          * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --

EMS = EMS or {};
EMS.AC = {};

function EMS.AC.Setup()
	-- fix sell building bug, basically only for lan games
	EMS.AC.SB = GUI.SellBuilding;
	EMS.AC.LastId = 0;
	EMS.AC.CheckSellBuilding = true;
	GUI.SellBuilding = function(_id)
		if EMS.AC.CheckSellBuilding then
			if _id == EMS.AC.LastId then
				return;
			end
		end
		EMS.AC.LastId = _id
		EMS.AC.SB(_id)
	end
end