-- ************************************************************************************************ 
-- *                                                                                              * 
-- *                                                                                              * 
-- *                                             EMS                                              * 
-- *                                         GUI Changes                                          * 
-- *                                                                                              * 
-- *                                                                                              * 
-- ************************************************************************************************
-- This file is supposed to contain additional changes on original GUI Elements

EMS.GC = {};
function EMS.GC.Setup()
	EMS.GC.GUIChange_BuyHeroWindow();
	EMS.GC.GUIChange_GameClock();
end

function EMS.GC.GUIChange_BuyHeroWindow()

	EMS.GC.HeroKeys = 
		{
			[Entities.PU_Hero1c] = "Dario",
			[Entities.PU_Hero2] = "Pilgrim",
			[Entities.PU_Hero3] = "Salim",
			[Entities.PU_Hero4] = "Erec",
			[Entities.PU_Hero5] = "Ari",
			[Entities.PU_Hero6] = "Helias",
			[Entities.CU_BlackKnight] = "Kerberos",
			[Entities.CU_Barbarian_Hero] = "Varg",
			[Entities.CU_Mary_de_Mortfichet] = "Mary_de_Mortfichet",
		}
	if not EMS.T.IsErbe() then
		EMS.GC.HeroKeys[Entities.PU_Hero10] = "Drake";
		EMS.GC.HeroKeys[Entities.PU_Hero11] = "Yuki";
		EMS.GC.HeroKeys[Entities.CU_Evil_Queen] = "Kala";
	end
		
	BuyHeroWindow_Update_BuyHero = function( _HeroEntityType )
		local PlayerID = GUI.GetPlayerID()
		local NumberOfHerosToBuy = Logic.GetNumberOfBuyableHerosForPlayer( PlayerID )

		local DisableFlag = 0
		
		if NumberOfHerosToBuy == 0 then
			DisableFlag = 1
		end
		
		if Logic.GetPlayerEntities( PlayerID, _HeroEntityType, 1 ) ~= 0 then
			DisableFlag = 1
		end
		
		if EMS.RD.Rules[EMS.GC.HeroKeys[_HeroEntityType]]:GetValue() == 0 then
			DisableFlag = 1;
		end
		XGUIEng.DisableButton( XGUIEng.GetCurrentWidgetID(), DisableFlag )
	end
	
end

function EMS.GC.GUIChange_GameClock()
	function GUIUpdate_Clock()
		
		local Seconds = Logic.GetTime() - ( EMS.GV.GameStartTime or Logic.GetTime() )
		
		local TotalMinutes = math.floor( Seconds / 60 )
		local Hours = math.floor( TotalMinutes / 60 )
		local Minutes = math.mod( TotalMinutes, 60 )
		local TotalSeconds = math.mod( math.floor(Seconds), 60 )
			
		local String = " "
		
		if Hours > 0 then		
			if Hours < 10 then
				String = String .. "0" .. Hours .. ":"
			else
				String = String .. Hours .. ":"
			end
		elseif Hours == 0 then
			String = String .. "00".. ":"
		end
		
		if Minutes == 0 then
			String = String .. "00" .. ":"
		else
			if Minutes <10 then
				String = String .. "0" .. Minutes .. ":"
			else
				String = String .. Minutes .. ":"
			end
		end
		
		
		if TotalSeconds < 10 then		
			String = String .. "0" .. TotalSeconds	
		else		
			String = String .. TotalSeconds	
		end

		XGUIEng.SetText(gvGUI_WidgetID.GameClock, String)	
	end
end