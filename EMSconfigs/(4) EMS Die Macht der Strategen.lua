
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
	Version = 3.0,
 
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
		--
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
	AntiHQRush = 1,
 
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
	--
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
end
--
function OnGameStart()
	ComfortsStarten()
	--
	TechSperren()
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
function TechSperren()
	for SpielerID = 1, 4 do
		-- Logic.SetTechnologyState(SpielerID, Technologies.UP1_Market, 0) -- Marktplatz
		Logic.SetTechnologyState(SpielerID,Technologies.B_Weathermachine, 0) -- Wetterturm
		Logic.SetTechnologyState(SpielerID,Technologies.B_PowerPlant,0) -- Wetterkraftwerk
		Logic.SetTechnologyState(SpielerID,Technologies.B_Stables, 0) -- Stall
		Logic.SetTechnologyState(SpielerID,Technologies.B_Foundry, 0) -- Kanonengießerei
		Logic.SetTechnologyState(SpielerID,Technologies.UP1_Tower, 0) -- Ballistaturm
	end
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
	HeldenwahlSpieler()
	for i = 1, 4 do
		Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, "", "HeldenWahlSpieler", 1, {}, {i})
	end
	--
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
    AddGold(playerID, 1000)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 3 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1000 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--
function chestCallbackPlayer_4(opener)
    local playerID = GetPlayer(opener)
    AddGold(playerID, 1000)
--
    if GUI.GetPlayerID() == playerID then
        if playerID == 4 then
           Message("@color:50,205,50 Ihr habt Eure Truhe mit 1000 Taler gefunden!");
        else
           Message("@color:250,55,50 Ihr habt die Truhe von Spieler 1 gemobst, das bringt schlechtes Karma mit sich!");
        end
		Sound.PlayGUISound(Sounds.OnKlick_Select_erec, 100);
    end
end
--##--

