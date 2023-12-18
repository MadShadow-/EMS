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
	Version = 3.4,
 
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
		local gvBasePath = "maps\\externalmap\\";
		Script.Load(gvBasePath.. "daily_cycle.lua");
		Script.Load(gvBasePath.. "MainMapScript.lua");
		Script.Load(gvBasePath.. "invasion.lua");
		Script.Load(gvBasePath.. "camps.lua");
		Script.Load(gvBasePath.. "achievements.lua");
		Script.Load(gvBasePath.. "GUI_Action.lua");
		Script.Load(gvBasePath.. "GUI_Tooltip.lua");
		Script.Load(gvBasePath.. "GUI_Update.lua");
		Script.Load(gvBasePath.. "traders.lua");
		Script.Load(gvBasePath.. "signalfire.lua");
		Script.Load(gvBasePath.. "tower_limit.lua");
		Script.Load(gvBasePath.. "briefing.lua");
		--Twa stuff aus cerberus (für npcs)
		Script.Load(gvBasePath.. "cerberus\\loader.lua");
		Script.Load(gvBasePath.. "merchantcaravantrader.lua");
		Lib.Require("module/io/NonPlayerCharacter");
		Lib.Require("module/entity/EntityTracker");
		Lib.Require("module/cinematic/BriefingSystem");
		--Lib.Require("comfort/GetUpgradeCategoryByEntityType");
		--Most important stuff from SIMÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		Script.Load(gvBasePath.. "kimichurasdefarmy.lua");
		Script.Load(gvBasePath.. "filter.lua");
		Script.Load(gvBasePath.. "spawnarmy.lua");
		
		---Seed für SP:
		if XNetwork.Manager_DoesExist() == 0 then
			local randomString = Framework.GetSystemTimeDateString()
			local seedTable = GenerateRandomHexValues(randomString)
			math.randomseed(seedTable[1],seedTable[2])
		end

		if not WidgetHelper then
			Script.Load( "MP_SettlerServer\\WidgetHelper.lua" )
		end
		--GUI
		OnMapStart_InitWidgets()
		XGUIEng.ShowWidget("Specials",0)
		
		SetupHighlandWeatherGfxSet();

		
		--Sommertage
		AddPeriodicSummer(20*60);

		--Wintertage
		AddPeriodicWinter(15*60);

		--Regentage
		AddPeriodicRain(5*60);

		--Sommertage
		AddPeriodicSummer(5*60);

		--Wintertage
		AddPeriodicWinter(10*60);

		--Regentage
		AddPeriodicRain(2*60);
		
		--Debug
		-- for i = 1,4 do
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.GoldRaw,100000)
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.ClayRaw,100000)
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.WoodRaw,100000)
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.StoneRaw,100000)
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.IronRaw,100000)
		-- 	Logic.AddToPlayersGlobalResource(i,ResourceType.SulfurRaw,100000)
		-- end
		--

		LocalMusic.UseSet = HIGHLANDMUSIC;


		
		Score.Player[0] = {buildings=0, all=0}
		MapTools.WallsToPlayerZero(Entities.XD_DarkWallStraightGate,
		Entities.XD_DarkWallStraightGate_Closed, 
		Entities.XD_DarkWallCorner, 
		Entities.XD_DarkWallStraight, 
		Entities.XD_DarkWallDistorted,
		Entities.XD_WallStraightGate,
		Entities.XD_WallStraightGate_Closed, 
		Entities.XD_WallCorner, 
		Entities.XD_WallStraight, 
		Entities.XD_WallDistorted,
		Entities.PB_PalisadeCorner,
		Entities.PB_PalisadeDistorted,
		Entities.PB_PalisadeStraight,
		Entities.PB_PalisadeStraightGate_Closed,
		Entities.PB_PalisadeStraightGate)

		Logic.SetPlayerRawName(5, "Banditen")
		Logic.SetPlayerRawName(6, "Invasoren")
		Logic.SetPlayerRawName(7, "Invasoren")
		Logic.SetPlayerRawName(8, "Händlergilde")
		
--------- Kimichuras Farben-KI-Verwalter--------------------------------
		local colors = {2,9,14,4,5,6,7,8,1,10,11,12,13,3,15,16}
		local players = GetActivePlayers();
		for i = 1,table.getn(players) do
			local col = XNetwork.GameInformation_GetLogicPlayerColor(players[i]);
			for j = table.getn(colors), 1, -1 do
				if colors[j] == col then
					table.remove(colors, j);
				end;
			end;
		end;
		
		if table.getn(players) == 1 then
			Display.SetPlayerColorMapping(2, colors[5])
		end
		Display.SetPlayerColorMapping(5, colors[3])
		Display.SetPlayerColorMapping(6, colors[16])
		Display.SetPlayerColorMapping(7, colors[7])
		Display.SetPlayerColorMapping(8, colors[15])
