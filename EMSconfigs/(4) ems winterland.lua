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
	Version = 4.9,
 
 
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
	    WT.SetupControllableTowers()
	    Truppen()
        Mission_InitWeather()
		Mission_InitWeatherGfxSets()

		LocalMusic.UseSet = HIGHLANDMUSIC;

		OverrideDiplomacy()
		-- hier die ais aufrufen

		CreateWoodPile( "P7", 500000)
		CreateWoodPile( "P6", 500000)
		CreateWoodPile( "P5", 500000)
		CreateWoodPile( "P4", 500000)		
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		-- Script function

	Script.Load(Folders.MapTools.."Ai\\Support.lua")
	Script.Load( Folders.MapTools.."Main.lua" )

	-- Unbedingt muß für die Einbindung der Ki hier auch dieses am Anfang geladen werden

	IncludeGlobals("MapEditorTools")
	Script.Load( "Data\\Script\\MapTools\\Counter.lua" )
	Script.Load( "Data\\Script\\MapTools\\MultiPlayer\\MultiplayerTools.lua" )
	Script.Load( "Data\\Script\\MapTools\\Tools.lua" )
	Script.Load( "Data\\Script\\MapTools\\WeatherSets.lua" )
	IncludeGlobals("Comfort")

	-- zuerst die normale initialisierung, danach dein code
	-- Init local map stuff
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		SetupPlayer7AI()
		SetupPlayer8AI()

		-- und die armeen erstellen
		SetupPlayer8Army0()
		SetupPlayer8Army1()
		SetupPlayer8Army2()
		SetupPlayer8Army3()
		SetupPlayer8Army4()
		SetupPlayer8Army5()	
		SetupPlayer8Army6()	
		SetupPlayer8Army7()	
     	MapTools.OpenPalisadeGates()
		MapTools.OpenWallGates()
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
				1700,
				1400,
				750,
				900,
				150,
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
	 AIPlayers = {7,8},
 
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
	HeavyCavalry = 0,
	LightCavalry = 0,
	Thief = 0,
	Rifle = 2,
	Scout = 1,
	Cannon1 = 0,
	Cannon2 = 0,
	Cannon3 = 0,
	Cannon4 = 0,
 
	-- * Buildings
	Bridge = 1,
	-- * Markets
	-- * 0 = Building markets is forbidden
	-- * 1 = Building markets is allowed
	-- * greater then one = Markets are allowed and limited to the number given
	Markets = 2,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 3500,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel =2, -- 0-3
	
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 5,
 
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  6,
 
	MakeSummer = 1,
	MakeRain   = 1,
	MakeSnow   = 1,
 
	-- * Fixes the DestrBuild bug
	AntiBug    = 1,
 
	-- * HQRush
	-- * If set to true, Headquarters are invulernerable as long the player still has village centers
	HQRush     = 1,
	BlessLimit = 1,
 
	-- * Heroes
	Dario    = 1,
	Pilgrim  = 1,
	Ari      = 1,
	Erec     = 1,
	Salim    = 1,
	Helias   = 1,
	Yuki     = 1,
	Kerberos = 1,
	Varg     = 1,
	Mary_de_Mortfichet = 1,
	Kala     = 1,
};

 function Mission_InitWeather()

	Logic.AddWeatherElement(2, 60, 1, 2, 5, 10)	-- Foggy with Rain
	Logic.AddWeatherElement(2, 60, 1, 5, 5, 10)	-- Foggy with Rain and Snow
	Logic.AddWeatherElement(3, 160, 1, 3, 5, 10)	-- Winter with Snow
	Logic.AddWeatherElement(3, 160, 1, 6, 5, 10)	-- Winter
	Logic.AddWeatherElement(3, 160, 1, 3, 5, 10)	-- Winter with Snow
	Logic.AddWeatherElement(3, 60, 1, 8, 5, 10)	-- Winter with Rain and Snow
	Logic.AddWeatherElement(3, 60, 1, 7, 5, 10)	-- Winter with Rain
end

function Mission_InitWeatherGfxSets()

	Display.SetRenderUseGfxSets(1)
	
	WeatherSets_SetupRain(2)
	WeatherSets_SetupSnow(3)
	WeatherSets_SetupRain(5, 1, 1)
	WeatherSets_SetupSnow(6, 1, 0)
	WeatherSets_SetupSnow(7, 1, 1)
	WeatherSets_SetupSnow(8, 1, 1)
end

-- eigentlich auch sp code, weiß gerade nicht ob die im mp genutzt wird. muss auf jeden fall aus der GameCallback_OnGameStart raus
function InitPlayerColorMapping()
	Display.SetPlayerColorMapping(8,ENEMY_COLOR2)
	Display.SetPlayerColorMapping(7,ENEMY_COLOR2)
