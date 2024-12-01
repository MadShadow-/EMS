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
		Script.Load("data\\maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua")
		mcbPacker.Paths = {{"data/maps/user/EMS/tools/", ".lua"}}
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmySpawnGenerator")
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmy")
		TriggerFix.AllScriptsLoaded()
		gv_difficulty=1	

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
		MapTools.OpenPalisadeGates()
		for i = 1, 10 do
			_G["createarmy"..i]()
		end
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

---- Die Armme


function createarmy1()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 4 
	end
    UA1 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA1:AddCommandMove(GetPosition("DEFF_Weg1"), true)
    UA1:AddCommandWaitForIdle(true)	
    UA1:AddCommandMove(GetPosition("DEFF_Weg2"), true)
    UA1:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA1, {
        Position=GetPosition("Ruine_1"),
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
	LeaderCount = 4
	end
    UA2 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA2:AddCommandMove(GetPosition("DEFF_Weg3"), true)
    UA2:AddCommandWaitForIdle(true)	
    UA2:AddCommandMove(GetPosition("DEFF_Weg4"), true)
    UA2:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA2, {
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
	LeaderCount = 2 
	end
    UA3 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA3:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA3:AddCommandWaitForIdle(true)	
    UA3:AddCommandMove(GetPosition("WEG_P5"), true)
    UA3:AddCommandWaitForIdle(true)	
	UA3:AddCommandMove(GetPosition("WEG_P6"), true)
    UA3:AddCommandWaitForIdle(true)	
    UA3:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA3:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA3, {
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
	LeaderCount = 4 
	end
    UA4 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA4:AddCommandMove(GetPosition("DEFF_Weg5"), true)
    UA4:AddCommandWaitForIdle(true)	
    UA4:AddCommandMove(GetPosition("DEFF_Weg6"), true)
    UA4:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA4, {
        Position=GetPosition("Ruine_4"),
		Generator = "Ruine4", 		-- wenn das hier tot ist, wird nix mehr gespawnt
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
	LeaderCount = 2 
	end
    UA5 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA5:AddCommandMove(GetPosition("WEG_P5"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA5:AddCommandWaitForIdle(true)	
	UA5:AddCommandMove(GetPosition("WEG_P6"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA5:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA5, {
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
	LeaderCount = 2 
	end
    UA6 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA5:AddCommandMove(GetPosition("WEG_P6"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("WEG_P5"), true)
    UA5:AddCommandWaitForIdle(true)	
	UA5:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA5:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA6, {
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
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA7:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA7:AddCommandWaitForIdle(true)	
    UA7:AddCommandMove(GetPosition("WEG_P5"), true)
    UA7:AddCommandWaitForIdle(true)	
	UA7:AddCommandMove(GetPosition("WEG_P6"), true)
    UA7:AddCommandWaitForIdle(true)	
    UA7:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA7:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA7, {
        Position=GetPosition("Ruine_7"),
		Generator = "Ruine7", 		-- wenn das hier tot ist, wird nix mehr gespawnt
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
	LeaderCount = 1 
	end
    UA8 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA8:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA8:AddCommandWaitForIdle(true)	
    UA8:AddCommandMove(GetPosition("WEG_P5"), true)
    UA8:AddCommandWaitForIdle(true)	
	UA8:AddCommandMove(GetPosition("WEG_P6"), true)
    UA8:AddCommandWaitForIdle(true)	
    UA8:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA8:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA8, {
        Position=GetPosition("Ruine_8"),
		Generator = "Ruine8", 		-- wenn das hier tot ist, wird nix mehr gespawnt
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
	LeaderCount = 1
	end
    UA9 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA9:AddCommandMove(GetPosition("WEG_P5"), true)
    UA9:AddCommandWaitForIdle(true)	
    UA9:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA9:AddCommandWaitForIdle(true)	
	UA9:AddCommandMove(GetPosition("WEG_P6"), true)
    UA9:AddCommandWaitForIdle(true)	
    UA9:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA9:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA9, {
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
	LeaderCount = 1 
	end
    UA10 = UnlimitedArmy:New {
        Player             = 8,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA10:AddCommandMove(GetPosition("WEG_P6"), true)
    UA10:AddCommandWaitForIdle(true)	
    UA10:AddCommandMove(GetPosition("WEG_P5"), true)
    UA10:AddCommandWaitForIdle(true)	
	UA10:AddCommandMove(GetPosition("WEG_P3/4"), true)
    UA10:AddCommandWaitForIdle(true)	
    UA10:AddCommandMove(GetPosition("WEG_P1/2"), true)
    UA10:AddCommandWaitForIdle(true)		
    UnlimitedArmySpawnGenerator:New(UA10, {
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


