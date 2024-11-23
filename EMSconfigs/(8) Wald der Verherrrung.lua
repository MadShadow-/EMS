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
	Version = 1.1,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		AddPeriodicSummer(2);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
	MapTools.DestroyEntities(Entities.XD_SnowBarrier1);
	end,
	
	Peacetime = 40,
	
	-- ********************************************************************************************
	--  			GameModes
	-- add as many items as you want = {"3vs3", "2vs2", "1vs1"},
	-- the callback will return you the index of the selected gamemode
	-- between 1 - max nr
	-- allows you to modify the game depending on the chosen gamemode
	-- GameMode determines the preselected value;
	GameMode = 1,
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
	end,
	
	-- ********************************************************************************************
	-- * Resource Level ( 1 = Normal, 2 = FastGame, 3 = SpeedGame )
	-- * Setting the resource level to either one, two or three will give the players the ressources
	-- * specified in the table below.
	-- * You can specify the resources for each gamemode
	-- ********************************************************************************************
	--[[
		Ressources
		You can specify the ressources for a player in one of the tables Normal, FastGame, SpeedGame
		by adding a key entry with the playerId containing 6 entries which either contain a number
		or a function that returns a number as amount for the respective ressource
		If a player is not specified, he will get the ressources of player 1
		So if you want to give the same amount of ressources to all players, just specify player 1
	]]
	ResourceLevel = 1,
	
	Ressources =
	{
		Normal = {
			[1] = {
				500,
				2200,
				1600,
				700,
				50,
				50,
			},
		},
	},
	
	-- ********************************************************************************************
	-- * Callback_OnFastGame
	-- * this function will be called alongside with Callback_OnGameStart
	-- * if the players selected fastgame or speedgame
	-- ********************************************************************************************
	Callback_OnFastGame = function()
	end,

	-- ********************************************************************************************
	-- * AI Players
	-- * specify AI players to make sure their entities won't be deleted on game start
	-- ********************************************************************************************
	AIPlayers = {6},
	
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