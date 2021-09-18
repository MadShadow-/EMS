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
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua");

		mcbPacker.Paths={{"maps\\user\\EMS\\tools\\", ".lua"}}
		mcbPacker.require("s5CommunityLib/lib/UnlimitedArmy")
        mcbPacker.require("s5CommunityLib/lib/UnlimitedArmySpawnGenerator")
		
		Script.Load(gvBasePath.. "briefings.lua");
		Script.Load(gvBasePath.. "daily_cycle.lua");
		Script.Load(gvBasePath.. "daily_cycle_rain.lua");
		Script.Load(gvBasePath.. "daily_cycle_snow.lua");
		Script.Load(gvBasePath.. "PoisenReiter.lua");
		Script.Load(gvBasePath.. "army_id5_banditen.lua");
		Script.Load(gvBasePath.. "army_id5_nebelvolk.lua");
		Script.Load(gvBasePath.. "army_id6.lua");
		Script.Load(gvBasePath.. "army_id6_wave2.lua");
		Script.Load(gvBasePath.. "army_id6_wave3.lua");
		Script.Load(gvBasePath.. "army_id6_wave4.lua");
		Script.Load(gvBasePath.. "army_id7.lua");
		Script.Load(gvBasePath.. "army_id7_wave2.lua");
		Script.Load(gvBasePath.. "army_id7_wave3.lua");
		Script.Load(gvBasePath.. "army_id7_wave4.lua");
		Script.Load(gvBasePath.. "army_id8.lua");
		Script.Load(gvBasePath.. "army_id8_wave2.lua");
		Script.Load(gvBasePath.. "army_id8_wave3.lua");
		Script.Load(gvBasePath.. "army_id8_wave4.lua");
		Script.Load(gvBasePath.. "MainMapScript.lua");
		TriggerFix.AllScriptsLoaded()


		SetupHighlandWeatherGfxSet();

		--Sommertage

		for i=1,2,1 do
		AddPeriodicSummer(4*60);
		AddPeriodicTransitionSunrise(60);
		AddPeriodicSunrise(60)
		AddPeriodicNight(4*60);
		AddPeriodicSunrise(60)
		AddPeriodicTransitionSunrise(60);
		end

		--Regentage

		AddPeriodicRain(4*60);
		AddPeriodicTransitionSunriseRain(60);
		AddPeriodicSunriseRain(60)
		AddPeriodicNightRain(4*60);
		AddPeriodicSunriseRain(60)
		AddPeriodicTransitionSunriseRain(60);



	

		LocalMusic.UseSet = MEDITERANEANMUSIC;


		
		Score.Player[0] = {buildings=0, all=0}
		MapTools.WallsToPlayerZero(Entities.XD_DarkWallStraightGate,Entities.XD_DarkWallStraightGate_Closed, Entities.XD_DarkWallCorner, Entities.XD_DarkWallStraight, Entities.XD_DarkWallDistorted)

		Logic.SetPlayerRawName(5, "Nebelvolk / Banditen")
		Logic.SetPlayerRawName(6, "Herzog der Schrecklichkeit")
		Logic.SetPlayerRawName(7, "Herzog der Herrlichkeit")
		Logic.SetPlayerRawName(8, "Herzog der Gerechtigkeit")

		Display.SetPlayerColorMapping(5, 1)   --Blau
		Display.SetPlayerColorMapping(6, 2)   --Rot
		Display.SetPlayerColorMapping(7,9)    -- dunkel grün
		Display.SetPlayerColorMapping(8, 3)   --gelb
	
		local resourceTable = {
			{Entities.XD_StonePit1, 1000000},
			{Entities.XD_IronPit1, 1000000},
			{Entities.XD_ClayPit1, 1000000},
			{Entities.XD_SulfurPit1, 10000000},
			{Entities.XD_Stone1, 5000},
			{Entities.XD_Iron1, 5000},
			{Entities.XD_Clay1, 5000},
			{Entities.XD_Sulfur1, 5000}
		}
		MapTools.SetMapResource(resourceTable);
		


		function
			LocalMusic.CallbackSettlerKilled(_HurterPlayerID, _HurtPlayerID)
				
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
	Peacetime = 70,
 
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
				0,
				0,
				0,
				0,
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
	AIPlayers = {



		AI.Player_EnableAi(8),
		AI.Village_SetSerfLimit(8,8),
		AI.Village_EnableConstructing(8,1),
		AI.Village_EnableExtracting(8,false),


		AI.Player_EnableAi(7),
		AI.Village_SetSerfLimit(7,8),
		AI.Village_EnableConstructing(7,1),
		AI.Village_EnableExtracting(7,false),


		AI.Player_EnableAi(6),
		AI.Village_SetSerfLimit(6,8),
		AI.Village_EnableConstructing(6,1),
		AI.Village_EnableExtracting(6,false)

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
	TowerLevel = 2, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 2,
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  3,
 
	-- * Enables chaning to a specific weather with the weather tower
	MakeSummer = 0,
	MakeRain   = 0,
	MakeSnow   = 0,
 
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