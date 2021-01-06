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
	Version = 1.00,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		SetFriendly(1,2)
		SetFriendly(3,4)
		Logic.SetShareExplorationWithPlayerFlag(1, 2, 1)
		Logic.SetShareExplorationWithPlayerFlag(2, 1, 1)
		Logic.SetShareExplorationWithPlayerFlag(3, 4, 1)
		Logic.SetShareExplorationWithPlayerFlag(4, 3, 1)
		CreateWoodPile( "P8", 10000000)
		CreateWoodPile( "P7", 10000000)
		CreateWoodPile( "P6", 10000000)
		CreateWoodPile( "P5", 10000000)
		CreateWoodPile( "P4", 10000000)
		CreateWoodPile( "P3", 10000000)
		CreateWoodPile( "P2", 10000000)
		CreateWoodPile( "P1", 10000000)
		SetupHighlandWeatherGfxSet()
		AddPeriodicRain(150)
		
		for i = 1,4,1 do
			Logic.SetTechnologyState(i, Technologies.GT_Printing, 0)
			Logic.SetTechnologyState(i, Technologies.GT_Alloying, 0)
			Logic.SetTechnologyState(i, Technologies.GT_Tactics, 0)
			Logic.SetTechnologyState(i, Technologies.GT_Binocular, 0)
			Logic.SetTechnologyState(i, Technologies.GT_Architecture, 0)
			Logic.SetTechnologyState(i,Technologies.T_MarketSulfur, 0)
			Logic.SetTechnologyState(i,Technologies.T_MarketIron, 0)
		end
		LocalMusic.UseSet = HIGHLANDMUSIC
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		if Logic.GetTimeToNextWeatherPeriod() > 15 then
			Logic.SetWeatherOffset(Logic.GetTimeToNextWeatherPeriod()-10)
		end
		AddPeriodicSummer(500)
		warten = 2
		StartSimpleJob("EisenErsetzer")
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		MapTools.OpenPalisadeGates()
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 20,
 
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
	-- * You could give different resources or change the map environment accordingly
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
		Normal = {
			[1] = {
				1000,
				1000,
				1000,
				1000,
				400,
				150,
			},
		},
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
	DisableStandardVictoryCondition = false,
 
	-- ********************************************************************************************
	-- * Units
	-- * Various units can be allowed or forbidden
	-- * A 0 means the unit is forbidden - a higher number represents the maximum allowed level
	-- * Example: 
	-- * Sword = 0, equals Swords are forbidden
	-- * Sword = 2, equals the maximum level for swords is 2 = Upgrading once
	-- ********************************************************************************************
	Sword   = 0,
	Bow     = 2,
	PoleArm = 2,
	HeavyCavalry = 0,
	LightCavalry = 0,
	Rifle = 0,
	Thief = 0,
	Scout = 0,
	Cannon1 = 0,
	Cannon2 = 0,
	Cannon3 = 0,
	Cannon4 = 0,
 
	-- * Buildings
	Bridge = 1,
	-- * Markets
	-- * -1 = forbidden
	-- * 0 = Building markets is allowed and unlimited
	-- * 1 = Building markets is allowed and limited to 1
	-- * greater then one = Markets are allowed and limited to the number given
	Markets = 1,
 
	-- * Trade Limit
	-- * 0 = no trade limit
	-- * greater zero = maximum amount that you can buy in one single trade 
	TradeLimit = 0,
 
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 0, -- 0-3
 
	-- * TowerLimit
	-- * 0  = no tower limit
	-- * >0 = towers are limited to the number given
	TowerLimit = 0,
 
	-- * WeatherChangeLockTimer
	-- * Minutes for how long the weather can't be changed directly again after a weatherchange happened
	WeatherChangeLockTimer =  2,
 
	MakeSummer = 1,
	MakeRain   = 1,
	MakeSnow   = 1,
 
	-- * Fixes the DestrBuild bug
	AntiBug    = 1,
 
	-- * HQRush
	-- * If set to true, Headquarters are invulernerable as long the player still has village centers
	HQRush     = 1,
	BlessLimit = 1,
	InvulnerableHQs = false,
 
	-- * Heroes
	NumberOfHeroesForAll = 0,
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
	
}

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

function EisenErsetzer()
	if warten == 0 then
		for i = 1,4,1 do
			Logic.SubFromPlayersGlobalResource(i, ResourceType.IronRaw, 400)
			Logic.AddToPlayersGlobalResource(i, ResourceType.Iron, 400)
		end
		return true
	end
	warten = warten - 1
	return false
end