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
	Version = 1,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupEvelanceWeatherGfxSet();
		LocalMusic.UseSet = DARKMOORMUSIC;
		
		-- basically content of InitMultiplayer()
		for i= 1, 4, 1 do
            Logic.SetModelAndAnimSet(GetID("P" ..i.. "Block"), Models.XD_RockDark7);
            Logic.SetNumberOfBuyableHerosForPlayer(i, 3);
		end
		-- init testmode if not multiplayer mode
        Mission_TestMode(not EMS.T.IsMultiplayer());
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		Mission_StartDecoJobs();
        Mission_CreateBearyFriends();
        Mission_StockResourceEntities();
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		-- delay your peacetime calback by one second
		StartSimpleJob("CTF_DelayOneSecond");
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
	GameMode = 2,
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
				1000,
				1800,
				1500,
				800,
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
	AIPlayers = {
		5
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
	TowerLimit = 5,
 
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
    BlessLimit = 0,
    
    Heroes = {3,3,3,3},
 
	-- * Heroes
	Dario    = 1,
	Pilgrim  = 1,
	Ari      = 1,
	Erec     = 1,
	Salim    = 1,
	Helias   = 1,
	Drake    = 0,
	Yuki     = 1,
	Kerberos = 1,
	Varg     = 1,
	Mary_de_Mortfichet = 1,
	Kala     = 1,
};

function CTF_DelayOneSecond()
	-- called by simple job to delay one second
	-- in order to show the countdown correctly which I also use for the peacetime.
	Mission_PeaceTimeOver();
	return true;
end

-- Fills resource heaps with additional units.
function Mission_StockResourceEntities()
    local ResourceHeapTypes = {
        Entities.XD_Clay1,
        Entities.XD_Iron1,
        Entities.XD_Stone1,
        Entities.XD_Sulfur1,
    }

    for k, v in pairs(ResourceHeapTypes) do
        local Heaps = {Logic.GetEntities(v, 48)};
        if Heaps[1] > 0 then
            for i= 2, Heaps[1]+1, 1 do
                Logic.SetResourceDoodadGoodAmount(Heaps[i], 4000);
            end
        end
    end
end

-- Some beauty surgery jobs tom improve different things.
function Mission_StartDecoJobs()
    if not CNetwork then
        -- Job that prevents from building close to the center.
        function Job_KillPlacementStateNearFlag()
            local StateID = GUI.GetCurrentStateID();
            if StateID == gvGUI_StateID.PlaceBuilding
            or StateID == gvGUI_StateID.PlaceKegCommand
            or StateID == gvGUI_StateID.PlaceTorchCommand then
                local Position1 = GetPosition(CTF.FlagPosition);
                local x, y = GUI.Debug_GetMapPositionUnderMouse();
                local Position2 = {X= x, Y= y};
                if IsValidPosition(Position2) then
                    if GetDistance(Position1, Position2) <= 4500 then
                        GUI.CancelState();
                        GUI.ActivateSelectionState();
                    end
                end
            end
        end
        StartSimpleHiResJob("Job_KillPlacementStateNearFlag");
    else
        GameCallback_PlaceBuildingAdditionalCheckOrig = GameCallback_PlaceBuildingAdditionalCheck;
        GameCallback_PlaceBuildingAdditionalCheck = function(_ucat, _x, _y, _rotation, _isBuildOn)
            local allowed = true;
            if GameCallback_PlaceBuildingAdditionalCheckOrig then
                allowed = GameCallback_PlaceBuildingAdditionalCheckOrig(_ucat, _x, _y, _rotation, _isBuildOn);
            end
            local pos = GetPosition(CTF.FlagPosition);
            if GetDistance(pos, {X=_x,Y=_y}) <= 4500 then
                return false;
            end
            return allowed;
        end
    end
end

function Mission_TestMode(_Flag)
    if _Flag then
        Message("@color:255,80,80 Mission test mode active!");
        Logic.PlayerSetGameStateToPlaying(3);
        Logic.SetSpeedFactor(GetID("Lustknabe"), 3.0);
        Logic.SetSpeedFactor(GetID("Rohrverleger"), 3.0);
        SetHostile(1, 3);
        Tools.ExploreArea(1, -1, 900);
        DestroyEntity("P1Block");
        DestroyEntity("P1Block");
    else
        DestroyEntity("Lustknabe");
        DestroyEntity("Rohrverleger");
    end
end

function Mission_StartCaptureTheFlag(_Players, _Playtime)
    CTF_Start(_Players, _Playtime);
end

-- This must be called in EMS!
function Mission_PeaceTimeOver()
    -- Prepare stuff
    for i= 1, 4, 1 do
        if IsExisting("HQ" ..i) and Logic.PlayerGetGameState(i) == 1 then
            MakeInvulnerable("HQ" ..i);
            MakeInvulnerable("VC1P" ..i);
            ReplaceEntity("P" ..i.. "Block", Entities.XD_RockDark7);
        end
    end
    Mission_StartCaptureTheFlag({1, 2, 3, 4}, 35 * 60);
