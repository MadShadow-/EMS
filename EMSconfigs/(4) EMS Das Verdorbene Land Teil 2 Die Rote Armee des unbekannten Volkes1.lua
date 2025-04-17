-- ************************************************************************************************
-- *                                                                                              *
-- *                                                                                              *
-- *                                              EMS                                             *
-- *                                         CONFIGURATION                                        *
-- *                                                                                              *
-- *                                                                                              *
-- ************************************************************************************************
 
EMS_CustomMapConfig =
{
	-- ********************************************************************************************
	-- * Configuration File Version
	-- * A version check will make sure every player has the same version of the configuration file
	-- ********************************************************************************************
	Version = 2,
 
	-- ********************************************************************************************
	-- * Debug Mode
	-- * Activates the ems debug mode if set to true.
	-- * This will enable key bindings to achieve some common debug tasks.
	-- * Ingame a button with the text "Debug" will be shown to give further information.
	-- * (Default: false)
	-- ********************************************************************************************
	ActivateDebug = false,
	
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
	Callback_OnMapStart = function()
		SetupHighlandWeatherGfxSet();
		AddPeriodicSummer(30*60);
		AddPeriodicRain(5*60);
		AddPeriodicWinter(10*60);
		AddPeriodicSummer(5*60);
		AddPeriodicRain(5*60);
		AddPeriodicWinter(30*60);
		AddPeriodicRain(10*60);
		AddPeriodicWinter(15*60);
		LocalMusic.UseSet = HIGHLANDMUSIC;
		Script.Load("data\\maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua")
		mcbPacker.Paths = {{"data/maps/user/EMS/tools/", ".lua"}}
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmySpawnGenerator")
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmy")
		TriggerFix.AllScriptsLoaded()					
		InitPlayerColorMapping()
		Mission_InitTechnologies()	
		StartSimpleJob("SurviveJob1")
		gvMission = {}
		gvMission.PlayerID = GUI.GetPlayerID()
				
		CreateRandomGoldChests()
		CreateChest(GetPosition("chest1"), chestCallbackWood)		
		CreateChest(GetPosition("chest2"), chestCallbackWood1)		
		CreateChest(GetPosition("chest3"), chestCallbackGold)		
		CreateChest(GetPosition("chest4"), chestCallbackGold1)		
		CreateChest(GetPosition("chest5"), chestCallbackIron1)		
		CreateChest(GetPosition("chest6"), chestCallbackIron)		
		CreateChest(GetPosition("chest7"), chestCallbackWood2)		
		CreateChest(GetPosition("chest9"), chestCallbackGold2)				
		CreateChest(GetPosition("chest11"), chestCallbackIron2)
		CreateChest(GetPosition("chest8"), chestCallbackWood3)
		CreateChest(GetPosition("chest10"), chestCallbackGold3)
		CreateChest(GetPosition("chest12"), chestCallbackIron3)		
		CreateChestOpener("Ari1")
		CreateChestOpener("Ari2")
		CreateChestOpener("Ari3")
		CreateChestOpener("Ari4")
		CreateChestOpener("Pilgrim1")
		CreateChestOpener("Pilgrim2")
		CreateChestOpener("Pilgrim3")
		CreateChestOpener("Pilgrim4")
		StartChestQuest()
		MercTent1()
	    MercTent2()
	    MercTent3()
		MercTent4()
	    MercTent5()
		MercTent6()
		MercTent7()
		MercTent8()
		gv_difficulty=1		
		modDT.init()
		KasernenHACK()	
		ButtonNeu_1() 
		ButtonNeu_2() 
		Burgaussehen()	
		Burgaussehen1()	
		Burgaussehen2()	
		Questbuch()

		  --Speere verboten---
ForbidTechnology (Technologies.T_UpgradeSpear1, 1)
ForbidTechnology (Technologies.T_UpgradeSpear1, 2)
ForbidTechnology (Technologies.T_UpgradeSpear1, 3)
ForbidTechnology (Technologies.T_UpgradeSpear1, 4)
--Speer 2 verboten--
ForbidTechnology (Technologies.T_UpgradeSpear2, 1)
ForbidTechnology (Technologies.T_UpgradeSpear2, 2)
ForbidTechnology (Technologies.T_UpgradeSpear2, 3)
ForbidTechnology (Technologies.T_UpgradeSpear2, 4)
--Speer 3 verboten--
ForbidTechnology (Technologies.T_UpgradeSpear3, 1)
ForbidTechnology (Technologies.T_UpgradeSpear3, 2)
ForbidTechnology (Technologies.T_UpgradeSpear3, 3)
ForbidTechnology (Technologies.T_UpgradeSpear3, 4)

				  --Bogen verboten---
ForbidTechnology (Technologies.T_UpgradeBow1, 1)
ForbidTechnology (Technologies.T_UpgradeBow1, 2)
ForbidTechnology (Technologies.T_UpgradeBow1, 3)
ForbidTechnology (Technologies.T_UpgradeBow1, 4)
		  --Bogen1 verboten---
ForbidTechnology (Technologies.T_UpgradeBow2, 1)
ForbidTechnology (Technologies.T_UpgradeBow2, 2)
ForbidTechnology (Technologies.T_UpgradeBow2, 3)
ForbidTechnology (Technologies.T_UpgradeBow2, 4)
		  --Bogen2 verboten---
ForbidTechnology (Technologies.T_UpgradeBow3, 1)
ForbidTechnology (Technologies.T_UpgradeBow3, 2)
ForbidTechnology (Technologies.T_UpgradeBow3, 3)
ForbidTechnology (Technologies.T_UpgradeBow3, 4)

		---------------			
			
		GUIAction_PlaceBuildingMaxTowerOrig = GUIAction_PlaceBuilding
		function GUIAction_PlaceBuilding(ucat)
			if ucat == UpgradeCategories.Tower then
				local pl = GUI.GetPlayerID()
				local num = Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_DarkTower1) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_DarkTower2) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_DarkTower3)
				if num >= 8 then
					Message("@color:170,255,0 Kein weiterer Turm erlaubt!")
				return
				end
			end
			GUIAction_PlaceBuildingMaxTowerOrig(ucat)
		end	
		
		---------------
		
		GUIAction_PlaceBuildingMaxFoundryOrig = GUIAction_PlaceBuilding
		function GUIAction_PlaceBuilding(ucat)
			if ucat == UpgradeCategories.Foundry then
				local pl = GUI.GetPlayerID()
				local num = Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_Foundry1) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_Foundry2)
				if num >= 3 then
					Message("@color:170,255,0 Kein weiterer kanonengießerei erlaubt!")
				return
				end
			end
			GUIAction_PlaceBuildingMaxFoundryOrig(ucat)
		end	
		
		----------------
		
		GUIAction_PlaceBuildingMaxStableOrig = GUIAction_PlaceBuilding
		function GUIAction_PlaceBuilding(ucat)
			if ucat == UpgradeCategories.Stable then
				local pl = GUI.GetPlayerID()
				local num = Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_Stable1) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(pl, Entities.PB_Stable2)
				if num >= 1 then
					Message("@color:170,255,0 Kein weiterer Reiterei erlaubt!")
				return
				end
			end
			GUIAction_PlaceBuildingMaxStableOrig(ucat)
		end	
		
		-----------
		

			
			StartSimpleJob("VictoryJob")
			StartSimpleJob("Player1LostJob");
			StartSimpleJob("Player2LostJob");	
			StartSimpleJob("Player3LostJob");
			StartSimpleJob("Player4LostJob");

		OverrideDiplomacy()
		-- hier die ais aufrufen		
		SetupPlayer5AI()
		SetupPlayer6AI()
		SetupPlayer7AI()	
		
			
		CreateWoodPile( "P1", 15000)
		CreateWoodPile( "P2", 15000)	
		CreateWoodPile( "P3", 15000)
		CreateWoodPile( "P4", 15000)	
		
		EnableAlarmLimit();
		EnableOvertimeLimit();
							
		   function VC_Deathmatch()
		return true
		end
	end,
 		
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		CreateSettlers()
		SpecialBriefing()
	
		for i = 1, 6 do
			_G["createarmy"..i]()
		end
		for i = 19, 29 do
			_G["createarmy"..i]()		
		end
		for i = 42, 59 do
			_G["createarmy"..i]()		
		end
		for i = 64, 73 do
			_G["createarmy"..i]()		
		end
		
		createarmy80()
		createarmy81()
		createarmy82()
		
	    --Stadtwachenfix
    GameCallback_OnTechnologyResearchedOriginal = GameCallback_OnTechnologyResearched
    function GameCallback_OnTechnologyResearched( _PlayerID, _TechnologyType )
        GameCallback_OnTechnologyResearchedOriginal( _PlayerID,_TechnologyType)
        if _TechnologyType == Technologies.T_TownGuard then
        Logic.SetTechnologyState(_PlayerID,Technologies.T_CityGuard, 3)
        end
    end
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
	StartSimpleJob("AI_AliveChecker")
	StartSimpleJob("AI_AliveChecker1")
	StartSimpleJob("AI_AliveChecker2")

			  --- mittlere zone  später runterschieben  zum allivechecker	
              ---  SNOW1 - SNOW20 	
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 0,
 
	-- ********************************************************************************************
	-- * GameMode
	-- * GameMode is a concept of a switchable option, that the scripter can freely use
	-- *
	-- * GameModes is a table that contains the available options for the players, for example:
	-- * GameModes = {"3vs3", "2vs2", "1vs1"},
	-- *
	-- * GameMode contains the index of selected mode by default - ranging from 1 to X
	-- *
	-- * Callback_GameModeSelected
	-- * Lets the scripter make changes, according to the selected game mode.
	-- * You could give different ressources or change the map environment accordingly
	-- * _gamemode contains the index of the selected option according to the GameModes table
	-- ********************************************************************************************
	GameMode = 1,
	GameModes = {"schwer"},
	Callback_GameModeSelected = function(_gamemode)
   -- leicht
    gv_placeholder = _gamemode
    -- mittel
    -- schwer
	end,
 
	-- ********************************************************************************************
	-- * Resource Level
	-- * Determines how much ressources the players start with
	-- * 1 = Normal
	-- * 2 = FastGame
	-- * 3 = SpeedGame
	-- * See the ressources table below for configuration
	-- ********************************************************************************************
	ResourceLevel = 1,
 
		-- ********************************************************************************************
	-- * Resources
	-- * Order:
	-- * Gold, Clay, Wood, Stone, Iron, Sulfur
	-- * Rules:
	-- * 1. If no player is defined, default values are used
	-- * 2. If player 1 is defined, these ressources will be used for all other players too
	-- * 3. Use the players index to give ressources explicitly
	-- ********************************************************************************************
	Ressources =
	{
		Normal = {
			[1] = {
				1750,
				1200,
				1200,
				1000,
				1200,
				300,
			},
		},
	},
 
	-- ********************************************************************************************
	-- * Callback_OnFastGame
	-- * Called together with Callback_OnGameStart if the player selected ResourceLevel 2 or 3
	-- * (FastGame or SpeedGame)
	-- ********************************************************************************************
	Callback_OnFastGame = function()
	end,
 
 		-- ********************************************************************************************
	-- * DisableInitCameraOnHeadquarter
	-- * Set to true if you don't want the camera to be set to the headquarter automatically
	-- * (default: false)
	-- ********************************************************************************************
	DisableInitCameraOnHeadquarter = false,
 
	-- ********************************************************************************************
	-- * DisableSetZoomFactor
	-- * If set to false, ZoomFactor will be set to 2 automatically
	-- * Set to true if nothing should be done
	-- * (default: false)
	-- ********************************************************************************************
	DisableSetZoomFactor = false,
 
	-- ********************************************************************************************
	-- * DisableStandardVictoryCondition
	-- * Set to true if you want to implement your own victory condition
	-- * Otherwise the player will lose upon losing his headquarter
	-- * (default: false)
	-- ********************************************************************************************
	DisableStandardVictoryCondition = true,
 
	-- ********************************************************************************************
	-- * Units
	-- * Various units can be allowed or forbidden
	-- * A 0 means the unit is forbidden - a higher number represents the maximum allowed level
	-- * Example: 
	-- * Sword = 0, equals Swords are forbidden
	-- * Sword = 2, equals the maximum level for swords is 2 = Upgrading once
	-- ********************************************************************************************
	Sword   = 4,
	Bow     = 4,
	PoleArm = 4,
	HeavyCavalry = 2,
	LightCavalry = 2,
	Rifle = 2,
	Thief = 0,
	Scout = 1,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
 
	-- * Buildings
	Bridge = 0,
 
	-- * Markets
	-- * -1 = Building markets is forbidden
	-- * 0 = Building markets is allowed
	-- * >0 = Markets are allowed and limited to the number given
	Markets = 3,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 4000,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 15,
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  10,
 
	-- * Enables chaning to a specific weather with the weather tower
	MakeSummer = 1,
	MakeRain   = 1,
	MakeSnow   = 1,
 
	-- * Fixes the DestrBuild bug
	AntiBug    = 1,
 
	-- * HQRush
	-- * If set to 1, Headquarters are invulernerable as long the player still has village centers
	AntiHQRush = 0,
 
	-- * If set to 1, Players can't abuse blessing and overtime in combination for unlimited work
	BlessLimit = 1,
 
	-- * if set to true, Players are not able to lose their Headquarter.
	InvulnerableHQs = false,
 
	-- * Heroes
	-- * NumberOfHeroesForAll sets the number of heroes every player can pick
	-- * 1 behind each hero defines if the hero is allowed; 0 for forbidden
	NumberOfHeroesForAll = 1,
	Dario    = 0,
	Pilgrim  = 1,
	Ari      = 0,
	Erec     = 0,
	Salim    = 0,
	Helias   = 0,
	Drake    = 0,
	Yuki     = 0,
	Kerberos = 0,
	Varg     = 0,
	Mary_de_Mortfichet = 0,
	Kala     = 0,
};

