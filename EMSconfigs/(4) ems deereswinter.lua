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
	Version = 2,

	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		MapTools.SetMapResource(
			{
				{Entities.XD_ClayPit1, 30000},
				{Entities.XD_StonePit1, 30000},
				{Entities.XD_IronPit1, 30000},
				{Entities.XD_SulfurPit1, 30000},
				{Entities.XD_Clay1, 1500},
				{Entities.XD_Stone1, 1500},
				{Entities.XD_Iron1, 1500},
				{Entities.XD_Sulfur1, 1500},
			}
		)
	end,

	Callback_OnGameStart = function()

	end,

	Callback_OnPeacetimeEnded = function()
		MapTools.DestroyEntities(Entities.XD_SnowBarrier1);
	end,

	Peacetime = 30,

	GameMode = 1,
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
	end,

	ResourceLevel = 1,
	Ressources =
	{
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
	},

	Callback_OnFastGame = function()
	end,

	AIPlayers = {},

	TowerLevel = 3,
	TowerLimit = 2,

	NumberOfHeroesForAll = 1,

	WeatherChangeLockTimer =  1,
};