end

function Mission_CreateBearyFriends()
    for i= 1, 4, 1 do
        SetHostile(i, 5);
        AI.Player_EnableAi(5);

        for i= 1, 4, 1 do
            local army = {};
            army.player 			     = 5;
            army.id					     = i;
            army.strength			     = 3;
            army.position			     = GetPosition("NVSpawnPoint");
            army.rodeLength			     = 2000;
            army.refresh 			     = true;
            army.retreatStrength	     = 1;
            army.baseDefenseRange	     = 2000;
            army.outerDefenseRange	     = 2000;

            army.spawnPos 		 	     = GetPosition("NVSpawnPoint");
            army.respawnTime 		     = 7 * 60;
            army.maxSpawnAmount 		 = 2;
            army.endless 			     = true;
            army.noEnemy 			     = true;
            army.noEnemyDistance 	     = 100;
            army.spawnTypes 			 = {
                {Entities.CU_Evil_LeaderBearman1, 16},
		        {Entities.CU_Evil_LeaderSkirmisher1, 16},
            };
            SetupArmy(army);
            SetupAITroopSpawnGenerator("NVArmy_" ..i.. "_Generator", army);
        end
    end
end

-- CTF-Stuff --

function CTF_DelayOneSecond()
	Mission_PeaceTimeOver();
	return true;
end

function GameCallback_CTF_OnFlagPicked(_PlayerID, _HeroID)
    -- Message("DEBUG: " .._HeroID.. " picked up flag for player " .._PlayerID);

    -- Info to all
    local Text = {
        de = "%s %s hat eine Flagge an sich genommen!",
        en = "%s %s has claimed a flag for themself!"
    };
    Message(string.format(
        Text[GetLanguage()],
        CTF_GetPlayerNameColored(_PlayerID),
        CTF.ColorGrey
    ));
end

function GameCallback_CTF_OnFlagCaptured(_PlayerID1, _EntityID1, _PlayerID2, _EntityID2)
    -- Message("DEBUG: player " .._PlayerID1.. " lost the flag to player " .._PlayerID2);

    -- Info to all
    local Text = {
        de = "%s %s hat die Flagge an %s %s verloren!",
        en = "%s %s has lost the flag to %s %s in shame!"
    };
    Message(string.format(
        Text[GetLanguage()],
        CTF_GetPlayerNameColored(_PlayerID1),
        CTF.ColorGrey,
        CTF_GetPlayerNameColored(_PlayerID2),
        CTF.ColorGrey
    ));
end

function GameCallback_CTF_OnFlagReplaced(_PlayerID, _HeroID)
    -- Message("DEBUG: " .._HeroID.. " lost the flag");

    -- Info to all
    local Text = {
        de = "%s %s hat die Flagge verloren! Eine neue Flagge ist erschienen!",
        en = "%s %s has lost the flag! A new flag has appeared!"
    };
    Message(string.format(
        Text[GetLanguage()],
        CTF_GetPlayerNameColored(_PlayerID),
        CTF.ColorGrey
    ));
end

function GameCallback_CTF_OnFlagDelivered(_PlayerID, _HeroID)
    -- Message("DEBUG: " .._HeroID.. " delivered flag to player " .._PlayerID);

    -- Info to all
    local Points = CTF_GetPlayerPoints(_PlayerID);
    local UserName = UserTool_GetPlayerName(_PlayerID);
    local R, G, B = GUI.GetPlayerColor(_PlayerID);
    local Text = {
        de = "%s %s hat sich die Flagge gesichert! @cr %s Flaggen gesamt: %d",
        en = "%s %s has taken the flag into the base! @cr %s Sum of flags: %d"
    };
    Message(string.format(
        Text[GetLanguage()], 
        CTF_GetPlayerNameColored(_PlayerID),
        CTF.ColorGrey,
        CTF.ColorWhite,
        Points
    ));

    -- Create flag at HQ
    local Points = CTF_GetPlayerPoints(_PlayerID);
    local AnchorEntity = GetID("P" .._PlayerID.. "FlagPos");
    if Points > 0 then
        local x,y,z = Logic.EntityGetPos(AnchorEntity);
        local ID = Logic.CreateEntity(
            Entities.XD_StandartePlayerColor,
            x + 100 + (100 * Points),
            y,
            270,
            _PlayerID
        );
        Logic.SetModelAndAnimSet(ID, Models.Banners_XB_LargeFull);
    end

    -- Declare victors
    local Points = CTF_GetPlayerPoints(_PlayerID);
    if Points > 0 then
        if Points >= 10 then
            CTF_StopDeathTimer();
            if XNetwork ~= nil and XNetwork.Manager_DoesExist() == 1 then
                local Team1 = XNetwork.GameInformation_GetPlayerTeam(_PlayerID);
                for i= 1, table.getn(CTF.Players), 1 do
                    local Team2 = XNetwork.GameInformation_GetPlayerTeam(i);
                    if Team1 == Team2 then
                        Logic.PlayerSetGameStateToWon(i);
                    else
                        Logic.PlayerSetGameStateToLost(i);
                    end
                end
            else
                Logic.PlayerSetGameStateToWon(_PlayerID);
            end
        end
    end
