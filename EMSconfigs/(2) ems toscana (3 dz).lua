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
	Version = 1,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		
		MapTools.CreateWoodPiles(3000);
		
		local t = {
			Entities.XD_StonePit1,
			Entities.XD_IronPit1,
			Entities.XD_ClayPit1,
			Entities.XD_SulfurPit1,
			Entities.XD_Clay1,
			Entities.XD_Iron1,
			Entities.XD_Stone1,
			Entities.XD_Sulfur1,
		}
		local amount = {
			[Entities.XD_StonePit1] = 100000,
			[Entities.XD_IronPit1] = 30000,
			[Entities.XD_ClayPit1] = 100000,
			[Entities.XD_SulfurPit1] = 50000,
			[Entities.XD_Stone1] = 4000,
			[Entities.XD_Iron1] = 1000,
			[Entities.XD_Clay1] = 4000,
			[Entities.XD_Sulfur1] = 1000
		}
		for eId in S5Hook.EntityIterator(Predicate.OfAnyType(t[1],t[2],t[3],t[4],t[6],t[5],t[7],t[8])) do
			local entityType = Logic.GetEntityType(eId)
			Logic.SetResourceDoodadGoodAmount( eId, amount[entityType])
		end
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		for i = 1,4 do
			 ForbidTechnology(Technologies.B_MasterBuilderWorkshop, i);
		end
		
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for i = 1,4 do
			 AllowTechnology(Technologies.B_MasterBuilderWorkshop, i);
			 SetHostile(i,5);
		end
		MapTools.OpenPalisadeGates()
	end,
	
	Peacetime = 30,
	
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
				2400,
				1750,
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
	AIPlayers = {},
};