--------------------



--Buttons für den Truppenhack---
function ButtonNeu_1() 
   GUITooltip_BuyMilitaryUnit_Orig = GUITooltip_BuyMilitaryUnit
    GUITooltip_BuyMilitaryUnit = function(_c1,_c2,_c3,_c4,_c5)
        GUITooltip_BuyMilitaryUnit_Orig(_c1,_c2,_c3,_c4,_c5)
		newString, numberOfChanges = string.gsub( _c2, "MenuBarracks/BuyLeaderPoleArm_normal", "" )
        if numberOfChanges == 1 then
         XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomText, "@color:255,0,0 Kaufe einen @color:255,255,255 Krieger des Nebelvolkes")
         XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomCosts, "Taler: 150 @cr Eisen: 30" )
		 end
   end
end
function ButtonNeu_2()    
    GUITooltip_BuyMilitaryUnit_OrigA = GUITooltip_BuyMilitaryUnit
    GUITooltip_BuyMilitaryUnit = function(_c1,_c2,_c3,_c4,_c5)
        GUITooltip_BuyMilitaryUnit_OrigA(_c1,_c2,_c3,_c4,_c5)
		newString, numberOfChanges = string.gsub( _c2, "MenuArchery/BuyLeaderBow_normal", "" )
        if numberOfChanges == 1 then
        XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomText, "@color:255,0,0 Kaufe einen @color:255,255,255 Nebelwerfer")
        XGUIEng.SetText( gvGUI_WidgetID.TooltipBottomCosts, "Taler: 150 @cr Holz: 30 @cr Eisen: 30" )
		end
	end
end

-------------------------



function VictoryJob() 
	if IsDestroyed("Ruine") and IsDead("Ruine1")  and IsDead("Ruine2") and IsDead("Ruine3")  and IsDead("Ruine4") and IsDead("Ruine5")  and IsDead("Ruine6") and IsDead("Ruine7")  and IsDead("Ruine8") and IsDead("Ruine9")  and IsDead("Ruine10") and IsDead("Ruine11")  and IsDead("Ruine12") and IsDead("Ruine13")  and IsDead("Ruine14") and IsDead("Ruine15") and IsDead("Kirche6")  and IsDead("Burg6_D") and IsDead("Burg6") then
		if Logic.PlayerGetGameState(1)==1 then 
			Logic.PlayerSetGameStateToWon(1)
		end
		if Logic.PlayerGetGameState(2)==2 then
			Logic.PlayerSetGameStateToWon(2)
		end
		if Logic.PlayerGetGameState(3)==3 then
			Logic.PlayerSetGameStateToWon(3)
		end
		if Logic.PlayerGetGameState(4)==4 then
			Logic.PlayerSetGameStateToWon(4)
		end
		return true;
	end
end


 function VictoryPlayers()
  for p=1,4 do
    if Logic.PlayerGetGameState(p) == 1 then
        Logic.PlayerSetGameStateToVictory(p)
    end
  end
  Trigger.DisableTriggerSystem(1)
end


function SurviveJob1()
  if not IsAlive("Burg5")then
    DefeatPlayers()
  end
end

function DefeatPlayers()
  for p=1,4 do
    if Logic.PlayerGetGameState(p) == 1 then
        Logic.PlayerSetGameStateToLost(p)
    end
  end
  Trigger.DisableTriggerSystem(1)
end

function AI_AliveChecker()
	if IsDead("Ruine") and IsDead("Ruine2") and IsDead("Ruine14") and IsDead("Ruine15") and IsDead("Ruine7") and IsDead("Ruine8") and IsDead("Ruine9") then
		for i = 1, 20 do
			DestroyEntity("SnowBarrier"..i)
		end
		--
		for i = 7, 18 do
			_G["createarmy"..i]()
		end
		for i = 30, 41 do
			_G["createarmy"..i]()		
		end
		for i = 60, 63 do
			_G["createarmy"..i]()		
		end
		for i = 74, 75 do
			_G["createarmy"..i]()		
		end
	return true
	end
end	

function AI_AliveChecker1()
	if IsDead("Ruine") and IsDead("Ruine2") and IsDead("Ruine14") and IsDead("Ruine15") then
		for i = 76, 77 do
			_G["createarmy"..i]()
		end
	return true
	end
end	

function AI_AliveChecker2()
	if IsDead("Ruine7") and IsDead("Ruine8") and IsDead("Ruine9") then
		for i = 78, 79 do
			_G["createarmy"..i]()
		end
	return true
	end
end			
		
		

function OverrideDiplomacy() -- diplo in funktion ausgelagert
Logic.SetShareExplorationWithPlayerFlag(1, 5, 1)
Logic.SetShareExplorationWithPlayerFlag(2, 5, 1)
Logic.SetShareExplorationWithPlayerFlag(3, 5, 1)
Logic.SetShareExplorationWithPlayerFlag(4, 5, 1)
        SetFriendly( 1, 5 )
		SetFriendly( 2, 5 )
		SetFriendly( 3, 5 )
		SetFriendly( 4, 5 )
		SetFriendly( 1, 8 )
		SetFriendly( 2, 8 )
		SetFriendly( 3, 8 )
		SetFriendly( 4, 8 )
	SetHostile( 1, 6 )
	SetHostile( 1, 7 )
    SetHostile( 2, 6 )
	SetHostile( 2, 7 )
    SetHostile( 3, 6 )
	SetHostile( 3, 7 )
    SetHostile( 4, 6 )
	SetHostile( 4, 7 )
	SetHostile( 6, 5 )
	SetHostile( 7, 5 )
	end
	

-- die Meldungen die am Anfang Angesprochen wurden

function Player1LostJob()
	if IsDestroyed("P1_AI_HQ") then
		Message( "@color:255,0,21 Die Burg von Spieler 1 ist gefallen!!! Ir seit am verlieren")
		Sound.PlayGUISound(Sounds.VoicesHero7_HERO7_InflictFear_rnd_01, 0)
		if Logic.PlayerGetGameState(1)==1 then -- tatsächlich verloren
			Logic.PlayerSetGameStateToLost(1)
		end
		return true
	end
end

function Player2LostJob()
	if IsDestroyed("P2_AI_HQ") then
		Message( "@color:255,0,21 Die Festung von Spieler 2 ist gefallen!!!Ir seit am verlieren")
		Sound.PlayGUISound(Sounds.VoicesHero7_HERO7_InflictFear_rnd_01, 0)
		if Logic.PlayerGetGameState(2)==1 then -- tatsächlich verloren
			Logic.PlayerSetGameStateToLost(2)
		end
		return true
	end
end
			
