
--######################################################################################################--
--######################                                                          ######################--
--######################           Mapname: (4) Die Macht der Strategen           ######################--
--######################           Author: Roma_invicta                           ######################--
--######################                                                          ######################--
--######################           Karte für das Wintertunier 2022                ######################--
--######################                                                          ######################--
--######################################################################################################--

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
	Version = 4.7,
 
	-- ********************************************************************************************
	-- * Debug Mode
	-- * Activates the ems debug mode if set to true.
	-- * This will enable key bindings to achieve some common debug tasks.
	-- * Ingame a button with the text "Debug" will be shown to give further information.
	-- * (Default: false)
	-- ********************************************************************************************
	ActivateDebug = false,
 
	-- ********************************************************************************************
	-- * Custom debug functions
	-- * If ActivateDebug is set to true, these two debug methods can be called by pressing N or M
	-- * _fromPlayer - the id of the player that pressed the key
	-- * _targetPlayerId1 - a player id between 1-8 (or 16 on cnetwork), that the caller wants to target
	-- * _targetPlayerId2 - a second player id
	-- * _x, _y - the position of the callers mouse at the time of pressing the key
	-- * Example content:
	-- * SetFriendly(_targetPlayerId1, _targetPlayerId2); -- make friends between p1 and p2
	-- * Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, _fromPlayer); -- create Serf for caller
	-- ********************************************************************************************
	CustomDebugFunc1 = function(_fromPlayer, _targetPlayerId1, _targetPlayerId2, _x, _y)
		Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, _fromPlayer);
	end,
	CustomDebugFunc2 = function(_fromPlayer, _target1, _target2, _x, _y)
		Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, _target2);
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
	Callback_OnMapStart = function()
		-- Der Pfad für die fertige Version
		gvBasePath = "maps\\user\\"..Framework.GetCurrentMapName().."\\";

	---------------------------SkriptLoad----------------------------
		Script.Load("data\\maps\\externalmap\\comforts.lua")
		Script.Load("data\\maps\\externalmap\\dompunkte.lua")
		Script.Load("data\\maps\\externalmap\\damagearea.lua")
		Script.Load("data\\maps\\externalmap\\maryfogmodels.lua")
		Script.Load("data\\maps\\externalmap\\allyaicontrol.lua")
		Script.Load("data\\maps\\externalmap\\militaryvictory.lua")
		Script.Load("data\\maps\\externalmap\\militarycontrol.lua")
		Script.Load("data\\maps\\externalmap\\eroberungspunkte.lua")
		--
		Script.Load("data\\maps\\externalmap\\kimichurasdefarmy.lua")
		Script.Load("data\\maps\\externalmap\\filter.lua")
		--
		Script.Load("data\\maps\\externalmap\\salim.lua")
		Script.Load("data\\maps\\externalmap\\helias.lua")
		Script.Load("data\\maps\\externalmap\\heldenmodus.lua")

	-----------------------  TwA HeroWindow  ------------------------
		Script.Load( "maps\\externalmap\\cerberus\\loader.lua" )
		Lib.Require("module/mp/BuyHero")
		--
		BuyHero.Install()
		HeldenwahlSpieler()
		
		-- BuyHero.AllowHero(_Type, _Allowed) 						-- Hier hero sperren
		-- BuyHero.SetNumberOfBuyableHeroes(_PlayerID, _Amount)		-- Anzahl der Helden
		-- XGUIEng.ShowWidget("BuyHeroWindow", 1) 					-- Im Sp manuell callen	
		
		-- GUIAction_ToggleMenu( gvGUI_WidgetID.BuyHeroWindow,-1)
		-- GUITooltip_Generic("MenuHeadquarter/buy_hero")
		
		GUIUpdate_BuyHeroButton = function()
			local PlayerID = GUI.GetPlayerID()
			local NumberOfHerosToBuy = Logic.GetNumberOfBuyableHerosForPlayer( PlayerID )
			--
			if NumberOfHerosToBuy > 0 or GUI.GetPlayerID() == 17 then
				XGUIEng.ShowWidget("Buy_Hero",1)        
			else
				XGUIEng.ShowWidget("Buy_Hero",0)        
			end
		end
		--
		GUIAction_ToggleMenuOrig = GUIAction_ToggleMenu
		function GUIAction_ToggleMenu( _Menu, _Status )
			GUIAction_ToggleMenuOrig( _Menu, _Status )
			
			if _Menu == gvGUI_WidgetID.BuyHeroWindow then
			
				if _Status == -1 then
					_Status = 1 - XGUIEng.IsWidgetShown( _Menu )
				end;
				if CNetwork then
					XGUIEng.ShowWidget("BuyHeroWindow", 1)
				else
					XGUIEng.ShowWidget( _Menu, _Status )
				end
			end;
		end;
	
	-----------------------------------------------------------------

		HistoryFlag = GoldHistoryCheck() -- Für SetVisibility() wichtig!
		Questbuch()
		SetupHighlandWeatherGfxSet();
		AddPeriodicSummer(1200*60)
		LocalMusic.UseSet = MEDITERANEANMUSIC;
		-- LocalMusic.UseSet = EVELANCEMUSIC
		Wettersperre = true
		MusicRtwI()

		for gate = 1, 4 do
			MakeInvulnerable("StoneGate_"..gate)
		end
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
        OnGameStart()
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
	 	OnPeacetimeOver()
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
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
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
		-- * Normal default: 1k, 1.8k, 1.5k, 0.8k, 50, 50
		Normal = {
			[1] = {
				500,
				1800,
				1500,
				800,
				0,
				150,
			},
		},
		-- * FastGame default: 2 x Normal Ressources
		FastGame = {},
 
		-- * SpeedGame default: 20k, 12k, 14k, 10k, 7.5k, 7.5k
		SpeedGame = {},
	},
 
	-- ********************************************************************************************
	-- * Callback_OnFastGame
	-- * Called together with Callback_OnGameStart if the player selected ResourceLevel 2 or 3
	-- * (FastGame or SpeedGame)
	-- ********************************************************************************************
	Callback_OnFastGame = function()
	end,
 
	-- ********************************************************************************************
	-- * AI Players
	-- * Player Entities that belong to an ID that is also present in the AIPlayers table won't be
	-- * removed
	-- ********************************************************************************************
	AIPlayers = {

	},
 
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
	DisableStandardVictoryCondition = false,
 
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
	Thief = 1,
	Scout = 1,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
 
	-- * Buildings
	Bridge = 1,
 
	-- * Markets
	-- * -1 = Building markets is forbidden
	-- * 0 = Building markets is allowed
	-- * >0 = Markets are allowed and limited to the number given
	Markets = -1,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 0,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	--TowerLimit = 8,
 
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
	Dario    = 1,
	Pilgrim  = 1,
	Ari      = 1,
	Erec     = 1,
	Salim    = 1,
	Helias   = 1,
	Drake    = 1,
	Yuki     = 1,
	Kerberos = 1,
	Varg     = 1,
	Mary_de_Mortfichet = 1,
	Kala     = 1,

};
--------------------------------------------------------------------------------

