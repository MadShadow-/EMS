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
	
		AddPeriodicSummer(60*60);
		AddPeriodicWinter(6000*60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		Script.Load("data\\maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua")
		mcbPacker.Paths = {{"data/maps/user/EMS/tools/", ".lua"}}
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmySpawnGenerator")
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmy")
		TriggerFix.AllScriptsLoaded()
		gv_difficulty=1	
		Mission_InitTechnologies()
		OverrideDiplomacy()
		Burgaussehen()	
		Burgaussehen1()
		Burgaussehen2()
		Burgaussehen3()
		Burgaussehen4()
		Burgaussehen5()
		StartSimpleJob("VictoryJob")
		StartSimpleJob("SurviveJob")

		CreateWoodPile( "P7", 500000)
		CreateWoodPile( "P8", 500000)		
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
		SetupPlayer5AI()	
		for i = 1, 15 do
			_G["createarmy"..i]()
	    end
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
		-- * Normal default: 1k, 1.8k, 1.5k, 0.8k, 50, 50
		Normal = {
			[1] = {
				400,
				1700,
				1250,
				680,
				0,
				0,
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
	AIPlayers = {5},
 
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
	-- * If set to 1, Headquarters are invulernerable as long the player still has village centers
	AntiHQRush = 0,
 
	-- * If set to 1, Players can't abuse blessing and overtime in combination for unlimited work
	BlessLimit = 1,
 
	-- * if set to true, Players are not able to lose their Headquarter.
	InvulnerableHQs = false,
 
	-- * Heroes
	Dario    = 0,
	Pilgrim  = 0,
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

function OverrideDiplomacy() -- diplo in funktion ausgelagert
	SetHostile( 1, 5 )
	SetHostile( 2, 5 )
end


function Burgaussehen()
 local burgid = GetEntityId("Wasser_Turm1")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen1()
 local burgid = GetEntityId("Wasser_Turm2")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen2()
 local burgid = GetEntityId("Turm_11_trupee")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen3()
 local burgid = GetEntityId("Turm_10_trupee")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen4()
 local burgid = GetEntityId("HQ_PL5")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

function Burgaussehen5()
 local burgid = GetEntityId("Turm_12_trupee")
   Logic.SetModelAndAnimSet(burgid, Models.CB_Bastille1)
end

-- die ki spieler alle in ne extra funktion
function SetupPlayer5AI()
	local aiID = 5;
	SetupPlayerAi( aiID, {5}); -- p5 hat nix anderes außer scriptgesteuerte truppen, deswegen kann wird der rest nicht benötigt
	SetPlayerName( aiID, "Räuber" );
end

function VictoryJob() 
	if IsDestroyed("HQ_PL5") and IsDead("Turm_10_trupee") and IsDead("Turm_11_trupee") and IsDead("Turm_12_trupee") then
		if Logic.PlayerGetGameState(1)==1 then 
			Logic.PlayerSetGameStateToWon(1)
		end
		if Logic.PlayerGetGameState(2)==1 then
			Logic.PlayerSetGameStateToWon(2)
		end
		return true;
	end
end
 
 function VictoryPlayers()
  for p=1,2 do
    if Logic.PlayerGetGameState(p) == 1 then
        Logic.PlayerSetGameStateToVictory(p)
    end
  end
  Trigger.DisableTriggerSystem(1)
end

function SurviveJob()
  if not IsAlive("P1_AI_HQ") and not IsAlive("P2_AI_HQ")then
    DefeatPlayers()
  end
end

function DefeatPlayers()
  for p=1,2 do
    if Logic.PlayerGetGameState(p) == 1 then
        Logic.PlayerSetGameStateToLost(p)
    end
  end
  Trigger.DisableTriggerSystem(1)
end


function createarmy1()
    local LeaderCount 
	if gv_difficulty == 1
	then
	LeaderCount = 15 
	end
    UA1 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA1:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA1:AddCommandWaitForIdle(true)	
    UA1:AddCommandMove(GetPosition("Turm_4"), true)
    UA1:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA1, {
        Position=GetPosition("Turm_4"),
		Generator = "HQ_PL5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=5,
        SpawnLeaders=5,
        LeaderDesc={
			{LeaderType=Entities.PU_LeaderHeavyCavalry1, SoldierNum=4, SpawnNum=4, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_AggressiveWolf, SoldierNum=0, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 10
	end
    UA2 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA2:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA2:AddCommandWaitForIdle(true)	
    UA2:AddCommandMove(GetPosition("Turm_4"), true)
    UA2:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA2, {
        Position=GetPosition("Turm_4"),
		Generator = "HQ_PL5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=5,
        SpawnLeaders=5,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 18 
	end
    UA3 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA3:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA3:AddCommandWaitForIdle(true)	
    UA3:AddCommandMove(GetPosition("Turm_4"), true)
    UA3:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA3, {
        Position=GetPosition("Turm_4"),
		Generator = "HQ_PL5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=5,
        SpawnLeaders=5,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 15 
	end
    UA4 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA4:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA4:AddCommandWaitForIdle(true)	
    UA4:AddCommandMove(GetPosition("Turm_12"), true)
    UA4:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA4, {
        Position=GetPosition("Turm_12"),
		Generator = "Turm_12_trupee", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=5,
        SpawnLeaders=5,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=4, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=4, Looped=true},
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
	LeaderCount = 15
	end
    UA5 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA5:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA5:AddCommandWaitForIdle(true)	
    UA5:AddCommandMove(GetPosition("Turm_11"), true)
    UA5:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA5, {
        Position=GetPosition("Turm_11"),
		Generator = "Turm_11_trupee", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=4, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=4, Looped=true},
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
	LeaderCount = 10 
	end
    UA6 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA6:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA6:AddCommandWaitForIdle(true)	
    UA6:AddCommandMove(GetPosition("Turm_10"), true)
    UA6:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA6, {
        Position=GetPosition("Turm_10"),
		Generator = "Turm_10_trupee", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 2
	end
    UA7 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA7:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA7:AddCommandWaitForIdle(true)	
    UA7:AddCommandMove(GetPosition("Turm_2"), true)
    UA7:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA7, {
        Position=GetPosition("Turm_2"),
		Generator = "Turm_2_army_1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=1,
        SpawnLeaders=1,
        LeaderDesc={
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=5, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 2
	end
    UA8 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA8:AddCommandMove(GetPosition("Turm_Attack10"), true)
    UA8:AddCommandWaitForIdle(true)	
    UA8:AddCommandMove(GetPosition("Turm_3"), true)
    UA8:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA8, {
        Position=GetPosition("Turm_3"),
		Generator = "Turm_3_army_1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=1,
        SpawnLeaders=1,
        LeaderDesc={
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=5, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 3
	end
    UA9 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA9:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA9:AddCommandWaitForIdle(true)	
    UA9:AddCommandMove(GetPosition("Unten1"), true)
    UA9:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA9, {
        Position=GetPosition("Unten1"),
		Generator = "Turm_Untenlinks", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=1,
        SpawnLeaders=1,
        LeaderDesc={
			 {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 3
	end
    UA10 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA10:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA10:AddCommandWaitForIdle(true)	
    UA10:AddCommandMove(GetPosition("Oben1"), true)
    UA10:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA10, {
        Position=GetPosition("Oben1"),
		Generator = "Turm_Oben1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=1,
        SpawnLeaders=1,
        LeaderDesc={
			 {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 15
	end
    UA11 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 4000,
        AutoRotateRange    = 4000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA11:AddCommandMove(GetPosition("Weg1"), true)
    UA11:AddCommandWaitForIdle(true)
    UA11:AddCommandMove(GetPosition("Weg2"), true)
    UA11:AddCommandWaitForIdle(true)		
    UA11:AddCommandMove(GetPosition("Turm_4"), true)
    UA11:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA11, {
        Position=GetPosition("Turm_4"),
		Generator = "HQ_PL5", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=6,
        LeaderDesc={
		    {LeaderType=Entities.PU_LeaderSword3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm3, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle1, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
		    {LeaderType=Entities.PU_LeaderSword3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
            {LeaderType=Entities.PU_LeaderBow3, SoldierNum=8, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderPoleArm3, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderRifle1, SoldierNum=8, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 15 
	end
    UA12 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA12:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA12:AddCommandWaitForIdle(true)	
    UA12:AddCommandMove(GetPosition("Wasser_Turm_1"), true)
    UA12:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA12, {
        Position=GetPosition("Wasser_Turm_1"),
		Generator = "Wasser_Turm1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 15 
	end
    UA13 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA13:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA13:AddCommandWaitForIdle(true)	
    UA13:AddCommandMove(GetPosition("Wasser_Turm_2"), true)
    UA13:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA13, {
        Position=GetPosition("Wasser_Turm_2"),
		Generator = "Wasser_Turm2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
            {LeaderType=Entities.CU_Barbarian_LeaderClub1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BlackKnight_LeaderMace1, SoldierNum=4, SpawnNum=3, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.CU_BanditLeaderSword1, SoldierNum=8, SpawnNum=8, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PU_LeaderHeavyCavalry2, SoldierNum=4, SpawnNum=1, Looped=true, Experience=VERYHIGH_EXPERIENCE},
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
	LeaderCount = 4 
	end
    UA14 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA14:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA14:AddCommandWaitForIdle(true)	
    UA14:AddCommandMove(GetPosition("Wasser_Turm_2"), true)
    UA14:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA14, {
        Position=GetPosition("Wasser_Turm_2"),
		Generator = "Wasser_Turm2", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=5, Looped=true},
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
	LeaderCount = 7 
	end
    UA15 = UnlimitedArmy:New {
        Player             = 5,
        Area               = 10000,
        AutoRotateRange    = 10000,
        Formation          = UnlimitedArmy.Formations.Chaotic,
        LeaderFormation    = FormationFunktion, ---
        AIActive           = true,
        AutoDestroyIfEmpty = false,
        IgnoreFleeing      = false,		
    }
    UA15:AddCommandMove(GetPosition("Turm_Attack2"), true)
    UA15:AddCommandWaitForIdle(true)	
    UA15:AddCommandMove(GetPosition("Wasser_Turm_2"), true)
    UA15:AddCommandWaitForIdle(true)	
    UnlimitedArmySpawnGenerator:New(UA15, {
        Position=GetPosition("Wasser_Turm_1"),
		Generator = "Wasser_Turm1", 		-- wenn das hier tot ist, wird nix mehr gespawnt
        ArmySize=LeaderCount,	
        SpawnCounter=6,
        SpawnLeaders=4,
        LeaderDesc={
			{LeaderType=Entities.CU_BanditLeaderBow1, SoldierNum=4, SpawnNum=2, Looped=true, Experience=VERYHIGH_EXPERIENCE},
			{LeaderType=Entities.PV_Cannon3, SoldierNum=0, SpawnNum=5, Looped=true},
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

-- Limit the Technologies here. For example Weathermashine.

function Mission_InitTechnologies()
	for i  = 1, 2 do
	ForbidTechnology( Technologies.T_ThiefSabotage, i)
    ForbidTechnology( Technologies.UP1_Market, i)
    ForbidTechnology( Technologies.UP1_Market, i)
end 
    for i = 5,8 do
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