function Player3LostJob()
	if IsDestroyed("P3_AI_HQ") then
		Message( "@color:255,0,21 Die Festung von Spieler 3 ist gefallen!!!Ir seit am verlieren")
		Sound.PlayGUISound(Sounds.VoicesHero7_HERO7_InflictFear_rnd_01, 0)
		if Logic.PlayerGetGameState(3)==1 then -- tatsächlich verloren
			Logic.PlayerSetGameStateToLost(3)
		end
		return true
	end
end

function Player4LostJob()
	if IsDestroyed("P4_AI_HQ") then
		Message( "@color:255,0,21 Die Festung von Spieler 4 ist gefallen!!!Ir seit am verlieren")
		Sound.PlayGUISound(Sounds.VoicesHero7_HERO7_InflictFear_rnd_01, 0)
		if Logic.PlayerGetGameState(4)==1 then -- tatsächlich verloren
			Logic.PlayerSetGameStateToLost(4)
		end
		return true
	end
end

function InitPlayerColorMapping()
	Display.SetPlayerColorMapping(5,5)
	Display.SetPlayerColorMapping(6,11)
	Display.SetPlayerColorMapping(7,2)
	XGUIEng.TransferMaterials( "Hero12_PoisonRange", "Buy_LeaderSpear" )
	XGUIEng.TransferMaterials( "Hero12_PoisonRange", "Buy_LeaderBow" )
    local pos = GetPosition( "altar" );
    Logic.CreateEffect( GGL_Effects.FXTemplarAltarEffect, pos.X, pos.Y, 2 );
end

-- Schatztruhen

function chestCallbackWood()
 Message("@color:178,2,255 Ihr habt einen Schatz mit 350 Holz gefunden")
 AddWood(1, 350)
 AddWood(2, 350)
 AddWood(3, 350)
 AddWood(4, 350)
end
function chestCallbackWood1()
 Message("@color:178,2,255 Ihr habt einen Schatz mit 350 Holz gefunden")
 AddWood(1, 350)
 AddWood(2, 350)
 AddWood(3, 350)
 AddWood(4, 350)
end
function chestCallbackWood2()
 Message("@color:178,2,255 Ihr habt einen Schatz mit 350 Holz gefunden")
 AddWood(1, 350)
 AddWood(2, 350)
 AddWood(3, 350)
 AddWood(4, 350)
end
function chestCallbackWood3()
 Message("@color:178,2,255 Ihr habt einen Schatz mit 350 Holz gefunden")
 AddWood(1, 350)
 AddWood(2, 350)
 AddWood(3, 350)
 AddWood(4, 350)
end
function chestCallbackIron()
 Message("@color:15,64,255 Ihr habt einen Schatz mit 350 Eisen gefunden")
 AddIron(1, 350)
 AddIron(2, 350)
 AddIron(3, 350)
 AddIron(4, 350)
end
function chestCallbackIron1()
 Message("@color:15,64,255 Ihr habt einen Schatz mit 350 Eisen gefunden")
 AddIron(1, 350)
 AddIron(2, 350)
 AddIron(3, 350)
 AddIron(4, 350)
end
function chestCallbackIron2()
 Message("@color:15,64,255 Ihr habt einen Schatz mit 350 Eisen gefunden")
 AddIron(1, 350)
 AddIron(2, 350)
 AddIron(3, 350)
 AddIron(4, 350)
end
function chestCallbackIron3()
 Message("@color:15,64,255 Ihr habt einen Schatz mit 350 Eisen gefunden")
 AddIron(1, 350)
 AddIron(2, 350)
 AddIron(3, 350)
 AddIron(4, 350)
end
function chestCallbackGold()
 Message("@color:115,209,65 Ihr habt einen Schatz mit 350 Talern gefunden")
 AddGold(1, 350)
 AddGold(2, 350)
 AddGold(3, 350)
 AddGold(4, 350)
end
function chestCallbackGold1()
 Message("@color:115,209,65 Ihr habt einen Schatz mit 350 Talern gefunden")
 AddGold(1, 350)
 AddGold(2, 350)
 AddGold(3, 350)
 AddGold(4, 350)
end
function chestCallbackGold2()
 Message("@color:115,209,65 Ihr habt einen Schatz mit 350 Talern gefunden")
 AddGold(1, 350)
 AddGold(2, 350)
 AddGold(3, 350)
 AddGold(4, 350)
end
function chestCallbackGold3()
 Message("@color:115,209,65 Ihr habt einen Schatz mit 350 Talern gefunden")
 AddGold(1, 350)
 AddGold(2, 350)
 AddGold(3, 350)
 AddGold(4, 350)
end

function MercTent1()
   local mercenaryId = GetEntityId("MercTent20")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 400);
    Logic.AddMercenaryOffer(mercenaryId, Entities.PU_LeaderSword2, 10, ResourceType.Gold, 200, ResourceType.Iron, 200);
	Logic.AddMercenaryOffer(mercenaryId, Entities.PV_Cannon3, 2, ResourceType.Gold, 600, ResourceType.Iron, 500);
end	

function MercTent2()
   local mercenaryId = GetEntityId("MercTent21")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 400);
    Logic.AddMercenaryOffer(mercenaryId, Entities.PU_LeaderSword2, 10, ResourceType.Gold, 200, ResourceType.Iron, 200);
	Logic.AddMercenaryOffer(mercenaryId, Entities.PV_Cannon3, 2, ResourceType.Gold, 600, ResourceType.Iron, 500);
end	

function MercTent3()
   local mercenaryId = GetEntityId("MercTent22")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 400);
    Logic.AddMercenaryOffer(mercenaryId, Entities.PU_LeaderSword2, 10, ResourceType.Gold, 200, ResourceType.Iron, 200);
	Logic.AddMercenaryOffer(mercenaryId, Entities.PV_Cannon3, 2, ResourceType.Gold, 600, ResourceType.Iron, 500);
end	

function MercTent4()
   local mercenaryId = GetEntityId("MercTent23")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 400);
    Logic.AddMercenaryOffer(mercenaryId, Entities.PU_LeaderSword2, 10, ResourceType.Gold, 200, ResourceType.Iron, 200);
	Logic.AddMercenaryOffer(mercenaryId, Entities.PV_Cannon3, 2, ResourceType.Gold, 600, ResourceType.Iron, 500);
end	

function MercTent5()
   local mercenaryId = GetEntityId("MercTent24")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
    Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
end	

function MercTent6()
   local mercenaryId = GetEntityId("MercTent25")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
    Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
end	

function MercTent7()
   local mercenaryId = GetEntityId("MercTent26")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
    Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
end	

function MercTent8()
   local mercenaryId = GetEntityId("MercTent27")
  	Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderSkirmisher1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
    Logic.AddMercenaryOffer(mercenaryId, Entities.CU_Evil_LeaderBearman1, 10, ResourceType.Gold, 500, ResourceType.Iron, 500);
end	




-- Burg für Leibis

SetupPlayerAi( 5, {
    serfLimit = 8,
    extracting = 0,
    resources = {
        gold = 20000,
        wood = 20000,
        clay = 20000,
        iron = 20000,
        stone = 20000,
        sulfur = 20000
    },
    refresh = {
        gold = 4000,
        wood = 4000,
        clay = 4000,
        iron = 4000,
        stone = 4000,
        sulfur = 4000,
        updateTime = 60
    },
    rebuild = {
        delay = 1,
        randomTime = 1
    },
    repairing = true,
    constructing = true
})




	-- die ki spieler alle in ne extra funktion
function SetupPlayer8AI()
	local aiID = 8;
	SetupPlayerAi( aiID, {8}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "handel" );
end	

	-- die ki spieler alle in ne extra funktion