-- Dario unverwundbarkeit einbauen 																					#erledigt
-- Veteran Majoren Techs 																							#erledigt
-- Veteran Majoren Patroullien 																						#erledigt
-- Respawnzeit Banditen herabsetzen 																				#erledigt von 10 auf 2 Minuten
-- Kala cooldown länger 																							#erledigt von 2 auf 4 Minuten
-- Offensiv Tribut herabsetzen																						#erledigt von 40.000 auf 25.000 Taler
-- Wetterkraftwerke erst baubar mit Wetterturm + Wetterkraftwerke werden zerstört + Wetterenergie auf 0 resettet.	#erledigt
-- Verbündete KI wird mit erstem Tribut feindlich zu den Banditen.													#erledigt
-- Turm Umwandlung "Süielereigen in Beschreibung"																	#erledigt
-- Verbündete KI Hilft bei Wetterturm Dz																			#erledigt
-- Notfalldorfzentrum 																								[Idee erstmal ausgesetzt]

	-----------------------  Gamesaveload  --------------------------
Mission_OnSaveGameLoaded = function()		
	StartSimpleJob("WeatherLoad")
end
--
function WeatherLoad()
	Display.GfxSetSetFogParams(1, 0.0, 1.0, 1, 152,190,182, 20000,28000)
	Display.GfxSetSetLightParams(1,  0.0, 1.0, 1, 50, 180, 255,210,210,150,150,150)
	--
	Display.GfxSetSetFogParams(2, 0.0, 1.0, 1, 150,150,255, 3000,14000)
	Display.GfxSetSetLightParams(2,  0.0, 1.0, 1, 100, 120, 100,120,255, 100,100,100)
	--
	Display.GfxSetSetFogParams(3, 0.0, 1.0, 1, 70,132,240, 5000,28000)
	Display.GfxSetSetLightParams(3,  0.0, 1.0, 1, 250, 132, 80,132,240, 50,50,50)
	--
	Display.GfxSetSetFogParams(4, 0.0, 1.0, 1, 50,100,255, 3000,16000)
	Display.GfxSetSetLightParams(4,  0.0, 1.0, 1, 100, 100, 100,70,255, 100,100,100)
