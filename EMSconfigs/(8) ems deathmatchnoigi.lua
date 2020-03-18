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
		gvDownCenterOpen = false;
		gvTopCenterOpen = false;
		gvMidCenterOpen = false;
		
		local p;
		
		-- any bot players?
		p = {1,2,3,4};
		local anyPlayersBot = false;
		for i = 1,4 do
			if Player(p[i]) then
				anyPlayersBot = true;
			end
		end
		
		-- any top players?
		p = {5,6,7,8};
		local anyPlayersTop = false;
		for i = 1,4 do
			if Player(p[i]) then
				anyPlayersTop = true;
			end
		end

		-- any bot out players?
		--> open their gates
		p = {1,3};
		local anyPlayersBotOut = false;
		for i = 1,2 do
			if Player(p[i]) then
				anyPlayersBotOut = true;
				OpenPlayerGatesAside(p[i]);
				OpenPlayerGatesToVillageCenter(p[i]);
			end
		end
		
		-- any top out players?
		--> open their gates
		p = {6,8};
		local anyPlayersTopOut = false;
		for i = 1,2 do
			if Player(p[i]) then
				anyPlayersTopOut = true;
				OpenPlayerGatesAside(p[i]);
				OpenPlayerGatesToVillageCenter(p[i]);
			end
		end
		
		-- middle bot players
		p = {2,4};
		for i = 1,2 do
			if Player(p[i]) then
				if anyPlayersTop then
					OpenPlayerGatesToMid(p[i]);
					if anyPlayersBotOut then
						OpenPlayerGatesAside(p[i]);
					end
				else
					OpenPlayerGatesAside(p[i])
				end
			end
		end
		
		-- middle top players
		p = {5,7};
		for i = 1,2 do
			if Player(p[i]) then
				if anyPlayersBot then
					OpenPlayerGatesToMid(p[i]);
					if anyPlayersTopOut then
						OpenPlayerGatesAside(p[i]);
					end
				else
					OpenPlayerGatesAside(p[i])
				end
			end
		end
		
		-- open entrances
		if gvDownCenterOpen and gvMidCenterOpen then
			OpenPassage(1);
		end
		if gvTopCenterOpen and gvMidCenterOpen then
			OpenPassage(2);
		end
		
		-- open village centers
		for i = 1,8 do
			if Player(i) then
				OpenPlayerGatesToVillageCenter(i);
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
				1000,
				2400,
				1750,
				800,
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


function Player(_playerId)
	return MCS.PlayerList[_playerId];
end

function OpenPlayerGatesAside(_playerId)
	if _playerId <= 4 then
		gvDownCenterOpen = true;
	else
		gvTopCenterOpen = true;
	end
	for i = 1,4 do
		DestroyEntity("p".._playerId.."_g"..i);
	end
end

function OpenPlayerGatesToMid(_playerId)
	gvMidCenterOpen = true;
	for i = 5,8 do
		DestroyEntity("p".._playerId.."_g"..i);
	end
end

function OpenPlayerGatesToVillageCenter(_playerId)
	for i = 1,2 do
		ReplaceEntity("P".._playerId.."_MiniGate"..i, Entities.XD_PalisadeGate2);
	end
end

function OpenPassage(_index)
	for i = 1,3 do
		DestroyEntity("d".._index.."_"..i);
	end
end