end

-- -------------------------------------------------------------------------- --
-- Cheap CTF Script by totalwarANGEL                                          --
-- Version 1.0.0                                                              --
-- (It's cheap, but cheap is sometimes sexy!)                                 --
-- -------------------------------------------------------------------------- --

CTF = {
    ColorGrey       = "@color:200,200,200",
    ColorWhite      = "@color:255,255,255",

    FlagPosition    = "PosFlag",
    FlagPickRange   = 400,
    FlagCarrier     = 0,
    FlagCarrierDeco = 0,
    FlagCarryTimer  = 0,
    FlagID          = 0,

    AttackerIdMap   = {},
    Players         = {},
};

-- Game Control --

function CTF_Start(_Players, _Time)
    for i= 1, table.getn(_Players), 1 do
        CTF.Players[i] = {_Players[i], 0};
    end
    gvOSI:InitOnScreenInformation();
    CTF_StartDeathTimer(_Time);
    CTF_ExplorationsAtStart();
    CTF_SpawnFlag();
    CTF_DisplayInformation();
    StartSimpleHiResJob("CTF_ClearTaggedHeroesJob");
    Trigger.RequestTrigger(
        Events.LOGIC_EVENT_ENTITY_HURT_ENTITY,
        "",
        "CTF_OnEntityHurtEntityJob",
        1
    );
end

function CTF_StartDeathTimer(_Time)
    if _Time and _Time > 0 then
        CTF.CountdownID = StartCountdown(
            _Time,
            CTF_DeclareVictorsAfterTimeLimit,
            true
        );
    end
end

function CTF_StopDeathTimer()
    if CTF.CountdownID then
        StopCountdown(CTF.CountdownID);
    end
end

function CTF_DeclareVictorsAfterTimeLimit()
    if XNetwork ~= nil and XNetwork.Manager_DoesExist() == 1 then
        local WinningTeam = CTF_GetTeamOfPlayerWithMostFlags();
        if WinningTeam == 0 then
            for k, v in pairs(CTF_GetAllPlayerData()) do
                Logic.PlayerSetGameStateToLost(v[1]);
            end
        else
            for k, v in pairs(CTF_GetAllPlayerData()) do
                local CurrentTeam = XNetwork.GameInformation_GetPlayerTeam(i);
                if WinningTeam == CurrentTeam then
                    Logic.PlayerSetGameStateToWon(v[1]);
                else
                    Logic.PlayerSetGameStateToLost(v[1]);
                end
            end
        end
    else
        Logic.PlayerSetGameStateToWon(GUI.GetPlayerID());
    end
end

function CTF_ExplorationsAtStart()
    for okey, oval in pairs(CTF_GetAllPlayerData()) do
        -- highlight HQs for player
        for ikey, ival in pairs(CTF_GetAllPlayerData()) do
            local x, y, z = Logic.EntityGetPos(GetID("HQ" ..ival[1]));
            local ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity, x, y, 0, oval[1]);
            Logic.SetEntityExplorationRange(ViewCenter, 15);
        end
        -- Highlight center
        -- TODO: Replace with minimap marker
        local x, y, z = Logic.EntityGetPos(GetID(CTF.FlagPosition));
        local ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity, x, y, 0, oval[1]);
        Logic.SetEntityExplorationRange(ViewCenter, 25);
    end
end

function CTF_DisplayInformation()
    for i= 1, table.getn(CTF.Players), 1 do
        local PlayerID = CTF.Players[i][1];
        gvOSI:OnScreenProgressBar({
            text	= CTF_GetPlayerNameColored(PlayerID),
		    maximum	= 10,
            color	= {GUI.GetPlayerColor(PlayerID)},
            player  = PlayerID,
            update	= function(_Data)
                return CTF.Players[_Data.player][2];
            end,
        })
    end
end

-- Flag Control --

function CTF_SpawnFlag()
    if not IsExisting(CTF.FlagID) then
        -- local ID = ReplaceEntity(CTF.FlagPosition, Entities.XD_Rock3);
        local ID = GetID(CTF.FlagPosition);
        Logic.SetModelAndAnimSet(ID, Models.Banners_XB_LargeFull);
        CTF.FlagID = ID;
    end
    if CTF.PickJobID and JobIsRunning(CTF.PickJobID) then
        EndJob(CTF.PickJobID);
    end
    CTF.PickJobID = StartSimpleHiResJob("CTF_PickUpJob");
    return CTF.FlagID;
end