function Questbuch()
	Logic.AddQuest(1, 1, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws0 oder Ws40, bei keiner Einigung muss WS0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei!", 1) 
	Logic.AddQuest(1, 2, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(1, 3, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(1, 4, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(2, 5, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws0 oder Ws40, bei keiner Einigung muss WS0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei!", 1) 
	Logic.AddQuest(2, 6, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(2, 7, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(2, 8, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(3, 9, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws0 oder Ws40, bei keiner Einigung muss WS0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei!", 1)  
	Logic.AddQuest(3, 10, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(3, 11, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(3, 12, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(4, 13, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws0 oder Ws40, bei keiner Einigung muss WS0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei!", 1) 
	Logic.AddQuest(4, 14, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(4, 15, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(4, 16, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
	Logic.AddQuest(17, 17, MAINQUEST_OPEN, "@color:255,255,0 Allgemeine Informationen", "@color:255,255,0 Siegesmöglichkeiten und Regeln: @cr @cr @color:255,255,255 1.) Die Karte hat 3 Siegesoptionen: Militärischer Sieg | Eroberungs Sieg | Dombau Sieg @cr @cr @color:124,255,0 2.) Erlaubte Agreements sind: @color:255,255,255 @cr Ws0 oder Ws40, bei keiner Einigung muss WS0 gespielt werden! [Die Tore von Alesia und Rom sind geschlossen | Dario regeneriert während dem WS keine Energie] @cr @cr @color:255,255,0 Weitere Informationen: @cr @cr @color:255,255,255 1.) Im Tributmenü können Spieler 1 und Spieler 3 eine defensive KI erwerben! @cr @cr 2.) a.) Die Gallier und Rom stehen neutral zu den Banditen! | b.) Das Dorfzentrum Eurer KI wird frei, wenn die Motte der KI fällt! | c.) Die Gallier und Rom haben Söldnerquatiere mit einem begrenztem Truppenlimit! @cr @cr 3.) Motten haben deutlich mehr Rüstungspunkte und dunkle Kanonentürme sind deutlich verstärkt worden @cr @cr @color:0,255,255 4.) Ställe, Kanonengießereien und Ballistatürme können auf dieser Map nicht gebaut werden! Jedoch sind diese Gebäude auf der Karte eroberbar! Um die Kontrolle über diese miltärischen Gebäude zu bekommen, muss vor Ort das Dorfzentrum aufgebaut werden! Auch bestimmte Helden schalten gesperrte Gebäude frei!", 1)  
	Logic.AddQuest(17, 18, MAINQUEST_OPEN, "@color:255,255,0 [1] Der Militärische Sieg", "@color:255,255,0 Schwierigkeit: normal zu erreichen @cr @cr @color:255,255,255 Der klassische Sieg: Das Spiel gilt militärisch als gewonnen, wenn beide Haupthäuser eines Teams zerstört worden sind!", 1) 
	Logic.AddQuest(17, 19, MAINQUEST_OPEN, "@color:255,255,0 [2] Der Eroberungs Sieg", "@color:255,255,0 Schwierigkeit: schwer zu erreichen @cr @cr @color:255,255,255 In der Kartenmitte existieren @color:255,0,0 5 eroberbare Dorfzentren @color:255,255,255 (nicht die beiden Dorfzentren auf den Inseln am Kartenrand). Wenn ein Team alle 5 Dorfzentren kontrolliert, startet der Zähler für den Eroberungs Sieg. Wenn ein Team alle 5 Dorfzentren @color:255,0,0 für 15 Minuten @color:255,255,255 halten kann, gewinnt dieses Team. @cr @cr @color:0,255,255 Wichtig: Ein Dorfzentrum gilt als verloren: Wenn a.) Von den 5 Dorfzentren eines zerstört wird @color:255,0,0 UND @color:0,255,255 b.) vom gegnerischem Team erfolgreich aufgebaut wurde! @cr @cr @color:255,255,255 Tritt dieser Fall ein, werden dem Team, welches von den 5 Dorfzentren eines verloren hat, die Punkte wieder langsam abgezogen! Abwärtszählend bei 0 wieder angekommen passiert nichts, es muss wieder von neuem angefangen werden. @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -schwer zu erreichen- eingestuft, da der Eroberungssieg ein Risiko birgt. @cr @color:255,255,255 Die verbündete Motte (Die Gallier oder Rom) wird, vorrausgesetzt die Motte ist noch am Leben, militärisch massiv anfangen, das Team anzugreifen, welches die 5 zusätzlichen Dorfzentren kontrolliert. Diese KI wird ihre Angriffe allerdings nicht bei einem Dorfzentrum Verlust anfangen zu stoppen. Sie wird solange das gegnerische Team angreifen, bis deren Haupthäuser fallen!", 1)
	Logic.AddQuest(17, 20, MAINQUEST_OPEN, "@color:255,255,0 [3] Der Dombau Sieg", "@color:255,255,0 Schwierigkeit: sehr schwer zu erreichen @cr @cr @color:255,255,255 Um den Dom bei der verbündeten KI bauen zu können, müssen @color:255,0,0 3 Vorraussetzungen @color:255,255,255 erfüllt werden: @cr 1.) Beide Teammitglieder müssen @color:0,255,255 alle Technologien @color:255,255,255 erforscht haben. @cr 2.) Das Spiel muss mindestens @color:0,255,255 80 Minuten @color:255,255,255 dauern. (Countdown oben links bei Kartenstart) @cr 3.) Ein Team muss @color:0,255,255 zeitgleich beide Insel Dorfzentren für 20 Minuten @color:255,255,255 gehalten haben. @cr @cr 4.) Am Ende muss ein @color:255,255,0 Tribut in 50.000 Höhe @color:255,255,255 bezahlt werden, um den Dom zu bauen. @color:255,255,0 Welche der 6 Ressourcenarten verlangt wird, wird kurz zuvor zufällig im Skript bestimmt! @color:255,255,255 @cr 5.) Der @color:255,255,0 Dom muss für 10 Minuten verteidigt @color:255,255,255 werden! Das Team, welches den Dom in Auftrag gegeben hat, wird @color:255,255,0 im Sekundentakt Ressourcen verlieren. @color:255,255,255 In der ersten Minute sind es 100 Ressourcen jeder Art, in der zweiten Minute 200 Ressourcen jeder Art, usw. @cr @cr Desweiter zu beachten: @cr a.) Geht die Dombaustelle im Spielverlauf verloren, ist @color:255,120,255 der Dombausieg nicht mehr zu erreichen. @color:255,255,255 @cr b.) Fällt der errichtete Dom, @color:255,120,255 verliert das Team, @color:255,255,255 welches den Dom in Auftrag gegeben hat! @cr @cr @color:255,255,0 Info: Dieser Sieg ist als -sehr schwer zu erreichen- eingestuft, da viele Vorraussetzungen erfüllt werden müssen. @cr @color:255,255,255 Der Dombau Sieg soll grundsätzlich einem Team eine Perspektive auf einen Sieg bringen, welches 2/3 der Kartenkontrolle verloren hat, eine Alternative zum -Self Destruct- sozusagen. Jedoch müssen zuerst, aus fairniss Gründen, (harte) Bedingungen erfüllt werden, damit der Dombausieg auch eine faire Siegesoption ist.", 1) 
--
Logic.AddQuest(1, 21, MAINQUEST_OPEN, "@color:121,205,205 Heldenmodus: Gute Helden", "@color:0,100,255  1.) Dario: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wetteränderung durch Orb [kein Wetterkraftwerk baubar!] | @color:255,255,255 Passive Fähigkeit: @color:155,100,155 Königliche Leibarde @color:255,255,255 (Erreicht Dario 150 HP, kommt seine Leibgarde. 10 Min Cooldown) @cr @cr @color:139,69,19 2.) Pilgrim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Eisenkanone | @color:255,255,255 Passive Fähigkeit: 1.) @color:155,100,155 Tod des Sprengmeisters @color:255,255,255 (Riesenexplosion, wenn Pilgrim stirbt, beim siebtem Tod ist Pilgrim als Held verloren) 2.) @color:155,100,155 Kanonenmeister @color:255,255,255 Pilgrim besitzt Baupläne für Kanonengießer und Türme! @cr @cr @color:173,255,47 3.) Salim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Fallenleger @color:255,255,255 (verstärkt + nahezu unsichtbar für Feinde) | Passive Fähigkeit: @color:155,100,155 Versorgungsmeister @color:255,255,255 (Farmen benötigen nur einen Bauern, welche auch kein Dz Platz verbrauchen. Mühlen und Gutshöfe geben mehr Dz Platz bei mindestens 50 Prozent Belegschaft! ) @cr @cr @color:50,205,50 4.) Erec: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wirbelschlag @color:255,255,255 (Verstärkt) | Passive Fähigkeit: 1.) @color:155,100,155 Beliebter Heerführer @color:255,255,255 (Soldaten fordern keinen Sold) 2.) @color:155,100,155 Heermeister @color:255,255,255 Erec besitzt Baupläne für Ställe @cr @cr @color:255,140,0 5.) Ari: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Aris Freunde @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Banditenführerin @color:255,255,255 (Kann immer EINEN verbündeten Banditenposten gründen) @cr @cr @color:240,128,128 6.) Helias: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Gottes Schutz @color:255,255,255 (Kurze Unverwundbarkeit für Soldaten im Umkreis) | Passive Fähigkeit: @color:155,100,155 Bescheidenheit @color:255,255,255 (Dorfzentren geben deutlich mehr Platz) @cr @cr @color:255,130,71 7.) Drake: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Meisterschütze @color:255,255,255 | Passive Fähigkeit: @color:155,100,155 Headshot @color:255,255,255 (Tötet gegnerische Helden, ausnahmslos, endgültig) @cr @cr @color:255,20,147 8.) Yuki: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Shuriken @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Freudenfeuerwerk @color:255,255,255 (Yuki bringt Euch sofort eine 300 Motivation (Bei Selektion vor erstem Zahltag 500!), solange sie lebt. Auch habt ihr ein neues Maximum an Motivation. @color:255,60,120 500 @color:255,255,255 ! Diese könnt Ihr ohne Zierobkekte erreichen!)", 1) 
Logic.AddQuest(1, 22, MAINQUEST_OPEN, "@color:238,44,44 Heldenmodus: Böse Helden", "@color:255,20,20 1.) Kala: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wohnstätte @color:255,255,255 (Kala kann einen nah gelegenen Turm, jeder Art, in eine Wohnstätte verwandeln!) | Passive Fähigkeit: @color:155,100,155 Brutmeisterin @color:255,255,255 (Kala kann immer wieder Truppen ihrer Sippe unabhängig vom Siedlungsplatz erwerben) @cr @cr @color:131,139,139 2.) Kerberos: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Dunkler Heerführer @color:255,255,255 (Kerberos ruft Elitekrieger mit unbegrenzter Lebensdauer herbei) | @color:155,100,155 Dunkler Kanonenturm @color:255,255,255 (Kerberos kann [begrenzt] jeden Spielereigenen Turm in einen mächtigen dunklen Kanonenturm umwandeln!) | Passive Fähigkeit: @color:155,100,155 Mächtige Rüstung @color:255,255,255 (Kerberos hat die stärksten Werte aller Helden) @cr @cr @color:190,190,190 3.) Varg: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Barbarenclan @color:255,255,255 (Varg ruft Elitekrieger der Barbaren mit begrenzter Lebensdauer herbei) | Aktive Fähigkeit: @color:155,100,155 Leitwolf @color:255,255,255 (Varg ruft Wölfe, welche keine begrenzte Lebenszeit haben, herbei!) @cr @cr @color:205,51,51 4.) Mary de Mortfichet: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Verführerin @color:255,255,255 (Mary kann fast jeden gegnerischen Helden, auch bei deren Bewusstlosigkeit, bekehren, außer ihr Gegenstück! Sie startet mit einer Erfolgswahrscheinlichkeit von 4 Prozent, mit jedem Fehlschlag steigt die Wahrscheinlichkeit auf Erfolg auf ein Maximum von 40 Prozent!) @cr Stirbt Mary, resettet sich Ihr Erfolgswert auf 4 Prozent! | Passive Fähigkeit: @color:155,100,155 Giftschutz @color:255,255,255 (Wichtige Gebäude und Arbeitergebäude des Spielers werden von einem tödlichem Nebel geschützt!)", 1)
--
Logic.AddQuest(2, 23, MAINQUEST_OPEN, "@color:121,205,205 Heldenmodus: Gute Helden", "@color:0,100,255  1.) Dario: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wetteränderung durch Orb [kein Wetterkraftwerk baubar!] | @color:255,255,255 Passive Fähigkeit: @color:155,100,155 Königliche Leibarde @color:255,255,255 (Erreicht Dario 150 HP, kommt seine Leibgarde. 10 Min Cooldown) @cr @cr @color:139,69,19 2.) Pilgrim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Eisenkanone | @color:255,255,255 Passive Fähigkeit: 1.) @color:155,100,155 Tod des Sprengmeisters @color:255,255,255 (Riesenexplosion, wenn Pilgrim stirbt, beim siebtem Tod ist Pilgrim als Held verloren) 2.) @color:155,100,155 Kanonenmeister @color:255,255,255 Pilgrim besitzt Baupläne für Kanonengießer und Türme! @cr @cr @color:173,255,47 3.) Salim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Fallenleger @color:255,255,255 (verstärkt + nahezu unsichtbar für Feinde) | Passive Fähigkeit: @color:155,100,155 Versorgungsmeister @color:255,255,255 (Farmen benötigen nur einen Bauern, welche auch kein Dz Platz verbrauchen. Mühlen und Gutshöfe geben mehr Dz Platz bei mindestens 50 Prozent Belegschaft!) @cr @cr @color:50,205,50 4.) Erec: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wirbelschlag @color:255,255,255 (Verstärkt) | Passive Fähigkeit: 1.) @color:155,100,155 Beliebter Heerführer @color:255,255,255 (Soldaten fordern keinen Sold) 2.) @color:155,100,155 Heermeister @color:255,255,255 Erec besitzt Baupläne für Ställe @cr @cr @color:255,140,0 5.) Ari: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Aris Freunde @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Banditenführerin @color:255,255,255 (Kann immer EINEN verbündeten Banditenposten gründen) @cr @cr @color:240,128,128 6.) Helias: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Gottes Schutz @color:255,255,255 (Kurze Unverwundbarkeit für Soldaten im Umkreis) | Passive Fähigkeit: @color:155,100,155 Bescheidenheit @color:255,255,255 (Dorfzentren geben deutlich mehr Platz) @cr @cr @color:255,130,71 7.) Drake: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Meisterschütze @color:255,255,255 | Passive Fähigkeit: @color:155,100,155 Headshot @color:255,255,255 (Tötet gegnerische Helden, ausnahmslos, endgültig) @cr @cr @color:255,20,147 8.) Yuki: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Shuriken @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Freudenfeuerwerk @color:255,255,255 (Yuki bringt Euch sofort eine 300 Motivation (Bei Selektion vor erstem Zahltag 500!), solange sie lebt. Auch habt ihr ein neues Maximum an Motivation. @color:255,60,120 500 @color:255,255,255 ! Diese könnt Ihr ohne Zierobkekte erreichen!)", 1) 
Logic.AddQuest(2, 24, MAINQUEST_OPEN, "@color:238,44,44 Heldenmodus: Böse Helden", "@color:255,20,20 1.) Kala: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wohnstätte @color:255,255,255 (Kala kann einen nah gelegenen Turm, jeder Art, in eine Wohnstätte verwandeln!) | Passive Fähigkeit: @color:155,100,155 Brutmeisterin @color:255,255,255 (Kala kann immer wieder Truppen ihrer Sippe unabhängig vom Siedlungsplatz erwerben) @cr @cr @color:131,139,139 2.) Kerberos: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Dunkler Heerführer @color:255,255,255 (Kerberos ruft Elitekrieger mit unbegrenzter Lebensdauer herbei) | @color:155,100,155 Dunkler Kanonenturm @color:255,255,255 (Kerberos kann [begrenzt] jeden Spielereigenen Turm in einen mächtigen dunklen Kanonenturm umwandeln!) | Passive Fähigkeit: @color:155,100,155 Mächtige Rüstung @color:255,255,255 (Kerberos hat die stärksten Werte aller Helden) @cr @cr @color:190,190,190 3.) Varg: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Barbarenclan @color:255,255,255 (Varg ruft Elitekrieger der Barbaren mit begrenzter Lebensdauer herbei) | Aktive Fähigkeit: @color:155,100,155 Leitwolf @color:255,255,255 (Varg ruft Wölfe, welche keine begrenzte Lebenszeit haben, herbei!) @cr @cr @color:205,51,51 4.) Mary de Mortfichet: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Verführerin @color:255,255,255 (Mary kann fast jeden gegnerischen Helden, auch bei deren Bewusstlosigkeit, bekehren, außer ihr Gegenstück! Sie startet mit einer Erfolgswahrscheinlichkeit von 4 Prozent, mit jedem Fehlschlag steigt die Wahrscheinlichkeit auf Erfolg auf ein Maximum von 40 Prozent!) @cr Stirbt Mary, resettet sich Ihr Erfolgswert auf 4 Prozent! | Passive Fähigkeit: @color:155,100,155 Giftschutz @color:255,255,255 (Wichtige Gebäude und Arbeitergebäude des Spielers werden von einem tödlichem Nebel geschützt!)", 1)
--
Logic.AddQuest(3, 25, MAINQUEST_OPEN, "@color:121,205,205 Heldenmodus: Gute Helden", "@color:0,100,255  1.) Dario: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wetteränderung durch Orb [kein Wetterkraftwerk baubar!] | @color:255,255,255 Passive Fähigkeit: @color:155,100,155 Königliche Leibarde @color:255,255,255 (Erreicht Dario 150 HP, kommt seine Leibgarde. 10 Min Cooldown) @cr @cr @color:139,69,19 2.) Pilgrim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Eisenkanone | @color:255,255,255 Passive Fähigkeit: 1.) @color:155,100,155 Tod des Sprengmeisters @color:255,255,255 (Riesenexplosion, wenn Pilgrim stirbt, beim siebtem Tod ist Pilgrim als Held verloren) 2.) @color:155,100,155 Kanonenmeister @color:255,255,255 Pilgrim besitzt Baupläne für Kanonengießer und Türme! @cr @cr @color:173,255,47 3.) Salim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Fallenleger @color:255,255,255 (verstärkt + nahezu unsichtbar für Feinde) | Passive Fähigkeit: @color:155,100,155 Versorgungsmeister @color:255,255,255 (Farmen benötigen nur einen Bauern, welche auch kein Dz Platz verbrauchen. Mühlen und Gutshöfe geben mehr Dz Platz bei mindestens 50 Prozent Belegschaft!) @cr @cr @color:50,205,50 4.) Erec: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wirbelschlag @color:255,255,255 (Verstärkt) | Passive Fähigkeit: 1.) @color:155,100,155 Beliebter Heerführer @color:255,255,255 (Soldaten fordern keinen Sold) 2.) @color:155,100,155 Heermeister @color:255,255,255 Erec besitzt Baupläne für Ställe @cr @cr @color:255,140,0 5.) Ari: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Aris Freunde @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Banditenführerin @color:255,255,255 (Kann immer EINEN verbündeten Banditenposten gründen) @cr @cr @color:240,128,128 6.) Helias: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Gottes Schutz @color:255,255,255 (Kurze Unverwundbarkeit für Soldaten im Umkreis) | Passive Fähigkeit: @color:155,100,155 Bescheidenheit @color:255,255,255 (Dorfzentren geben deutlich mehr Platz) @cr @cr @color:255,130,71 7.) Drake: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Meisterschütze @color:255,255,255 | Passive Fähigkeit: @color:155,100,155 Headshot @color:255,255,255 (Tötet gegnerische Helden, ausnahmslos, endgültig) @cr @cr @color:255,20,147 8.) Yuki: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Shuriken @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Freudenfeuerwerk @color:255,255,255 (Yuki bringt Euch sofort eine 300 Motivation (Bei Selektion vor erstem Zahltag 500!), solange sie lebt. Auch habt ihr ein neues Maximum an Motivation. @color:255,60,120 500 @color:255,255,255 ! Diese könnt Ihr ohne Zierobkekte erreichen!)", 1) 
Logic.AddQuest(3, 26, MAINQUEST_OPEN, "@color:238,44,44 Heldenmodus: Böse Helden", "@color:255,20,20 1.) Kala: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wohnstätte @color:255,255,255 (Kala kann einen nah gelegenen Turm, jeder Art, in eine Wohnstätte verwandeln!) | Passive Fähigkeit: @color:155,100,155 Brutmeisterin @color:255,255,255 (Kala kann immer wieder Truppen ihrer Sippe unabhängig vom Siedlungsplatz erwerben) @cr @cr @color:131,139,139 2.) Kerberos: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Dunkler Heerführer @color:255,255,255 (Kerberos ruft Elitekrieger mit unbegrenzter Lebensdauer herbei) | @color:155,100,155 Dunkler Kanonenturm @color:255,255,255 (Kerberos kann [begrenzt] jeden Spielereigenen Turm in einen mächtigen dunklen Kanonenturm umwandeln!) Passive Fähigkeit: @color:155,100,155 Mächtige Rüstung @color:255,255,255 (Kerberos hat die stärksten Werte aller Helden) @cr @cr @color:190,190,190 3.) Varg: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Barbarenclan @color:255,255,255 (Varg ruft Elitekrieger der Barbaren mit begrenzter Lebensdauer herbei) | Aktive Fähigkeit: @color:155,100,155 Leitwolf @color:255,255,255 (Varg ruft Wölfe, welche keine begrenzte Lebenszeit haben, herbei!) @cr @cr @color:205,51,51 4.) Mary de Mortfichet: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Verführerin @color:255,255,255 (Mary kann fast jeden gegnerischen Helden, auch bei deren Bewusstlosigkeit, bekehren, außer ihr Gegenstück! Sie startet mit einer Erfolgswahrscheinlichkeit von 4 Prozent, mit jedem Fehlschlag steigt die Wahrscheinlichkeit auf Erfolg auf ein Maximum von 40 Prozent!) @cr Stirbt Mary, resettet sich Ihr Erfolgswert auf 4 Prozent! | Passive Fähigkeit: @color:155,100,155 Giftschutz @color:255,255,255 (Wichtige Gebäude und Arbeitergebäude des Spielers werden von einem tödlichem Nebel geschützt!)", 1)
--
Logic.AddQuest(4, 27, MAINQUEST_OPEN, "@color:121,205,205 Heldenmodus: Gute Helden", "@color:0,100,255  1.) Dario: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wetteränderung durch Orb [kein Wetterkraftwerk baubar!] | @color:255,255,255 Passive Fähigkeit: @color:155,100,155 Königliche Leibarde @color:255,255,255 (Erreicht Dario 150 HP, kommt seine Leibgarde. 10 Min Cooldown) @cr @cr @color:139,69,19 2.) Pilgrim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Eisenkanone | @color:255,255,255 Passive Fähigkeit: 1.) @color:155,100,155 Tod des Sprengmeisters @color:255,255,255 (Riesenexplosion, wenn Pilgrim stirbt, beim siebtem Tod ist Pilgrim als Held verloren) 2.) @color:155,100,155 Kanonenmeister @color:255,255,255 Pilgrim besitzt Baupläne für Kanonengießer und Türme! @cr @cr @color:173,255,47 3.) Salim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Fallenleger @color:255,255,255 (verstärkt + nahezu unsichtbar für Feinde) | Passive Fähigkeit: @color:155,100,155 Versorgungsmeister @color:255,255,255 (Farmen benötigen nur einen Bauern, welche auch kein Dz Platz verbrauchen. Mühlen und Gutshöfe geben mehr Dz Platz bei mindestens 50 Prozent Belegschaft!) @cr @cr @color:50,205,50 4.) Erec: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wirbelschlag @color:255,255,255 (Verstärkt) | Passive Fähigkeit: 1.) @color:155,100,155 Beliebter Heerführer @color:255,255,255 (Soldaten fordern keinen Sold) 2.) @color:155,100,155 Heermeister @color:255,255,255 Erec besitzt Baupläne für Ställe @cr @cr @color:255,140,0 5.) Ari: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Aris Freunde @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Banditenführerin @color:255,255,255 (Kann immer EINEN verbündeten Banditenposten gründen) @cr @cr @color:240,128,128 6.) Helias: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Gottes Schutz @color:255,255,255 (Kurze Unverwundbarkeit für Soldaten im Umkreis) | Passive Fähigkeit: @color:155,100,155 Bescheidenheit @color:255,255,255 (Dorfzentren geben deutlich mehr Platz) @cr @cr @color:255,130,71 7.) Drake: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Meisterschütze @color:255,255,255 | Passive Fähigkeit: @color:155,100,155 Headshot @color:255,255,255 (Tötet gegnerische Helden, ausnahmslos, endgültig) @cr @cr @color:255,20,147 8.) Yuki: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Shuriken @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Freudenfeuerwerk @color:255,255,255 (Yuki bringt Euch sofort eine 300 Motivation (Bei Selektion vor erstem Zahltag 500!), solange sie lebt. Auch habt ihr ein neues Maximum an Motivation. @color:255,60,120 500 @color:255,255,255 ! Diese könnt Ihr ohne Zierobkekte erreichen!)", 1) 
Logic.AddQuest(4, 28, MAINQUEST_OPEN, "@color:238,44,44 Heldenmodus: Böse Helden", "@color:255,20,20 1.) Kala: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wohnstätte @color:255,255,255 (Kala kann einen nah gelegenen Turm, jeder Art, in eine Wohnstätte verwandeln!) | Passive Fähigkeit: @color:155,100,155 Brutmeisterin @color:255,255,255 (Kala kann immer wieder Truppen ihrer Sippe unabhängig vom Siedlungsplatz erwerben) @cr @cr @color:131,139,139 2.) Kerberos: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Dunkler Heerführer @color:255,255,255 (Kerberos ruft Elitekrieger mit unbegrenzter Lebensdauer herbei) | @color:155,100,155 Dunkler Kanonenturm @color:255,255,255 (Kerberos kann [begrenzt] jeden Spielereigenen Turm in einen mächtigen dunklen Kanonenturm umwandeln!) Passive Fähigkeit: @color:155,100,155 Mächtige Rüstung @color:255,255,255 (Kerberos hat die stärksten Werte aller Helden) @cr @cr @color:190,190,190 3.) Varg: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Barbarenclan @color:255,255,255 (Varg ruft Elitekrieger der Barbaren mit begrenzter Lebensdauer herbei) | Aktive Fähigkeit: @color:155,100,155 Leitwolf @color:255,255,255 (Varg ruft Wölfe, welche keine begrenzte Lebenszeit haben, herbei!) @cr @cr @color:205,51,51 4.) Mary de Mortfichet: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Verführerin @color:255,255,255 (Mary kann fast jeden gegnerischen Helden, auch bei deren Bewusstlosigkeit, bekehren, außer ihr Gegenstück! Sie startet mit einer Erfolgswahrscheinlichkeit von 4 Prozent, mit jedem Fehlschlag steigt die Wahrscheinlichkeit auf Erfolg auf ein Maximum von 40 Prozent!) @cr Stirbt Mary, resettet sich Ihr Erfolgswert auf 4 Prozent! | Passive Fähigkeit: @color:155,100,155 Giftschutz @color:255,255,255 (Wichtige Gebäude und Arbeitergebäude des Spielers werden von einem tödlichem Nebel geschützt!)", 1)
--
Logic.AddQuest(17, 29, MAINQUEST_OPEN, "@color:121,205,205 Heldenmodus: Gute Helden", "@color:0,100,255  1.) Dario: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wetteränderung durch Orb [kein Wetterkraftwerk baubar!] | @color:255,255,255 Passive Fähigkeit: @color:155,100,155 Königliche Leibarde @color:255,255,255 (Erreicht Dario 150 HP, kommt seine Leibgarde. 10 Min Cooldown) @cr @cr @color:139,69,19 2.) Pilgrim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Eisenkanone | @color:255,255,255 Passive Fähigkeit: 1.) @color:155,100,155 Tod des Sprengmeisters @color:255,255,255 (Riesenexplosion, wenn Pilgrim stirbt, beim siebtem Tod ist Pilgrim als Held verloren) 2.) @color:155,100,155 Kanonenmeister @color:255,255,255 Pilgrim besitzt Baupläne für Kanonengießer und Türme! @cr @cr @color:173,255,47 3.) Salim: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Fallenleger @color:255,255,255 (verstärkt + nahezu unsichtbar für Feinde) | Passive Fähigkeit: @color:155,100,155 Versorgungsmeister @color:255,255,255 (Farmen benötigen nur einen Bauern, welche auch kein Dz Platz verbrauchen. Mühlen und Gutshöfe geben mehr Dz Platz bei mindestens 50 Prozent Belegschaft!) @cr @cr @color:50,205,50 4.) Erec: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wirbelschlag @color:255,255,255 (Verstärkt) | Passive Fähigkeit: 1.) @color:155,100,155 Beliebter Heerführer @color:255,255,255 (Soldaten fordern keinen Sold) 2.) @color:155,100,155 Heermeister @color:255,255,255 Erec besitzt Baupläne für Ställe @cr @cr @color:255,140,0 5.) Ari: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Aris Freunde @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Banditenführerin @color:255,255,255 (Kann immer EINEN verbündeten Banditenposten gründen) @cr @cr @color:240,128,128 6.) Helias: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Gottes Schutz @color:255,255,255 (Kurze Unverwundbarkeit für Soldaten im Umkreis) | Passive Fähigkeit: @color:155,100,155 Bescheidenheit @color:255,255,255 (Dorfzentren geben deutlich mehr Platz) @cr @cr @color:255,130,71 7.) Drake: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Meisterschütze @color:255,255,255 | Passive Fähigkeit: @color:155,100,155 Headshot @color:255,255,255 (Tötet gegnerische Helden, ausnahmslos, endgültig) @cr @cr @color:255,20,147 8.) Yuki: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Shuriken @color:255,255,255 (Verstärkt) | Passive Fähigkeit: @color:155,100,155 Freudenfeuerwerk @color:255,255,255 (Yuki bringt Euch sofort eine 300 Motivation (Bei Selektion vor erstem Zahltag 500!), solange sie lebt. Auch habt ihr ein neues Maximum an Motivation. @color:255,60,120 500 @color:255,255,255 ! Diese könnt Ihr ohne Zierobkekte erreichen!)", 1) 
Logic.AddQuest(17, 30, MAINQUEST_OPEN, "@color:238,44,44 Heldenmodus: Böse Helden", "@color:255,20,20 1.) Kala: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Wohnstätte @color:255,255,255 (Kala kann einen nah gelegenen Turm, jeder Art, in eine Wohnstätte verwandeln!) | Passive Fähigkeit: @color:155,100,155 Brutmeisterin @color:255,255,255 (Kala kann immer wieder Truppen ihrer Sippe unabhängig vom Siedlungsplatz erwerben) @cr @cr @color:131,139,139 2.) Kerberos: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Dunkler Heerführer @color:255,255,255 (Kerberos ruft Elitekrieger mit unbegrenzter Lebensdauer herbei) | @color:155,100,155 Dunkler Kanonenturm @color:255,255,255 (Kerberos kann [begrenzt] jeden Spielereigenen Turm in einen mächtigen dunklen Kanonenturm umwandeln!)  Passive Fähigkeit: @color:155,100,155 Mächtige Rüstung @color:255,255,255 (Kerberos hat die stärksten Werte aller Helden) @cr @cr @color:190,190,190 3.) Varg: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Barbarenclan @color:255,255,255 (Varg ruft Elitekrieger der Barbaren mit begrenzter Lebensdauer herbei) | Aktive Fähigkeit: @color:155,100,155 Leitwolf @color:255,255,255 (Varg ruft Wölfe, welche keine begrenzte Lebenszeit haben, herbei!) @cr @cr @color:205,51,51 4.) Mary de Mortfichet: @color:255,255,255 Aktive Fähigkeit: @color:155,100,155 Verführerin @color:255,255,255 (Mary kann fast jeden gegnerischen Helden, auch bei deren Bewusstlosigkeit, bekehren, außer ihr Gegenstück! Sie startet mit einer Erfolgswahrscheinlichkeit von 4 Prozent, mit jedem Fehlschlag steigt die Wahrscheinlichkeit auf Erfolg auf ein Maximum von 40 Prozent!) @cr Stirbt Mary, resettet sich Ihr Erfolgswert auf 4 Prozent! | Passive Fähigkeit: @color:155,100,155 Giftschutz @color:255,255,255 (Wichtige Gebäude und Arbeitergebäude des Spielers werden von einem tödlichem Nebel geschützt!)", 1)
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
end