end 

function OverrideDiplomacy() -- diplo in funktion ausgelagert
	SetHostile( 1, 8 )
	SetHostile( 2, 8 )
	SetHostile( 3, 8 )
	SetHostile( 4, 8 )
	SetHostile( 1, 7 )
	SetHostile( 2, 7 )
    SetHostile( 3, 7 )
	SetHostile( 4, 7 )
end

-- die ki spieler alle in ne extra funktion
function SetupPlayer8AI()
	local aiID = 8;
	SetupPlayerAi( aiID, {8}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Banditen" );
end

function SetupPlayer7AI()
	local aiID = 7;
	local strength = 2;
	local range = 0;
	local techlevel = 2;
	local position = "P7_AI_HQ";    -- natürlich sollte man P3_AI_HQ als Skriptnamen dem Hauptquartier geben, natürlich bei player 4 P4_AI_HQ etc..
	local aggressiveness = 0;
	local peacetime = 0*1;
	local noEnemy             = false;
  local noEnemyDistance     = 0;
   local  beAgressive = false;
	MapEditor_SetupAI( aiID, strength, range, techlevel, position, aggressiveness, peacetime, noEnemyDistance, noEnemy, beAgressive );
	SetupPlayerAi( aiID, { extracting = 0, repairing = true, constructing = true, -- das kann alles in einen aufruf gepackt werden
		resources = {
			gold		=   6000,
			clay		=   0,
			iron		=   250,
			sulfur		=   2500,
			stone		=   0,
			wood		=   2500,
		},
		refresh = {
			gold		=   6000,
			clay		=   0,
			iron		=   2500,
			sulfur		=   2500,
			stone		=   0,
			wood		=   2500,
			updateTime	=   200
		},
	});
	SetPlayerName( aiID, "Die Schwefel Stadt" );
end

function SetupPlayer8Army0()

	Player8Army0 = { -- variable umbenennen
		-- Normale Armee Daten
		id                  = 0, -- armyid 0 wird nicht von der mapeditor ki benutzt
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("JB2"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("AB1"),
		spawnGenerator      = "AB2",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("H"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army0)
	SetupAITroopSpawnGenerator("Player8Army0", Player8Army0)
	StartSimpleJob("ControlPlayer8Army0")
end
function ControlPlayer8Army0()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army0", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army0) then
			TickOffensiveAIController(Player8Army0)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army0) then
			return true
		end

	end
end


function SetupPlayer8Army1()

	Player8Army1 = { -- variable umbenennen
		-- Normale Armee Daten
		id                  = 1, -- armyid 0 wird nicht von der mapeditor ki benutzt
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("z1"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("AB3"),
		spawnGenerator      = "AB2",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("t"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army1)
	SetupAITroopSpawnGenerator("Player8Army1", Player8Army1)
	StartSimpleJob("ControlPlayer8Army1")
end
function ControlPlayer8Army1()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army1", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army1) then
			TickOffensiveAIController(Player8Army1)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army1) then
			return true
		end

	end
end

function SetupPlayer8Army2()
	Player8Army2 = {
		-- Normale Armee Daten
		id                  = 2,
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("z2"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D2"),
		spawnGenerator      = "XX",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("f2"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army2)
	SetupAITroopSpawnGenerator("Player8Army2", Player8Army2)
	StartSimpleJob("ControlPlayer8Army2")
end
function ControlPlayer8Army2()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army2", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army2) then
			TickOffensiveAIController(Player8Army2)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army2) then
			return true
		end

	end
end

function SetupPlayer8Army3()
	Player8Army3 = {
		-- Normale Armee Daten
		id                  = 3,
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("z3"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D4"),
		spawnGenerator      = "i4",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("T1"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army3)
	SetupAITroopSpawnGenerator("Player8Army3", Player8Army3)
	StartSimpleJob("ControlPlayer8Army3")
end
function ControlPlayer8Army3()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army3", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army3) then
			TickOffensiveAIController(Player8Army3)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army3) then
			return true
		end

	end
end

function SetupPlayer8Army4()
	Player8Army4 = {
		-- Normale Armee Daten
		id                  = 4,
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("Z6"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D5"),
		spawnGenerator      = "mi",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,	  
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("v2"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army4)
	SetupAITroopSpawnGenerator("Player8Army4", Player8Army4)
	StartSimpleJob("ControlPlayer8Army4")
end
function ControlPlayer8Army4()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army4", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army4) then
			TickOffensiveAIController(Player8Army4)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army4) then
			return true
		end

	end
end

function SetupPlayer8Army5()
	Player8Army5 = {
		-- Normale Armee Daten
		id                  = 5,
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("z11"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D10"),
		spawnGenerator      = "u4",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,      -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           =  {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("br"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army5)
	SetupAITroopSpawnGenerator("Player8Army5", Player8Army5)
	StartSimpleJob("ControlPlayer8Army5")
end
function ControlPlayer8Army5()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army5", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army5) then
			TickOffensiveAIController(Player8Army5)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army5) then
			return true
		end

	end
end

function SetupPlayer8Army6()
	Player8Army6 = {
		-- Normale Armee Daten
		id                  = 6,
		player              = 8,
		strength            = 3,
		rodeLength          = 30,
		position            = GetPosition("D13"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D13"),
		spawnGenerator      = "D14",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 2,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = false,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("D15"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army6)
	SetupAITroopSpawnGenerator("Player8Army6", Player8Army6)
	StartSimpleJob("ControlPlayer8Army6")
end
function ControlPlayer8Army6()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army6", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army6) then
			TickOffensiveAIController(Player8Army6)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army6) then
			return true
		end

	end
end

function SetupPlayer8Army7()
	Player8Army7 = {
		-- Normale Armee Daten
		id                  = 7,
		player              = 8,
		strength            = 3,
		rodeLength          = 50,
		position            = GetPosition("D16"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.PU_LeaderRifle1, 4},
			{Entities.CU_Barbarian_LeaderClub1, 4 },
			{Entities.PV_Cannon3, 0},
		},
		spawnPos            = GetPosition("D16"),
		spawnGenerator      = "D17",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 3,
		noEnemy             = true,
		noEnemyDistance     = 2,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 50,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 50,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("LO"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army7)
	SetupAITroopSpawnGenerator("Player8Army7", Player8Army7)
	StartSimpleJob("ControlPlayer8Army7")
end
function ControlPlayer8Army7()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army7", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army7) then
			TickOffensiveAIController(Player8Army7)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army7) then
			return true
		end

	end
end

function Truppen()

AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("B1").X, GetPosition("B1").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("B1").X, GetPosition("B1").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o2").X, GetPosition("o2").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o2").X, GetPosition("o2").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o3").X, GetPosition("o3").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o3").X, GetPosition("o3").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o4").X, GetPosition("o4").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o4").X, GetPosition("o4").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o5").X, GetPosition("o5").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o5").X, GetPosition("o5").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o6").X, GetPosition("o6").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o6").X, GetPosition("o6").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o7").X, GetPosition("o7").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o7").X, GetPosition("o7").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o8").X, GetPosition("o8").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o8").X, GetPosition("o8").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o9").X, GetPosition("o9").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o9").X, GetPosition("o9").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o10").X, GetPosition("o10").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o10").X, GetPosition("o10").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o11").X, GetPosition("o11").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o11").X, GetPosition("o11").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o12").X, GetPosition("o12").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle1, nil, 8, GetPosition("o12").X, GetPosition("o12").Y, 0, 1, 3,4)
AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, GetPosition("o13").X, GetPosition("o13").Y, 0, 1, 3,8)
AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, GetPosition("o14").X, GetPosition("o14").Y, 0, 1, 3,8)
AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, GetPosition("o15").X, GetPosition("o15").Y, 0, 1, 3,8)
AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, GetPosition("o16").X, GetPosition("o16").Y, 0, 1, 3,8)
end


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

