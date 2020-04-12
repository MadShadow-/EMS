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
	Version = 1.2,
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
		ConquerArea.Setup();
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
		MapTools.OpenPalisadeGates();
		ConquerArea.Start();
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
	Bridges = 0,
};

ConquerArea = {};

function ConquerArea.Setup()
	ConquerArea.Pos = GetPosition("midFlag");
	ConquerArea.Range = 1000;
	ConquerArea.ConquerAreaCounterMax = 90;
	ConquerArea.LoseAreaCounterMax = 10;
	
	ConquerArea.CounterValues = {
		ConquerArea.ConquerAreaCounterMax, -- team1
		"placeholder",
		ConquerArea.ConquerAreaCounterMax, -- team2
		
		-- index + 3
		ConquerArea.LoseAreaCounterMax, -- team1
		"placeholder",
		ConquerArea.LoseAreaCounterMax -- team2
	};
	ConquerArea.LoseAreaCounterOffset = 3;
	
	ConquerArea.Conquered = {false, "placeholder", false};
	ConquerArea.ConquerStarted = {false, "placeholder", false};
	ConquerArea.LoseStarted = {false, "placeholder", false};
	ConquerArea.TimerColor = "";
	ConquerArea.Flags = {};
	for i = 1,4 do
		ConquerArea.SpawnFlag(i);
	end
	
	local pos = GetPosition("midFlag");
	for i = 1,4 do
		Logic.SetEntityExplorationRange(Logic.CreateEntity(Entities.XD_ScriptEntity,  pos.X+i, pos.Y+i, 0, i), 10);
	end
	
	-- attraction place provided by steam machine
	S5Hook.GetRawMem(9002416)[0][16][Entities.CB_SteamMashine*8+2][44]:SetInt(25);
	
	ConquerArea.SteamMashines = {};
	if ems_debug then
		ConquerArea.ActivateDebug();
	end
end

function ConquerArea.Start()
	ConquerAreaControlJobId = StartSimpleJob("ConquerAreaControlJob");
end

function ConquerAreaControlJob()
	local loseAreaCounterIndex;
	for teamId = 1,4,2 do
		if ConquerArea.HasEntitiesInArea(teamId) then
			-- team has entities in area
			if not ConquerArea.Conquered[teamId] then
				if not ConquerArea.ConquerStarted[teamId] then
					ConquerArea.StartConquer(teamId);
				end
				
				if ConquerArea.CounterValues[teamId] > 0 then
					ConquerArea.CounterValues[teamId] = ConquerArea.CounterValues[teamId] - 1;
					ConquerArea.TimerSetValue(teamId, ConquerArea.CounterValues[teamId]);
				else
					ConquerArea.AreaConquered(teamId);
				end
			else
				if ConquerArea.LoseStarted[teamId] then
					ConquerArea.CancelLose(teamId);
				end
			end
			
		else
			-- team has no entities in area
			if ConquerArea.Conquered[teamId] then
				if not ConquerArea.LoseStarted[teamId] then
					ConquerArea.StartLose(teamId);
				end
				
				loseAreaCounterIndex = teamId + ConquerArea.LoseAreaCounterOffset;
				if ConquerArea.CounterValues[loseAreaCounterIndex] > 0 then
					ConquerArea.CounterValues[loseAreaCounterIndex] = ConquerArea.CounterValues[loseAreaCounterIndex] - 1;
					ConquerArea.TimerSetValue(teamId, ConquerArea.CounterValues[loseAreaCounterIndex]);
				else
					ConquerArea.AreaLost(teamId);
				end
			else
				if ConquerArea.ConquerStarted[teamId] then
					ConquerArea.CancelConquer(teamId);
				end
			end
		end
	end
end

-- start callbacks
function ConquerArea.StartConquer(_teamId)
	ConquerArea.ResetCounter(_teamId);
	ConquerArea.ConquerStarted[_teamId] = true;
	ConquerArea.TimerStatusUpdate(_teamId, 1, "@color:0,255,0 ");
end

function ConquerArea.StartLose(_teamId)
	ConquerArea.ResetCounter(_teamId);
	ConquerArea.LoseStarted[_teamId] = true;
	ConquerArea.TimerStatusUpdate(_teamId, 1, "@color:255,0,0 ");
end

-- action callbacks
function ConquerArea.AreaConquered(_teamId)
	ConquerArea.Conquered[_teamId] = true;
	ConquerArea.Reward(_teamId);
	ConquerArea.Reward(_teamId+1);
	ConquerArea.TimerStatusUpdate(_teamId, 0, "");
end

function ConquerArea.AreaLost(_teamId)
	ConquerArea.Conquered[_teamId] = false;
	ConquerArea.RemoveReward(_teamId);
	ConquerArea.RemoveReward(_teamId+1);
	ConquerArea.TimerStatusUpdate(_teamId, 0, "");
end

-- cancel callbacks
function ConquerArea.CancelConquer(_teamId)
	ConquerArea.ConquerStarted[_teamId] = false;
	ConquerArea.TimerStatusUpdate(_teamId, 0, "");
end

function ConquerArea.CancelLose(_teamId)
	ConquerArea.LoseStarted[_teamId] = false;
	ConquerArea.TimerStatusUpdate(_teamId, 0, "");
end