function CTF_PickFlag(_HeroID)
    local PlayerID = Logic.EntityGetPlayer(_HeroID);
    CTF.FlagCarrier = _HeroID;
    CTF.FlagCarryTimer = 900;
    local ID = GetID(CTF.FlagPosition);
    Logic.SetModelAndAnimSet(ID, Models.XD_BoneAnimal5);
    CTF.FlagID = 0;
    if CTF.CarryJobID and JobIsRunning(CTF.CarryJobID) then
        EndJob(CTF.CarryJobID);
    end
    CTF.CarryJobID = StartSimpleHiResJob("CTF_CarryHomeJob");
    if GameCallback_CTF_OnFlagPicked then
        GameCallback_CTF_OnFlagPicked(PlayerID, _HeroID);
    end
end

function CTF_CaptureFlag(_HeroID)
    local PlayerID1 = Logic.EntityGetPlayer(CTF.FlagCarrier);
    local PlayerID2 = Logic.EntityGetPlayer(_HeroID);
    CTF.FlagCarrier = _HeroID;
    CTF.FlagCarryTimer = 900;
    if GameCallback_CTF_OnFlagCaptured then
        GameCallback_CTF_OnFlagCaptured(PlayerID1, CTF.FlagCarrier, PlayerID2, _HeroID);
    end
end

function CTF_ResetFlag()
    local PlayerID = 0;
    local HeroID = CTF.FlagCarrier;
    if IsExisting(HeroID) then
        PlayerID = Logic.EntityGetPlayer(HeroID);
    end
    DestroyEntity(CTF.FlagCarrierDeco);
    CTF.FlagCarrierDeco = 0;
    CTF.FlagCarrier = 0;
    CTF.FlagCarryTimer = 0;
    if GameCallback_CTF_OnFlagReplaced then
        GameCallback_CTF_OnFlagReplaced(PlayerID, HeroID);
    end
end

function CTF_DeliverFlag()
    local HeroID = CTF.FlagCarrier;
    local PlayerID = Logic.EntityGetPlayer(HeroID);
    DestroyEntity(CTF.FlagCarrierDeco);
    CTF.FlagCarrierDeco = 0;
    CTF.FlagCarrier = 0;
    CTF.FlagCarryTimer = 0;
    CTF_AddPoints(PlayerID, 1);
    if CTF.PickJobID and JobIsRunning(CTF.PickJobID) then
        EndJob(CTF.PickJobID);
    end
    CTF.PickJobID = StartSimpleHiResJob("CTF_PickUpJob");
    CTF_SpawnFlag();
    if GameCallback_CTF_OnFlagDelivered then
        GameCallback_CTF_OnFlagDelivered(PlayerID, HeroID);
    end
end

function CTF_PickUpJob()
    if CTF.FlagCarrier ~= 0 then
        CTF.PickJobID = nil;
        return true;
    end
    for k, v in pairs(CTF_GetAllPlayerData()) do
        if not CTF_AreEnemiesInAreaWithoutDeadHeroes(v[1], CTF.FlagPosition, CTF.FlagPickRange * 5) then
            local HeroesList = {};
            Logic.GetHeroes(v[1], HeroesList);
            for j= 1, table.getn(HeroesList), 1 do
                if Logic.GetEntityHealth(HeroesList[j]) > 0 then
                    if IsNear(HeroesList[j], CTF.FlagPosition, CTF.FlagPickRange) then
                        CTF_PickFlag(HeroesList[j])
                        CTF.PickJobID = nil;
                        return true;
                    end
                end
            end
        end
    end
end

function CTF_CarryHomeJob()
    if CTF.FlagCarrier == 0 then
        CTF.CarryJobID = nil;
        return true;
    end

    -- Creates a flag near the carrier
    if not IsExisting(CTF.FlagCarrier) or Logic.IsEntityMoving(CTF.FlagCarrier) then
        DestroyEntity(CTF.FlagCarrierDeco);
    end
    if CTF.FlagCarrier ~= 0 and not IsExisting(CTF.FlagCarrierDeco) then
        local Position = GetRelativePos(CTF.FlagCarrier, 200, -180);
        local Orientation = Logic.GetEntityOrientation(CTF.FlagCarrier);
        CTF.FlagCarrierDeco = Logic.CreateEntity(Entities.XD_Rock1, Position.X, Position.Y, 270, 0);
        Logic.SetModelAndAnimSet(CTF.FlagCarrierDeco, Models.Banners_XB_BendFull);
    end
    
    -- Reset when holding to long
    CTF.FlagCarryTimer = CTF.FlagCarryTimer -1;
    if CTF.FlagCarryTimer == 0 then
        CTF_ResetFlag();
        CTF_SpawnFlag();
    end

    -- Info on minimap
    if math.mod(Logic.GetTime(), 4) == 0 then
        local x, y, z = Logic.EntityGetPos(CTF.FlagCarrier);
        GUI.ScriptSignal(x, y, 2);
    end

    -- Capture flag
    if CTF.FlagCarrier ~= 0 and Logic.GetEntityHealth(CTF.FlagCarrier) == 0 then
        local CapturerID = 0;
        local PlayerIDCarrier = Logic.EntityGetPlayer(CTF.FlagCarrier);
        for k, v in pairs(CTF_GetAllPlayerData()) do
            if v[1] ~= PlayerIDCarrier then
                CapturerID = CFT_GetHeroOfPlayerThatAttackedEntityRecently(v[1], CTF.FlagCarrier);
                if CapturerID ~= 0 then
                    break;
                end
            end
        end
        if IsExisting(CapturerID) then
            CTF_CaptureFlag(CapturerID);
        else
            CTF_ResetFlag();
            CTF_SpawnFlag();
        end
    end

    -- Deliver flag
    if IsNear(CTF.FlagCarrier, CTF_GetPlayerHQOfEntity(CTF.FlagCarrier), 1500) then
        CTF_DeliverFlag();
        CTF.CarryJobID = nil;
        return true;
    end