--
	-- Allg. Funktionen
	SalimOnSaveGameLoaded()
	HeliasOnSaveGameLoaded()
	-- Helden
	HeroGUIUpdateTicker = 0
	StartSimpleJob("HeroGUI_Update")
--
	return true
end
--
function HeroGUI_Update()
	if HeroGUIUpdateTicker == 1 then
	-- Dario
		XGUIEng.TransferMaterials("WeatherTower_MakeSummer", "Hero1_SendHawk")
		XGUIEng.TransferMaterials("WeatherTower_MakeRain", "Hero1_ProtectUnits")
		XGUIEng.TransferMaterials("WeatherTower_MakeSnow", "Hero1_LookAtHawk")
	--Pilgrim
		XGUIEng.TransferMaterials("Buy_Cannon3", "Hero2_BuildCannon")
	--Ari
		XGUIEng.TransferMaterials("Build_Outpost", "Hero5_Camouflage")
	--KalaAbility I
		for i= 0, 17, 1 do
			XGUIEng.SetMaterialTexture("QuestInformationIcon", i, "data\\graphics\\textures\\gui\\questinformation\\nephtower.png")
		end    
			XGUIEng.TransferMaterials("QuestInformationIcon","Hero12_PoisonArrows")
--##--			
	elseif HeroGUIUpdateTicker == 10 then
	--KalaAbility II
		for i= 0, 17, 1 do
			XGUIEng.SetMaterialTexture("QuestInformationIcon", i, "data\\graphics\\textures\\gui\\questinformation\\nephilim.png")
		end    
			XGUIEng.TransferMaterials("QuestInformationIcon","Hero12_PoisonRange")
--##--			
	elseif HeroGUIUpdateTicker == 20 then
	--Kerberos
		for i= 0, 17, 1 do
			XGUIEng.SetMaterialTexture("QuestInformationIcon", i, "data\\graphics\\textures\\gui\\questinformation\\tower.png")
		end    
			XGUIEng.TransferMaterials("QuestInformationIcon","Hero7_Madness")
	end
--##--

	HeroGUIUpdateTicker = HeroGUIUpdateTicker + 1
	if HeroGUIUpdateTicker >= 60 then
		HeroGUIUpdateTicker = nil
		return true
	end
end
--
function OnPeacetimeOver()
	for j = 1, 4 do
		ReplaceEntity("StoneGate_"..j, Entities.XD_WallStraightGate)
		MakeVulnerable("StoneGate_"..j)
		Wettersperre = false
    end
	--
	StartSimpleJob("DomTimerStartCountdown")
end
--
function DomTimerStartCountdown()
	if Counter.Tick2("TimerDelayDom", 10) then
		if DombausperreCountdown > 10 then
			MapLocal_StartCountDown(DombausperreCountdown)
		end
		return true
	end
end
--
function OnGameStart()
	HeldenmodusStarten()
	ComfortsStarten()
	--
	StartSimpleHiResJob("WsWettersperre")
	--
	StartSimpleJob("WeatherLoad")
	StartSimpleJob("GameFuncStart")
	StartSimpleJob("HQDeadVictory")
	Chests()
	StartSimpleJob("RTW1Repeat")
end
--
function WsWettersperre()
	local playerID = GUI.GetPlayerID() 
	if Logic.GetPlayersGlobalResource(playerID, ResourceType.WeatherEnergy) >= 2 then
		Logic.AddToPlayersGlobalResource(playerID, ResourceType.WeatherEnergy, -2)
	end
--
	if Wettersperre == false then
		return true
	end
end
--
function GameFuncStart()
	DamagePlayerEntitiesInAreas_Init() -- Für Mary de Mortfichet
	MilitaryControl()
	EroberungspunkteStart()
	DompunkteStart()
	StartAllyAiControle()
	return true
end

