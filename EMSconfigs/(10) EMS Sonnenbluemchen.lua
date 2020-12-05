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
	
	ActivateDebug = true,
	CustomDebugFunc1 = function(_fromPlayer, _target1, _target2, _x, _y)
		--local eId=Logic.CreateEntity(Entities.XD_ResourceTree, _x, _y, 0, 0);
		--Logic.SetResourceDoodadGoodAmount( eId, 5000 );
		MapTools.CreateWoodPile(_x, _y, 500);
	end,
	
	CustomDebugFunc2 = function(_fromPlayer, _target1, _target2, _x, _y)
		local eId=Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, 1);
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		for i = 1,4 do
			for eId in S5Hook.EntityIterator(Predicate.OfType(Entities["XD_Sunflower"..i] )) do
				S5Hook.GetEntityMem(eId)[25]:SetFloat(2.5);
			end
		end
		
		for eId in S5Hook.EntityIterator(Predicate.OfType(Entities["XD_Corn1"] )) do
			S5Hook.GetEntityMem(eId)[25]:SetFloat(math.random(0.8,1.5));
		end
			

		MapTools.CreateWoodPiles(5000);
		
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
			[Entities.XD_Iron1] = 4000,
			[Entities.XD_Clay1] = 4000,
			[Entities.XD_Sulfur1] = 4000
		}
		for eId in S5Hook.EntityIterator(Predicate.OfAnyType(t[1],t[2],t[3],t[4],t[6],t[5],t[7],t[8])) do
			local entityType = Logic.GetEntityType(eId)
			Logic.SetResourceDoodadGoodAmount( eId, amount[entityType])
		end
		
		--Logic.CreateEntity(Entities.PB_Headquarters1, 25700.00, 56600, 0, 9);
		--Logic.CreateEntity(Entities.PB_Headquarters1, 17300, 44400, 0, 10);
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		--Logic.CreateEntity(Entities.PB_VillageCenter1, 24200, 51600, 0, 9);
		--Logic.CreateEntity(Entities.PB_VillageCenter1, 16400, 41400, 0, 10);
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		MapTools.OpenPalisadeGates();
		for eId in S5Hook.EntityIterator(Predicate.OfType(Entities["XD_Palisade3"] )) do
			DestroyEntity(eId);
		end
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 40,
 
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
	-- * Called together with Callback_OnGameStart if the player selected ResourceLevel 2 or 3
	-- * (FastGame or SpeedGame)
	-- ********************************************************************************************
	Callback_OnFastGame = function()
	end,

};