end

function CTF_OnEntityHurtEntityJob()
    local AttackerID = Event.GetEntityID1();
    local AttPlayer  = Logic.EntityGetPlayer(AttackerID);
    local AttackedID = {Event.GetEntityID2()};
    for i= 1, table.getn(AttackedID), 1 do
        if Logic.IsHero(AttackerID) == 1 then
            table.insert(CTF.AttackerIdMap, {AttackedID[i], AttackerID, 150});
        end
    end
end

function CFT_GetHeroOfPlayerThatAttackedEntityRecently(_PlayerID, _EntityID)
    for i= table.getn(CTF.AttackerIdMap), 1, -1 do
        if CTF.AttackerIdMap[i][1] == _EntityID then
            if IsExisting(CTF.AttackerIdMap[i][2]) then
                if Logic.GetEntityHealth(CTF.AttackerIdMap[i][2]) > 0 then
                    local AttackerPlayerID = Logic.EntityGetPlayer(CTF.AttackerIdMap[i][2]);
                    if _PlayerID == AttackerPlayerID then
                        return CTF.AttackerIdMap[i][2];
                    end
                end
            end
        end
    end
    return 0;
end

function CTF_ClearTaggedHeroesJob()
    for i= table.getn(CTF.AttackerIdMap), 1, -1 do
        CTF.AttackerIdMap[i][3] = CTF.AttackerIdMap[i][3] -1;
        if CTF.AttackerIdMap[i][3] < 1 then
            table.remove(CTF.AttackerIdMap, i);
        end
    end
end

-- Helper --

function CTF_AddPoints(_PlayerID, _Amount)
    for i= 1, table.getn(CTF.Players), 1 do
        if CTF.Players[i] and CTF.Players[i][1] == _PlayerID then
            CTF.Players[i][2] = CTF.Players[i][2] + math.abs(_Amount);
        end
    end
end

function CTF_IsDraw()
    if CTF_GetPlayerCount() == 1 then
        return false;
    end
    local IsDraw = true;
    local Points = CTF_GetPlayerPoints(CTF.Players[1][1]);
    for i= 2, CTF_GetPlayerCount(), 1 do
        if Points ~= CTF_GetPlayerPoints(CTF.Players[i][1]) then
            IsDraw = false;
        end
    end
    return IsDraw;
end

function CTF_GetPlayerPoints(_PlayerID)
    local Data = CTF_GetPlayerData(_PlayerID);
    if Data[1] ~= -1 then
        return Data[2];
    end
    return 0;
end

function CTF_GetTeamOfPlayerWithMostFlags()
    if CTF_IsDraw() then
        return 0;
    end
    local AdvantagerousPlayer = {-1, 0};
    for k, v in pairs(CTF_GetAllPlayerData()) do
        if v[2] > AdvantagerousPlayer[2] then
            AdvantagerousPlayer[1] = v[1];
            AdvantagerousPlayer[2] = v[2];
        end
    end
    return XNetwork.GameInformation_GetPlayerTeam(AdvantagerousPlayer[1]);
end

function CTF_AreEnemiesInAreaWithoutDeadHeroes(_PlayerID, _Position, _Area)
    return table.getn(CTF_GetEnemiesInAreaWithoutDeadHeroes(_PlayerID, _Position, _Area)) > 0;
end

function CTF_GetEnemiesInAreaWithoutDeadHeroes(_PlayerID, _Position, _Area)
    local EnemiesResult = {};
    for i= 1, 8, 1 do
        if i ~= _PlayerID and Logic.GetDiplomacyState(_PlayerID, i) == DiplomacyHostile then
            local Enemies = GetPlayerEntities(i, 0);
            for j= table.getn(Enemies), 1, -1 do
                local IsKilled = Logic.GetEntityHealth(Enemies[j]) == 0;
                local IsHero = Logic.IsHero(Enemies[j]) == 1;
                local IsSoldier = Logic.IsEntityInCategory(Enemies[j], EntityCategories.Soldier) == 1;
                if (IsHero or IsSolider) and not IsKilled then
                    table.insert(EnemiesResult, Enemies[j]);
                end
            end
        end
    end
    return EnemiesResult;
end

