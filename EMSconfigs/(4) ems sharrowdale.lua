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
	Version = 3,
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * this function is called directly after the loading screen vanishes
	-- * it's a replacement for FirstMapAction/GameCallback_OnGameSart
	-- * use for initialisation
	-- ********************************************************************************************
	
	Callback_OnMapStart = function()
		if not CNetwork then
			math.randomseed(444);
		end
		SetupHighlandWeatherGfxSet();
		AddPeriodicSummer(7*60);
		AddPeriodicWinter(4*60);
		AddPeriodicRain(60);
		AddPeriodicSummer(5*60);
		AddPeriodicWinter(2*60);
		
		LocalMusic.UseSet = HIGHLANDMUSIC;
		
		MultiplayerTools.InitCameraPositionsForPlayers();
		SetupDiplomacy();
		TowersInvulnerable();
		CreateArmies();
	
		local ViewCenter;
		-- 0 = grün
		-- 1 = blau
		-- 2 = weiss
		-- 3 = rot
		for i = 1,4 do
			ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity, 36713, 36699+i, 0, i)
			Logic.SetEntityExplorationRange(ViewCenter, 10)
			ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity, 36829, 70244+i, 0, i)
			Logic.SetEntityExplorationRange(ViewCenter, 25)
			ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity, 36988, 2909+i, 0, i)
			Logic.SetEntityExplorationRange(ViewCenter, 25)
		end
		
		-- overwrite enlarge army
		EnlargeArmy = function(_army,_troop)
			local troop = CreateTroop(_army,_troop)
			AI.Entity_ConnectLeader(troop,_army.id)
			return troop;
		end
		
		Start_Condition = function()
			if IsDead("kerberos") then
				SetupWinCondition();
				CreateSupportArmies();
				CreateAttackingArmies();
				Message("@color:0,255,255 Haltet die Mitte für 15 Minuten!");
				return true;
			end
		end
		StartSimpleJob("Start_Condition");
		
		Camera.ZoomSetFactorMax(2);
		
		Logic.SetEntityInvulnerabilityFlag(65537, 1);
		Logic.SetEntityInvulnerabilityFlag(65538, 1);
		Logic.SetEntityInvulnerabilityFlag(65539, 1);
		Logic.SetEntityInvulnerabilityFlag(65540, 1);

	end,
	
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * called when the players start the actual game by pressing the start button
	-- * and after the 10 seconds of countdown
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		local firstUpgradeTimer = 60*7;
		local secondUpgradeTimer = 60*10;
		
		UpgradeCounter = firstUpgradeTimer;
		UpgradedTowerLevel = 1;
		UpgradeTowers = function()
			UpgradeCounter = UpgradeCounter - 1;
			if UpgradeCounter <= 0 then
				UpgradeTowerLevel(UpgradedTowerLevel);
				UpgradedTowerLevel = UpgradedTowerLevel + 1;
				UpgradeCounter = secondUpgradeTimer;
				if UpgradedTowerLevel >= 3 then
					return true;
				end
			end
		end
		StartSimpleJob("UpgradeTowers");
		StartSimpleJob("ControllKerberos")

		GameCallback_PlaceBuildingAdditionalCheck_Orig = GameCallback_PlaceBuildingAdditionalCheck or function() end
		function GameCallback_PlaceBuildingAdditionalCheck(_EntityType, _X, _Y, _R, _IsBuildOn)
			-- is tower in middle
			if Logic.GetUpgradeCategoryByBuildingType(_EntityType) == UpgradeCategories.Tower then
				if (36800 - _X) ^ 2 + (36800 - _Y) ^ 2 <= 36000000 then -- 6000 ^ 2
					return false
				end
			end
			return GameCallback_PlaceBuildingAdditionalCheck_Orig(_EntityType, _X, _Y, _R, _IsBuildOn)
		end

		GUIUpdate_BuildingButtons_Orig = GUIUpdate_BuildingButtons
		function GUIUpdate_BuildingButtons(_Widget, _Technology)
			GUIUpdate_BuildingButtons_Orig(_Widget, _Technology)
			if _Widget == "Build_Foundry" then
				local player = GUI.GetPlayerID()
				if Logic.GetNumberOfEntitiesOfTypeOfPlayer(player, Entities.PB_Foundry1) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(player, Entities.PB_Foundry2) >= 4 then
					XGUIEng.DisableButton("Build_Foundry", 1)
				end
			end
		end

		GUIAction_PlaceBuilding_Orig = GUIAction_PlaceBuilding
		function GUIAction_PlaceBuilding(_UpgradeCategory)
			if _UpgradeCategory == UpgradeCategories.Foundry then
				local player = GUI.GetPlayerID()
				if Logic.GetNumberOfEntitiesOfTypeOfPlayer(player, Entities.PB_Foundry1) + Logic.GetNumberOfEntitiesOfTypeOfPlayer(player, Entities.PB_Foundry2) >= 4 then
					return
				end
			end
			GUIAction_PlaceBuilding_Orig(_UpgradeCategory)
		end

		function DoManualButtonUpdateOnBuildingCreated()
			local id = Event.GetEntityID()
			if Logic.IsBuilding(id) == 1 and Logic.EntityGetPlayer(id) == GUI.GetPlayerID() then
				--XGUIEng.DoManualButtonUpdate("SerfConstructionMenu")
				local ids = {GUI.GetSelectedEntities()}
				GUI.ClearSelection()
				for i = 1, table.getn(ids) do
					GUI.SelectEntity(ids[i])
				end
			end
		end
		Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED, nil, "DoManualButtonUpdateOnBuildingCreated", 1)
	end,
	
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called after the peace time ends
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
	end,
	
	Peacetime = 0,
	
	-- ********************************************************************************************
	--  			GameModes
	-- add as many items as you want = {"3vs3", "2vs2", "1vs1"},
	-- the callback will return you the index of the selected gamemode
	-- between 1 - max nr
	-- allows you to modify the game depending on the chosen gamemode
	-- GameMode determines the preselected value;
	GameMode = 1,
	GameModes = {"2vs2"},
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
				1000,
				2400,
				1900,
				500,
				150,
				150,
			},
		},
		FastGame = { -- 0 means the values for Normal ressources will be multiplied by 2
			[1] = {
				0,
				0,
				0,
				0,
				0,
				0,
			},
		},
		SpeedGame = { -- 0 means standard values will be used (20k, 12k, 14k, 10k, 7.5k, 7.5k)
			[1] = {
				0,
				0,
				0,
				0,
				0,
				0,
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
	
	TowerLevel = 3,
	TowerLimit = 5,
	NumberOfHeroesForAll = 0,
	Cannon1 = 1,
	Cannon2 = 1,
	Cannon3 = 1,
	Cannon4 = 1,
	TradeLimit = 3500,
	Markets = 0,
	
	HeavyCavalry = 2,
	LightCavalry = 2,
	Thief = 1,
	
	AntiHQRush = 0,

	-- ********************************************************************************************
	-- * AI Players
	-- * specify AI players to make sure their entities won't be deleted on game start
	-- ********************************************************************************************
	AIPlayers = {7,8},
};

function SetupDiplomacy()
	-- teams
	SetFriendly(1,2);
	SetFriendly(3,4);
	
	-- enemies
	SetHostile(1,3);
	SetHostile(1,4);
	SetHostile(2,3);
	SetHostile(2,4);
	
	-- kerberos
	SetHostile(1,7);
	SetHostile(2,7);
	SetHostile(3,7);
	SetHostile(4,7);
	SetHostile(1,8);
	SetHostile(2,8);
	SetHostile(3,8);
	SetHostile(4,8);
	
	Logic.SetPlayerRawName( 7, "Kerberos" );
	Display.SetPlayerColorMapping(7, 12);
	Display.SetPlayerColorMapping(8, 12);
end

function TowersInvulnerable()
	for i = 1,6 do
		MakeInvulnerable("ut"..i);
	end
	MakeInvulnerable(75690);
	MakeInvulnerable(73409);
end

function CreateArmies()
	local x = 1000000;
	Tools.GiveResouces(7, x, x, x, x, x, x);
	local desc = {serfLimit = 4}
	SetupPlayerAi(7,desc);
	SetupPlayerAi(8,desc);
	
	CreateBaseArmies();
	CreateDefendArmies()
end

function CreateBaseArmies()
	BaseArmies = {};
	BaseArmies.MaxTroops = 5;
	
	BaseArmy1 = {}
	BaseArmy1.player = 7
	BaseArmy1.id = 6
	BaseArmy1.strength = BaseArmies.MaxTroops
	BaseArmy1.position = {X=36751,Y=66174}
	BaseArmy1.rodeLength = 2000
	SetupArmy(BaseArmy1)
	for i = 1, BaseArmies.MaxTroops  do
		EnlargeArmy(BaseArmy1, GetRandomBaseArmyDesc());
	end
	FrontalAttack(BaseArmy1)
	
	BaseArmy2 = {}
	BaseArmy2.player = 8
	BaseArmy2.id = 6
	BaseArmy2.strength = BaseArmies.MaxTroops
	BaseArmy2.position = {X=36875,Y= 6707}
	BaseArmy2.rodeLength = 2000
	SetupArmy(BaseArmy2)
	for i = 1, BaseArmies.MaxTroops  do
		EnlargeArmy(BaseArmy2, GetRandomBaseArmyDesc());
	end
	FrontalAttack(BaseArmy2)
	StartSimpleJob("RefreshBaseArmies");
end

function RefreshBaseArmies()
	for i = 1,2 do
		if(IsWeak(_G["BaseArmy"..i])) then
			EnlargeArmy(_G["BaseArmy"..i], GetRandomBaseArmyDesc());
		end
	end
end

function GetRandomBaseArmyDesc()
	local troopDescription = {
		maxNumberOfSoldiers = 8,
		minNumberOfSoldiers = 0,
		experiencePoints = VERYLOW_EXPERIENCE,
	};
	if math.random(4) == 1 then
		-- ~20% chance for sword
		troopDescription.leaderType = Entities.PU_LeaderSword3;
	else
		-- ~80% chance for bow
		troopDescription.leaderType = Entities.PU_LeaderBow3;
	end
	return troopDescription;
end

function CreateDefendArmies()
	DefendingArmiesCounters = {0,0,0,0,0};
	DefendingArmiesCounters.Max = 20;
	DefendingArmiesCounters.MaxTroops = 5;

	army1 = {}
	army1.player = 7
	army1.id = 1
	army1.strength = DefendingArmiesCounters.MaxTroops
	army1.position = {X=36713,Y=36699}
	army1.rodeLength = 4000
	SetupArmy(army1)
	-- 2 to 5 because RefreshJob instantly adds one
	for i = 2,DefendingArmiesCounters.MaxTroops  do
		EnlargeArmy(army1, GetRandomTroopsDescription());
	end
	FrontalAttack(army1)
	
	
	army2 = {}
	army2.player = 7
	army2.id = 2
	army2.strength = DefendingArmiesCounters.MaxTroops
	army2.position = {X=29486,Y=36729}
	army2.rodeLength = 2000
	SetupArmy(army2)
	for i = 2,DefendingArmiesCounters.MaxTroops  do
		EnlargeArmy(army2, GetRandomTroopsDescription());
	end
	FrontalAttack(army2)
	
	army3 = {}
	army3.player = 7
	army3.id = 3
	army3.strength = DefendingArmiesCounters.MaxTroops
	army3.position = {X=36809,Y=28629}
	army3.rodeLength = 2000
	SetupArmy(army3)
	for i = 2,DefendingArmiesCounters.MaxTroops  do
		EnlargeArmy(army3, GetRandomTroopsDescription());
	end
	FrontalAttack(army3)
	
	army4 = {}
	army4.player = 7
	army4.id = 4
	army4.strength = DefendingArmiesCounters.MaxTroops
	army4.position = {X=44103,Y=36767}
	army4.rodeLength = 2000
	SetupArmy(army4)
	for i = 2,DefendingArmiesCounters.MaxTroops  do
		EnlargeArmy(army4, GetRandomTroopsDescription());
	end
	FrontalAttack(army4)
	
	army5 = {}
	army5.player = 7
	army5.id = 5
	army5.strength = DefendingArmiesCounters.MaxTroops
	army5.position = {X=36897,Y=45347}
	army5.rodeLength = 2000
	SetupArmy(army5)
	for i = 2,DefendingArmiesCounters.MaxTroops  do
		EnlargeArmy(army5, GetRandomTroopsDescription());
	end
	FrontalAttack(army5)
	StartSimpleJob("RefreshDefendingArmies");
end

function GetRandomTroopsDescription()
	local troopDescription = {
		maxNumberOfSoldiers = 8,
		minNumberOfSoldiers = 0,
		experiencePoints = VERYLOW_EXPERIENCE,
	};
	if math.random(3) == 1 then
		-- ~30% chance for bows
		troopDescription.leaderType = Entities.CU_BanditLeaderBow1;
	else
		-- ~60% chance for sword
		troopDescription.leaderType = Entities.CU_BlackKnight_LeaderMace2;
	end
	return troopDescription;
end

function RefreshDefendingArmies()
	local troops;
	local playerId = 7;
	local allRespawnsDead = true;
	for armyId = 1,5 do
		if(IsAlive("resp"..armyId)) then
			allRespawnsDead = false;
			troops = AI.Army_GetNumberOfTroops(playerId, armyId);
			if troops < DefendingArmiesCounters.MaxTroops then
				DefendingArmiesCounters[armyId] = DefendingArmiesCounters[armyId] - 1;
				if DefendingArmiesCounters[armyId] <= 0 then
					EnlargeArmy(_G["army"..armyId], GetRandomTroopsDescription());
					DefendingArmiesCounters[armyId] = DefendingArmiesCounters.Max;
				end
			end
		end
	end

	if allRespawnsDead then
		return true;
	end
end

function CreateSupportArmies()
	SupportArmies = {10,10};
	SupportArmies.MaxTroops = 6;
	SupportArmies.Max = 30;
	
	SupportArmies.Anchors = 
	{
		{{36751,66174}, {36929,57182}, {36945,51614}, {36780,45158}, {36745,36863}, Current=1, Counter=30, CounterMax=50},
		{{36875, 6707}, {36806,15963}, {36917,20357}, {36960,28359}, {36745,36863}, Current=1, Counter=30, CounterMax=50},
	};
	
	SupportArmy1 = {}
	SupportArmy1.player = 7
	SupportArmy1.id = 0
	SupportArmy1.strength = SupportArmies.MaxTroops
	SupportArmy1.position = {X=36751,Y=66174}
	SupportArmy1.rodeLength = 2000
	SetupArmy(SupportArmy1)
	for i = 1, SupportArmies.MaxTroops  do
		EnlargeArmy(SupportArmy1, GetRandomSupportArmyDesc());
	end
	Advance(SupportArmy1)
	
	SupportArmy2 = {}
	SupportArmy2.player = 8
	SupportArmy2.id = 0
	SupportArmy2.strength = SupportArmies.MaxTroops
	SupportArmy2.position = {X=36875,Y= 6707}
	SupportArmy2.rodeLength = 2000
	SetupArmy(SupportArmy2)
	for i = 1, SupportArmies.MaxTroops  do
		EnlargeArmy(SupportArmy2, GetRandomSupportArmyDesc());
	end
	Advance(SupportArmy2)
	StartSimpleJob("RefreshSupportArmies");
	StartSimpleJob("ControlSupportArmies");
end

function RefreshSupportArmies()
	for armyId = 1,2 do
		if(IsDead(_G["SupportArmy"..armyId])) then
			SupportArmies[armyId] = SupportArmies[armyId] - 1;
			if SupportArmies[armyId] <= 0 then
				for j = 1, SupportArmies.MaxTroops  do
					EnlargeArmy(_G["SupportArmy"..armyId], GetRandomSupportArmyDesc());
					SupportArmies[armyId] = SupportArmies.Max;
				end
				SupportArmies.Anchors[armyId].Current = 1;
				SupportArmies.Anchors[armyId].Counter = SupportArmies.Anchors[armyId].CounterMax;
			end
		end
	end
end

function ControlSupportArmies()
	local army;
	local current;
	for armyId = 1,2 do
		army = _G["SupportArmy"..armyId]
		if(not IsDead(army)) then
			SupportArmies.Anchors[armyId].Counter = SupportArmies.Anchors[armyId].Counter - 1;
			if SupportArmies.Anchors[armyId].Counter <= 0 then
				if SupportArmies.Anchors[armyId].Current < table.getn(SupportArmies.Anchors[armyId]) then
					-- next anchor
					SupportArmies.Anchors[armyId].Current = SupportArmies.Anchors[armyId].Current + 1;
					current = SupportArmies.Anchors[armyId].Current;
					-- move army to anchor
					Redeploy(army, {X=SupportArmies.Anchors[armyId][current][1],Y=SupportArmies.Anchors[armyId][current][2]});
					SupportArmies.Anchors[armyId].Counter = SupportArmies.Anchors[armyId].CounterMax;
				end
			end
		end
	end
end

function GetRandomSupportArmyDesc()
	local troopDescription = {
		maxNumberOfSoldiers = 8,
		minNumberOfSoldiers = 0,
		experiencePoints = VERYLOW_EXPERIENCE,
	};
	if math.random(3) == 1 then
		-- ~30% chance for bows
		troopDescription.leaderType = Entities.CU_BanditLeaderBow1;
	else
		-- ~60% chance for sword
		troopDescription.leaderType = Entities.CU_BlackKnight_LeaderMace2;
	end
	return troopDescription;
end


function SetupWinCondition()
	
	-- jo.
	UserTool_GetPlayerName_Orig = UserTool_GetPlayerName;
	UserTool_GetPlayerName = function(_Id)
		if _Id == 7 then
			return "Kerberos";
		else
			return UserTool_GetPlayerName_Orig(_Id);
		end
	end
	
	GUIUpdate_VCTechRaceProgress = function()end
	GUIUpdate_VCTechRaceColor = function()end
	
	--[[ my gui
	local widgetWidth = 100;
	local containerWidth = 189;
	XGUIEng.ShowWidget("VCMP_Window", 1);
	for i = 1,3 do
		XGUIEng.ShowWidget("VCMP_Team"..i.."TechRace", 1);
		XGUIEng.ShowWidget("VCMP_Team"..i.."ProgressBG",0);
		
		XGUIEng.SetWidgetSize("VCMP_Team"..i, widgetWidth-1, 20, 22);
		XGUIEng.SetWidgetPositionAndSize("VCMP_Team"..i.."TechRace", 0, 0, containerWidth, 14, 22);
		XGUIEng.SetWidgetPositionAndSize("VCMP_Team"..i.."Name", 2, 3, widgetWidth-1, 14, 22);
		XGUIEng.SetMaterialColor("VCMP_Team"..i.."Name", 0, 0, 0, 0, 0);
		XGUIEng.SetWidgetSize("VCMP_Team"..i.."_Shade", widgetWidth, 16)
		XGUIEng.SetProgressBarValues("VCMP_Team"..i.."Progress", 600, 600)
		for j = 1,8 do
			XGUIEng.ShowWidget("VCMP_Team"..i.."Player"..j, 0);
		end
		XGUIEng.SetWidgetPositionAndSize("VCMP_Team"..i.."Progress", 0, 0, containerWidth, 14, 22);
	end
	for i = 4, 8 do 
		XGUIEng.ShowWidget("VCMP_Team"..i, 0);
		XGUIEng.ShowWidget("VCMP_Team"..i.."_Shade", 0);
	end]]
	
	-- napo
	local barLength = 250
	local textBoxSize = 15
	local barHeight = 4
	local heightElement = 25
	XGUIEng.SetWidgetSize( "VCMP_Window", 252, 294)
	XGUIEng.ShowWidget( "VCMP_Window", 1)
	XGUIEng.ShowAllSubWidgets( "VCMP_Window",1)	
	for i = 1, 8 do
		for j = 1, 8 do
			XGUIEng.ShowWidget( "VCMP_Team"..i.."Player"..j, 0)
		end
		XGUIEng.SetWidgetSize( "VCMP_Team"..i, 252, 32)
		XGUIEng.SetWidgetSize( "VCMP_Team"..i.."Name", 252, 32)
		XGUIEng.ShowWidget( "VCMP_Team"..i.."_Shade", 0)
		XGUIEng.SetMaterialColor( "VCMP_Team"..i.."Name", 0, 0, 0, 0, 0) --hide BG by using alpha = 0s
		XGUIEng.ShowWidget( "VCMP_Team"..i.."PointGame", 0)

		
		-- manage progress bars
		XGUIEng.ShowWidget( "VCMP_Team"..i.."TechRace", 1)
		XGUIEng.ShowAllSubWidgets( "VCMP_Team"..i.."TechRace", 1)
		XGUIEng.SetWidgetSize( "VCMP_Team"..i.."TechRace", barLength, barHeight)
		XGUIEng.SetWidgetSize( "VCMP_Team"..i.."Progress", barLength, barHeight)
		XGUIEng.SetWidgetSize( "VCMP_Team"..i.."ProgressBG", barLength, barHeight)

		-- widget positions to set
		XGUIEng.SetWidgetPosition( "VCMP_Team"..i, 0, heightElement*(i-1))
		XGUIEng.SetWidgetPosition( "VCMP_Team"..i.."Name", 0, 0)
		XGUIEng.SetWidgetPosition( "VCMP_Team"..i.."TechRace", 0, textBoxSize)
	end
	for i = 4, 8 do 
		XGUIEng.ShowWidget("VCMP_Team"..i, 0);
		XGUIEng.ShowWidget("VCMP_Team"..i.."_Shade", 0);
	end
	
	StartSimpleJob("JobConquerArea");
	ConquerArea = {
		Points = {0,0,0},
		PointsNeeded = 900, -- 15 minuten a 60 sekunden
		Position = {X=36737, Y=36735},
		Teams = {{1,2},{3,4},{7,8}};
		Players = {1,1,2,2}
	};
	
	local r,g,b;
	for teamId = 1,3 do
		r,g,b = GUI.GetPlayerColor(ConquerArea.Teams[teamId][1]);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", UserTool_GetPlayerName(ConquerArea.Teams[teamId][1]));
		XGUIEng.SetMaterialColor("VCMP_Team"..teamId.."Progress", 0, r, g, b, 150)
	end
	
	ConqueringTeam = 0
end

function JobConquerArea()

	-- update team points
	for i = 1,3 do
		XGUIEng.SetProgressBarValues("VCMP_Team"..i.."Progress", ConquerArea.Points[i], ConquerArea.PointsNeeded);
	end
	
	local range = 4000;
	local entities, entitiesOfTeam;
	local numberOfPlayers = 0;
	local entityName, entity;
	for teamId = 1, table.getn(ConquerArea.Teams) do
		if ConquerArea.Points[teamId] >= ConquerArea.PointsNeeded then
			TeamWon(teamId);
			return true;
		end
		entitiesOfTeam = 0;
		for teamPlayerId = 1, table.getn(ConquerArea.Teams[teamId]) do
			entities = {Logic.GetPlayerEntitiesInArea(ConquerArea.Teams[teamId][teamPlayerId], 0, ConquerArea.Position.X, ConquerArea.Position.Y, range, 16 )};
			entitiesOfTeam = entitiesOfTeam + entities[1];
			for i = 1, entities[1] do
				entity = entities[1+i];
				if Logic.IsHero(entity) == 1 then
					if IsDead(entity) then
						entitiesOfTeam = entitiesOfTeam - 1;
					end
				end
			end
		end
		
		--[[ kerberos - is a hero too
		if teamId == 3 then
			entities = {Logic.GetPlayerEntitiesInArea(5, Entities.CU_BlackKnight, ConquerArea.Position.X, ConquerArea.Position.Y, range, 1 )};
			if entities[1] > 0 then
				if IsDead(entities[2]) then
					entitiesOfTeam = entitiesOfTeam - 1;
				end
			end
		end]]
		
		if entitiesOfTeam > 0 then
			ConqueringTeam = teamId;
			numberOfPlayers = numberOfPlayers + 1;
			if numberOfPlayers > 1 then
				ConqueringTeam = 0;
				return;
			end
		end
	end
	if ConqueringTeam > 0 then
		ConquerArea.Points[ConqueringTeam] = ConquerArea.Points[ConqueringTeam] + 1;
		for teamId = 1,3 do
			XGUIEng.SetText("VCMP_Team"..teamId.."Name", UserTool_GetPlayerName(ConquerArea.Teams[teamId][1]) .. " ("..ConquerArea.Points[teamId] .. "/" .. ConquerArea.PointsNeeded..")");
		end
	end
end

function TeamWon(_teamId)
	GUI.AddStaticNote("@color:0,255,0 Team ".. UserTool_GetPlayerName(ConquerArea.Teams[_teamId][1]) .. " won!");
	for i = 1,3 do
		GUI.AddStaticNote("Punkte Team "..UserTool_GetPlayerName(ConquerArea.Teams[i][1]).." : " .. ConquerArea.Points[i]);
	end
	for i = 1,8 do
		for j = i,8 do
			SetFriendly(i,j);
		end
	end
end

function UpgradeTowerLevel(_level)
	local player;
	for playerId, playerData in pairs(EMS.PlayerList) do
		player = playerId;
	end
	local n,eID = Logic.GetPlayerEntities(7, Entities["PB_Tower".._level], 1);
	if (n > 0) then
		local firstEntity = eID;
		repeat
			if CNetwork then
				SendEvent.UpgradeBuilding(eID);
			elseif GUI.GetPlayerID() == player then
				GUI.UpgradeSingleBuilding(eID);
			end
			eID = Logic.GetNextEntityOfPlayerOfType(eID);
		until (firstEntity == eID);
	end
end

function ControllKerberos()
	local pos = GetPosition("kerberos")
	if IsAlive("kerberos") and (36800 - pos.X) ^ 2 + (36800 - pos.Y) ^ 2 > 144000000 then -- 12000
		Move("kerberos", {X = 36800, Y = 36800})
	end
end

function CreateAttackingArmies()
	StartSimpleJob("ControlAttackingArmies");
	AttackArmies = {
		-- first spawn timers
		30,
		30,
		30,
		30,
		120,
		120,
		120,
		120,
		SpawnRight = {X=37136, Y=474},
		WaitOnRespawn = 20,
	};
	
	AttackArmies.Anchors = 
	{	
		-- attack p1 path
		{{37136, 474}, {36657,13614}, {31412,20620}, {25531,27228}, {20466,34269}, {16602,30987}, { 9917,33411}, { 8419,26454}, {10128,20856}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p2 path
		{{36840, 73303}, {36959,59399}, {30101,50599}, {26239,46524}, {20024,39087}, {16451,43191}, {  9400,40426}, {  7432,45010}, {11425,53606}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p3 path
		{{37136, 474}, {36657,13614}, {42340,21139}, {48940,28314}, {53521,34718}, {57495,29984}, { 64208,33589}, { 64901,27111}, {63190,22235}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p4 path
		{{36840, 73303}, {36959,59399}, {43805,50188}, {48077,45844}, {53944,39076}, {57203,43226}, {  63376,40466}, {  65961,45654}, {61479,53476}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p1 path
		{{37136, 474}, {36657,13614}, {31412,20620}, {25531,27228}, {20466,34269}, {16602,30987}, { 9917,33411}, { 8419,26454}, {10128,20856}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p2 path
		{{36840, 73303}, {36959,59399}, {30101,50599}, {26239,46524}, {20024,39087}, {16451,43191}, {  9400,40426}, {  7432,45010}, {11425,53606}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p3 path
		{{37136, 474}, {36657,13614}, {42340,21139}, {48940,28314}, {53521,34718}, {57495,29984}, { 64208,33589}, { 64901,27111}, {63190,22235}, Current=1, Counter=30, CounterMax=100},
		
		-- attack p4 path
		{{36840, 73303}, {36959,59399}, {43805,50188}, {48077,45844}, {53944,39076}, {57203,43226}, {  63376,40466}, {  65961,45654}, {61479,53476}, Current=1, Counter=30, CounterMax=100},
	};
	
	-- attack p1
	AttackArmy1 = {}
	AttackArmy1.player = 8
	AttackArmy1.id = 2
	AttackArmy1.strength = 9
	AttackArmy1.position = {X=37136, Y=474}
	AttackArmy1.rodeLength = 2000
	SetupArmy(AttackArmy1)
	Advance(AttackArmy1)
	
	-- attack p2
	AttackArmy2 = {}
	AttackArmy2.player = 7
	AttackArmy2.id = 7
	AttackArmy2.strength = 9
	AttackArmy2.position = {X=36840, Y=73303}
	AttackArmy2.rodeLength = 2000
	SetupArmy(AttackArmy2)
	Advance(AttackArmy2)
	
	-- attack p3
	AttackArmy3 = {}
	AttackArmy3.player = 8
	AttackArmy3.id = 3
	AttackArmy3.strength = 9
	AttackArmy3.position = {X=37136, Y=474}
	AttackArmy3.rodeLength = 2000
	SetupArmy(AttackArmy3)
	Advance(AttackArmy3)
	
	-- attack p4
	AttackArmy4 = {}
	AttackArmy4.player = 7
	AttackArmy4.id = 8
	AttackArmy4.strength = 9
	AttackArmy4.position = {X=36840, Y=73303}
	AttackArmy4.rodeLength = 2000
	SetupArmy(AttackArmy4)
	Advance(AttackArmy4)
	
	-- attack p1
	AttackArmy5 = {}
	AttackArmy5.player = 8
	AttackArmy5.id = 4
	AttackArmy5.strength = 9
	AttackArmy5.position = {X=37136, Y=474}
	AttackArmy5.rodeLength = 2000
	SetupArmy(AttackArmy5)
	Advance(AttackArmy5)
	
	-- attack p2
	AttackArmy6 = {}
	AttackArmy6.player = 7
	AttackArmy6.id = 9
	AttackArmy6.strength = 9
	AttackArmy6.position = {X=36840, Y=73303}
	AttackArmy6.rodeLength = 2000
	SetupArmy(AttackArmy6)
	Advance(AttackArmy6)
	
	-- attack p3
	AttackArmy7 = {}
	AttackArmy7.player = 8
	AttackArmy7.id = 5
	AttackArmy7.strength = 9
	AttackArmy7.position = {X=37136, Y=474}
	AttackArmy7.rodeLength = 2000
	SetupArmy(AttackArmy7)
	Advance(AttackArmy7)
	
	-- attack p4
	AttackArmy8 = {}
	AttackArmy8.player = 8
	AttackArmy8.id = 7
	AttackArmy8.strength = 9
	AttackArmy8.position = {X=36840, Y=73303}
	AttackArmy8.rodeLength = 2000
	SetupArmy(AttackArmy8)
	Advance(AttackArmy8)
	
	AttackArmies.Troops =
	{
		{
			-- strength 1
			Entities.CU_BanditLeaderBow1,
			Entities.CU_BanditLeaderBow1,
			Entities.CU_BlackKnight_LeaderMace2,
			Entities.CU_BlackKnight_LeaderMace2,
			Entities.PV_Cannon1,
		},
		{
			-- strength 2
			Entities.CU_BlackKnight_LeaderMace2,
			Entities.CU_BlackKnight_LeaderMace2,
			Entities.CU_BlackKnight_LeaderMace2,
			Entities.PU_LeaderSword2,
			Entities.PU_LeaderBow2,
			Entities.PU_LeaderBow2,
			Entities.PV_Cannon2,
		},
		{
			-- strength 3
			Entities.PU_LeaderBow3,
			Entities.PU_LeaderSword3,
			Entities.PV_Cannon3,
		},
		{
			-- strength 4
			Entities.PU_LeaderBow4,
			Entities.PU_LeaderBow4,
			Entities.PU_LeaderSword4,
			Entities.PU_LeaderSword4,
			Entities.PU_LeaderHeavyCavalry1,
			Entities.PV_Cannon3,
			Entities.PV_Cannon4,
		},
		{
			-- strength 5
			Entities.PU_LeaderBow4,
			Entities.PU_LeaderBow4,
			Entities.PU_LeaderBow4,
			Entities.PU_LeaderSword4,
			Entities.PU_LeaderSword4,
			Entities.PU_LeaderSword4,
			Entities.PU_LeaderHeavyCavalry2,
			Entities.PU_LeaderHeavyCavalry2,
			Entities.PV_Cannon4,
			Entities.PV_Cannon4,
			Entities.CU_VeteranMajor
		},
	};
	AttackArmies.Leaders = {};
	AttackArmies.BattleTaskLists = {
		["TL_BATTLE"] = true,
		["TL_BATTLE_BOW"] = true,
		["TL_BATTLE_MACE"] = true,
		["TL_BATTLE_SPECIAL"] = true,
		["TL_BATTLE_VEHICLE"] = true,
		["TL_BATTLE_CROSSBOW"] = true,
		["TL_START_BATTLE"] = true,
	};
end

function ControlAttackingArmies()
	-- handle: respawn: random types, number and troop level depending on players strength
	-- make sure army only moves when not in fight
	local army;
	local current;
	local anchorIndex;
	local playerStr;
	local numOfTroops;
	for armyId = 1,8 do
	
		army = _G["AttackArmy"..armyId]
		anchorIndex = armyId;
		if anchorIndex > 4 then
			anchorIndex = anchorIndex - 4;
		end
		playerStr = GetStrength(anchorIndex); -- anchorIndex == playerId
		if playerStr >= 1 then
			if(not IsDead(army)) then
				-- don't move army during fight
				if not IsFighting(armyId) then
					AttackArmies.Anchors[armyId].Counter = AttackArmies.Anchors[armyId].Counter - 1;
					if AttackArmies.Anchors[armyId].Counter <= 0 then
						if AttackArmies.Anchors[armyId].Current < table.getn(AttackArmies.Anchors[armyId]) then
							-- next anchor
							AttackArmies.Anchors[armyId].Current = AttackArmies.Anchors[armyId].Current + 1;
							current = AttackArmies.Anchors[armyId].Current;
							-- move army to anchor
							Redeploy(army, {X=AttackArmies.Anchors[armyId][current][1],Y=AttackArmies.Anchors[armyId][current][2]});
							AttackArmies.Anchors[armyId].Counter = AttackArmies.Anchors[armyId].CounterMax;
						end
					end
				end
			else
				-- respawn counter
				AttackArmies[armyId] = AttackArmies[armyId] - 1;
				if AttackArmies[armyId] <= 0 then
					numOfTroops = playerStr + 2;
					if numOfTroops > 8 then
						numOfTroops = 8;
					end
					AttackArmies.Leaders[armyId] = {};
					for i = 1, numOfTroops do
						table.insert(AttackArmies.Leaders[armyId], EnlargeAttackArmy(army, playerStr));
					end
					-- reset base
					Redeploy(army, AttackArmies.Anchors[armyId][1]);
					AttackArmies[armyId] = (240/playerStr); -- respawn timer
					AttackArmies.Anchors[armyId].Current = 1;
					AttackArmies.Anchors[armyId].Counter = AttackArmies.WaitOnRespawn;
				end
			end
		end
	end
end

function IsFighting(_armyId)
	local leaders = AttackArmies.Leaders[_armyId];
	if not leaders then
		return false;
	end
	for i = 1, table.getn(leaders) do
		if AttackArmies.BattleTaskLists[Logic.GetCurrentTaskList(leaders[i])] then
			return true;
		end
	end
	return false;
end

--[[
	Strength
	as an overview whats strength does
	100 Soldiers = 3 Strength
	15k ress(gold,iron,sulfur) = 1 strength
	
	150 soldiers, 20k taler, 5k sulfur, 3k iron = 6,3 => 6 strength
	
	troops per army = strength + 2;
	1 strength = 3 troops
	6 Strength = 9 troops
	
	respawn timer 
	6 min = 240/ strength
	strength 1 = 6 min
	2 = 3 min
	3 = 2 min
	4 = 1.5 min
	5 = 1.2
	9 = 40s
	
	troop types:
	5 levels
	level = strength / 2;
	srength 1 =  level 1
	2 = 1
	3 = 2
	9 = 10
]]

function GetStrength(_playerId)
	local numOfSoldiers = Logic.GetNumberOfAttractedSoldiers(_playerId) * 3;
	local ressourceScale = 150;
	local gold = math.floor( GetGold(_playerId) / ressourceScale );
	local iron = math.floor( GetIron(_playerId) / ressourceScale );
	local sulfur = math.floor( GetSulfur(_playerId) / ressourceScale );
	local strength = numOfSoldiers + gold + iron + sulfur;
	strength = math.floor(strength/100 + 0.5) - (ConquerArea.Players[_playerId] == ConqueringTeam and 0 or 2);
	return strength;
end

function EnlargeAttackArmy(_army, _strength)
	local troopDescription = {
		maxNumberOfSoldiers = 8,
		minNumberOfSoldiers = 0,
		experiencePoints = VERYLOW_EXPERIENCE,
	};
	_strength = math.floor(_strength/2 + 0.5);
	if _strength < 1 then
		_strength = 1;
	elseif _strength > 5 then
		_strength = 5;
	end
	-- happy coding =)
	troopDescription.leaderType = AttackArmies.Troops[_strength][math.random(table.getn(AttackArmies.Troops[_strength]))];
	return EnlargeArmy(_army, troopDescription);
end






