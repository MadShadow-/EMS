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
	ActivateDebug = false,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		AddPeriodicSummer(4*60);
		AddPeriodicRain(30);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = MEDITERANEANMUSIC;
		
		MapTools.SetMapResourceDefault();
		WT21.Setup();
		MapTools.CreateWoodPiles(50000, Entities.XD_SingnalFireOff);
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		MapTools.SetVillageCenterPlacesProvided(Entities.CB_SteamMashine, 30);
		for i = 1,4 do ForbidTechnology(Technologies.B_MasterBuilderWorkshop, i); end
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for i = 1,4 do AllowTechnology(Technologies.B_MasterBuilderWorkshop, i); end
		MapTools.OpenWallGates()
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
				2750,
				2400,
				900,
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
	
	HeavyCavalry = 2,
	LightCavalry = 2,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
	
	NumberOfHeroesForAll = 2,
	Drake = 0,
	
	-- * TowerLevel
	-- * 0 = Towers forbidden
	-- * 1 = Watchtowers
	-- * 2 = Balistatowers
	-- * 3 = Cannontowers
	TowerLevel = 3, -- 0-3
 
	-- * TowerLimit
	-- * >0 = towers are limited to the number given
	TowerLimit = 3,
	
};

WT21 = {};

function WT21.Setup()
	WT21.VCGiver1 = 0;
	WT21.VCGiver2 = 0;
	WT21.ResourceHutCounter = {[0]=0,[1]=0,[2]=0}; -- per team
	WT21.SupplyCounter = 120;
	local buildingInfoHut1 =
	{
		SpawnInfo =
		{
			Type = Entities.CB_InventorsHut1,
			X = 36800,
			Y = 3600,
			Rotation = 180,
			Owner = 5,
		},
		NeutralPlayer = 5,
		ConquerConditionCallback = WT21.DefaultConquerCondition,
		RespawnCallback = WT21.ResourceHut_RespawnCallback,
		HealthThreshold = 150, -- health at which building can be conquered
		RespawnHurtValue = 100, -- hp to hurt entity with after spawn
	};
	MapTools.AddConquerBuilding(buildingInfoHut1);

	local buildingInfoHut2 =
	{
		SpawnInfo =
		{
			Type = Entities.CB_InventorsHut1,
			X = 37000,
			Y = 69700,
			Rotation = 0,
			Owner = 5,
		},
		NeutralPlayer = 5,
		ConquerConditionCallback = WT21.DefaultConquerCondition,
		RespawnCallback = WT21.ResourceHut_RespawnCallback,
		HealthThreshold = 150, -- health at which building can be conquered
		RespawnHurtValue = 100, -- hp to hurt entity with after spawn
	};
	MapTools.AddConquerBuilding(buildingInfoHut2);


	local buildingInfoCastle =
	{
		SpawnInfo =
		{
			Type = Entities.CB_Castle1,
			X = 36800,
			Y = 36800,
			Rotation = 0,
			Owner = 5,
		},
		NeutralPlayer = 5,
		ConquerConditionCallback = WT21.DefaultConquerCondition,
		RespawnCallback = WT21.Castle_RespawnCallback,
		HealthThreshold = 150, -- health at which building can be conquered
		RespawnHurtValue = 100, -- hp to hurt entity with after spawn
	};
	MapTools.AddConquerBuilding(buildingInfoCastle);
	StartSimpleJob("WT21_ResourceSupplyJob");
end

function WT21.GetTeam(_Id)
	if _Id == nil then return 0; end
	if _Id > 0 and _Id <= 2 then
		return 1;
	elseif
		_Id <=4 then
		return 2;
	else
		return 0;
	end
end

function WT21.ResourceHut_RespawnCallback(_prevOwner, _newOwner)
	WT21.ResourceHutCounter[WT21.GetTeam(_newOwner)] = WT21.ResourceHutCounter[WT21.GetTeam(_newOwner)] + 1;
	WT21.ResourceHutCounter[WT21.GetTeam(_prevOwner)] = WT21.ResourceHutCounter[WT21.GetTeam(_prevOwner)] - 1;
end

function WT21.Castle_RespawnCallback(_prevOwner, _newOwner)
	local newOwner1 = -1;
	local newOwner2 = -1;
	if _newOwner == 1 or _newOwner == 2 then
		newOwner1 = 1;
		newOwner2 = 2;
	elseif _newOwner == 3 or _newOwner == 4 then
		newOwner1 = 3;
		newOwner2 = 4;
	end
	if newOwner1 > 0 then
		DestroyEntity(WT21.VCGiver1);
		DestroyEntity(WT21.VCGiver2);
		WT21.VCGiver1 = Logic.CreateEntity(Entities.CB_SteamMashine, 200, 200, 0, newOwner1);
		WT21.VCGiver2 = Logic.CreateEntity(Entities.CB_SteamMashine, 200, 200, 0, newOwner2);
	end
end

function WT21.DefaultConquerCondition(_buildingInfo) -- returns the playerId that has the building conquered or false if neutral
	local numEntities = 1;
	local range = 1500;
	local entities;
	local entitiesInArea = {};
	for playerId = 1,4 do
		entities = {Logic.GetPlayerEntitiesInArea(playerId, 0, _buildingInfo.SpawnInfo.X, _buildingInfo.SpawnInfo.Y, range, numEntities)}
		if entities[1] > 0 then
			entitiesInArea[playerId] = true;
		end
	end
	local t1 = entitiesInArea[1] or entitiesInArea[2];
	local t2 = entitiesInArea[3] or entitiesInArea[4];
	if t1 and t2 then
		return false;
	elseif t1 then
		if entitiesInArea[1] then return 1 else return 2 end;
	elseif t2 then
		if entitiesInArea[3] then return 3 else return 4 end;
	end
	return false;
end

-- function WT21.OnPeaceTimeEnded()	
	-- WT21.ResourceSupplyCounter = 0;
	-- WT21_SupplyResourcesToOwners = function()
		-- WT21.ResourceSupplyCounter = WT21.ResourceSupplyCounter + 1;
		-- if WT21.ResourceSupplyCounter > 30 then
			-- WT21.SupplyResources(WT21.ResourceHuts[1].Owner);
			-- WT21.SupplyResources(WT21.ResourceHuts[2].Owner);
			-- WT21.ResourceSupplyCounter = 0;
		-- end
	-- end;
	-- StartSimpleJob("WT21_SupplyResourcesToOwners");
-- end

function WT21_ResourceSupplyJob()
	if WT21.SupplyCounter > 0 then
		WT21.SupplyCounter = WT21.SupplyCounter - 1;
		return;
	end

	WT21.SupplyCounter = 120;
	for i = 1,4 do
		local team = WT21.GetTeam(i);
		WT21.SupplyResources(i, WT21.ResourceHutCounter[team]);
	end
end

function WT21.SupplyResources(_pId, _factor)
	if _pId == -1 then
		return;
	end
	local res =
	{
		400*_factor, -- gold
		200*_factor, -- lehm
		200*_factor, -- wood
		200*_factor, -- stone
		400*_factor, -- iron
		400*_factor, -- sulfur
	};
	Tools.GiveResouces(_pId, unpack(res));
end