function CTF_GetPlayerHQOfEntity(_HeroID)
    if IsExisting(_HeroID) then
        local PlayerID = Logic.EntityGetPlayer(_HeroID);
        local EntityID = GetID("HQ" ..PlayerID);
        if IsExisting(EntityID) then
            return EntityID;
        end
    end
    return 0;
end

-- TODO: Is that needed anymore?
function CTF_GetFistHQOfPlayer(_PlayerID)
    local EntityTypes = {
        Entities.PB_Headquarters1,
        Entities.PB_Headquarters2,
        Entities.PB_Headquarters3,
    };
    for i= 1, table.getn(EntityTypes), 1 do
        local Found = GetPlayerEntities(_PlayerID, EntityTypes[i]);
        if table.getn(Found) > 0 then
            return Found[1];
        end
    end
    return 0;
end

function CTF_GetPlayerNameColored(_PlayerID)
    local UserName = UserTool_GetPlayerName(_PlayerID);
    local R, G, B = GUI.GetPlayerColor(_PlayerID);
    return string.format("@color:%d,%d,%d %s", R, G, B, UserName);
end

function CTF_GetPlayerCount()
    return table.getn(CTF_GetAllPlayerData());
end

function CTF_GetAllPlayerData()
    return CTF.Players;
end

function CTF_GetPlayerData(_PlayerID)
    for i= 1, table.getn(CTF.Players) do
        if CTF.Players[i][1] == _PlayerID then
            return CTF.Players[i];
        end
    end
    return {-1, 0};
end

-- -------------------------------------------------------------------------- --
-- Comforts for CTF                                                           --
-- Version 1.0.0                                                              --
-- -------------------------------------------------------------------------- --

function GetPlayerEntities(_PlayerID, _EntityType)
    local PlayerEntities = {}
    if _EntityType ~= 0 then
        local n,eID = Logic.GetPlayerEntities(_PlayerID, _EntityType, 1);
        if (n > 0) then
            local firstEntity = eID;
            repeat
                table.insert(PlayerEntities,eID)
                eID = Logic.GetNextEntityOfPlayerOfType(eID);
            until (firstEntity == eID);
        end
    elseif _EntityType == 0 then
        for k,v in pairs(Entities) do
            if string.find(k, "PU_") or string.find(k, "PB_") or string.find(k, "CU_") or string.find(k, "CB_")
            or string.find(k, "XD_DarkWall") or string.find(k, "XD_Wall") or string.find(k, "PV_") then
                local n,eID = Logic.GetPlayerEntities(_PlayerID, v, 1);
                if (n > 0) then
                local firstEntity = eID;
                repeat
                    table.insert(PlayerEntities,eID)
                    eID = Logic.GetNextEntityOfPlayerOfType(eID);
                until (firstEntity == eID);
                end
            end
        end
    end
    return PlayerEntities
end

function AreEnemiesInArea( _player, _position, _range)
    return AreEntitiesOfDiplomacyStateInArea( _player, _position, _range, Diplomacy.Hostile )
end
function AreEntitiesOfDiplomacyStateInArea( _player, _position, _range, _state )
    for i = 1,8 do
        if Logic.GetDiplomacyState( _player, i) == _state then
            if AreEntitiesInArea( i, 0, _position, _range, 1) then
                return true
            end
        end
    end
    return false
end

function GetLanguage()
    return (XNetworkUbiCom.Tool_GetCurrentLanguageShortName() == "de" and "de") or "en";
end

function ChangePlayersPlayerID(_newPlayer)
    local oldPlayer = GUI.GetPlayerID()
    GUI.SetControlledPlayer(_newPlayer)
    Logic.ActivateUpdateOfExplorationForAllPlayers()
	if gvMission then
	    gvMission.PlayerID = _newPlayer
	end
    Logic.PlayerSetIsHumanFlag( oldPlayer, 0 )
    Logic.PlayerSetIsHumanFlag( _newPlayer, 1 )
    Logic.PlayerSetGameStateToPlaying( _newPlayer )
    GUI.ClearSelection()
    PlayerChange_OldPlayer = oldPlayer
end

function StartCountdown(_Limit, _Callback, _Show)
    assert(type(_Limit) == "number")
    assert( not _Callback or type(_Callback) == "function" )
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
function CountdownIsVisisble()
    for i = 1, Counter.Index do
        if Counter.IsValid("counter" .. i) and Counter["counter" .. i].Show then
            return true
        end
    end
    return false
end

function IsValidPosition(_pos)
	if type(_pos) == "table" then
		if (_pos.X ~= nil and type(_pos.X) == "number") and (_pos.Y ~= nil and type(_pos.Y) == "number") then
			local world = {Logic.WorldGetSize()};
			if _pos.X <= world[1] and _pos.X >= 0 and _pos.Y <= world[2] and _pos.Y >= 0 then
				return true;
			end
		end
	end
	return false;
end