--##--
function Chests()
	StartSimpleJob("Action_ChestJob") -- Comforts
	CreateRandomGoldChests()
  
	CreateChest(GetPosition("HiddenCestPlayer_1"), chestCallbackPlayer_1)
	CreateChest(GetPosition("HiddenCestPlayer_2"), chestCallbackPlayer_2)
	CreateChest(GetPosition("HiddenCestPlayer_3"), chestCallbackPlayer_3)
	CreateChest(GetPosition("HiddenCestPlayer_4"), chestCallbackPlayer_4)
  
	StartChestQuest()
end
--
function chestCallbackPlayer_1(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 1000)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 1 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1000 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--
function chestCallbackPlayer_2(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 1000)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 2 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1000 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--
function chestCallbackPlayer_3(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 1250)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 3 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1250 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--
function chestCallbackPlayer_4(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 1250)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 4 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1250 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--##--

function Questbuch()
	Logic.AddQuest(1, 1, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws 0 oder Ws 40, bei keiner Einigung muss WS 0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei! @cr @cr @color:255,255,255 5.) Dz Trade in der @color:255,50,50 Spielerbasis ist nicht @color:255,255,255 erlaubt, sobald der Siedlungsplatz einmal bebaut wurde! Dorfzentren in der Kartenmitte dürfen allerdings getauscht werden!", 1) 
	Logic.AddQuest(1, 2, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(1, 3, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(1, 4, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(2, 5, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws 0 oder Ws 40, bei keiner Einigung muss WS 0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei! @cr @cr @color:255,255,255 5.) Dz Trade in der @color:255,50,50 Spielerbasis ist nicht @color:255,255,255 erlaubt, sobald der Siedlungsplatz einmal bebaut wurde! Dorfzentren in der Kartenmitte dürfen allerdings getauscht werden!", 1) 
	Logic.AddQuest(2, 6, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(2, 7, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(2, 8, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(3, 9, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws 0 oder Ws 40, bei keiner Einigung muss WS 0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei! @cr @cr @color:255,255,255 5.) Dz Trade in der @color:255,50,50 Spielerbasis ist nicht @color:255,255,255 erlaubt, sobald der Siedlungsplatz einmal bebaut wurde! Dorfzentren in der Kartenmitte dürfen allerdings getauscht werden!", 1)  
	Logic.AddQuest(3, 10, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(3, 11, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(3, 12, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(4, 13, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws 0 oder Ws 40, bei keiner Einigung muss WS 0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei! @cr @cr @color:255,255,255 5.) Dz Trade in der @color:255,50,50 Spielerbasis ist nicht @color:255,255,255 erlaubt, sobald der Siedlungsplatz einmal bebaut wurde! Dorfzentren in der Kartenmitte dürfen allerdings getauscht werden!", 1) 
	Logic.AddQuest(4, 14, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(4, 15, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(4, 16, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(17, 17, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws 0 oder Ws 40, bei keiner Einigung muss WS 0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei! @cr @cr @color:255,255,255 5.) Dz Trade in der @color:255,50,50 Spielerbasis ist nicht @color:255,255,255 erlaubt, sobald der Siedlungsplatz einmal bebaut wurde! Dorfzentren in der Kartenmitte dürfen allerdings getauscht werden!", 1)  
	Logic.AddQuest(17, 18, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind! Aufgrund des deaktivierten HQ-Rush Schutzes wurde der Rüstungswert der Zitadelle angehoben", 1) 
	Logic.AddQuest(17, 19, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(17, 20, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
Logic.AddQuest(1, 21, MAINQUEST_OPEN, "@color:0,255,255 Änderungen Wintertunier 2024", "@color:0,0,255 1.) @color:255,255,0 Die Tribute @color:255,255,255 für die verbündete KI wurden erhöht, sowie neu gebalanced. @cr @cr @color:0,0,255 2.) @color:255,255,255 Die @color:255,255,0 defensiv Truppen @color:255,255,255 der KI patroullieren nun, sowie eine Fehlerbehebung beim Nachkauf der schnelleren Respawn Zeit. @cr @cr @color:0,0,255 3.) @color:255,255,255 Neuer Tribut hinzugefügt: @color:255,255,0 Offensiv Beteiligung @color:255,255,255 - Eure verbündete KI greift aktiv euren Gegner an. Ihre Stärke hängt davon ab, wie viele Dorfzentren ihr in der mitte erobert @color:255,255,85 (Das Dorfzentrum in der Kartenmitte beim Wetterturm beeinflusst diese Stärke nicht). @color:255,255,255 @cr @cr @color:0,0,255 4.) @color:255,255,0 Überarbeitung der eroberbare Dorfzentren: @color:255,255,255 - Von den 7 eroberbaren Dorfzentren können nur noch 3 von den Spielern selbst beansprucht werden @color:255,255,85 [2 Insel Dorfzentren, 1 Wetterturm Dorfzentrum] @color:255,255,255 Die anderen 4 Dorfzentren @color:255,255,85 [2 Reiterei Dorfzentren, 2 Kanonenmanufaktur Dorfzentren] @color:255,255,255 können nur noch für die eigene verbündete KI erobert werden, deren Stärke für ihre Offensiv Armee davon abhängt. @cr @cr @color:0,0,255 5.) @color:255,255,255 Aufgrund des deaktivierten HQ-Rush Schutzes wurde der @color:255,255,0 Rüstungswert der Zitadelle @color:255,255,255 stark angehoben. @cr @cr @color:0,0,255 6.) @color:255,255,0 Die Spieler 3 und 4 erhalten etwas mehr Gold @color:255,255,255 aus ihren Kisten als Schadensersatz für die ungünstigere Position ihrer Steinminen. @cr @cr @color:0,0,255 7.) @color:255,255,0 Der Veteran Captain @color:255,255,85 [Erhaltbar durch Kerberos] @color:255,255,255 und @color:255,255,0 der Veteran Leutnant @color:255,255,85 [Erhaltbar durch Varg] @color:255,255,255 haben Anpassungen bezüglich Rüstungswert, Schaden @color:255,255,85 [Durch Schmiedetechnologien sowie das Sägewerk] @color:255,255,255, Unterhaltskosten und Rekrutierungskosten erhalten", 1) 
Logic.AddQuest(2, 22, MAINQUEST_OPEN, "@color:0,255,255 Änderungen Wintertunier 2024", "@color:0,0,255 1.) @color:255,255,0 Die Tribute @color:255,255,255 für die verbündete KI wurden erhöht, sowie neu gebalanced. @cr @cr @color:0,0,255 2.) @color:255,255,255 Die @color:255,255,0 defensiv Truppen @color:255,255,255 der KI patroullieren nun, sowie eine Fehlerbehebung beim Nachkauf der schnelleren Respawn Zeit. @cr @cr @color:0,0,255 3.) @color:255,255,255 Neuer Tribut hinzugefügt: @color:255,255,0 Offensiv Beteiligung @color:255,255,255 - Eure verbündete KI greift aktiv euren Gegner an. Ihre Stärke hängt davon ab, wie viele Dorfzentren ihr in der mitte erobert @color:255,255,85 (Das Dorfzentrum in der Kartenmitte beim Wetterturm beeinflusst diese Stärke nicht). @color:255,255,255 @cr @cr @color:0,0,255 4.) @color:255,255,0 Überarbeitung der eroberbare Dorfzentren: @color:255,255,255 - Von den 7 eroberbaren Dorfzentren können nur noch 3 von den Spielern selbst beansprucht werden @color:255,255,85 [2 Insel Dorfzentren, 1 Wetterturm Dorfzentrum] @color:255,255,255 Die anderen 4 Dorfzentren @color:255,255,85 [2 Reiterei Dorfzentren, 2 Kanonenmanufaktur Dorfzentren] @color:255,255,255 können nur noch für die eigene verbündete KI erobert werden, deren Stärke für ihre Offensiv Armee davon abhängt. @cr @cr @color:0,0,255 5.) @color:255,255,255 Aufgrund des deaktivierten HQ-Rush Schutzes wurde der @color:255,255,0 Rüstungswert der Zitadelle @color:255,255,255 stark angehoben. @cr @cr @color:0,0,255 6.) @color:255,255,0 Die Spieler 3 und 4 erhalten etwas mehr Gold @color:255,255,255 aus ihren Kisten als Schadensersatz für die ungünstigere Position ihrer Steinminen.", 1) 
Logic.AddQuest(3, 23, MAINQUEST_OPEN, "@color:0,255,255 Änderungen Wintertunier 2024", "@color:0,0,255 1.) @color:255,255,0 Die Tribute @color:255,255,255 für die verbündete KI wurden erhöht, sowie neu gebalanced. @cr @cr @color:0,0,255 2.) @color:255,255,255 Die @color:255,255,0 defensiv Truppen @color:255,255,255 der KI patroullieren nun, sowie eine Fehlerbehebung beim Nachkauf der schnelleren Respawn Zeit. @cr @cr @color:0,0,255 3.) @color:255,255,255 Neuer Tribut hinzugefügt: @color:255,255,0 Offensiv Beteiligung @color:255,255,255 - Eure verbündete KI greift aktiv euren Gegner an. Ihre Stärke hängt davon ab, wie viele Dorfzentren ihr in der mitte erobert @color:255,255,85 (Das Dorfzentrum in der Kartenmitte beim Wetterturm beeinflusst diese Stärke nicht). @color:255,255,255 @cr @cr @color:0,0,255 4.) @color:255,255,0 Überarbeitung der eroberbare Dorfzentren: @color:255,255,255 - Von den 7 eroberbaren Dorfzentren können nur noch 3 von den Spielern selbst beansprucht werden @color:255,255,85 [2 Insel Dorfzentren, 1 Wetterturm Dorfzentrum] @color:255,255,255 Die anderen 4 Dorfzentren @color:255,255,85 [2 Reiterei Dorfzentren, 2 Kanonenmanufaktur Dorfzentren] @color:255,255,255 können nur noch für die eigene verbündete KI erobert werden, deren Stärke für ihre Offensiv Armee davon abhängt. @cr @cr @color:0,0,255 5.) @color:255,255,255 Aufgrund des deaktivierten HQ-Rush Schutzes wurde der @color:255,255,0 Rüstungswert der Zitadelle @color:255,255,255 stark angehoben. @cr @cr @color:0,0,255 6.) @color:255,255,0 Die Spieler 3 und 4 erhalten etwas mehr Gold @color:255,255,255 aus ihren Kisten als Schadensersatz für die ungünstigere Position ihrer Steinminen.", 1) 
Logic.AddQuest(4, 24, MAINQUEST_OPEN, "@color:0,255,255 Änderungen Wintertunier 2024", "@color:0,0,255 1.) @color:255,255,0 Die Tribute @color:255,255,255 für die verbündete KI wurden erhöht, sowie neu gebalanced. @cr @cr @color:0,0,255 2.) @color:255,255,255 Die @color:255,255,0 defensiv Truppen @color:255,255,255 der KI patroullieren nun, sowie eine Fehlerbehebung beim Nachkauf der schnelleren Respawn Zeit. @cr @cr @color:0,0,255 3.) @color:255,255,255 Neuer Tribut hinzugefügt: @color:255,255,0 Offensiv Beteiligung @color:255,255,255 - Eure verbündete KI greift aktiv euren Gegner an. Ihre Stärke hängt davon ab, wie viele Dorfzentren ihr in der mitte erobert @color:255,255,85 (Das Dorfzentrum in der Kartenmitte beim Wetterturm beeinflusst diese Stärke nicht). @color:255,255,255 @cr @cr @color:0,0,255 4.) @color:255,255,0 Überarbeitung der eroberbare Dorfzentren: @color:255,255,255 - Von den 7 eroberbaren Dorfzentren können nur noch 3 von den Spielern selbst beansprucht werden @color:255,255,85 [2 Insel Dorfzentren, 1 Wetterturm Dorfzentrum] @color:255,255,255 Die anderen 4 Dorfzentren @color:255,255,85 [2 Reiterei Dorfzentren, 2 Kanonenmanufaktur Dorfzentren] @color:255,255,255 können nur noch für die eigene verbündete KI erobert werden, deren Stärke für ihre Offensiv Armee davon abhängt. @cr @cr @color:0,0,255 5.) @color:255,255,255 Aufgrund des deaktivierten HQ-Rush Schutzes wurde der @color:255,255,0 Rüstungswert der Zitadelle @color:255,255,255 stark angehoben. @cr @cr @color:0,0,255 6.) @color:255,255,0 Die Spieler 3 und 4 erhalten etwas mehr Gold @color:255,255,255 aus ihren Kisten als Schadensersatz für die ungünstigere Position ihrer Steinminen.", 1) 
Logic.AddQuest(17, 25, MAINQUEST_OPEN, "@color:0,255,255 Änderungen Wintertunier 2024", "@color:0,0,255 1.) @color:255,255,0 Die Tribute @color:255,255,255 für die verbündete KI wurden erhöht, sowie neu gebalanced. @cr @cr @color:0,0,255 2.) @color:255,255,255 Die @color:255,255,0 defensiv Truppen @color:255,255,255 der KI patroullieren nun, sowie eine Fehlerbehebung beim Nachkauf der schnelleren Respawn Zeit. @cr @cr @color:0,0,255 3.) @color:255,255,255 Neuer Tribut hinzugefügt: @color:255,255,0 Offensiv Beteiligung @color:255,255,255 - Eure verbündete KI greift aktiv euren Gegner an. Ihre Stärke hängt davon ab, wie viele Dorfzentren ihr in der mitte erobert @color:255,255,85 (Das Dorfzentrum in der Kartenmitte beim Wetterturm beeinflusst diese Stärke nicht). @color:255,255,255 @cr @cr @color:0,0,255 4.) @color:255,255,0 Überarbeitung der eroberbare Dorfzentren: @color:255,255,255 - Von den 7 eroberbaren Dorfzentren können nur noch 3 von den Spielern selbst beansprucht werden @color:255,255,85 [2 Insel Dorfzentren, 1 Wetterturm Dorfzentrum] @color:255,255,255 Die anderen 4 Dorfzentren @color:255,255,85 [2 Reiterei Dorfzentren, 2 Kanonenmanufaktur Dorfzentren] @color:255,255,255 können nur noch für die eigene verbündete KI erobert werden, deren Stärke für ihre Offensiv Armee davon abhängt. @cr @cr @color:0,0,255 5.) @color:255,255,255 Aufgrund des deaktivierten HQ-Rush Schutzes wurde der @color:255,255,0 Rüstungswert der Zitadelle @color:255,255,255 stark angehoben. @cr @cr @color:0,0,255 6.) @color:255,255,0 Die Spieler 3 und 4 erhalten etwas mehr Gold @color:255,255,255 aus ihren Kisten als Schadensersatz für die ungünstigere Position ihrer Steinminen.", 1)
end

--##--
function RTW1Repeat()
	if Counter.Tick2("RTW1", 1800) then
		MusicRtwI()
		return false
	end
end
--
function MusicOddM() -- Dario callt Winter
	Message("@color:200,0,0 Musik: @color:0,155,155 Orks On Da Move")
	Sound.StartMusic("data\\maps\\externalmap\\orksondamove.mp3", 130)
	LocalMusic.SongLength =  Logic.GetTime() + 180
end
--
function MusicIts() -- Dombausieg erreichbar
	Message("@color:200,0,0 Musik: @color:0,155,155 Ivan Torrent - Supernova")
	Sound.StartMusic("data\\maps\\externalmap\\ivantorrentsupernova.mp3", 130)
	LocalMusic.SongLength =  Logic.GetTime() + 177
end
--
function MusicRtwI() -- Mapstart + 30 min
	Message("@color:200,0,0 Musik: @color:0,155,155 Rome total war - Main menu music")
	Sound.StartMusic("data\\maps\\externalmap\\rtwintro.mp3", 130)
	LocalMusic.SongLength =  Logic.GetTime() + 181
end
--##--

function TestGame(player)
	AddGold(player, 1000000)
	AddClay(player, 1000000)
	AddWood(player, 1000000)
	AddStone(player, 1000000)
	AddIron(player, 1000000)
	AddSulfur(player, 1000000)
	--
	Logic.SetTechnologyState(player, Technologies.UP1_University, 3)
	Logic.SetTechnologyState(player, Technologies.GT_GearWheel, 3)
	Logic.SetTechnologyState(player, Technologies.UP1_Headquarter, 3)
	Logic.SetTechnologyState(player, Technologies.UP2_Headquarter, 3)
	Logic.SetTechnologyState(player, Technologies.GT_ChainBlock, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Alloying, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Matchlock, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Trading, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Tactics, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Printing, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Metallurgy, 3)
	Logic.SetTechnologyState(player, Technologies.GT_PulledBarrel, 3)
	Logic.SetTechnologyState(player, Technologies.B_Bridge,3)
	Logic.SetTechnologyState(player, Technologies.GT_Chemistry, 3)
	Logic.SetTechnologyState(player, Technologies.UP2_Tower,3)
	Logic.SetTechnologyState(player, Technologies.GT_Architecture, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Strategies, 3)
	Logic.SetTechnologyState(player, Technologies.GT_Library, 3)
	--
	SetFriendly(1,7)
	DestroyEntity("DzManufakturSued")
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
	Logic.CreateEntity(Entities.PU_Serf, 31519, 56506, 0, 1)
end