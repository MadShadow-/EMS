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
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		DrawBridge1 = ReplaceEntity(65750, Entities.XD_DrawBridgeOpen1);
		DrawBridge2 = ReplaceEntity(85056, Entities.XD_DrawBridgeOpen1);
		
		--Tools.ExploreArea(1,1,900)
		
		-- brückebauplätze
		if isHuman(4) then
			if not isHuman(5) then
				DestroyEntity(65748);
			end
			if not isHuman(6) then
				DestroyEntity(65674);
			end
		end
		
		if isHuman(1) then
			if not isHuman(2) then
				DestroyEntity(84720);
			end
			if not isHuman(6) then
				DestroyEntity(66724);
			end
		end
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		for i = 1,8 do
			ForbidTechnology(Technologies.B_Bridge, i);
		end
		MapTools.NoResourcePaybackForStartTurrets();
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for i = 1,8 do
			AllowTechnology(Technologies.B_Bridge, i);
		end
		MapTools.OpenPalisadeGates();
		
		if isHuman(1) and isHuman(4) then
			StartWinter(600);
			AddPeriodicWinter(600);
		end
		
		local hasAlly = false;
		if isHuman(4) then
			if isHuman(5) then
				hasAlly = true;
				DestroyEntity("rock1");
				DestroyEntity("rock2");
			end
			if isHuman(6) then
				hasAlly = true;
				DestroyEntity("rock3");
				DestroyEntity("rock4");
			end
			if hasAlly then
				DrawBridge1 = ReplaceEntity(DrawBridge1, Entities.PB_DrawBridgeClosed2);
			end
		end
		
		hasAlly = false;
		if isHuman(1) then
			if isHuman(2) then
				hasAlly = true;
				DestroyEntity("rock7");
				DestroyEntity("rock8");
			end
			if isHuman(3) then
				hasAlly = true;
				DestroyEntity("rock5");
				DestroyEntity("rock6");
			end
			if hasAlly then
				DrawBridge2 = ReplaceEntity(DrawBridge2, Entities.PB_DrawBridgeClosed2);
			end
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

function isHuman(_pId)
	-- [[
		tt = {
			[1] = false,
			[2] = false,
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = false,
		}
		do return tt[_pId]; end
	--]]
	return XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(_pId) == 1;
end
	