function GetDistance(_pos1, _pos2)
    if (type(_pos1) == "string") or (type(_pos1) == "number") then
        _pos1 = GetPosition(_pos1);
    end
    if (type(_pos2) == "string") or (type(_pos2) == "number") then
        _pos2 = GetPosition(_pos2);
    end
	assert(type(_pos1) == "table");
	assert(type(_pos2) == "table");
    local xDistance = (_pos1.X - _pos2.X);
    local yDistance = (_pos1.Y - _pos2.Y);
    return math.sqrt((xDistance^2) + (yDistance^2));
end

function GetRelativePos(_target,_distance,_angle)
    if not type(_target) == "table" and not IsExisting(_target) then
        return;
    end
    if _angle == nil then
        _angle = 0;
    end

    local pos1;
    if type(_target) == "table" then
        local pos = _target;
        local ori = 0+_angle;
        pos1 = { X= pos.X+_distance * math.cos(math.rad(ori)),
                 Y= pos.Y+_distance * math.sin(math.rad(ori))};
    else
        local eID = GetID(_target);
        local pos = GetPosition(eID);
        local ori = Logic.GetEntityOrientation(eID)+_angle;
        if Logic.IsBuilding(eID) == 1 then
            x, y = Logic.GetBuildingApproachPosition(eID);
            pos = {X= x, Y= y};
            ori = ori -90;
        end
        pos1 = { X= pos.X+_distance * math.cos(math.rad(ori)),
                 Y= pos.Y+_distance * math.sin(math.rad(ori))};
    end
    return pos1;
end

-- -------------------------------------------------------------------------- --
-- On Screen Information                                                      --
-- (taken from "Hinter dem Horizont" (2014))                                  --
-- -------------------------------------------------------------------------- --

gvOSI = {
	Position = {},
}

ONSCREEN_BAR = 1;
ONSCREEN_INFO = 0;

function gvOSI:InitOnScreenInformation()
	-- clear updates
	GUIUpdate_GetTeamPoints = function()end
	GUIUpdate_VCTechRaceProgress = function()end
	GUIUpdate_VCTechRaceColor = function()end
	
	function OSI_UpdateOSI()
		gvOSI:HideAllInformation();
		
        table.foreach(
            gvOSI.Position,
            function(k,v)
                if gvOSI.Position[k] ~= nil then
                    -- progress bar
                    if gvOSI.Position[k].type == ONSCREEN_BAR then
                        local pos = gvOSI.Position[k];
                        local current = pos:update();
                        local col = pos.color;
                        
                        if current >= pos.maximum then
                            current = pos.maximum;
                            pos.fulfilled = true;
                        else
                            pos.fulfilled = false;
                        end
                        gvOSI:ShowOnScreenProgressBar(k,pos.text,current,pos.maximum,col[1],col[2],col[3],col[4]);
                    
                    -- information
                    elseif gvOSI.Position[k].type == ONSCREEN_INFO then
                        local pos = gvOSI.Position[k];
                        local current = pos:update();
                        local fulfilled = false
                        
                        if current == true then
                            fulfilled = true;
                        else
                            fulfilled = false;
                        end
                        pos.fulfilled = fulfilled;
                        gvOSI:ShowOnScreenInformation(k,pos.text,current)
                    end
                end
            end
        );
	end
	StartSimpleJob("OSI_UpdateOSI")
	
	-- reload after load game
	gvOSI:OSIonSaveGameLoaded();
	Mission_OnSaveGameLoaded_OrigINFO = Mission_OnSaveGameLoaded;
	Mission_OnSaveGameLoaded = function()
		Mission_OnSaveGameLoaded_OrigINFO();
		gvOSI:OSIonSaveGameLoaded();
	end
end

function gvOSI:OnScreenProgressBar(t)
	if not t.color then
		t.color = {180,180,180,200};
    end
    if not t.color[4] then
		t.color[4] = 200;
	end
	gvOSI.ID = (gvOSI.ID or 0) +1
	assert(table.getn(gvOSI.Position) < 8,"only 8 positions can be shown!");
    local Index = table.getn(gvOSI.Position)+1;
    gvOSI.Position[Index] = t;
    gvOSI.Position[Index].type = ONSCREEN_BAR;
    gvOSI.Position[Index].id = gvOSI.ID;
	
	return gvOSI.ID;
end
function gvOSI:OnScreenInformation(t)
	gvOSI.ID = (gvOSI.ID or 0) +1;
    assert(table.getn(gvOSI.Position) < 8,"only 8 positions can be shown!");
    local Index = table.getn(gvOSI.Position)+1;
    gvOSI.Position[Index] = t;
    gvOSI.Position[Index].type = ONSCREEN_BAR;
    gvOSI.Position[Index].id = gvOSI.ID;

	return gvOSI.ID;
end

function gvOSI:GetPositionByID(ID)
	local foundPos = 0
    table.foreach(
        gvOSI.Position,
        function(k,v)
            if gvOSI.Position[k] then
                if gvOSI.Position[k].id == ID then
                    foundPos = k;
                end
            end
        end
    );
	
	return foundPos