-- ********************************************************************************************
-- ********************************************************************************************
-- Controllable Towers
WT = WT or {};
function WT.SetupControllableTowers()
	WT.TowerSpawns = {{34200, 22900},{43000, 23200},{34000, 54000},{43100, 53400}}
	WT.TowerState = {
		Neutral = 1,
		Attackable = 2
	}
	WT.TowerStates = {WT.TowerState.Attackable, WT.TowerState.Attackable, WT.TowerState.Attackable, WT.TowerState.Attackable}
	WT.Towers = {
		Logic.CreateEntity(Entities.CB_Lighthouse, WT.TowerSpawns[1][1], WT.TowerSpawns[1][2], 0, 7),
		Logic.CreateEntity(Entities.CB_Lighthouse, WT.TowerSpawns[2][1], WT.TowerSpawns[2][2], 0, 7),
		Logic.CreateEntity(Entities.CB_Lighthouse, WT.TowerSpawns[3][1], WT.TowerSpawns[3][2], 0, 7),
		Logic.CreateEntity(Entities.CB_Lighthouse, WT.TowerSpawns[4][1], WT.TowerSpawns[4][2], 0, 7)
	};
	
	-- attraction place provided by steam machine
	S5Hook.GetRawMem(9002416)[0][16][Entities.CB_SteamMashine*8+2][44]:SetInt(25);
	
	WT.VillageCenterProviders = {};
	for i = 1,4 do
		WT.VillageCenterProviders[i] = {0,0,0,0};
	end
	
	WT.TextTable = {
		Team1 = " und ",
		Team2 = " haben einen Leuchtturm erobert!"
	}
	
	StartSimpleJob("WT_TowerController");