------------------------------------------------------------------

		SetHostile(1,3)
		SetHostile(1,4)
		SetHostile(1,5)
		SetHostile(1,6)

		SetHostile(2,3)
		SetHostile(2,4)
		SetHostile(2,5)
		SetHostile(2,6)

		SetFriendly(1,2)
		SetFriendly(3,4)

		ActivateShareExploration(1,2, true)
		ActivateShareExploration(3,4, true)

		SetHostile(3,5)
		SetHostile(3,7)

		SetHostile(4,5)
		SetHostile(4,7)

		for i=1,4 do
			SetNeutral(i,8)
		end
	
		local resourceTable = {
			{Entities.XD_StonePit1, 100000},
			{Entities.XD_IronPit1, 100000},
			{Entities.XD_ClayPit1, 100000},
			{Entities.XD_SulfurPit1, 100000},
			{Entities.XD_Stone1, 2000},
			{Entities.XD_Iron1, 2000},
			{Entities.XD_Clay1, 2000},
			{Entities.XD_Sulfur1, 2000}
		}
		MapTools.SetMapResource(resourceTable);
		


		function LocalMusic.CallbackSettlerKilled(_HurterPlayerID, _HurtPlayerID)
				
				local PlayerID = GUI.GetPlayerID()
				
				if _HurterPlayerID ~= _HurtPlayerID 
				and PlayerID == _HurtPlayerID  then        
					if LocalMusic.LastBattleMusicStarted < Logic.GetTime() then                    
						if Logic.IsEntityInCategory(_HurterPlayerID,EntityCategories.EvilLeader) == 1 then
							LocalMusic.BattlesOnTheMap = 2
						else
							LocalMusic.BattlesOnTheMap = 1
						end
						LocalMusic.LastBattleMusicStarted = Logic.GetTime() + 127
						LocalMusic.SongLength = 0
					end
				end
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
		Normal = {},
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
	AIPlayers = {},
 
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
	Bridge = 0,
 
	-- * Markets
	-- * -1 = Building markets is forbidden
	-- * 0 = Building markets is allowed
	-- * >0 = Markets are allowed and limited to the number given
	Markets = 3,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 5000,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 8,
 
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
	NumberOfHeroesForAll = 2,
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



function GetActivePlayers()
    local Players = {};
    if XNetwork.Manager_DoesExist() == 1 then
        -- TODO: Does that fix everything for Community Server?
        for i= 1, table.getn(Score.Player), 1 do
            if Logic.PlayerGetGameState(i) == 1 then
                table.insert(Players, i);
            end
        end
    else
        table.insert(Players, GUI.GetPlayerID());
    end
    return Players;
end


function ActivateShareExploration(_player1, _player2, _both)

    assert(type(_player1) == "number" and type(_player2) == "number" and _player1 <= 16 and _player2 <= 16 and _player1 >= 1 and _player2 >= 1)

    if _both == false then
        Logic.SetShareExplorationWithPlayerFlag(_player1, _player2, 1)
    else
        Logic.SetShareExplorationWithPlayerFlag(_player1, _player2, 1)
        Logic.SetShareExplorationWithPlayerFlag(_player2, _player1, 1)
    end

end

function DeactivateShareExploration(_player1, _player2, _both)

    assert(type(_player1) == "number" and type(_player2) == "number" and _player1 <= 16 and _player2 <= 16 and _player1 >= 1 and _player2 >= 1)

    if _both == false then
        Logic.SetShareExplorationWithPlayerFlag(_player1, _player2, 0)
    else
        Logic.SetShareExplorationWithPlayerFlag(_player1, _player2, 0)
        Logic.SetShareExplorationWithPlayerFlag(_player2, _player1, 0)
    end

end

function GenerateRandomHexValues(dateTimeString)
	-- Ersetze Bindestriche durch Leerzeichen, um den String aufzuteilen
	dateTimeString = string.gsub(dateTimeString, "-", " ")

	-- Teile den String in Komponenten (Jahr, Monat, Tag, Stunde, Minute, Sekunde)
	local _, _, year, month, day, hour, minute, second = string.find(dateTimeString, "(%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")

	-- Konvertiere die Komponenten in Zahlen
	year, month, day, hour, minute, second = tonumber(year), tonumber(month), tonumber(day), tonumber(hour), tonumber(minute), tonumber(second)

	-- Verwende die Datum/Uhrzeit-Komponenten, um die Seed-Werte zu erstellen
	local hex_x = year + month + day + hour + minute + second
	local hex_y = year * month * day * hour * minute * second
	local table = {hex_x,hex_y}
	-- Gib die hexadezimalen Werte aus
	return table
end