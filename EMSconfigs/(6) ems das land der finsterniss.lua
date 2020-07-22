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
	Version = 1.1,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
	
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;

		OverrideDiplomacy()
		-- hier die ais aufrufen

		CreateWoodPile( "P7", 500000)
		CreateWoodPile( "P6", 500000)
		CreateWoodPile( "P5", 500000)
		CreateWoodPile( "P4", 500000)
		CreateWoodPile( "P3", 500000)
		CreateWoodPile( "P2", 500000)
		
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
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
		SetupPlayer8Army8()
		SetupPlayer8Army9()
		
		MapTools.OpenPalisadeGates()
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 30,
 
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
				2400,
				1750,
				700,
				50,
				50,
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
	AIPlayers = {8},
 
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
	Rifle = 2,
	Thief = 1,
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
	Markets = 0,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 0,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 1, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 0,
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  3,
 
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
	Drake    = 1,
	Yuki     = 1,
	Kerberos = 1,
	Varg     = 1,
	Mary_de_Mortfichet = 1,
	Kala     = 1,
};

-- eigentlich auch sp code, weiß gerade nicht ob die im mp genutzt wird. muss auf jeden fall aus der GameCallback_OnGameStart raus
function InitPlayerColorMapping()
	Display.SetPlayerColorMapping(8,ENEMY_COLOR2)
end 

function OverrideDiplomacy() -- diplo in funktion ausgelagert
	SetHostile( 1, 8 )
	SetHostile( 2, 8 )
	SetHostile( 3, 8 )
	SetHostile( 4, 8 )
	SetHostile( 5, 8 )
	SetHostile( 6, 8 )
end

-- die ki spieler alle in ne extra funktion
function SetupPlayer8AI()
	local aiID = 8;
	SetupPlayerAi( aiID, {8}); -- p8 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Nebelvolk" );
end

function SetupPlayer8Army0()

	Player8Army0 = { -- variable umbenennen
		-- Normale Armee Daten
		id                  = 0, -- armyid 0 wird nicht von der mapeditor ki benutzt
		player              = 8,
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("JB2"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("AB1"),
		spawnGenerator      = "AB2",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("z1"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("AB3"),
		spawnGenerator      = "AB4",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("z2"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D2"),
		spawnGenerator      = "D1",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("z3"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D4"),
		spawnGenerator      = "D3",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("Z6"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D5"),
		spawnGenerator      = "D6",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("f3"),
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("z11"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D10"),
		spawnGenerator      = "D11",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("Z14"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D13"),
		spawnGenerator      = "D14",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("T4"),
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
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("Z17"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D16"),
		spawnGenerator      = "D17",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("f5"),
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

function SetupPlayer8Army8()
	Player8Army8 = {
		-- Normale Armee Daten
		id                  = 8,
		player              = 8,
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("Z20"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D19"),
		spawnGenerator      = "D20",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("V5"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army8)
	SetupAITroopSpawnGenerator("Player8Army8", Player8Army8)
	StartSimpleJob("ControlPlayer8Army8")
end
function ControlPlayer8Army8()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army8", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army8) then
			TickOffensiveAIController(Player8Army8)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army8) then
			return true
		end

	end
end

function SetupPlayer8Army9()
	Player8Army9 = {
		-- Normale Armee Daten
		id                  = 9,
		player              = 8,
		strength            = 8,
		rodeLength          = 10000,
		position            = GetPosition("Z23"),

		-- Daten für den SpawnGenerator
		spawnTypes          = {
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
			{Entities.CU_Evil_LeaderSkirmisher1, 16},
			{Entities.CU_Evil_LeaderBearman1, 16},
		},
		spawnPos            = GetPosition("D22"),
		spawnGenerator      = "D23",
		endless             = true,
		respawnTime         = 1,
		refresh             = true,
		maxSpawnAmount      = 2,
		noEnemy             = true,
		noEnemyDistance     = 20,
     beAgressive = true,
		-- Daten für diese Control-Funktion
		retreatStrength     = 0,          -- Wenn nur noch 2 Hauptmänner existieren, dann urück zur Basis laufen...
		baseDefenseRange    = 30,       -- ...und sich nur innerhalb dieses Radius bewegen und verteidigen
		outerDefenseRange   = 30,      -- Wenn stark genug, dann bewegt sich die Armee offensiv in diesem Radius
		AttackAllowed       = true,       -- Die Armee darf auch angreifen...
		AttackPos           = {           -- Zufällig einen dieser drei Punkte angreifen
			GetPosition("X4"),
		},
		pulse               = true,       -- und dabei auch mal die Formation auflösen.
	}
	SetupArmy(Player8Army9)
	SetupAITroopSpawnGenerator("Player8Army9", Player8Army9)
	StartSimpleJob("ControlPlayer8Army9")
end
function ControlPlayer8Army9()

	-- Nur alle 10 Sekunden Befehle erteilen, das reicht
	if Counter.Tick2("ControlPlayer8Army9", 10) then

		-- Wenn die Armee noch Soldaten hat, dann die Befehle erteilen
		if IsAlive(Player8Army9) then
			TickOffensiveAIController(Player8Army9)

			-- Ansonsten prüfen, ob überhaupt noch eine Armee entstehen kann. Wenn der Spawn Generator kaputt ist, brauchen wir den Job auch nicht mehr
		elseif IsAITroopGeneratorDead(Player8Army9) then
			return true
		end

	end
end

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