end

function WT_TowerController()
	local range = 3000;
	for i = 1,4 do
		if IsAlive(WT.Towers[i]) then
			if WT.TowerStates[i] == WT.TowerState.Attackable then
				-- if tower falls below 150 hp, set neutral and activate conquer mode
				if Logic.GetEntityHealth(WT.Towers[i]) <= 150 then
					WT.SpawnTower(i, 8, WT.TowerState.Neutral, Entities.CB_Lighthouse);
				end
			else
				-- conquer mode: if one team is solo in the area of range around the tower, the tower will fall into their hands
				local entities, isTeam1, isTeam2, isTeam3 = 0, false, false, false;
				for playerId = 1, 2 do
					entities = {Logic.GetPlayerEntitiesInArea(playerId, 0, WT.TowerSpawns[i][1], WT.TowerSpawns[i][2], range, 5)}
					for i = 1, entities[1] do
						if IsAlive(entities[i+1]) then
							isTeam1 = true;
							break;
						end
					end
				end
				for playerId = 3, 4 do
					entities = {Logic.GetPlayerEntitiesInArea(playerId, 0, WT.TowerSpawns[i][1], WT.TowerSpawns[i][2], range, 5)}
					for i = 1, entities[1] do
						if IsAlive(entities[i+1]) then
							isTeam2 = true;
							break;
						end
					end
				end
				if isTeam1 and not isTeam2 then
					Message(WT.GetPlayerColorString(1) .. UserTool_GetPlayerName(1) .. " @color:255,125,0 " .. WT.TextTable.Team1 .. WT.GetPlayerColorString(2) .. UserTool_GetPlayerName(2) .. " @color:255,125,0 " .. WT.TextTable.Team2);
					WT.SpawnTower(i, 1, WT.TowerState.Attackable, Entities.CB_LighthouseActivated);
				elseif not isTeam1 and isTeam2 then
					Message(WT.GetPlayerColorString(3) .. UserTool_GetPlayerName(3) .. " @color:255,125,0 " .. WT.TextTable.Team1 .. WT.GetPlayerColorString(4) .. UserTool_GetPlayerName(4) .. " @color:255,125,0 " .. WT.TextTable.Team2);
					WT.SpawnTower(i, 3, WT.TowerState.Attackable, Entities.CB_LighthouseActivated);
				end
			end
		else
			WT.SpawnTower(i, 8, WT.TowerState.Neutral, Entities.CB_Lighthouse);
		end
	end
end

function WT.GetPlayerColorString(_playerId)
	local r,g,b = GUI.GetPlayerColor(_playerId);
	return " @color:"..r..","..g..","..b.." ";
end

function WT.SpawnTower(_towerId, _playerId, _towerState, _entity)
	if IsAlive(WT.Towers[_towerId]) then
		DestroyEntity(WT.Towers[_towerId]);
	end
	WT.Towers[_towerId] = Logic.CreateEntity(_entity, WT.TowerSpawns[_towerId][1], WT.TowerSpawns[_towerId][2], 0, _playerId)
	Logic.HurtEntity(WT.Towers[_towerId], 400);
	WT.TowerStates[_towerId] = _towerState;
	
	local towersTeam1 = 0;
	local towersTeam2 = 0;
	local player;
	for i = 1,4 do
		player = Logic.EntityGetPlayer(WT.Towers[i]);
		if player == 1 then
			towersTeam1 = towersTeam1 + 1;
		elseif player == 3 then
			towersTeam2 = towersTeam2 + 1;
		end
	end
	
	WT.CreateVillageCenterProviders(towersTeam1, 1);
	WT.CreateVillageCenterProviders(towersTeam1, 2);
	WT.CreateVillageCenterProviders(towersTeam2, 3);
	WT.CreateVillageCenterProviders(towersTeam2, 4);
end

function WT.CreateVillageCenterProviders(_numTowers, _playerId)
	for towerId = 1, _numTowers do
		if not IsAlive(WT.VillageCenterProviders[_playerId][towerId]) then
			WT.VillageCenterProviders[_playerId][towerId] = Logic.CreateEntity(Entities.CB_SteamMashine, 500, 500, 0, _playerId);
			Logic.SetModelAndAnimSet( WT.VillageCenterProviders[_playerId][towerId], Models.XD_Rock3);
		end
	end
	for towerId = _numTowers+1, 4 do
		if IsAlive(WT.VillageCenterProviders[_playerId][towerId]) then
			DestroyEntity(WT.VillageCenterProviders[_playerId][towerId]);
			WT.VillageCenterProviders[_playerId][towerId] = 0;
		end
	end
end