-- timer update
function ConquerArea.TimerStatusUpdate(_teamId, _show, _color)
	if ConquerArea.IsSpectator() then
		local widget = ConquerArea.SpectatorGetTimerWidget(_teamId);
		XGUIEng.ShowWidget(widget, _show);
	elseif ConquerArea.isMyGUI(_teamId) then
		XGUIEng.ShowWidget("EMSTimer", _show);
		ConquerArea.TimerColor = _color;
	else
		XGUIEng.ShowWidget("EMSTimer2", _show);
	end
end

function ConquerArea.IsSpectator()
	return GUI.GetPlayerID() == 17;
end

function ConquerArea.SpectatorGetTimerWidget(_teamId)
	if GUI.GetPlayerID() == 17 then
		if _teamId < 3 then
			return "EMSTimer";
		else
			return "EMSTimer2";
		end
	end
end

function ConquerArea.TimerSetValue(_teamId, _value)
	local minutes = math.floor(_value/60);
	local seconds = _value - minutes*60;
	if seconds < 10 then
		seconds = "0"..seconds;
	end
	if ConquerArea.IsSpectator() then
		local widget = ConquerArea.SpectatorGetTimerWidget(_teamId);
		XGUIEng.SetText(widget,  "@color:255,165,0 ".. minutes .. ":" .. seconds);
	elseif ConquerArea.isMyGUI(_teamId) then
		XGUIEng.SetText("EMSTimer", ConquerArea.TimerColor .. minutes .. ":" .. seconds);
	else
		XGUIEng.SetText("EMSTimer2",  "@color:255,165,0 ".. minutes .. ":" .. seconds);
	end
end

-- reset
function ConquerArea.ResetCounter(_teamId)
	ConquerArea.CounterValues[_teamId] = ConquerArea.ConquerAreaCounterMax;
	ConquerArea.CounterValues[_teamId+ConquerArea.LoseAreaCounterOffset] = ConquerArea.LoseAreaCounterMax;
end

function ConquerArea.HasEntitiesInArea(_teamId)
	local entities = {Logic.GetPlayerEntitiesInArea(_teamId,     0, ConquerArea.Pos.X, ConquerArea.Pos.Y, ConquerArea.Range, 1)};
	local entitiesInArea = false;
	if entities[1] > 0 then
		if Logic.IsBuilding(entities[2]) == 0 then
			entitiesInArea = true;
		end
	end
	entities = {Logic.GetPlayerEntitiesInArea(_teamId + 1, 0, ConquerArea.Pos.X, ConquerArea.Pos.Y, ConquerArea.Range, 1)};
	if entities[1] > 0 then
		if Logic.IsBuilding(entities[2]) == 0 then
			entitiesInArea = true;
		end
	end
	return entitiesInArea;
end

function ConquerArea.isMyGUI(_teamId)
	local pId = GUI.GetPlayerID();
	return (pId == _teamId) or (pId == _teamId+1);
end

function ConquerArea.Reward(_pId)
	ConquerArea.SteamMashines[_pId] = Logic.CreateEntity(Entities.CB_SteamMashine, 100, 100, 0, _pId);
	ConquerArea.SpawnFlag(_pId, true);
end

function ConquerArea.RemoveReward(_pId)
	DestroyEntity(ConquerArea.SteamMashines[_pId]);
	ConquerArea.SpawnFlag(_pId);
end

function ConquerArea.SpawnFlag(_pId, _setToPlayer)
	DestroyEntity(ConquerArea.Flags[_pId]);
	local pos = {
		{29754,29971, 317},
		{31337, 30014, 44.87},
		{31411, 31004, 130.82},
		{29775, 31143, 231.08}
	};
	local _flagPlayer = 8;
	if _setToPlayer then
		_flagPlayer = _pId;
	end
	ConquerArea.Flags[_pId] = Logic.CreateEntity(Entities.XD_StandartePlayerColor, pos[_pId][1], pos[_pId][2], pos[_pId][3], _flagPlayer);
end

function ConquerArea.ActivateDebug()
	Message("@color:255,165,0 local map debug active");
	ConquerArea.DebugEntities = {};
	function ConquerArea.SpawnLocal(_id)
		local x,y = GUI.Debug_GetMapPositionUnderMouse();
		Sync.Call("ConquerArea.Spawn", _id, x, y);
	end
	
	function ConquerArea.Spawn(_id, _x, _y)
		table.insert(ConquerArea.DebugEntities, Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, _id));
	end
	
	function ConquerArea.DespawnLocal()
		Sync.Call("ConquerArea.Despawn");
	end
	
	function ConquerArea.Despawn()
		for i = 1, table.getn(ConquerArea.DebugEntities) do
			DestroyEntity(ConquerArea.DebugEntities[i]);
		end
		ConquerArea.DebugEntities = {};
	end
	Sync.Add("ConquerArea.Spawn");
	Sync.Add("ConquerArea.Despawn");
	Input.KeyBindDown(Keys.Y, "ConquerArea.SpawnLocal(1)", 2);
	Input.KeyBindDown(Keys.X, "ConquerArea.SpawnLocal(2)", 2);
	Input.KeyBindDown(Keys.C, "ConquerArea.SpawnLocal(3)", 2);
	Input.KeyBindDown(Keys.V, "ConquerArea.SpawnLocal(4)", 2);
	Input.KeyBindDown(Keys.M, "ConquerArea.DespawnLocal()", 2);
	
	ConquerArea.Start();
	ConquerArea.Start = function() end;
end