end
function gvOSI:RemoveOnScreenInfoByID(osi)
	local pos = gvOSI:GetPositionByID(osi);
	if pos > 0 then
		if gvOSI.Position[pos] ~= nil then
			table.remove(gvOSI.Position,pos);
		end
	end
end
function gvOSI:IsFullfilled(osi)
	local pos = gvOSI:GetPositionByID(osi)
	if pos > 0 then
		if gvOSI.Position[pos] ~= nil then
			return gvOSI.Position[pos].fulfilled == true;
		end
	end
	return false;
end

function gvOSI:OSIonSaveGameLoaded()
	XGUIEng.ShowWidget( "VCMP_Window", 1 )
	XGUIEng.SetWidgetPosition( "VCMP_Window", 5, 100 )
	XGUIEng.SetWidgetPosition( "NotesWindow", 220, 150 )
	for i=1,8 do
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player1", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player2", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player3", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player4", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player5", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player6", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player7", 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."Player8", 0 )
		XGUIEng.SetWidgetSize( "VCMP_Team"..i, 200, 10 )
		XGUIEng.SetWidgetPositionAndSize( "VCMP_Team"..i.."Name", 5, 0, 200, 4 )
		XGUIEng.SetWidgetPositionAndSize( "VCMP_Team"..i.."Shade", 5, 0, 200, 4 )
		XGUIEng.SetWidgetPositionAndSize( "VCMP_Team"..i.."Points", 5, 0, 200, 0 )
		XGUIEng.SetWidgetPositionAndSize( "VCMP_Team"..i.."PointGame", 5, 5, 200, 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i, 0 )
		XGUIEng.ShowWidget( "VCMP_Team"..i.."_Shade", 0 )
	end
end

function gvOSI:ShowOnScreenProgressBar(_position,_title,_state,_max,_r,_g,_b,_t)
	gvOSI:HideOnScreenInformation(_position)
	XGUIEng.ShowWidget( "VCMP_Team".._position, 1 )
	XGUIEng.SetWidgetSize( "VCMP_Team".._position, 200, 10 )
	XGUIEng.SetText( "VCMP_Team".._position.."Points", _title )
	XGUIEng.SetText( "VCMP_Team".._position.."Name", "" )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."PointGame", 1 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."_Shade", 1 )
	
	local r = _r
	local g = _g
	local b = _b
	local t = _t
	local percent1 = (_state/_max)*100
	local percent2 = (200/100)*Round(percent1)
	if percent2 > 200 then percent2 = 200 end
	if r == nil then r = 100 end
	if g == nil then g = 100 end
	if b == nil then b = 100 end
	if t == nil then t = 200 end

	XGUIEng.SetWidgetSize( "VCMP_Team".._position.."Name", percent2, 4 )
	XGUIEng.SetWidgetSize( "VCMP_Team".._position.."_Shade", 200, 4 )
	XGUIEng.SetMaterialColor("VCMP_Team".._position.."Name",0,r,g,b,t)
	return (_state >= _max)
end
function gvOSI:ShowOnScreenInformation(_position,_title,_flag)
	gvOSI:HideOnScreenInformation(_position)
	XGUIEng.ShowWidget( "VCMP_Team".._position, 1 )
	XGUIEng.SetWidgetSize( "VCMP_Team".._position, 200, 15 )
	XGUIEng.SetText( "VCMP_Team".._position.."Points", _title )
	XGUIEng.SetText( "VCMP_Team".._position.."Name", "" )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."PointGame", 1 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."_Shade", 1 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."_Shade", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position, 1 )
	
	local color = {0,0,0,150}
	if _flag == true then
		color = {0,132,0,255}
	elseif _flag == 0 then
		color = {165,0,0,255}
	end
	XGUIEng.SetMaterialColor("VCMP_Team".._position.."Name",0,color[1],color[2],color[3],color[4])
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Name", 190, 0, 13, 13 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Shade", 190, 0, 13, 13 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Points", 0, 0, 200, 0 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."PointGame", 0, 0, 200, 0 )
	return _flag
end

function gvOSI:HideOnScreenInformation(_position)
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player1", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player2", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player3", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player4", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player5", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player6", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player7", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."Player8", 0 )
	XGUIEng.SetWidgetSize( "VCMP_Team".._position, 200, 10 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Name", 5, 0, 200, 4 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Shade", 5, 0, 200, 4 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."Points", 5, 0, 200, 0 )
	XGUIEng.SetWidgetPositionAndSize( "VCMP_Team".._position.."PointGame", 5, 5, 200, 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position, 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."_Shade", 0 )
	
	XGUIEng.ShowWidget( "VCMP_Team".._position, 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."PointGame", 0 )
	XGUIEng.ShowWidget( "VCMP_Team".._position.."_Shade", 0 )
end
function gvOSI:HideAllInformation()
	for i=1,8 do
		gvOSI:HideOnScreenInformation(i)
	end
end

function Round(_Value)
    return math.floor(_Value + 0.5);
end