function SetupPlayer7AI()
	local aiID = 7;
	SetupPlayerAi( aiID, {7}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Nebelvolk" );
end

	-- die ki spieler alle in ne extra funktion
function SetupPlayer5AI()
	local aiID = 5;
	SetupPlayerAi( aiID, {5}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Hauptstadt" );
end	

	-- die ki spieler alle in ne extra funktion
function SetupPlayer6AI()
	local aiID = 6;
	SetupPlayerAi( aiID, {6}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Banditen" );
end	

------------
--- Kaserne 
------------

function KasernenHACK()
GUIAction_BuyMilitaryUnit_Orig = GUIAction_BuyMilitaryUnit
	GUIAction_BuyMilitaryUnit = function(_a)
		if _a == UpgradeCategories.LeaderPoleArm then
			_a = UpgradeCategories.Evil_LeaderBearman
		end
		if _a == UpgradeCategories.LeaderBow then
			_a = UpgradeCategories.Evil_LeaderSkirmisher
		end
		GUIAction_BuyMilitaryUnit_Orig(_a)
	end
end

----------
---Towser
----------

modDT = {}
function modDT.init()
	modDT.unpackFix()
	modDT.GameCallback_GUI_SelectionChanged = GameCallback_GUI_SelectionChanged
	GameCallback_GUI_SelectionChanged = function()
	modDT.GameCallback_GUI_SelectionChanged()
	local sel = GUI.GetSelectedEntity()
	if IsEntityOfType(sel, "PB_DarkTower1") and Logic.IsConstructionComplete(sel)==1 then
			XGUIEng.ShowWidget("Tower", 1)
			XGUIEng.ShowWidget("Commands_Tower", 1)
			XGUIEng.ShowWidget("Upgrade_Tower1", 1)
			XGUIEng.ShowWidget("Upgrade_Tower2", 0)
			XGUIEng.ShowWidget("Upgrade_Tower3", 0)
		elseif IsEntityOfType(sel, "PB_DarkTower2") then
			XGUIEng.ShowWidget("Tower", 1)
			XGUIEng.ShowWidget("Commands_Tower", 1)
			XGUIEng.ShowWidget("Upgrade_Tower1", 0)
			XGUIEng.ShowWidget("Upgrade_Tower2", 1)
			XGUIEng.ShowWidget("Upgrade_Tower3", 0)
	  elseif IsEntityOfType(sel, "PB_DarkTower3") then
			XGUIEng.ShowWidget("Tower", 1)
			XGUIEng.ShowWidget("Commands_Tower", 1)
			XGUIEng.ShowWidget("Upgrade_Tower1", 0)
			XGUIEng.ShowWidget("Upgrade_Tower2", 0)
			XGUIEng.ShowWidget("Upgrade_Tower3", 1)
		end
	end
	modDT.GUIAction_PlaceBuilding = GUIAction_PlaceBuilding
	GUIAction_PlaceBuilding = function(...)
		if arg[1] == UpgradeCategories.Tower then
			arg[1] = UpgradeCategories.DarkTower
		end
		modDT.GUIAction_PlaceBuilding(unpack(arg))
	end
end
function modDT.unpackFix()
	if not unpack{true} then
		unpack = function(t, i)
			i = i or 1
			if i <= table.getn(t) then
				return t[i], unpack(t, i+1)
			end
		end
	end
end

function Burgaussehen()
 local burgid = GetEntityId("CB_Bastille2_2")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen1()
 local burgid = GetEntityId("CB_Bastille1_1")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen2()
 local burgid = GetEntityId("CB_Bastille3_3")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end


function CreateSettlers()
	CreateMilitaryGroup(5,Entities.PU_LeaderRifle2,8,GetPosition("Haupt"),"Scharfsch")
	Move("Scharfsch","Hauptstadt")
	
	CreateMilitaryGroup(7,Entities.CU_Evil_LeaderBearman1,16,GetPosition("NVTruppe1"),"NVTruppen")
	Move("NVTruppen","Hauptstadt")
	
	CreateMilitaryGroup(7,Entities.CU_Evil_LeaderBearman1,16,GetPosition("NVTruppe2"),"NV1Truppen")	
	Move("NV1Truppen","Hauptstadt")
		
	CreateMilitaryGroup(5,Entities.PU_LeaderRifle2,8,GetPosition("TBurgH"),"TruppenH")
	Move("TruppenH","Moor")
	end
	
	

-----  Text

function SpecialBriefing()
	local briefing = {};
	local AP, ASP = AddPages(briefing);
 
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Wir haben ein großes Problem");
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Wir brauchen umbedingt eure Hilfe gegen diese Invasion");
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Als Hilfe geben wir euch die  Reiterei und Kanongießerei zu bauen davon könnt ihr viele von bauen und truppen Rekutieren");
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Aber Seit Vorsichtig, Die Moor Gebiete werden Stark verteidigt von den gegnerischen Truppen");
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Da Die Banditen die Handelroute unten Blockiert haben, koennen die Verbuendten auch keinen Nachschub schicken leider");
	AP{ 
     title = "@color:115,209,65 Mission",
		text = "@color:115,209,65 Besiegt das Nebelvolk, die Hauptstadt darf nicht fallen sonst ist game over",		
		position =  GetPosition("Moor"),
		explore	= 1500,
		dialogCamera	=	true
	};
	ASP("Buergermeister","Buergermeister","@color:115,209,65 Oh, sie kommen, alle zu den Waffen...", true);
	StartBriefing(briefing);
		return true
end	

function Questbuch()	
Logic.AddQuest(1, 1, MAINQUEST_OPEN, "@color:255,255,0 Informationen", "Sieg und Niederlage:  Auf Die Man Achten muss: Die Burg in der Mitte darf Nicht fallen, Auch eure Eigene Burg darf nicht fallen. Besieg alle Gegnerischen Uhreinwohner", 1)  
--
Logic.AddQuest(2, 2, MAINQUEST_OPEN, "@color:255,255,0 Informationen", "Sieg und Niederlage:  Auf Die Man Achten muss: Die Burg in der Mitte darf Nicht fallen, Auch eure Eigene Burg darf nicht fallen. Besieg alle Gegnerischen Uhreinwohner", 1)  
--
Logic.AddQuest(3, 3, MAINQUEST_OPEN, "@color:255,255,0 Informationen", "Sieg und Niederlage:  Auf Die Man Achten muss: Die Burg in der Mitte darf Nicht fallen, Auch eure Eigene Burg darf nicht fallen. Besieg alle Gegnerischen Uhreinwohner", 1)  
--
Logic.AddQuest(4, 4, MAINQUEST_OPEN, "@color:255,255,0 Informationen", "Sieg und Niederlage:  Auf Die Man Achten muss: Die Burg in der Mitte darf Nicht fallen, Auch eure Eigene Burg darf nicht fallen. Besieg alle Gegnerischen Uhreinwohner", 1)  
--
end


		
function createarmy1()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6
	end
    UA1 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA1:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA1:AddCommandWaitForIdle(true)	
    UA1:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA1:AddCommandWaitForIdle(true)	
	UA1:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA1:AddCommandWaitForIdle(true)	
    UA1:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA1:AddCommandWaitForIdle(true)		
    UA1:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA1:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA1, {
        Position=GetPosition("Ruine1"),
		Generator = "Ruine", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua1)
    for id in ua1:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy2()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5
	end
    UA2 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA2:AddCommandMove(GetPosition("Ruine_deff_Weg1"), true)
    UA2:AddCommandWaitForIdle(true)	
    UA2:AddCommandMove(GetPosition("Ruine_deff_Weg2"), true)
    UA2:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA2, {
        Position=GetPosition("Ruine1"),
		Generator = "Ruine", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=2,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua2)
    for id in ua2:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy3()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA3 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA3:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA3:AddCommandWaitForIdle(true)	
    UA3:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA3:AddCommandWaitForIdle(true)	
	UA3:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA3:AddCommandWaitForIdle(true)	
    UA3:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA3:AddCommandWaitForIdle(true)		
    UA3:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA3:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA3, {
        Position=GetPosition("Ruine1"),
		Generator = "Ruine", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua3)
    for id in ua3:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy4()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA4 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA4:AddCommandMove(GetPosition("Ruine2_deff_Weg1"), true)
    UA4:AddCommandWaitForIdle(true)	
    UA4:AddCommandMove(GetPosition("Ruine2_deff_Weg2"), true)
    UA4:AddCommandWaitForIdle(true)	
	UA4:AddCommandMove(GetPosition("Ruine2_deff_Weg3"), true)
    UA4:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA4, {
        Position=GetPosition("Ruine_2"),
		Generator = "Ruine2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=2,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua4)
    for id in ua4:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy5()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA5 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA5:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA5:AddCommandWaitForIdle(true)	
	UA5:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA5:AddCommandWaitForIdle(true)		
    UA5:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA5:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA5, {
        Position=GetPosition("Ruine_2"),
		Generator = "Ruine2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua5)
    for id in ua5:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy6()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA6 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA6:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA6:AddCommandWaitForIdle(true)	
    UA6:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA6:AddCommandWaitForIdle(true)	
	UA6:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA6:AddCommandWaitForIdle(true)	
    UA6:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA6:AddCommandWaitForIdle(true)		
    UA6:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA6:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA6, {
        Position=GetPosition("Ruine_2"),
		Generator = "Ruine2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua6)
    for id in ua6:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end


function createarmy7()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3
	end
    UA7 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA7:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA7:AddCommandWaitForIdle(true)	
    UA7:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA7:AddCommandWaitForIdle(true)	
	UA7:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA7:AddCommandWaitForIdle(true)	
    UA7:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA7:AddCommandWaitForIdle(true)		
    UA7:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA7:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA7, {
        Position=GetPosition("Ruine_3"),
		Generator = "Ruine3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua7)
    for id in ua7:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy8()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA8 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA8:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA8:AddCommandWaitForIdle(true)	
    UA8:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA8:AddCommandWaitForIdle(true)	
	UA8:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA8:AddCommandWaitForIdle(true)	
    UA8:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA8:AddCommandWaitForIdle(true)		
    UA8:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA8:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA8, {
        Position=GetPosition("Ruine_3"),
		Generator = "Ruine3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua8)
    for id in ua8:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end


function createarmy9()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5
	end
    UA9 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA9:AddCommandMove(GetPosition("Ruine3_deff_Weg1"), true)
    UA9:AddCommandWaitForIdle(true)	
    UA9:AddCommandMove(GetPosition("Ruine3_deff_Weg2"), true)
    UA9:AddCommandWaitForIdle(true)	
	UA9:AddCommandMove(GetPosition("Ruine3_deff_Weg3"), true)
    UA9:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA9, {
        Position=GetPosition("Ruine_3"),
		Generator = "Ruine3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua9)
    for id in ua9:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy10()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA10 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA10:AddCommandMove(GetPosition("Ruine4_deff_Weg1"), true)
    UA10:AddCommandWaitForIdle(true)	
    UA10:AddCommandMove(GetPosition("Ruine4_deff_Weg2"), true)
    UA10:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA10, {
        Position=GetPosition("Ruine_4"),
		Generator = "Ruine4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua10)
    for id in ua10:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy11()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA11 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA11:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA11:AddCommandWaitForIdle(true)	
    UA11:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA11:AddCommandWaitForIdle(true)	
	UA11:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA11:AddCommandWaitForIdle(true)	
    UA11:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA11:AddCommandWaitForIdle(true)		
    UA11:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA11:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA11, {
        Position=GetPosition("Ruine_4"),
		Generator = "Ruine4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua11)
    for id in ua11:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy12()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA12 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA12:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA12:AddCommandWaitForIdle(true)	
    UA12:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA12:AddCommandWaitForIdle(true)	
	UA12:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA12:AddCommandWaitForIdle(true)	
    UA12:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA12:AddCommandWaitForIdle(true)		
    UA12:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA12:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA12, {
        Position=GetPosition("Ruine_4"),
		Generator = "Ruine4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua12)
    for id in ua12:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy13()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA13 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA13:AddCommandMove(GetPosition("Ruine5_deff_Weg1"), true)
    UA13:AddCommandWaitForIdle(true)	
    UA13:AddCommandMove(GetPosition("Ruine5_deff_Weg2"), true)
    UA13:AddCommandWaitForIdle(true)	
	UA13:AddCommandMove(GetPosition("Ruine5_deff_Weg3"), true)
    UA13:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA13, {
        Position=GetPosition("Ruine_5"),
		Generator = "Ruine5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua13)
    for id in ua13:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy14()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA14 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA14:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA14:AddCommandWaitForIdle(true)	
    UA14:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA14:AddCommandWaitForIdle(true)	
	UA14:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA14:AddCommandWaitForIdle(true)	
    UA14:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA14:AddCommandWaitForIdle(true)		
    UA14:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA14:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA14, {
        Position=GetPosition("Ruine_5"),
		Generator = "Ruine5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua14)
    for id in ua14:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy15()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA15 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA15:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA15:AddCommandWaitForIdle(true)	
    UA15:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA15:AddCommandWaitForIdle(true)	
	UA15:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA15:AddCommandWaitForIdle(true)	
    UA15:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA15:AddCommandWaitForIdle(true)		
    UA15:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA15:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA15, {
        Position=GetPosition("Ruine_5"),
		Generator = "Ruine5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua15)
    for id in ua15:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy16()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA16 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA16:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA16:AddCommandWaitForIdle(true)	
    UA16:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA16:AddCommandWaitForIdle(true)	
	UA16:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA16:AddCommandWaitForIdle(true)	
    UA16:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA16:AddCommandWaitForIdle(true)		
    UA16:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA16:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA16, {
        Position=GetPosition("Ruine_6"),
		Generator = "Ruine6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua16)
    for id in ua16:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy17()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA17 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA17:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA17:AddCommandWaitForIdle(true)	
    UA17:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA17:AddCommandWaitForIdle(true)	
	UA17:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA17:AddCommandWaitForIdle(true)	
    UA17:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA17:AddCommandWaitForIdle(true)		
    UA17:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA17:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA17, {
        Position=GetPosition("Ruine_6"),
		Generator = "Ruine6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua17)
    for id in ua17:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy18()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA18 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA18:AddCommandMove(GetPosition("Ruine6_deff_Weg1"), true)
    UA18:AddCommandWaitForIdle(true)	
    UA18:AddCommandMove(GetPosition("Ruine6_deff_Weg2"), true)
    UA18:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA18, {
        Position=GetPosition("Ruine_6"),
		Generator = "Ruine6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua18)
    for id in ua18:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy19()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5
	end
    UA19 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA19:AddCommandMove(GetPosition("Ruine7_deff_Weg1"), true)
    UA19:AddCommandWaitForIdle(true)	
    UA19:AddCommandMove(GetPosition("Ruine7_deff_Weg2"), true)
    UA19:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA19, {
        Position=GetPosition("Ruine_7"),
		Generator = "Ruine7", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua19)
    for id in ua19:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy20()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA20 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA20:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA20:AddCommandWaitForIdle(true)	
    UA20:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA20:AddCommandWaitForIdle(true)	
	UA20:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA20:AddCommandWaitForIdle(true)	
    UA20:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA20:AddCommandWaitForIdle(true)		
    UA20:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA20:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA20, {
        Position=GetPosition("Ruine_7"),
		Generator = "Ruine7", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua20)
    for id in ua20:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy21()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA21 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA21:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA21:AddCommandWaitForIdle(true)	
    UA21:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA21:AddCommandWaitForIdle(true)	
	UA21:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA21:AddCommandWaitForIdle(true)	
    UA21:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA21:AddCommandWaitForIdle(true)		
    UA21:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA21:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA21, {
        Position=GetPosition("Ruine_7"),
		Generator = "Ruine7", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua21)
    for id in ua21:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy22()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6
	end
    UA22 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA22:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA22:AddCommandWaitForIdle(true)	
    UA22:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA22:AddCommandWaitForIdle(true)	
	UA22:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA22:AddCommandWaitForIdle(true)	
    UA22:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA22:AddCommandWaitForIdle(true)		
    UA22:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA22:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA22, {
        Position=GetPosition("Ruine_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua22)
    for id in ua22:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy23()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA23 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA23:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA23:AddCommandWaitForIdle(true)	
    UA23:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA23:AddCommandWaitForIdle(true)	
	UA23:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA23:AddCommandWaitForIdle(true)	
    UA23:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA23:AddCommandWaitForIdle(true)		
    UA23:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA23:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA23, {
        Position=GetPosition("Ruine_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua23)
    for id in ua23:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy24()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA24 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA24:AddCommandMove(GetPosition("Ruine8_deff_Weg1"), true)
    UA24:AddCommandWaitForIdle(true)	
    UA24:AddCommandMove(GetPosition("Ruine8_deff_Weg2"), true)
    UA24:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA24, {
        Position=GetPosition("Ruine_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua24)
    for id in ua24:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy25()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA25 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA25:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA25:AddCommandWaitForIdle(true)	
    UA25:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA25:AddCommandWaitForIdle(true)	
	UA25:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA25:AddCommandWaitForIdle(true)	
    UA25:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA25:AddCommandWaitForIdle(true)		
    UA25:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA25:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA25, {
        Position=GetPosition("Ruine_8_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua25)
    for id in ua25:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy26()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA26 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA26:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA26:AddCommandWaitForIdle(true)	
    UA26:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA26:AddCommandWaitForIdle(true)	
	UA26:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA26:AddCommandWaitForIdle(true)	
    UA26:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA26:AddCommandWaitForIdle(true)		
    UA26:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA26:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA26, {
        Position=GetPosition("Ruine_8_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua26)
    for id in ua26:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy27()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA27 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA27:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA27:AddCommandWaitForIdle(true)	
    UA27:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA27:AddCommandWaitForIdle(true)	
	UA27:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA27:AddCommandWaitForIdle(true)	
    UA27:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA27:AddCommandWaitForIdle(true)		
    UA27:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA27:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA27, {
        Position=GetPosition("Ruine_9"),
		Generator = "Ruine9", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua27)
    for id in ua27:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy28()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA28 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA28:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA28:AddCommandWaitForIdle(true)	
    UA28:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA28:AddCommandWaitForIdle(true)	
	UA28:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA28:AddCommandWaitForIdle(true)	
    UA28:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA28:AddCommandWaitForIdle(true)		
    UA28:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA28:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA28, {
        Position=GetPosition("Ruine_9"),
		Generator = "Ruine9", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua28)
    for id in ua28:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy29()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA29 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA29:AddCommandMove(GetPosition("Ruine9_deff_Weg1"), true)
    UA29:AddCommandWaitForIdle(true)	
    UA29:AddCommandMove(GetPosition("Ruine9_deff_Weg2"), true)
    UA29:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA29, {
        Position=GetPosition("Ruine_9"),
		Generator = "Ruine9", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua29)
    for id in ua29:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy30()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA30 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA30:AddCommandMove(GetPosition("Ruine10_deff_Weg1"), true)
    UA30:AddCommandWaitForIdle(true)	
    UA30:AddCommandMove(GetPosition("Ruine10_deff_Weg2"), true)
    UA30:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA30, {
        Position=GetPosition("Ruine_10"),
		Generator = "Ruine10", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua30)
    for id in ua30:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy31()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA31 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA31:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA31:AddCommandWaitForIdle(true)	
    UA31:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA31:AddCommandWaitForIdle(true)	
	UA31:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA31:AddCommandWaitForIdle(true)	
    UA31:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA31:AddCommandWaitForIdle(true)		
    UA31:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA31:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA31, {
        Position=GetPosition("Ruine_10"),
		Generator = "Ruine10", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua31)
    for id in ua31:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy32()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA32 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA32:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA32:AddCommandWaitForIdle(true)	
    UA32:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA32:AddCommandWaitForIdle(true)	
	UA32:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA32:AddCommandWaitForIdle(true)	
    UA32:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA32:AddCommandWaitForIdle(true)		
    UA32:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA32:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA32, {
        Position=GetPosition("Ruine_10"),
		Generator = "Ruine10", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua32)
    for id in ua32:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy33()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA33 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA33:AddCommandMove(GetPosition("Ruine11_deff_Weg1"), true)
    UA33:AddCommandWaitForIdle(true)	
    UA33:AddCommandMove(GetPosition("Ruine11_deff_Weg2"), true)
    UA33:AddCommandWaitForIdle(true)
    UA33:AddCommandMove(GetPosition("Ruine11_deff_Weg3"), true)
    UA33:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA33, {
        Position=GetPosition("Ruine_11"),
		Generator = "Ruine11", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua33)
    for id in ua33:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy34()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA34 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA34:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA34:AddCommandWaitForIdle(true)	
    UA34:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA34:AddCommandWaitForIdle(true)	
	UA34:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA34:AddCommandWaitForIdle(true)	
    UA34:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA34:AddCommandWaitForIdle(true)		
    UA34:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA34:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA34, {
        Position=GetPosition("Ruine_11"),
		Generator = "Ruine11", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua34)
    for id in ua34:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy35()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA35 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA35:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA35:AddCommandWaitForIdle(true)	
    UA35:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA35:AddCommandWaitForIdle(true)	
	UA35:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA35:AddCommandWaitForIdle(true)	
    UA35:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA35:AddCommandWaitForIdle(true)		
    UA35:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA35:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA35, {
        Position=GetPosition("Ruine_11"),
		Generator = "Ruine11", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua35)
    for id in ua35:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy36()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA36 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA36:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA36:AddCommandWaitForIdle(true)	
    UA36:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA36:AddCommandWaitForIdle(true)	
	UA36:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA36:AddCommandWaitForIdle(true)	
    UA36:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA36:AddCommandWaitForIdle(true)		
    UA36:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA36:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA36, {
        Position=GetPosition("Ruine_12"),
		Generator = "Ruine12", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua36)
    for id in ua36:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy37()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA37 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA37:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA37:AddCommandWaitForIdle(true)	
    UA37:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA37:AddCommandWaitForIdle(true)	
	UA37:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA37:AddCommandWaitForIdle(true)	
    UA37:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA37:AddCommandWaitForIdle(true)		
    UA37:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA37:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA37, {
        Position=GetPosition("Ruine_12"),
		Generator = "Ruine12", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua37)
    for id in ua37:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy38()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA38 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA38:AddCommandMove(GetPosition("Ruine12_deff_Weg1"), true)
    UA38:AddCommandWaitForIdle(true)	
    UA38:AddCommandMove(GetPosition("Ruine12_deff_Weg2"), true)
    UA38:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA38, {
        Position=GetPosition("Ruine_12"),
		Generator = "Ruine12", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua38)
    for id in ua38:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy39()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA39 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA39:AddCommandMove(GetPosition("Ruine13_deff_Weg1"), true)
    UA39:AddCommandWaitForIdle(true)	
    UA39:AddCommandMove(GetPosition("Ruine13_deff_Weg2"), true)
    UA39:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA39, {
        Position=GetPosition("Ruine_13"),
		Generator = "Ruine13", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua39)
    for id in ua39:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy40()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA40 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA40:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA40:AddCommandWaitForIdle(true)	
    UA40:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA40:AddCommandWaitForIdle(true)	
	UA40:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA40:AddCommandWaitForIdle(true)	
    UA40:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA40:AddCommandWaitForIdle(true)		
    UA40:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA40:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA40, {
        Position=GetPosition("Ruine_13"),
		Generator = "Ruine13", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua40)
    for id in ua40:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy41()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA41 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA41:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA41:AddCommandWaitForIdle(true)	
    UA41:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA41:AddCommandWaitForIdle(true)	
	UA41:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA41:AddCommandWaitForIdle(true)	
    UA41:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA41:AddCommandWaitForIdle(true)		
    UA41:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA41:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA41, {
        Position=GetPosition("Ruine_13"),
		Generator = "Ruine13", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua41)
    for id in ua41:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy42()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA42 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA42:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA42:AddCommandWaitForIdle(true)	
    UA42:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA42:AddCommandWaitForIdle(true)	
	UA42:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA42:AddCommandWaitForIdle(true)	
    UA42:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA42:AddCommandWaitForIdle(true)		
    UA42:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA42:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA42, {
        Position=GetPosition("Ruine_14"),
		Generator = "Ruine14", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua42)
    for id in ua42:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy43()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA43 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA43:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA43:AddCommandWaitForIdle(true)	
    UA43:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA43:AddCommandWaitForIdle(true)	
	UA43:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA43:AddCommandWaitForIdle(true)	
    UA43:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA43:AddCommandWaitForIdle(true)		
    UA43:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA43:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA43, {
        Position=GetPosition("Ruine_14"),
		Generator = "Ruine14", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua43)
    for id in ua43:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy44()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA44 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA44:AddCommandMove(GetPosition("Ruine14_deff_Weg1"), true)
    UA44:AddCommandWaitForIdle(true)	
    UA44:AddCommandMove(GetPosition("Ruine14_deff_Weg2"), true)
    UA44:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA44, {
        Position=GetPosition("Ruine_14"),
		Generator = "Ruine14", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua44)
    for id in ua44:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy45()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 5 
	end
    UA45 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA45:AddCommandMove(GetPosition("Ruine15_deff_Weg1"), true)
    UA45:AddCommandWaitForIdle(true)	
    UA45:AddCommandMove(GetPosition("Ruine15_deff_Weg2"), true)
    UA45:AddCommandWaitForIdle(true)
    UA45:AddCommandMove(GetPosition("Ruine15_deff_Weg3"), true)
    UA45:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA45, {
        Position=GetPosition("Ruine_15"),
		Generator = "Ruine15", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua45)
    for id in ua45:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy46()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA46 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA46:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA46:AddCommandWaitForIdle(true)	
    UA46:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA46:AddCommandWaitForIdle(true)	
	UA46:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA46:AddCommandWaitForIdle(true)	
    UA46:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA46:AddCommandWaitForIdle(true)		
    UA46:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA46:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA46, {
        Position=GetPosition("Ruine_15"),
		Generator = "Ruine15", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua46)
    for id in ua46:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy47()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA47 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA47:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA47:AddCommandWaitForIdle(true)	
    UA47:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA47:AddCommandWaitForIdle(true)	
	UA47:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA47:AddCommandWaitForIdle(true)	
    UA47:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA47:AddCommandWaitForIdle(true)		
    UA47:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA47:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA47, {
        Position=GetPosition("Ruine_15"),
		Generator = "Ruine15", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua47)
    for id in ua47:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy48()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA48 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA48:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA48:AddCommandWaitForIdle(true)	
    UA48:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA48:AddCommandWaitForIdle(true)	
	UA48:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA48:AddCommandWaitForIdle(true)	
    UA48:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA48:AddCommandWaitForIdle(true)		
    UA48:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA48:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA48, {
        Position=GetPosition("Zelt_1"),
		Generator = "Zelt1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua48)
    for id in ua48:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy49()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA49 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 2000,
        AutoRotateRange    = 2000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA49:AddCommandMove(GetPosition("Zelt1_deff1"), true)
    UA49:AddCommandWaitForIdle(true)	
    UA49:AddCommandMove(GetPosition("Zelt1_deff2"), true)
    UA49:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA49, {
        Position=GetPosition("Zelt_1"),
		Generator = "Zelt1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua49)
    for id in ua49:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy50()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA50 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 2000,
        AutoRotateRange    = 2000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA50:AddCommandMove(GetPosition("Zelt2_deff1"), true)
    UA50:AddCommandWaitForIdle(true)	
    UA50:AddCommandMove(GetPosition("Zelt2_deff2"), true)
    UA50:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA50, {
        Position=GetPosition("Zelt_2"),
		Generator = "Zelt2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua50)
    for id in ua50:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy51()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA51 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA51:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA51:AddCommandWaitForIdle(true)	
    UA51:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA51:AddCommandWaitForIdle(true)
    UA51:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA51:AddCommandWaitForIdle(true)	
    UA51:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA51:AddCommandWaitForIdle(true)	
	UA51:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA51:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA51, {
        Position=GetPosition("Zelt_2"),
		Generator = "Zelt2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua51)
    for id in ua51:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy52()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA52 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA52:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA52:AddCommandWaitForIdle(true)	
    UA52:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA52:AddCommandWaitForIdle(true)
    UA52:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA52:AddCommandWaitForIdle(true)	
    UA52:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA52:AddCommandWaitForIdle(true)	
	UA52:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA52:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA52, {
        Position=GetPosition("Zelt_3"),
		Generator = "Zelt3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua52)
    for id in ua52:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy53()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA53 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 2000,
        AutoRotateRange    = 2000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA53:AddCommandMove(GetPosition("Zelt3_deff1"), true)
    UA53:AddCommandWaitForIdle(true)	
    UA53:AddCommandMove(GetPosition("Zelt3_deff2"), true)
    UA53:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA53, {
        Position=GetPosition("Zelt_3"),
		Generator = "Zelt3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua53)
    for id in ua53:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy54()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA54 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 2000,
        AutoRotateRange    = 2000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA54:AddCommandMove(GetPosition("Zelt4_deff1"), true)
    UA54:AddCommandWaitForIdle(true)	
    UA54:AddCommandMove(GetPosition("Zelt4_deff2"), true)
    UA54:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA54, {
        Position=GetPosition("Zelt_4"),
		Generator = "Zelt4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua54)
    for id in ua54:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy55()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA55 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA55:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA55:AddCommandWaitForIdle(true)	
    UA55:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA55:AddCommandWaitForIdle(true)
    UA55:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA55:AddCommandWaitForIdle(true)	
    UA55:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA55:AddCommandWaitForIdle(true)
    UA55:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA55:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA55, {
        Position=GetPosition("Zelt_4"),
		Generator = "Zelt4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow2, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua55)
    for id in ua55:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy56()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA56 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA56:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA56:AddCommandWaitForIdle(true)	
    UA56:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA56:AddCommandWaitForIdle(true)
    UA56:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA56:AddCommandWaitForIdle(true)	
    UA56:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA56:AddCommandWaitForIdle(true)
    UA56:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA56:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA56, {
        Position=GetPosition("Burg_6"),
		Generator = "Burg6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua56)
    for id in ua56:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy57()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4
	end
    UA57 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA57:AddCommandMove(GetPosition("Burg6_Weg1"), true)
    UA57:AddCommandWaitForIdle(true)	
    UA57:AddCommandMove(GetPosition("Burg_6"), true)
    UA57:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA57, {
        Position=GetPosition("Burg_6"),
		Generator = "Burg6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua57)
    for id in ua57:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy58()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA58 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA58:AddCommandMove(GetPosition("Burg6_6_Weg1"), true)
    UA58:AddCommandWaitForIdle(true)	
    UA58:AddCommandMove(GetPosition("Burg_6_6"), true)
    UA58:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA58, {
        Position=GetPosition("Burg_6_6"),
		Generator = "Burg6_D", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua58)
    for id in ua58:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy59()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA59 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA59:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA59:AddCommandWaitForIdle(true)	
    UA59:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA59:AddCommandWaitForIdle(true)
    UA59:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA59:AddCommandWaitForIdle(true)	
    UA59:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA59:AddCommandWaitForIdle(true)
    UA59:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA59:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA59, {
        Position=GetPosition("Burg_6_6"),
		Generator = "Burg6_D", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua59)
    for id in ua59:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy60()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA60 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA60:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA60:AddCommandWaitForIdle(true)	
    UA60:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA60:AddCommandWaitForIdle(true)
    UA60:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA60:AddCommandWaitForIdle(true)	
    UA60:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA60:AddCommandWaitForIdle(true)
    UA60:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA60:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA60, {
        Position=GetPosition("Kirche_6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua60)
    for id in ua60:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy61()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA61 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA61:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA61:AddCommandWaitForIdle(true)	
    UA61:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA61:AddCommandWaitForIdle(true)
    UA61:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA61:AddCommandWaitForIdle(true)	
    UA61:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA61:AddCommandWaitForIdle(true)
    UA61:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA61:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA61, {
        Position=GetPosition("Kirche_6_6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua61)
    for id in ua61:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy62()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA62 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA62:AddCommandMove(GetPosition("Kirche_Weg1"), true)
    UA62:AddCommandWaitForIdle(true)	
    UA62:AddCommandMove(GetPosition("Kirche_Weg2"), true)
    UA62:AddCommandWaitForIdle(true)
    UA62:AddCommandMove(GetPosition("Kirche_Weg3"), true)
    UA62:AddCommandWaitForIdle(true)		
    UnlimitedArmySpawnGenerator:New(UA62, {
        Position=GetPosition("Kirche_6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua62)
    for id in ua62:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy63()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 2 
	end
    UA63 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA63:AddCommandMove(GetPosition("Kirche_Weg4"), true)
    UA63:AddCommandWaitForIdle(true)	
    UA63:AddCommandMove(GetPosition("Kirche_Weg5"), true)
    UA63:AddCommandWaitForIdle(true)
    UA63:AddCommandMove(GetPosition("Kirche_Weg6"), true)
    UA63:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA63, {
        Position=GetPosition("Kirche_6_6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua63)
    for id in ua63:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy64()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA64 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA64:AddCommandMove(GetPosition("Burg5_Weg1"), true)
    UA64:AddCommandWaitForIdle(true)	
    UA64:AddCommandMove(GetPosition("Burg5_Weg2"), true)
    UA64:AddCommandWaitForIdle(true)
    UA64:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA64:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA64, {
        Position=GetPosition("Burg5_Spawn1"),
		Generator = "Burg5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},			
        },
    })
	function KillAllLeadersWithNoSoldiers(ua64)
    for id in ua64:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy65()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA65 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA65:AddCommandMove(GetPosition("Burg5_Weg4"), true)
    UA65:AddCommandWaitForIdle(true)	
    UA65:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA65:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA65, {
        Position=GetPosition("Burg5_Spawn2"),
		Generator = "Burg5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},	
        },
    })
	function KillAllLeadersWithNoSoldiers(ua65)
    for id in ua65:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy66()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA66 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA66:AddCommandMove(GetPosition("Burg5_Weg5"), true)
    UA66:AddCommandWaitForIdle(true)	
    UA66:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA66:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA66, {
        Position=GetPosition("Burg5_Spawn3"),
		Generator = "Burg5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},	
        },
    })
	function KillAllLeadersWithNoSoldiers(ua66)
    for id in ua66:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy67()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA67 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA67:AddCommandMove(GetPosition("Burg5_Weg6"), true)
    UA67:AddCommandWaitForIdle(true)	
    UA67:AddCommandMove(GetPosition("Burg5_Weg7"), true)
    UA67:AddCommandWaitForIdle(true)
    UA67:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA67:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA67, {
        Position=GetPosition("Burg5_Spawn4"),
		Generator = "Burg5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle2, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},	
        },
    })
	function KillAllLeadersWithNoSoldiers(ua67)
    for id in ua67:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy68()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA68 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA68:AddCommandMove(GetPosition("Bastille1"), true)
    UA68:AddCommandWaitForIdle(true)	
    UA68:AddCommandMove(GetPosition("Bastille2"), true)
    UA68:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA68, {
        Position=GetPosition("Bastille1_1_N1"),
		Generator = "CB_Bastille1_1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PV_Cannon2, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua68)
    for id in ua68:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy69()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA69 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA69:AddCommandMove(GetPosition("Bastille3_Angriff1"), true)
    UA69:AddCommandWaitForIdle(true)	
    UA69:AddCommandMove(GetPosition("Bastille3_Angriff2"), true)
    UA69:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA69, {
        Position=GetPosition("Bastille3_3_N2"),
		Generator = "CB_Bastille3_3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PV_Cannon2, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua69)
    for id in ua69:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy70()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 3 
	end
    UA70 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA70:AddCommandMove(GetPosition("Bastille2_Angriff1"), true)
    UA70:AddCommandWaitForIdle(true)	
    UA70:AddCommandMove(GetPosition("Bastille2_Angriff2"), true)
    UA70:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA70, {
        Position=GetPosition("Bastille2_2_N2"),
		Generator = "CB_Bastille2_2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PV_Cannon2, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua70)
    for id in ua70:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy71()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA71 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA71:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA71:AddCommandWaitForIdle(true)	
    UA71:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA71:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA71, {
        Position=GetPosition("Burg5_Cano"),
		Generator = "Burg5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=4,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
			{LeaderType=Entities.PV_Cannon1, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PV_Cannon2, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua71)
    for id in ua71:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy72()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA72 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA72:AddCommandMove(GetPosition("Burg5_Weg1"), true)
    UA72:AddCommandWaitForIdle(true)	
    UA72:AddCommandMove(GetPosition("Burg5_Weg2"), true)
    UA72:AddCommandWaitForIdle(true)
	UA72:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA72:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA72, {
        Position=GetPosition("P5_Towser1"),
		Generator = "P5_Towser", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=4,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua72)
    for id in ua72:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy73()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA73 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA73:AddCommandMove(GetPosition("Burg5_Weg6"), true)
    UA73:AddCommandWaitForIdle(true)	
    UA73:AddCommandMove(GetPosition("Burg5_Weg7"), true)
    UA73:AddCommandWaitForIdle(true)
	UA73:AddCommandMove(GetPosition("Burg5_Weg3"), true)
    UA73:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA73, {
        Position=GetPosition("P5_Towser2"),
		Generator = "P5_Towser3", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=4,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua73)
    for id in ua73:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end


function createarmy74()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA74 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA74:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA74:AddCommandWaitForIdle(true)	
    UA74:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA74:AddCommandWaitForIdle(true)	
    UA74:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA74:AddCommandWaitForIdle(true)
    UA74:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA74:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA74, {
        Position=GetPosition("KircheAngriff"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=5, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua74)
    for id in ua74:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end


function createarmy75()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA75 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA75:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA75:AddCommandWaitForIdle(true)	
    UA75:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA75:AddCommandWaitForIdle(true)	
    UA75:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA75:AddCommandWaitForIdle(true)
    UA75:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA75:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA75, {
        Position=GetPosition("KircheAngriff1"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=5, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua75)
    for id in ua75:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

----------------------------

function createarmy76()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA76 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA76:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA76:AddCommandWaitForIdle(true)	
    UA76:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA76:AddCommandWaitForIdle(true)	
    UA76:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA76:AddCommandWaitForIdle(true)
    UA76:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA76:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA76, {
        Position=GetPosition("A6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=4, Looped=true},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=5, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua76)
    for id in ua76:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy77()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA77 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA77:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA77:AddCommandWaitForIdle(true)	
    UA77:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA77:AddCommandWaitForIdle(true)	
    UA77:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA77:AddCommandWaitForIdle(true)
    UA77:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA77:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA77, {
        Position=GetPosition("A7"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=1, Looped=true},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=4, Looped=true},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=5, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow4, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PV_Cannon4, SoldierNum=0, SpawnNum=1, Looped=true},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua77)
    for id in ua77:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy78()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA78 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA78:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA78:AddCommandWaitForIdle(true)	
    UA78:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA78:AddCommandWaitForIdle(true)	
    UA78:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA78:AddCommandWaitForIdle(true)
    UA78:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA78:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA78, {
        Position=GetPosition("A7"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_VeteranMajor, SoldierNum=0, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_VeteranCaptain, SoldierNum=0, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_VeteranCaptain, SoldierNum=0, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua78)
    for id in ua78:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy79()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 10 
	end
    UA79 = UnlimitedArmy:New {
        Player             = 6,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
	UA79:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA79:AddCommandWaitForIdle(true)	
    UA79:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA79:AddCommandWaitForIdle(true)	
    UA79:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA79:AddCommandWaitForIdle(true)
    UA79:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA79:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA79, {
        Position=GetPosition("A6"),
		Generator = "Kirche6", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_VeteranMajor, SoldierNum=0, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_VeteranCaptain, SoldierNum=0, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_VeteranCaptain, SoldierNum=0, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderRifle1, SoldierNum=4, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua79)
    for id in ua79:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy80()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 6 
	end
    UA80 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA80:AddCommandMove(GetPosition("Ruine_Weg5"), true)
    UA80:AddCommandWaitForIdle(true)	
    UA80:AddCommandMove(GetPosition("Ruine_Weg4"), true)
    UA80:AddCommandWaitForIdle(true)	
	UA80:AddCommandMove(GetPosition("Ruine_Weg3"), true)
    UA80:AddCommandWaitForIdle(true)	
    UA80:AddCommandMove(GetPosition("Ruine_Weg2"), true)
    UA80:AddCommandWaitForIdle(true)		
    UA80:AddCommandMove(GetPosition("Ruine_Weg1"), true)
    UA80:AddCommandWaitForIdle(true)
    UnlimitedArmySpawnGenerator:New(UA80, {
        Position=GetPosition("Ruine_15"),
		Generator = "Ruine15", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=3,
        SpawnLeaders=4,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua80)
    for id in ua80:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy81()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 8 
	end
    UA81 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA81:AddCommandMove(GetPosition("Oben1_Weg2"), true)
    UA81:AddCommandWaitForIdle(true)	
    UA81:AddCommandMove(GetPosition("Oben1_Weg1"), true)
    UA81:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA81, {
        Position=GetPosition("Oben1_1"),
		Generator = "Oben1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=15,
        SpawnLeaders=2,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua81)
    for id in ua81:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end

function createarmy82()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 8 
	end
    UA82 = UnlimitedArmy:New {
        Player             = 7,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA82:AddCommandMove(GetPosition("Oben1_Weg1"), true)
    UA82:AddCommandWaitForIdle(true)	
    UA82:AddCommandMove(GetPosition("Oben1_Weg2"), true)
    UA82:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA82, {
        Position=GetPosition("Oben1_1"),
		Generator = "Oben1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=15,
        SpawnLeaders=2,
        LeaderDesc={
		    {LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_Evil_LeaderSkirmisher1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Evil_LeaderBearman1, SoldierNum=16, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
        },
    })
	function KillAllLeadersWithNoSoldiers(ua82)
    for id in ua82:Iterator(true) do
        if IsAlive(id) then
            if Logic.LeaderGetNumberOfSoldiers(id)==0 then
                SetHealth(id, 0)
            end
        end
    end
end
end



--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- This function is called on game start and after save game is loaded, setup your weather gfx
-- sets here

function Mission_InitWeatherGfxSets()

	-- Use gfx sets
	-- Befehlsatz einfach Kommentierung durch entfernen der beiden Bindestriche rausnehmen.
	-- nicht vergessen das man nur ein setzten sollte.

	--SetupNormalWeatherGfxSet()
	--SetupHighlandWeatherGfxSet()
	--SetupSteppeWeatherGfxSet()
	--SetupMoorWeatherGfxSet()
	SetupEvelanceWeatherGfxSet()
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Wetterperioden einstellen

---function InitWeather()

	-- Hier wird der Wetterwechsel festgelegtl
	-- Beispiel 4 Min Sommer, dann 2 Minuten Winter, dann wieder alles von vorne

	---AddPeriodicSummer(1*60)
--- end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function Mission_InitTechnologies()
	for i  = 1, 4 do
	ForbidTechnology( Technologies.T_MakeSnow, i)
	ForbidTechnology( Technologies.T_MakeSummer, i)
	ForbidTechnology( Technologies.T_MakeRain, i)
	ForbidTechnology( Technologies.T_ChangeWeather, i)
	ForbidTechnology( Technologies.T_WeatherForecast, i)
	ForbidTechnology( Technologies.T_ThiefSabotage, i)
	ForbidTechnology( Technologies.T_PV_Cannon4, i)
end 
    for i = 5, 7 do
        ResearchTechnology(Technologies.T_BodkinArrow, i)
        ResearchTechnology(Technologies.T_Fletching, i)
        ResearchTechnology(Technologies.T_WoodAging, i)
        ResearchTechnology(Technologies.T_Turnery, i)
        ResearchTechnology(Technologies.T_Masonry, i)
        ResearchTechnology(Technologies.GT_Binocul, i)
        ResearchTechnology(Technologies.GT_Mathematics, i)
        ResearchTechnology(Technologies.T_PaddedArcherArmor, i)
        ResearchTechnology(Technologies.T_LeatherArcherArmor, i)
        ResearchTechnology(Technologies.T_LeatherMailArmor, i)
        ResearchTechnology(Technologies.T_SoftArcherArmor, i)
        ResearchTechnology(Technologies.T_ChainMailArmor, i)
        ResearchTechnology(Technologies.T_PlateMailArmor, i)
        ResearchTechnology(Technologies.T_MasterOfSmithery, i)
        ResearchTechnology(Technologies.T_IronCasting, i)
        ResearchTechnology(Technologies.T_BetterTrainingArchery, i)
        ResearchTechnology(Technologies.T_Research_Shoeing, i)
        ResearchTechnology(Technologies.T_BetterTrainingBarracks, i)
end
end

-- Build Groups and attach Leaders

---function Mission_InitGroups()

---end


	
-- Holzstapel


function CreateWoodPile( _posEntity, _resources )
	assert( type( _posEntity ) == "string" );
	assert( type( _resources ) == "number" );
	gvWoodPiles = gvWoodPiles or {
		JobID = StartSimpleJob("ControlWoodPiles"),
	};
	local pos = GetPosition( _posEntity );
	local pile_id = Logic.CreateEntity( Entities.XD_Rock3, pos.X, pos.Y, 0, 0 );

	SetEntityName( pile_id, _posEntity.."_WoodPile" );

	local newE = ReplaceEntity( _posEntity, Entities.XD_ResourceTree );
	Logic.SetModelAndAnimSet(newE, Models.XD_SignalFire1);
	Logic.SetResourceDoodadGoodAmount( GetEntityId( _posEntity ), _resources*10 );
	Logic.SetModelAndAnimSet(pile_id, Models.Effects_XF_ChopTree);
	table.insert( gvWoodPiles, { ResourceEntity = _posEntity, PileEntity = _posEntity.."_WoodPile", ResourceLimit = _resources*9 } );
end

function ControlWoodPiles()
	for i = table.getn( gvWoodPiles ),1,-1 do
		if Logic.GetResourceDoodadGoodAmount( GetEntityId( gvWoodPiles[i].ResourceEntity ) ) <= gvWoodPiles[i].ResourceLimit then
			DestroyWoodPile( gvWoodPiles[i], i );
		end
	end
end

function DestroyWoodPile( _piletable, _index )
	local pos = GetPosition( _piletable.ResourceEntity );
	DestroyEntity( _piletable.ResourceEntity );
	DestroyEntity( _piletable.PileEntity );
	Logic.CreateEffect( GGL_Effects.FXCrushBuilding, pos.X, pos.Y, 0 );
	table.remove( gvWoodPiles, _index )
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Zeitzähler

function StartCountdown(_Limit, _Callback, _Show)

	assert(type(_Limit) == "number")

	Counter.Index = (Counter.Index or 0) + 1

	if _Show and CountdownIsVisisble() then
		assert(false, "StartCountdown: A countdown is already visible")
	end

	Counter["counter" .. Counter.Index] = {Limit = _Limit, TickCount = 0, Callback = _Callback, Show = _Show, Finished = false}

	if _Show then
		MapLocal_StartCountDown(_Limit)
	end

	if Counter.JobId == nil then
		Counter.JobId = StartSimpleJob("CountdownTick")
	end

	return Counter.Index
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function StopCountdown(_Id)

	if Counter.Index == nil then
		return
	end

	if _Id == nil then
		for i = 1, Counter.Index do
			if Counter.IsValid("counter" .. i) then
				if Counter["counter" .. i].Show then
					MapLocal_StopCountDown()
				end
				Counter["counter" .. i] = nil
			end
		end
	else
		if Counter.IsValid("counter" .. _Id) then
			if Counter["counter" .. _Id].Show then
				MapLocal_StopCountDown()
			end
			Counter["counter" .. _Id] = nil
		end
	end
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function CountdownTick()

	local empty = true
	for i = 1, Counter.Index do
		if Counter.IsValid("counter" .. i) then
			if Counter.Tick("counter" .. i) then
				Counter["counter" .. i].Finished = true
			end

			if Counter["counter" .. i].Finished and not IsBriefingActive() then
				if Counter["counter" .. i].Show then
					MapLocal_StopCountDown()
				end

				-- callback function

				if type(Counter["counter" .. i].Callback) == "function" then
					Counter["counter" .. i].Callback()
				end

				Counter["counter" .. i] = nil
			end

			empty = false
		end
	end

	if empty then
		Counter.JobId = nil
		Counter.Index = nil
		return true
	end
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function CountdownIsVisisble()
	for i = 1, Counter.Index do
		if Counter.IsValid("counter" .. i) and Counter["counter" .. i].Show then
			return true
		end
	end

	return false
end

-- AutoUmlaut function

function Umlaute( _text )
	local texttype = type( _text );
	if texttype == "string" then
		_text = string.gsub( _text, "ä", "\195\164" );
		_text = string.gsub( _text, "ö", "\195\182" );
		_text = string.gsub( _text, "ü", "\195\188" );
		_text = string.gsub( _text, "ß", "\195\159" );
		_text = string.gsub( _text, "Ä", "\195\132" );
		_text = string.gsub( _text, "Ö", "\195\150" );
		_text = string.gsub( _text, "Ü", "\195\156" );
		return _text;
	elseif texttype == "table" then
		for k,v in _text do
			_text[k] = Umlaute( v );
		end
		return _text;
	else
		return _text;
	end
end

function AutoUmlaut()
	StartBriefingUmlauteOrig = StartBriefing;
	StartBriefing = function( _briefing )
		StartBriefingUmlauteOrig( Umlaute( _briefing ) );
	end

	CreateNPCUmlauteOrig = CreateNPC;
	CreateNPC = function( _npc )
		CreateNPCUmlauteOrig( Umlaute( _npc ) );
	end

	MessageUmlauteOrig = Message;
	Message = function( _text )
		MessageUmlauteOrig( Umlaute( tostring( _text ) ) );
	end
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function AddPages( _briefing )
	local AP = function(_page) table.insert(_briefing, _page); return _page; end
	local ASP = function(_entity, _title, _text, _dialog) return AP(CreateShortPage(_entity, _title, _text, _dialog)); end
	return AP, ASP;
end

function CreateShortPage( _entity, _title, _text, _dialog) 
    local page = {
        title = _title,
        text = _text,
        position = GetPosition( _entity ),
        dialogCamera = _dialog
    };
    return page;
end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- Dies sind die Funktion für den Alarm/Ueberstunden Fix
-- Diese brauchen nicht verändert werden, können aber (zusammen mit ihrem Aufruf) entfernt werden, sofern sie nicht benötigt werden

function EnableAlarmLimit()
	GUIAction_ActivateAlarmOrig = GUIAction_ActivateAlarm;
	GUIAction_ActivateAlarm = function()
		alarmWait = Logic.GetCurrentTurn() + 300;    -- Zeit die, der Alarm aktiviert bleiben muss (300=30sekunden)
		GUIAction_ActivateAlarmOrig();
	end

	GUIAction_QuitAlarmOrig = GUIAction_QuitAlarm;
	GUIAction_QuitAlarm = function()
		local turns = Logic.GetCurrentTurn();
		if turns >= alarmWait then
			GUIAction_QuitAlarmOrig();
		else
			Sound.PlayFeedbackSound( Sounds.VoicesWorker_WORKER_FunnyNo_rnd_10, 0 );
			Message( "Der Alarm kann erst in " .. math.floor( ( alarmWait - turns ) / 10 ) .. " Sekunden wieder aufgehoben werden." );
		end
	end
end

function EnableOvertimeLimit()
	tOvertimes = {};
	GUI.ToggleOvertimeAtBuildingOrig = GUI.ToggleOvertimeAtBuilding;
	GUI.ToggleOvertimeAtBuilding = function( _id )
		LimitOvertime( _id, GUI.ToggleOvertimeAtBuildingOrig );
	end

	GUI.ForceSettlerToWorkOrig = GUI.ForceSettlerToWork;
	GUI.ForceSettlerToWork = function( _id )
		LimitOvertime( _id, GUI.ToggleOvertimeAtBuildingOrig );
	end

	LimitOvertime = function( _id, _func )
		local knowntime = tOvertimes[_id];
		local turns = Logic.GetCurrentTurn();
		if not knowntime or turns > knowntime then
			_func( _id );
			tOvertimes[_id] = turns + 100;    -- Zeit die, die Ueberstunden aktiviert bleiben mussen (100=10sekunden)
		else
			Sound.PlayFeedbackSound( Sounds.VoicesWorker_WORKER_FunnyNo_rnd_10, 0 );
			Message( "Die Ueberstunden dauern noch mindestens " .. math.floor( ( knowntime - turns ) / 10 ) .. " Sekunden." );
		end
	end
	Camera.ZoomSetFactorMax(2)
end


function FixMultiBuildingDestroyBug()
	MultiBuildingDestroyBugLastId = 0
	GUI.SellBuilding_Orig_System = GUI.SellBuilding;
	GUI.SellBuilding = function(_Id)
		if _Id == MultiBuildingDestroyBugLastId then
			return;
		end
		MultiBuildingDestroyBugLastId = _Id
		GUI.SellBuilding_Orig_System(_Id)
	end
end
 
