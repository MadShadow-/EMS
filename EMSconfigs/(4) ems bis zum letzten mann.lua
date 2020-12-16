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
	Version = 1.3,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
	--ActivateDebug = 1,
	
	CustomDebugFunc1 = function(_fromPlayer, _target1, _target2, _x, _y)
		--Logic.CreateEntity(Entities.PU_Serf, _x, _y, 0, _fromPlayer);
		--MyUA = QuickLazyUnlimitedArmy:New({Player=5, Area=3000, TransitAttackMove=true}, 1, 5);
		--for i = 1,8 do
		--	MyUA:CreateLeaderForArmy(Entities.PU_LeaderBow4, 8, {X=_x,Y=_y}, 0);
		--end
	
		--MyUA:AddCommandMove({X=20200,Y=35000}, false);
		--[[
		todo:
		-- suddendeath
		kala größer start cooldown.. 20  minuten ruhe
		steinhaufen größer, seuche als krasser angriff für 10k
		cooldown 10 minuten bei seuche und diebe.
		suddean death fixe, dass man wirklich ress verliert.
		-- genaue infos an alle.
		
		3 minuten bei dem alchemie kram.
		-- diebe bisschen teuerer, sollten in gegner siedlung reinlaufen. 3,5
		diebe sollen weglaufen, bzw wissen ob man aus einem gebäude klauen kann
		- zerstörung auf einer seite
		
		- mitte in eine unlimited army packen
		- diebe sind op. kosten sollten mit zeit steigern
		
		-- done
		besseres feedback bei ws reduktion
		amree links oben spawnt obwohl brücke weg
		söldnerqurtiere, npc callback orig aufrufen
		performanz verbessern, bei der armee UND bei dem gift.
		]]
		WT.SpawnCity();
	end,
	
	CustomDebugFunc2 = function(_fromPlayer, _target1, _target2, _x, _y)
		--MyUA:AddCommandMove({X=_x,Y=_y}, false);
		--WT.Covid19(1,1,1);
		WT.SpawnThiefs(1,1,1)
	end,
	
	Callback_OnMapStart = function()
		TriggerFix_mode = "Xpcall" -- disable trigger warnings
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua");
		if not mcbPacker then
			Message("@color:255,0,0 mcbPacker is missing! maybe the community lib is not installed!");
			return;
		end
		mcbPacker.mainPath="maps\\user\\EMS\\tools\\";
		mcbPacker.require("s5CommunityLib/comfort/other/FrameworkWrapperLight");
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\lib\\UnlimitedArmySpawnGenerator.lua");
		
		WT.ExtendUnlimitedArmy();
		WT.ChangeUABehaviour();
		
		S5HookLoader.Init()
		EntityIdChangedHelper.Init()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		--Tools.ExploreArea(1,1,900)
		--MultiplayerTools.RemoveAllPlayerEntities(2)
		--MultiplayerTools.RemoveAllPlayerEntities(2)
		
		--createArmies();
		--Tools.ExploreArea(1,1,900)
		-- for eId in S5Hook.EntityIterator(Predicate.OfAnyPlayer(1,2,3,4)) do Message(eId) end
		-- check if player dead, sonst keine wellen mehr spawnen
		-- wenn beide dead, alle armeen drüben killen
		-- manche truppen bewegen sich nicht, eventuell wegen der ai
		
		WT.InitHQPositions();
		
		-- configuration
		-- time until sudden death 
		WT.SuddenDeathCounter = 60*60*1.5; -- 1.5h
		
		-- time a technologies are stopped upon attack
		WT.TechnologiesStopLimit = 60*1; -- 1min
		
		-- wave intervalls (better to be an exact multiple of 60);
		WT.MaxWaveCooldown = 60*5; -- default 5 min
		
		-- this map has a special peacetime, that can be reduced by ingame actions
		WT.InitialPeacetime = 60*40; -- default 40 minutes
		
		--
		WT.ActionCooldownLimitMax = 60*5; -- 5 min not used for all anymore
		--WT.ProtectionLimitMax = 60*5; -- 5 min
		
		MapTools.CreateWoodPiles(50000);
		
		WT.CreateAI();
		
		for pId = 1,4 do
			ResearchTechnology(Technologies.T_ThiefSabotage, pId);
			
			local mercTent = GetEntityId( "m"..pId.."2" );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_Scout, 2, ResourceType.Wood, 100 );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderBow3, 5, ResourceType.Wood, 600 );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderSword3, 5, ResourceType.Wood, 600 );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderSword2, 5, ResourceType.Wood, 300 );
			
			mercTent = GetEntityId( "m"..pId.."1" );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderHeavyCavalry2, 3, ResourceType.Gold, 1500, ResourceType.Wood, 1000 );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderSword3, 3, ResourceType.Wood, 900 );
			Logic.AddMercenaryOffer( mercTent, Entities.PU_LeaderSword2, 5, ResourceType.Wood, 300 );
			
		end
		
		-- quick and dirty copy paste for researching all smith techs
		local armor = 3;
		local damage = 3;
		for _ai = 5,8 do
			Logic.SetTechnologyState(_ai, Technologies.T_ChainMailArmor, armor);
			Logic.SetTechnologyState(_ai, Technologies.T_PlateMailArmor, armor);
			Logic.SetTechnologyState(_ai, Technologies.T_PaddedArcherArmor, armor);
			Logic.SetTechnologyState(_ai, Technologies.T_LeatherArcherArmor, armor);
			
			-- change unit damage
			Logic.SetTechnologyState(_ai, Technologies.T_IronCasting, damage);
			Logic.SetTechnologyState(_ai, Technologies.T_BodkinArrow, damage);
			Logic.SetTechnologyState(_ai, Technologies.T_Turnery, damage);
			Logic.SetTechnologyState(_ai, Technologies.T_BlisteringCannonballs, damage);
			
			-- unit movementspeed
			Logic.SetTechnologyState(_ai, T_BetterTrainingBarracks, movementspeed);
			Logic.SetTechnologyState(_ai, T_BetterTrainingArchery, movementspeed);
			Logic.SetTechnologyState(_ai, T_Shoeing, movementspeed);
			Logic.SetTechnologyState(_ai, T_BetterChassis, movementspeed);
		end
		
		WT.InitText();
		
		WT.CreateChests();
		
		WT.CreateVisionAreas();
		
		WT.InitGUI();
		
		WT.InitStopTechnologies();
		
		WT.InitTaxes();
		
		WT.InitCovid19();
		
		WT.CurrentTargetPlayer = 0;
		if GUI.GetPlayerID() == 1 then
			WT.CurrentTargetPlayer = 4;
		elseif GUI.GetPlayerID() == 2 then
			WT.CurrentTargetPlayer = 3;
		elseif GUI.GetPlayerID() == 3 then
			WT.CurrentTargetPlayer = 2;
		elseif GUI.GetPlayerID() == 4 then
			WT.CurrentTargetPlayer = 1;
		end

		--XGUIEng.ShowWidget("EMSMAWT20", 1); -- TODO: remove

		XGUIEng.SetText("EMSMAWToPlayer", "@center " .. UserTool_GetPlayerName(WT.CurrentTargetPlayer));
		
		WT.DelayedSpawnsInit();

		WT.InitKala();
		
		WT.InitThiefs();
		
		WT.InitWaves();
		
		WT.CampsDeadInit();
		
		WT.PlayerColorMapping();
		local resourceTable = {
			{Entities.XD_Stone1, 5000},
			{Entities.XD_Iron1, 1500},
			{Entities.XD_Clay1, 3000},
			{Entities.XD_Sulfur1, 1500}
		}
		MapTools.SetMapResource(resourceTable);
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		WT.WavePeacetimeInit();
		WT.InitWinCondition();
		WT.SuddenDeathInit();
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 0,
 
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
				0,
				2200,
				2200,
				1200,
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
	
	DontRemoveScriptEntities = true,
	AIPlayers = {5,6,7,8},
	
	NumberOfHeroesForAll = 2,

	
	HeavyCavalry = 2,
	LightCavalry = 2,
	Cannon4 = 1,
	Cannon3 = 1,
	Cannon2 = 1,
	Cannon1 = 1,
	Markets = -1,
	TowerLevel = 3,
	TowerLimit = 10,
	WeatherChangeLockTimer = 1,
	Thief = 0,
	AntiHQRush = 0,
	
	InvulnerableHQs = false,
};

WT = {};
WT20 = {};

WT.Bridge1 = 65568;
WT.Bridge2 = 78666;
WT.Bridge3 = 81780;
WT.Bridge4 = 72123;

function WT.InitHQPositions()
	WT.HQPositions = {
		{X=20200,Y=35000},
		{X=20200,Y=41900},
		{X=56700,Y=41900},
		{X=56700,Y=35000},
	};
end

function WT.InitWinCondition()
	local team1Dead = IsDead("hq1") and IsDead("hq2");
	local team2Dead = IsDead("hq3") and IsDead("hq4");
	if team1Dead or team2Dead then
		-- one team dead at start? skip win condition;
		return;
	end
	WT.WinConditionJob = StartSimpleJob("WT_WinController");
end

function WT_WinController()
	local team1Dead = IsDead("hq1") and IsDead("hq2");
	local team2Dead = IsDead("hq3") and IsDead("hq4");
	
	if team1Dead and team2Dead then
		Message("@color:0,255,0 Das Spiel ist zu Ende! Es gibt ein Unentschieden?");
	elseif team1Dead then
		Message("@color:0,255,0 Das Spiel ist zu Ende! Team 2 hat gewonnen!");
	elseif team2Dead then
		Message("@color:0,255,0 Das Spiel ist zu Ende! Team 1 hat gewonnen!");
	end

	if team1Dead or team2Dead then
		-- end game mechanics
		WT.WavesActivated[1] = false;
		WT.WavesActivated[2] = false;
		for i = 1, 4 do
			for j = 5,8 do
				SetNeutral(i,j);
			end
		end
		return true;
	end
		
end

function WT.ClearGarbage()
	local tt = 0;
	for eId in S5Hook.EntityIterator(
		Predicate.OfAnyType(
			Entities.XD_RockKhakiBright1, Entities.XD_RockKhakiMedium1, 
			Entities.XD_RockKhakiMedium2, Entities.XD_PlantDecalLarge1,
			Entities.XD_PlantDecal1, Entities.XD_PlantDecalLarge5,
			Entities.XD_GreeneryVertical2, Entities.XD_PlantDecal4,
			Entities.XD_Plant3, Entities.XD_Plant4,
			Entities.XD_RockMedium1, Entities.XD_PlantDecal2,
			Entities.XD_PlantDecal3, Entities.XD_PlantDecalLarge2,
			Entities.XD_WaterPlant2, Entities.XD_WaterLily2,
			Entities.XD_WaterLily1, Entities.XD_RockKhakiBright2,
			Entities.XD_GreeneryVertical1
		)) do
		tt = tt + 1;
		DestroyEntity(eId);
	end
	LuaDebugger.Log("cleared " ..tt.." garbage entities");
end

function WT.PlayerColorMapping()
	for playerId = 5, 16  do
		Display.SetPlayerColorMapping(playerId, 12);
	end
	
	-- set friendly ai -- color;
	if WT.IsLocalPlayerInTeam(1) then
		Display.SetPlayerColorMapping(8, 8);
	elseif WT.IsLocalPlayerInTeam(2) then
		Display.SetPlayerColorMapping(6, 8);
	end
end

function WT.InitThiefs()
	WT.FreeThiefs = {};
	WT.FreeThiefs.Thiefs = {};
	for i = 1,4 do
		WT.FreeThiefs.Thiefs[i] = {Building="b"..i.."61", Thief="th"..i, PlayerId = i};
	end
	StartSimpleJob("WT_ControlFreeThiefs");
end

function WT_ControlFreeThiefs()
	local data, pos;
	for i = table.getn(WT.FreeThiefs.Thiefs), 1, -1 do
		data = WT.FreeThiefs.Thiefs[i];
		if IsDead(data.Building) then
			pos = GetPosition(data.Thief);
			entities = {Logic.GetEntitiesInArea(Entities.XD_IronGrid1, pos.X, pos.Y, 2000, 16)};
			for j = 2, entities[1]+1 do
				DestroyEntity(entities[j]);
			end
			ChangePlayer(data.Thief, data.PlayerId);
			table.remove(WT.FreeThiefs.Thiefs, i);
			if table.getn(WT.FreeThiefs.Thiefs) == 0 then
				return true;
			end
		end
	end
end

function WT.InitWaves()
	WT.SpawnArmies = {};
	WT.SpawnedArmies ={{},{}}
	-- set actual wave count based on how much time has passed when ws is over.
	-- assuming wave 1 spawns at 20 minutes
	WT.WaveCount = {
		1,
		1
	};
	-- only for displaying wave count - actualy wave count may start with wave 4, for example, so wave count local always start at 1
	WT.WaveCountLocal = 1;
	-- contains the table of the waves
	WT.CreateSpawnTable();
end

function WT.SpawnWave(_teamId)
	
	local target1, _target2;
	local player1, player2;
	if _teamId == 1 then
		player1 = 1;
		player2 = 2;
	else
		player1 = 3;
		player2 = 4;
	end
	if IsDead("hq"..player1) and IsDead("hq"..player2) then
		WT.TeamDeadCallback(_teamId);
		return;
	end
	target1 = WT.HQPositions[player1];
	target2 = WT.HQPositions[player2];
	
	--local tickdelta = _teamId - 1; -- values between 0 and 1
	local maxdelta = 24;
	local addArmyToSpawn = function(_strength, _armyId, _playerId, _x, _y)
		local spawn = GetPosition("w".._playerId.._armyId);
		if spawn.X == 0 then
			Message("@color:255,0,0 addArmyToSpawn invalid positioN!");
			return;
		end
		WT.UniqueDeltaCounter = (WT.UniqueDeltaCounter or 0) + 1;
		local tickdelta = math.mod(WT.UniqueDeltaCounter, maxdelta);
		local armyData = 
		{
			Army=QuickLazyUnlimitedArmy:New({Player=5, Area=6000, TransitAttackMove=true, DoNotNormalizeSpeed=true, AutoDestroyIfEmpty=true}, tickdelta, maxdelta),
			WaveCount = _strength,
			ArmyTypeId    = _armyId,
			AttackPlayer  = _playerId,
			AttackX = _x,
			AttackY = _y,
			SpawnX = spawn.X,
			SpawnY = spawn.Y
		};
		table.insert(WT.SpawnArmies, armyData);
		table.insert(WT.SpawnedArmies[_teamId], armyData.Army);
	end
	
	local waveCount = WT.WaveCount[_teamId];
	local pos;
	for playerId = player1, player2 do
		pos = WT.HQPositions[playerId];
		if pos.X > 0 then
			for armyId = 2,6 do -- 2-6 is circle
				if armyId == 3 then
					if IsAlive(WT["Bridge"..playerId]) then
						-- only spawn army if bride alive
						addArmyToSpawn(waveCount, armyId, playerId, pos.X, pos.Y);
					end
				else
					addArmyToSpawn(waveCount, armyId, playerId, pos.X, pos.Y);
				end
			end
		end
	end
	
	-- 1, 7 are shared armies.
	pos = WT.HQPositions[player1];
	addArmyToSpawn(waveCount, 1, player1, pos.X, pos.Y);

	pos = WT.HQPositions[player2];
	addArmyToSpawn(waveCount, 7, player2, pos.X, pos.Y);

	-- create armies, but with 0.1 sec delay to prevent strong spawn lags.
	StartSimpleHiResJob("WT_SpawnArmies");
	
	if WT.IsLocalPlayerInTeam(_teamId) then
		Message("@color:255,80,80 Die "..WT.WaveCountLocal..". Welle ist erschienen!");
		WT.WaveCountLocal = WT.WaveCountLocal + 1;
	end
	
	WT.WaveCount[_teamId] = math.min(WT.WaveCount[_teamId] + 1, table.getn(WT.SpawnTable));
end

function WT.TeamDeadCallback(_teamId)
	WT.WavesActivated[_teamId] = false;
end

function WT.IsLocalPlayerInTeam(_teamId)
	if GUI.GetPlayerID() <= 2 then
		return _teamId == 1;
	elseif GUI.GetPlayerID() <= 4 then
		return _teamId == 2;
	end
	return false;
end

function WT_SpawnArmies()
	if table.getn(WT.SpawnArmies) == 0 then
		return true;
	end
	local armyData = WT.SpawnArmies[1];
	table.remove(WT.SpawnArmies, 1);
	
	local waveCount = armyData.WaveCount;
	local armies = WT.SpawnTable[waveCount];
	local troops = armies[armyData.ArmyTypeId];
	
	for i = 1, table.getn(troops) do
		armyData.Army:CreateLeaderForArmy(Entities[troops[i]], 16, {X=armyData.SpawnX, Y=armyData.SpawnY}, 5);
	end
	-- todo: if armyId == 5 or 2, check island.
	-- if is winter
	if Logic.GetWeatherState() == 3 then
		if armyData.ArmyTypeId == 2 then
			local stop = GetPosition("i"..armyData.AttackPlayer..armyData.AttackPlayer);
			armyData.Army:AddCommandMove({X=stop.X,Y=stop.Y}, false);
			armyData.Army:AddCommandWaitForIdle();
		elseif armyData.ArmyTypeId == 5 then
			local stop = GetPosition("i"..armyData.AttackPlayer);
			armyData.Army:AddCommandMove({X=stop.X,Y=stop.Y}, false);
			armyData.Army:AddCommandWaitForIdle();
		end
	end
	
	--[[if armyData.ArmyTypeId == 2 then
		local stop = GetPosition("a"..armyData.AttackPlayer.."1");
		armyData.Army:AddCommandMove({X=stop.X,Y=stop.Y}, false);
		armyData.Army:AddCommandWaitForIdle();
	end]]
	armyData.Army:AddCommandMove({X=armyData.AttackX,Y=armyData.AttackY}, false);
	armyData.Army:AddCommandDefend({X=armyData.AttackX,Y=armyData.AttackY}, 20000);
	return;
end

WT.TroopTypes =
{
	"PU_LeaderSword",
	"PU_LeaderBow",
	"PU_LeaderPoleArm",
	"PV_Cannon",
	"PU_LeaderCavalry",
	"PU_LeaderHeavyCavalry",
	"PU_LeaderRifle",
	"CU_Evil_LeaderBearman",
	"CU_Evil_LeaderSkirmisher"
};
--[[
	1/2 = 0.5+0.05 = 1;
	2/2 = 1+0.5 = 1
	3/2 = 1.5+0.5 = 2;
	4/2 = 2+0.5 = 2;
]]
function WT.GetTroopType(_troopType, _lvl)
	if _troopType > 7 then
		_lvl = 1;
	elseif _troopType > 4 then
		_lvl = math.floor(_lvl/2 + 0.5);
	end
	return WT.TroopTypes[_troopType] .. _lvl;
end

function WT.CreateSpawnTable()
	WT.SpawnTable = {};
	
	-- make waves kinda random but in borders
	local minTroops = 1; -- minmum troops
	local maxTroops = 2; -- maximum troops -- max 8. or smth
	local minTroopLevel = 1; -- increase slowly -- every 3 -- max 4
	local maxTroopLevel = 1; -- increase slowly -- every 2 -- max4
	local availableTroopTypes = 4; -- until 9, increase by one every x rounds until 9

	-- always increase with math.min(newvalue, maximumvalue); to stay on max
	local getRandomTroop = function()
		local rndType = math.random(1, availableTroopTypes);
		local rndLevel = math.random(minTroopLevel, maxTroopLevel);
		return WT.GetTroopType(rndType, rndLevel);
	end
	
	local intervall = math.floor(WT.MaxWaveCooldown/60);
	-- assuming 120 minutes max duration, and 60 minutes after suddendeath
	local maxWaves = 180 / intervall; -- minutes / minutes per wave
	local army;
	for i = 1, maxWaves do
		-- adjust parameters per each wave
		
		-- maxtroop level +1 every 2nd wave
		-- min troop count every 2
		if math.mod(i, 2) == 0 then
			maxTroopLevel = math.min(maxTroopLevel+1, 4);
			minTroops = math.min(minTroops+1, 6);
		end
		
		-- mintroopLevel
		if math.mod(i, 3) == 0 then
			minTroopLevel = math.min(minTroopLevel+1, 4);
			
			-- reduce by one every 3rd
			minTroops = math.min(minTroops-1, 6);
			maxTroops = math.min(maxTroops-1, 8);
			
			availableTroopTypes = math.min(availableTroopTypes+1, 9);
		end
		
		-- increase max troops every round by 1
		maxTroops = math.min(maxTroops + 1, 8);
		
		local armies = {};
		for armyId = 1,7 do
			army = {};
			for troop = 1, math.random(minTroops,maxTroops) do
				army[troop] = getRandomTroop(); -- Entities[getRandomTroop()]; -- use getRandomTroop(); only to see spawn types.
			end
			armies[armyId] = army;
		end
		WT.SpawnTable[i] = armies;
	end
end

function WT.TogglePlayerId(_x) -- by Kimichura himsulf.
	return _x + (math.mod(_x, 2) * 2 - 1)
end

function WT20.GUIAction_ToggleTarget()
	WT.CurrentTargetPlayer = WT.TogglePlayerId(WT.CurrentTargetPlayer);
	XGUIEng.SetText("EMSMAWToPlayer", "@center " .. UserTool_GetPlayerName(WT.CurrentTargetPlayer));
end

function WT.CreateAI()
	for i = 1,2 do
		SetHostile(i, 5);
		SetHostile(i, 6);
	end
	for i = 3,4 do
		SetHostile(i, 5);
		SetHostile(i, 7);
		SetHostile(i, 8);
	end
	if CNetwork then
		for playerId = 1,4 do
			SetHostile(playerId, 9);
		end
	end
	for j = 5,8 do
		local desc = {serfLimit = 4}
		SetupPlayerAi(j, desc); -- TODO: activate
	end
	
	WT.CreateBaseCamps();
end

function WT.CreateBaseCamps()
	
	WT.ArmyDesc =
	{
		{ -- s11
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.CU_BanditLeaderSword1,
					number = 5,
				}
			},
			RodeLength = 1500,
		},
		
		{ -- s12
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderBow3,
					number = 2,
				},
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderSword1,
					number = 6,
				}
			},
			RodeLength = 2000,
		},
		
		{ -- s13
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.CU_BlackKnight_LeaderMace2,
					number = 4,
				},
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderBow3,
					number = 4,
				}
			},
			RodeLength = 2000,
		},
		
		{ -- s14
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.CU_BlackKnight_LeaderMace2,
					number = 8,
				}
			},
			RodeLength = 2000,
		},
		
		{ -- s15
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.CU_BlackKnight_LeaderMace2,
					number = 4,
				},
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderBow4,
					number = 4,
				}
			},
			RodeLength = 2000,
		},
		
		{ -- s16
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderBow4,
					number = 4,
				},
				{
					maxNumberOfSoldiers = 3,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderHeavyCavalry2,
					number = 4,
				}
			},
			RodeLength = 2000,
		},
		{ -- s17
			Troops =
			{
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.CU_BlackKnight_LeaderMace2,
					number = 4,
				},
				{
					maxNumberOfSoldiers = 8,
					minNumberOfSoldiers = 0,
					experiencePoints = VERYLOW_EXPERIENCE,
					leaderType = Entities.PU_LeaderBow4,
					number = 4,
				}
			},
			RodeLength = 2000, 
		},
	}

	WT.Armies = {};
	--[[
	local counter = 0;
	for spawnArea = 5,8 do
		for armyId = 1, table.getn(WT.ArmyDesc) do
			local army = {}
			army.player = spawnArea;
			army.id = armyId
			army.strength = 9
			local pos = GetPosition("s"..(spawnArea-4)..armyId);
			army.position = {X = pos.X, Y=pos.Y};
			army.rodeLength = WT.ArmyDesc[armyId].RodeLength;
			SetupArmy(army)

			for troopDescrId = 1, table.getn(WT.ArmyDesc[armyId].Troops) do
				for troopIndex = 1, WT.ArmyDesc[armyId].Troops[troopDescrId].number do
					EnlargeArmy(army, WT.ArmyDesc[armyId].Troops[troopDescrId]);
				end
			end
			if spawnArea == 5 and armyId == 6 then
				--LuaDebugger.Break();
			end
			counter = counter + 1;
			WT.Armies[counter] = army;
			
			--army = UnlimitedArmy:New({Player=5, Area=WT.ArmyDesc[armyId].RodeLength});
			--[[local spawn = GetPosition("s"..(spawnArea-4)..armyId);
			LuaDebugger.Log(spawn);
			if(spawn.X <= 0) or spawn.Y <= 0 then
				LuaDebugger.Log("invalid spawn ".."s"..(spawnArea-4)..armyId);
				return;
			end
			
			army = UnlimitedArmy:New({Player=5, Area=WT.ArmyDesc[armyId].RodeLength});
			Armies[spawnArea][armyId] = army;
			for troopDescrId = 1, table.getn(WT.ArmyDesc[armyId].Troops) do
				local armyDesc = WT.ArmyDesc[armyId].Troops[troopDescrId];
				for troopIndex = 1, armyDesc.number do
					army:CreateLeaderForArmy(armyDesc.leaderType, armyDesc.maxNumberOfSoldiers, spawn, armyDesc.experiencePoints);
				end
			end
			army:AddCommandDefend(spawn, WT.ArmyDesc[armyId].RodeLength, false)]]
		end
	end]]

end

function WT.DelayedSpawnsInit()
	WT.DelayedSpawnPositions =
	{
		{},{}
	};
	local data;
	local f = function(_playerId, _teamId)
		for armyId = 1,7 do
			data = GetPosition("s".._playerId..armyId);
			data.PlayerId = _playerId + 4;
			data.ArmyId = armyId;
			table.insert(WT.DelayedSpawnPositions[_teamId], data);
		end
	end
	for playerId = 1,2 do
		f(playerId, 1);
	end
	for playerId = 3,4 do
		f(playerId, 2);
	end
	StartSimpleJob("WT_DelayedSpawnsController");
end

function WT_DelayedSpawnsController()
	local f = function(_playerId, _teamId)
		local entities;
		local data;
		for i = table.getn(WT.DelayedSpawnPositions[_teamId]), 1, -1 do
			data = WT.DelayedSpawnPositions[_teamId][i];
			entities = {Logic.GetPlayerEntitiesInArea(_playerId, 0, data.X, data.Y, 4000, 1)};
			if entities[1] > 0 then
				WT.CreateArmyDelayed(data.PlayerId, data.ArmyId, data.X, data.Y);
				table.remove(WT.DelayedSpawnPositions[_teamId], i);
			end
		end
	end
	for playerId = 1,2 do
		f(playerId, 1);
	end
	for playerId = 3,4 do
		f(playerId, 2);
	end
end

function WT.CreateArmyDelayed(_playerId, _armyId, _x, _y)
	WT.ArmyCounter = WT.ArmyCounter or 0;
	WT.ArmyCounter = WT.ArmyCounter + 1;
	
	local army = {}
	army.player = _playerId;
	army.id = _armyId
	army.strength = 9
	army.position = {X = _x, Y=_y};
	army.rodeLength = WT.ArmyDesc[_armyId].RodeLength;
	SetupArmy(army)

	for troopDescrId = 1, table.getn(WT.ArmyDesc[_armyId].Troops) do
		for troopIndex = 1, WT.ArmyDesc[_armyId].Troops[troopDescrId].number do
			EnlargeArmy(army, WT.ArmyDesc[_armyId].Troops[troopDescrId]);
		end
	end
	WT.Armies[WT.ArmyCounter] = army;
end

function WT.CreateChests()
	WT.Chests =  {};
	local chestName;
	for playerId = 1,4 do
		for chestType = 1,4 do
			chestName = "c"..playerId..chestType;
			table.insert(WT.Chests, {ChestType=chestType, Position=GetPosition(chestName), Entity=GetEntityId(chestName)});
		end
	end
	WT.ChestContent =
	{
		{500,0,900,0,0,0, "Taler und Holz"},
		{500,0,500,500,0,0, "Taler, Holz und Stein"},
		{500,0,1000,0,0,0, "Taler und Holz"},
		{1500,0,1000,1000,0,0, "Taler, Holz und Stein"},
	};
	WT.ChestRange=400;
	StartSimpleJob("WT_ChestControl");
end

function WT_ChestControl()
	local entities;
	for i = table.getn(WT.Chests), 1, -1 do
		for playerId = 1,4 do
			entities = {Logic.GetPlayerEntitiesInArea(playerId, 0, WT.Chests[i].Position.X, WT.Chests[i].Position.Y, WT.ChestRange, 3)};
			if entities[1] > 0 then
				ReplaceEntity(WT.Chests[i].Entity, Entities.XD_ChestOpen);
				WT.GiveChestContent(playerId,WT.Chests[i].ChestType);
				table.remove(WT.Chests, i);
				break;
			end
		end
	end
end

function WT.GiveChestContent(_playerId, _chestType)
	local r = WT.ChestContent[_chestType];
	Tools.GiveResouces(_playerId, unpack(r));
	if GUI.GetPlayerID() == _playerId then
		Message("@color:255,255,0 Du hast eine Kiste gefunden! Darin waren " .. r[7] .. "!");
	end
end

function WT.CreateVisionAreas()
	WT.VisionAreaPositions = {};
	for i = 1,9 do
		WT.VisionAreaPositions[i] = GetPosition("v1"..i);
	end
	-- create mirrored x
	for i = 1,9 do
		SetEntityName( Logic.CreateEntity(Entities.XD_ScriptEntity, Logic.WorldGetSize() - WT.VisionAreaPositions[i].X, WT.VisionAreaPositions[i].Y, 0, 1), "v4"..i);
	end
	-- create mirrored y
	for i = 1,9 do
		SetEntityName( Logic.CreateEntity(Entities.XD_ScriptEntity,WT.VisionAreaPositions[i].X, Logic.WorldGetSize() - WT.VisionAreaPositions[i].Y, 0, 3), "v2"..i);
	end
	
	-- create mirrored x&y
	for i = 1,9 do
		SetEntityName( Logic.CreateEntity(Entities.XD_ScriptEntity, Logic.WorldGetSize() - WT.VisionAreaPositions[i].X, Logic.WorldGetSize() - WT.VisionAreaPositions[i].Y, 0, 1), "v3"..i);
	end
	StartSimpleJob("WT_SetupVisionDelayed");
end

function WT_SetupVisionDelayed()
	local visions = 
	{
		25,
		15,
		15,
		
		10,
		15,
		15,
		
		15,
		15,
		10

	};
	for pId = 1,4 do
		for vId = 1,9 do
			Logic.SetEntityExplorationRange(GetEntityId("v"..pId..vId), visions[vId]);
		end
	end
end

function WT.InitGUI()
	
	WT.Actions =
	{
		WT.Covid19,
		WT.SpawnThiefs,
		WT.ReduceMotivation,
		WT.TaxMalus,
		WT.StopTechnologies,
		
		WT.Protect,
		WT.Protect,
		WT.Protect,
		WT.Protect,
		WT.Protect,
	};
	
	WT.ActionCooldowns = {};
	local cd = WT.ActionCooldownLimitMax;
	WT.ActionCooldownLimits =
	{

		60*10,
		60*10,
		cd,
		cd,
		cd,
		
		-- protections
		60*5,
		60*5,
		60*5,
		60*5,
		60*5,
	};
	
	WT.ActionInitialCooldowns = 
	{
		60*30,
		60*30,
		60*15,
		60*15,
		60*15,
		
		-- protections
		60*29,
		60*29,
		60*5,
		60*5,
		60*5,
	}
	
	-- if a protection for a player is > 0 then he is protected
	WT.Protections = {};
	WT.ProtectionLimits = {
		30,--60*29,
		30,--60*29,
		30,--60*5,
		30,--60*5,
		30,--60*5,
	};
	
	for playerId = 1,4 do
		WT.Protections[playerId] = {};
		WT.ActionCooldowns[playerId] = {}
		for i = 1,table.getn(WT.ActionCooldownLimits) do
			WT.ActionCooldowns[playerId][i] = WT.ActionInitialCooldowns[i];
		end
		for attackType = 1,5 do
			WT.Protections[playerId][attackType] = 0;
		end
	end
	
	WT.Buttons = {};
	for i = 1, 10 do
		WT.Buttons[i] = "EMSMAWTAction"..i;
		XGUIEng.DisableButton(WT.Buttons[i], 1);
	end
		
	
	WT.ActionCosts = 
	{
		{
			{ResourceType.Gold, 10000}
		},
		{
			{ResourceType.Gold, 4000}
		},
		{
			{ResourceType.Gold, 2000}
		},
		{
			{ResourceType.Gold, 2000}
		},
		{
			{ResourceType.Gold, 2000}
		},
			-- protect
		{
			{ResourceType.Gold, 4000}
		},
		{
			{ResourceType.Gold, 1000}
		},
		{
			{ResourceType.Gold, 1000}
		},
		{
			{ResourceType.Gold, 1000}
		},
		{
			{ResourceType.Gold, 1000}
		},
	};
	
	if CNetwork then
		CNetwork.SetNetworkHandler("WT.LogicAction",
		function (_name, _playerId, _buttonIndex, _target)
			if CNetwork.IsAllowedToManipulatePlayer(_name, _playerId) then
				WT.LogicAction(_playerId, _buttonIndex, _target);
			end
		end)
	end
	
	StartSimpleJob("WT_ReduceCooldowns");
end

function WT.InitKala()
	WT.GameCallback_NPCInteraction = GameCallback_NPCInteraction
	GameCallback_NPCInteraction = function(_heroId, _npcId)
		WT.GameCallback_NPCInteraction( _heroId, _npcId )
		if _npcId ~= GetEntityId("kala1") and _npcId ~= GetEntityId("kala2") then
			return;
		end
		if GUI.GetPlayerID() == GetPlayer(_heroId) then
			XGUIEng.ShowWidget("EMSMAWT20", 1);
		end
	end
	EnableNpcMarker(GetEntityId("kala1"));
	EnableNpcMarker(GetEntityId("kala2"));
end

function WT20.Close()
	XGUIEng.ShowWidget("EMSMAWT20", 0);
end

function WT20.GUIUpdate_Tooltip(_buttonIndex)
	XGUIEng.SetText("EMSMAWTHead", WT.TextTable.Tooltips[_buttonIndex].Titel);
	XGUIEng.SetText("EMSMAWTMaintext", WT.TextTable.Tooltips[_buttonIndex].Text);
	local costs = WT.ActionCosts[_buttonIndex];
	local costString = WT.GetCostString(costs, GUI.GetPlayerID());
	local cooldown = WT.ActionCooldowns[GUI.GetPlayerID()][_buttonIndex];
	if cooldown > 0 then
		local color = " @color:255,80,80 ";
		if _buttonIndex > 5 then
			color = " @color:80,255,80 ";
		end
		costString = costString .. " Cooldown: ".. color .. cooldown .. "s";
	end
	XGUIEng.SetText("EMSMAWTCosts", costString);
end

function WT_ReduceCooldowns()
	for playerId = 1,4 do
		for i = 1,5 do
			WT.Protections[playerId][i] = WT.Protections[playerId][i] - 1;
		end
		for i = 1, 10 do
			if WT.ActionCooldowns[playerId][i] > 1 then
				WT.ActionCooldowns[playerId][i] = WT.ActionCooldowns[playerId][i] - 1;
			elseif WT.ActionCooldowns[playerId][i] == 1 then
				WT.ActionCooldowns[playerId][i] = 0;
				if GUI.GetPlayerID() == playerId then
					XGUIEng.DisableButton(WT.Buttons[i], 0);
				end
			end
		end
	end
end


function WT.Protect(_playerId, _buttonIndex, _fromPlayerId)
	local player1 = 1;
	local player2 = 2;
	if _fromPlayerId > 2 then
		player1 = 3;
		player2 = 4;
	end
	WT.Protections[player1][_buttonIndex-5] = WT.ProtectionLimits[_buttonIndex-5];
	WT.Protections[player2][_buttonIndex-5] = WT.ProtectionLimits[_buttonIndex-5];
	
	if GUI.GetPlayerID() == player1 or GUI.GetPlayerID() == player2 then
		XGUIEng.DisableButton(WT.Buttons[_buttonIndex], 1);
		if GUI.GetPlayerID() == _fromPlayerId then
			Message("@color:80,255,0 " .. WT.TextTable.ProtectionActivated.Self[_buttonIndex-5]);
		else
			Message("@color:80,255,0 " .. WT.TextTable.ProtectionActivated.Teammate[_buttonIndex-5]);
		end
	end
end

function WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId)
	local success = true;
	if WT.Protections[_playerId][_buttonIndex] > 0 then
		success = false;
	end
	WT.AttackFeedback(_buttonIndex, _playerId, _fromPlayerId, success);
	return success;
end

function WT.AttackFeedback(_buttonIndex, _targetPlayerId, _fromPlayerId, success)
	local col1 = "@color:255,165,0 "; -- orange
	local col2 = "@color:80,255,80 "; -- green
	--LuaDebugger.Log(_targetPlayerId .. " " .. _fromPlayerId);
	if GUI.GetPlayerID() == _targetPlayerId then
		if success then
			Message(col1 .. WT.TextTable.Attacks[_buttonIndex].ReceivedAttackSuccess); -- ihr wurdet angegriffen
		else
			Message(col2 .. WT.TextTable.Attacks[_buttonIndex].ReceivedAttackFail); -- abgewehrt
		end
	elseif GUI.GetPlayerID() == _fromPlayerId then
		if success then
			Message(col2 .. WT.TextTable.Attacks[_buttonIndex].SentAttackSuccess); -- angriff erfolgreich
		else
			Message(col1 .. WT.TextTable.Attacks[_buttonIndex].SentAttackFail); -- angriff fehlgeschlagen
		end
	elseif GUI.GetPlayerID() > 4 then
		if success then
			Message(
				col1 .. WT.GetUserName(_fromPlayerId) .. WT.TextTable.Attacks.Attack ..
				WT.GetUserName(_targetPlayerId) .. WT.TextTable.Attacks[_buttonIndex].WitnessAttackSuccess
			); -- angriff erfolgreich
		else
			Message(
				col2 .. WT.GetUserName(_fromPlayerId) .. WT.TextTable.Attacks.Attack .. 
				WT.GetUserName(_targetPlayerId) .. WT.TextTable.Attacks[_buttonIndex].WitnessAttackFail
			); -- angriff
		end
	end
end

function WT.GetUserName(_playerId)
	local r,g,b = GUI.GetPlayerColor(_playerId);
	return " @color:"..r..","..g..","..b.." " .. UserTool_GetPlayerName(_playerId) .. " @color:255,255,255 ";
end

function WT20.GUIAction_Button(_buttonIndex)
	local costs = WT.ActionCosts[_buttonIndex];
	if not WT.HasEnoughResources(GUI.GetPlayerID(), costs) then
		return;
	end
	if WT.ActionCooldowns[GUI.GetPlayerID()][_buttonIndex] > 0 then
		Message("@color:255,80,80 Diese Aktion hat noch " .. WT.ActionCooldowns[GUI.GetPlayerID()][_buttonIndex] .. " Sekunden cooldown!");
	end

	Sync.Call("WT.LogicAction", GUI.GetPlayerID(), _buttonIndex, WT.CurrentTargetPlayer);
end

function WT.LogicAction(_playerId, _buttonIndex, _target)
	local costs = WT.ActionCosts[_buttonIndex];
	if not WT.HasEnoughResources(_playerId, costs) then
		return;
	end
	if WT.ActionCooldowns[_playerId][_buttonIndex] > 0 then
		Message(WT.GetUserName(_playerId).." Action still has cooldown");
		return;
	end

	if _buttonIndex <= 5 then
		-- set cooldowns is for attack actions only
		-- protect action set their cooldowns on their own
		WT.SetCooldowns(_playerId, _buttonIndex);
	end
	WT.ActionCooldowns[_playerId][_buttonIndex] = WT.ActionCooldownLimits[_buttonIndex];
	WT.Pay(_playerId, WT.ActionCosts[_buttonIndex]);
	WT.Actions[_buttonIndex](_target, _buttonIndex, _playerId);
end

function WT.SetCooldowns(_playerId, _buttonIndex)
	-- protects have their own cooldown function
	if _buttonIndex > 5 then
		return 
	end;
	-- set cooldowns for all attacks players of one team
	local secondPlayerInTeam = WT.TogglePlayerId(_playerId);
	local players = {_playerId, secondPlayerInTeam}
	local playerId;
	local cooldownForAll = 120;
	for pIndex = 1,2 do
		playerId = players[pIndex]
		for i = 1, 5 do
			if WT.ActionCooldowns[playerId][i] < cooldownForAll then
				WT.ActionCooldowns[playerId][i] = cooldownForAll;
			end
			if GUI.GetPlayerID() == playerId then
				XGUIEng.DisableButton(WT.Buttons[i], 1);
			end
		end
	end
	WT.ActionCooldowns[_playerId][_buttonIndex] = WT.ActionCooldownLimits[_buttonIndex];
end


-- WT.SpawnThiefs(1,1,1)
function WT.SpawnThiefs(_playerId, _buttonIndex, _fromPlayerId)
	local buttonIndex = 2;
	if not WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId) then
		return;
	end
	--local spawn = WT.HQPositions[_playerId];

	local sector = Logic.GetSector(GetEntityId("hq".._playerId));
	local numThiefs = 20;
	
	local thiefPlayerId;
	if CNetwork then
		thiefPlayerId = 9;
	else
		thiefPlayerId = 5;
	end
	local entity = Entities.PU_Thief;
	
	WT.SpawnThiefsData = WT.SpawnThiefsData or {};
	WT.SpawnThiefsData[_playerId] = {};
	
	local thiefSpawnAreas = 
	{
		GetPosition("w".._playerId.."5"),
		GetPosition("w".._playerId.."7"),
		GetPosition("w".._playerId.."1"),
	};
	
	local x,y;
	local range = 35; -- up to 3500 range, spawn only in 100er steps
	local spawnAreaId;
	for i = 1, numThiefs do
		spawnAreaId = math.random(1,3);
		x = thiefSpawnAreas[spawnAreaId].X + math.random(-300,300);
		y = thiefSpawnAreas[spawnAreaId].Y + math.random(-300, 300);
		WT.SpawnThiefsData[_playerId][i] = AI.Entity_CreateFormation(
			thiefPlayerId,
			entity,
			0,
			0,
			x,y,
			0,0,
			0,
			0
		);
	end
	
	local chance = 3; -- realchance = 1/chance
	local thiefId;
	local buildingId;
	WT.ThiefBuildings = WT.ThiefBuildings or {};
	WT.ThiefBuildings[_playerId] = {};
	
	--[[local getBuildingId = function(_thiefId, _reuseBuilding)
		local pos = GetPosition(_thiefId);
		local range = 6000;
		local buildings = {};
		for eId in S5Hook.EntityIterator(Predicate.IsBuilding(), Predicate.InRect(pos.X-range, pos.Y-range, pos.X+range, pos.Y+range), Predicate.OfPlayer(_playerId)) do
			--if WT.DoesBuildingHaveADoor(eId) then
				table.insert(buildings, eId);
			--end
		end
		local dbgStr = "numBuildings: "..table.getn(buildings);
		
		local buildingId = -1;
		local rnd;
		while(table.getn(buildings) > 0) do
			rnd = math.random(1, table.getn(buildings));
			buildingId = buildings[rnd];
			table.remove(buildings, rnd);
			if _reuseBuilding then
				return buildingId, dbgStr;
			else
				if WT.ThiefBuildings[_playerId][buildingId] == nil then
					WT.ThiefBuildings[_playerId][buildingId] = true;
					return buildingId, dbgStr;
				else
					buildingId = -1;
				end
			end
		end
		return buildingId, dbgStr;
	end]]
	--for eId in S5Hook.EntityIterator(Predicate.IsBuilding(), Predicate.InRect(pos.X-range, pos.Y-range, pos.X+range, pos.Y+range), Predicate.OfPlayer(_playerId)) do
	local buildings = {};
	local poolId = WT.GetUnitPoolByPlayerId(_playerId);
	for eId, v in pairs(WT.UnitPool[poolId].Buildings) do
		if Logic.EntityGetPlayer(eId) == _playerId then
			table.insert(buildings, eId);
		end
	end
	--end

	local getBuildingId = function(thiefId)
		if table.getn(buildings) == 0 then
			return -1;
		end
		local bIndex = math.random(1,table.getn(buildings));
		local bId = buildings[bIndex];
		WT.ThiefBuildings[_playerId][bId] = WT.ThiefBuildings[_playerId][bId] or 0;
		WT.ThiefBuildings[_playerId][bId] = WT.ThiefBuildings[_playerId][bId] + 1;
		if WT.ThiefBuildings[_playerId][bId] >= 3 then
			-- not more then 3 thiefs on one building
			table.remove(buildings, bIndex);
		end
		return bId;
	end
	
	WT.SpawnThiefActionList = WT.SpawnThiefActionList or {};
	local str;
	local thiefData;
	for i = 1, table.getn(WT.SpawnThiefsData[_playerId]) do
		thiefId = WT.SpawnThiefsData[_playerId][i];
		thiefData = {};
		if IsAlive(thiefId) then
			thiefData.Thief = thiefId;
			if true then -- if math.mod(math.random(1,chance),chance) == 0 then
				buildingId = getBuildingId(thiefId, true);
				--LuaDebugger.Log("Sabotage: "..thiefId.." "..buildingId);
				if buildingId > 0 then
					--WT.ThiefSabotage(thiefId, buildingId);
				end
				thiefData.Building = buildingId;
				thiefData.Method = 1;
			else
				buildingId, str = getBuildingId(thiefId, false);
				if buildingId > 0 then
					--WT.ThiefStealGoods(thiefId, buildingId);
					str = str .. " do actual steal";
					thiefData.Method = 1;
				else
					str = str .. " attempt destroy";
					buildingId = getBuildingId(thiefId, true);
					if buildingId > 0 then
						--WT.ThiefSabotage(thiefId, buildingId);
						thiefData.Method = 2;
					end
				end
				thiefData.Building = buildingId;
				--LuaDebugger.Log("StealGoods: "..thiefId.." "..buildingId .. " " .. str);
			end
			table.insert(WT.SpawnThiefActionList, thiefData);
		end
	end

	StartSimpleHiResJob("WT_ThiefAction");
end

function WT.DoesBuildingHaveADoor(_buildingId)
	local eTypeName = Logic.GetEntityTypeName(Logic.GetEntityType(_buildingId));
	if string.find(eTypeName, "Tower", 1, true)
	or string.find(eTypeName, "Beautification", 1, true) then
		return false;
	end
	return true;
end

function WT_ThiefAction()
	for i = table.getn(WT.SpawnThiefActionList), 1, -1 do
		local thiefData = WT.SpawnThiefActionList[i];
		if thiefData.Building ~= -1 then
			if thiefData.Method == 1 then
				WT.ThiefSabotage(thiefData.Thief, thiefData.Building);
			else
				WT.ThiefStealGoods(thiefData.Thief, thiefData.Building);
			end
		end
		table.remove(WT.SpawnThiefActionList, i);
	end
	StartSimpleJob("WT_ThiefsWaitIdle");
	return true;
end

function WT_ThiefsWaitIdle()
	local thiefId;
	for playerId = 1,4 do
		if WT.SpawnThiefsData[playerId] then
			for j = 1, table.getn(WT.SpawnThiefsData[playerId]) do
				thiefId = WT.SpawnThiefsData[playerId][j];
				if IsAlive(thiefId) then
					if Logic.GetCurrentTaskList(thiefId) == "TL_THIEF_IDLE" then
						Logic.HurtEntity(thiefId, Logic.GetEntityHealth(thiefId));
						table.remove(WT.SpawnThiefsData[playerId], j);
						if table.getn(WT.SpawnThiefsData[playerId]) == 0 then
							return true;
						end
					end
				end
			end
		end
	end
end

function WT.ThiefSabotage(_thiefId, _buildingId)
	if CNetwork then
		SendEvent.ThiefSabotage(_thiefId, _buildingId);
	else
		PostEvent.ThiefSabotage(_thiefId, _buildingId);
	end
end

function WT.ThiefStealGoods(_thiefId, _buildingId)
	if CNetwork then
		SendEvent.ThiefStealGoods(_thiefId, _buildingId);
	else
		PostEvent.ThiefStealFrom(_thiefId, _buildingId);
	end
end

function WT.ReduceMotivation(_playerId, _buttonIndex, _fromPlayerId)
	local buttonIndex = 3;
	if not WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId) then
		return;
	end
	local motiChange = 0.2;
	for eId in S5Hook.EntityIterator(Predicate.OfCategory(EntityCategories.Worker), Predicate.OfPlayer(_playerId)) do
		local newMotivation = Logic.GetSettlersMotivation(eId) - motiChange;
		S5Hook.SetSettlerMotivation(eId, newMotivation);
	end
end

function WT.InitTaxes()
	if CNetwork then
		CNetwork.SetNetworkHandler("SetTaxes",
			function(name, _playerID, _level)
				if CNetwork.IsAllowedToManipulatePlayer(name, _playerID) and Logic.GetTechnologyState(_playerID, Technologies.GT_Literacy) == 4 then
					if WT.TaxLevelLockedSeconds[_playerID] < 0 then
						CLogger.Log("SetTaxes", _playerID, _level);
						SendEvent.SetTaxes(_playerID, _level);
					else
						if GUI.GetPlayerID() == _playerID then
							Message("Du kannst das jetzt nicht tun.");
						end
					end
				end;
			end
		);
		
	else
		Message("@color:255,0,0 Init Taxes only works with CNetwork Multiplayer");
	end
	
	WT.TaxLevelLockedSeconds = {};
	for playerId = 1, 4 do
		WT.TaxLevelLockedSeconds[playerId] = 0;
	end
	StartSimpleJob("WT_TaxLevelLockControl");
end

-- WT.TaxMalus(1,1,1);
function WT.TaxMalus(_playerId, _buttonIndex, _fromPlayerId)
	if not CNetwork then
		Message("@color:255,0,0 Init Taxes only works with CNetwork Multiplayer");
		return;
	end
	local buttonIndex = 4;
	if not WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId) then
		return;
	end

	SendEvent.SetTaxes(_playerId, 1);
	WT.TaxLevelLockedSeconds[_playerId] = 3*60; 
end

function WT_TaxLevelLockControl()
	for playerId = 1,4 do
		WT.TaxLevelLockedSeconds[playerId] = WT.TaxLevelLockedSeconds[playerId] - 1;
	end
end

function WT.InitStopTechnologies()
	WT.TechnologiesStopped = {};
	for playerId = 1,4 do
		WT.TechnologiesStopped[playerId] = 0;
	end
	if not CUtil then
		Message("@color:255,0,0 InitStopTechnologies() works only in SP Extended/ CNetwork Multiplayer");
	end
	GameCallback_ResearchProgress = function(player, research_building, technology, entity, research_amount, current_progress, max)
		if WT.TechnologiesStopped[player] > 0 then
			return (1/8)*research_amount;
		end
		return research_amount;
	end
	StartSimpleJob("WT_StopTechnologyController");
end

-- WT.StopTechnologies(1,1,1)
function WT.StopTechnologies(_playerId, _buttonIndex, _fromPlayerId)
	if not CUtil then
		Message("@color:255,0,0 InitStopTechnologies() works only in SP Extended/ CNetwork Multiplayer");
		return;
	end
	local buttonIndex = 5;
	if not WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId) then
		return;
	end
	WT.TechnologiesStopped[_playerId] = WT.TechnologiesStopLimit;
end

function WT_StopTechnologyController()
	for playerId = 1,4 do
		WT.TechnologiesStopped[playerId] = WT.TechnologiesStopped[playerId] - 1;
	end
end

-- todo: entity iterator nur einmal.
-- diebe und seuche in mehreren spawn areas?
function WT.InitCovid19()
	WT.ExpelSettler = function() end
	if CNetwork then
		WT.ExpelSettler = SendEvent.ExpelSettler;
	else
		WT.ExpelSettler = function(_eId, _pId)
			if GUI.GetPlayerID() == _pId then
				GUI.ExpelSettler(_eId);
			end
		end
	end
end

WT.CovidPositions = {};
WT.CovidCenterPositions = {};
WT.CovidActivePlayers = {};
WT.CovidRangePerSpot = 10;
WT.CovidDuration = 80;
--WT.CovidMinDamage = 3;
--WT.CovidMaxDamage = 3;
WT.CovidDamage = 2;
WT.MotiReduction = 0.02;
function WT.Covid19(_playerId, _buttonIndex, _fromPlayerId)
	local buttonIndex = 1;
	if not WT.IsAttackable(_playerId, _buttonIndex, _fromPlayerId) then
		return;
	end
	local spawns = {WT.HQPositions[_playerId], GetPosition("covid".._playerId.."1"), GetPosition("covid".._playerId.."2")};
	local spawn;
	local numSpawns = 12;
	local range = 35;--00;
	WT.CovidPositions[_playerId] = {};
	WT.CovidCenterPositions[_playerId] = {};
	local covidSpawn;
	for k = 1, numSpawns do
		spawn = spawns[math.random(1,3)];
		covidSpawn = {X = spawn.X + math.random(-range,range)*100, Y = spawn.Y + math.random(-range,range)*100};
		WT.CovidCenterPositions[_playerId][WT.GetPosStr(covidSpawn)] = covidSpawn;
		Logic.CreateEffect(GGL_Effects.FXKalaPoison, covidSpawn.X, covidSpawn.Y);
		
		for i = -WT.CovidRangePerSpot, WT.CovidRangePerSpot do
			for j = -WT.CovidRangePerSpot, WT.CovidRangePerSpot do
				WT.CovidPositions[_playerId][WT.GetPosStr(covidSpawn, i, j)] = true;
			end
		end
	end
	
	if WT.CovidJobId == nil then
		WT.CovidJobId = StartSimpleJob("WT_CovidJob");
	end
	WT.CovidActivePlayers[_playerId] = WT.CovidDuration;
end

function WT_CovidJob()
	for playerId = 1,4 do
		if WT.CovidActivePlayers[playerId] and WT.CovidActivePlayers[playerId] > 0 then
			WT.CovidTick(playerId);
		end
	end
end

function WT.CovidTick(_playerId)
	local pos;
	-- create effects
	if math.mod(WT.CovidActivePlayers[_playerId], 7) == 0 then
		for spawnStr, pos in pairs(WT.CovidCenterPositions[_playerId]) do
			Logic.CreateEffect(GGL_Effects.FXKalaPoison, pos.X, pos.Y);
		end
	end
	
	local poolId = WT.UnitPoolId1;
	if _playerId > 2 then
		poolId = WT.UnitPoolId2;
	end

	local ref = WT.CovidPositions[_playerId];
	local damage, newHealth;
	for eId, v in pairs(WT.UnitPool[poolId].Covid) do
		pos = GetPosition(eId);
		posstr = WT.GetPosStr(pos);
		--LuaDebugger.Log(posstr);
		if ref[posstr] then
			damage = WT.CovidDamage; -- math.random(WT.CovidMinDamage, WT.CovidMaxDamage);
			newHealth = Logic.GetEntityHealth(eId) - damage;
			--LuaDebugger.Log("hurt");
			Logic.HurtEntity(eId, damage);
			if Logic.IsWorker(eId) == 1 and newHealth > 0 then
				local newMotivation = math.max(Logic.GetSettlersMotivation(eId) - WT.MotiReduction, 0.2);
				--LuaDebugger.Log("Set moti"..Logic.GetEntityTypeName(Logic.GetEntityType(eId)));
				S5Hook.SetSettlerMotivation(eId, newMotivation);
			end
			if math.random(1,60) == 1 then
				WT.SpreadCovid(_playerId, pos);
			end
		end
	end
	
	--[[
	local range = WT.CovidRangePerSpot;
	for i = 1, table.getn(WT.CovidPositions[_playerId]) do
		pos = WT.CovidPositions[_playerId][i];
		-- create kala effect
		if math.mod(WT.CovidActivePlayers[_playerId], 5) == 0 then
			Logic.CreateEffect(GGL_Effects.FXKalaPoison, pos.X, pos.Y);
		end
		for eId in S5Hook.EntityIterator(
				Predicate.IsSettler(),
				Predicate.OfPlayer(_playerId),
				Predicate.InRect(pos.X-range, pos.Y-range, pos.X+range, pos.Y+range)
		) do

			if not Logic.IsHero(eId) then
				WT.ExpelSettler(eId, _playerId); -- TODO: cheatprotect
			else
				SetHealth(eId, 0);
			end

		end
	end]]
	WT.CovidActivePlayers[_playerId] = WT.CovidActivePlayers[_playerId] - 1;
end

function WT.SpawnCity()
	for i = 1, table.getn(WT.City) do
		Logic.CreateEntity(WT.City[i][1], WT.City[i][2].X, WT.City[i][2].Y);
	end
	
	--t = {}; for eId in S5Hook.EntityIterator(Predicate.IsBuilding(), Predicate.OfPlayer(1)) do table.insert(t,{Logic.GetEntityType(eId),GetPosition(eId)}); end
end

function WT.RecordCity()
	t = {}; for eId in S5Hook.EntityIterator(Predicate.IsBuilding(), Predicate.OfPlayer(1)) do table.insert(t,{Logic.GetEntityType(eId),GetPosition(eId)}); end
end

function WT.SpreadCovid(_playerId, _pos)
	local minDist = 10000000;
	for spawnStr, pos in pairs(WT.CovidCenterPositions[_playerId]) do
		local squaredMin = WT.GetSquaredDistancePP(_pos, pos);
		if squaredMin < minDist then
			minDist = squaredMin;
		end
	end
	if minDist > 250000 then
		WT.CovidCenterPositions[_playerId][WT.GetPosStr(_pos)] = _pos;
		Logic.CreateEffect(GGL_Effects.FXKalaPoison, _pos.X, _pos.Y);
	end
	--	WT.CovidCenterPositions[_playerId][WT.GetPosStr(_pos)] = {X=_pos.X, Y=_pos.Y};
	--	Logic.CreateEffect(GGL_Effects.FXKalaPoison, _pos.X, _pos.Y);
	--end

	local posStr;
	for i = -WT.CovidRangePerSpot, WT.CovidRangePerSpot do
		for j = -WT.CovidRangePerSpot, WT.CovidRangePerSpot do
			posStr = WT.GetPosStr(_pos, i, j);
			if not WT.CovidPositions[_playerId][posStr] then
				WT.CovidPositions[_playerId][posStr] = true;
				if not addNewEffect then
					addNewEffect = {X=(math.floor(_pos.X/100)+i)*100, Y=(math.floor(_pos.Y/100)+j)*100};
				end
			end
		end
	end
	if addNewEffect then
	--	WT.CovidCenterPositions[_playerId][WT.GetPosStr(addNewEffect)] = {X=addNewEffect.X, Y=addNewEffect.Y};
	--	Logic.CreateEffect(GGL_Effects.FXKalaPoison, addNewEffect.X, addNewEffect.Y);
	end
end

function WT.GetPosStr(_pos, _x, _y)
	if _x then
		return tostring(math.floor(_pos.X/100)+_x)..tostring(math.floor(_pos.Y/100)+_y);
	end
	return tostring(math.floor(_pos.X/100))..tostring(math.floor(_pos.Y/100));
end

function WT.MakeBBArmiesAttack()
	-- make sure all leftover bb armies attack the player, hence don't use resources anymore
	for i = 1, table.getn(WT.Armies) do
		if not IsDead(WT.Armies[i]) then
			--FrontalAttack(WT.Armies[i],{X=Logic.WorldGetSize()/2,Y=Logic.WorldGetSize()/2}, 2000);
			AI.Army_SetAnchorRodeLength(WT.Armies[i].player,WT.Armies[i].id, 40000);
		end
	end
end

function WT.SuddenDeathInit()
	StartSimpleJob("WT_SuddenDeathCountdown");
end

function WT_SuddenDeathCountdown()
	WT.SuddenDeathCounter = WT.SuddenDeathCounter - 1;
	if WT.SuddenDeathCounter <= 0 then
		WT.ActivateSuddenDeath();
		WT.MaxWaveCooldown = 60*4;
		return true;
	end
end

function WT.ActivateSuddenDeath()
	Message("@color:255,0,0 Suddendeath ist aktiv!");
	StartSimpleJob("WT_SuddenDeath");
end

function WT_SuddenDeath()
	WT.SuddenDeathCounter = WT.SuddenDeathCounter + 1;
	local amount = math.ceil(WT.SuddenDeathCounter/45); -- every 45 seconds + 1
	for playerId = 1,4 do
		Message(math.min(amount, GetWood(playerId)));
		AddGold(playerId, -math.min(amount*1.5, GetGold(playerId)));
		AddClay(playerId, -math.min(amount, GetClay(playerId)));
		AddWood(playerId, -math.min(amount, GetWood(playerId)));
		AddStone(playerId, -math.min(amount, GetStone(playerId)));
		AddIron(playerId, -math.min(amount, GetIron(playerId)));
		AddSulfur(playerId, -math.min(amount, GetSulfur(playerId)));
	end
	if WT.SuddenDeathCounter == 60*60 then
		-- 1hour into sudden death
		WT.DestroyAllTowers();
	end
end

function WT.DestroyAllTowers()
	for eId in S5Hook.EntityIterator(Predicate.OfAnyType(Entities.PB_Tower3, Entities.PB_Tower2, Entities.PB_Tower1)) do
		DestroyEntity(eId);
	end
end

function WT.WavePeacetimeInit()
	local peacetime = WT.InitialPeacetime;
	WT.Peacetimes = 
	{
		peacetime, -- team1
		peacetime -- team2
	};
	WT.WavesActivated =
	{
		false,
		false
	}
	
	WT.TimeSinceStart = 0;
	StartSimpleJob("WT_PeacetimeCounter");
	
	if GUI.GetPlayerID() <= 2 then
		XGUIEng.ShowWidget("EMSTimer", 1);
	elseif GUI.GetPlayerID() <= 4 then
		XGUIEng.ShowWidget("EMSTimer", 1);
	else
		-- spectator
		XGUIEng.ShowWidget("EMSTimer", 1);
		XGUIEng.ShowWidget("EMSTimer2", 1);
	end
	WT.UpdatePeacetimeTimers();
end

function WT.CalculateTimeStr(_seconds)
	local f = function(_time)
		if string.len(tostring(_time)) == 1 then
			return "0".._time;

		end
		return _time;
	end
	local minutes = math.floor(_seconds/60)
	_seconds = _seconds-(minutes*60);
	minutes = f(minutes);
	_seconds = f(_seconds);
	return minutes..":".._seconds;
end

function WT_PeacetimeCounter()
	for teamId = 1,2 do
		if WT.Peacetimes[teamId] > 0 then
			WT.Peacetimes[teamId] = WT.Peacetimes[teamId] - 1;
		elseif not WT.WavesActivated[teamId] then
			WT.ActivateWaves(teamId);
			WT.WavesActivated[teamId] = true;
		end
	end
	WT.UpdatePeacetimeTimers();
	WT.TimeSinceStart = WT.TimeSinceStart + 1;
	if WT.WavesActivated[1] and WT.WavesActivated[2] then
		return true;
	end
end

function WT.UpdatePeacetimeTimers()
	if GUI.GetPlayerID() <= 2 then
		WT.UpdatePeacetimeTimer("EMSTimer", 1);
	elseif GUI.GetPlayerID() <= 4 then
		WT.UpdatePeacetimeTimer("EMSTimer", 2);
	else
		WT.UpdatePeacetimeTimer("EMSTimer", 1);
		WT.UpdatePeacetimeTimer("EMSTimer2", 2);
	end
end

function WT.UpdatePeacetimeTimer(_widget, _teamId)
	if not WT.WavesActivated[_teamId] then
		XGUIEng.SetText(_widget, WT.CalculateTimeStr(WT.Peacetimes[_teamId]));
	end
end

function WT.ActivateWaves(_teamId)
	if WT.WaveCountStart == nil then
		-- calculate start wave
		-- wave 1 is supposed start around minute 20, so time passed - 20 minutes.
		-- increase level for each 5 minutes that have passed
		-- example: 35 minutes, 20min=wave1, 35min=wave4
		WT.WaveCountStart = math.floor(math.max(WT.TimeSinceStart-20*60, 0) / (5*60)) + 1;		
		WT.WaveCount = {
			WT.WaveCountStart, -- team1
			WT.WaveCountStart -- team2
		};
		WT.WaveCountdown =
		{
			WT.MaxWaveCooldown,
			WT.MaxWaveCooldown,
		};
		StartSimpleJob("WT_WaveController");
	end
	WT.SpawnWave(_teamId);
end

function WT_WaveController()
	for teamId = 1,2 do
		if WT.WavesActivated[teamId] then
			WT.WaveCountdown[teamId] = WT.WaveCountdown[teamId] - 1;
			if WT.WaveCountdown[teamId] <= 0 then
				WT.SpawnWave(teamId);
				WT.WaveCountdown[teamId] = WT.MaxWaveCooldown;
			end
		end
	end
	WT.UpdateWaveTimers();
end

function WT.UpdateWaveTimers()
	if GUI.GetPlayerID() <= 2 then
		WT.UpdateWaveTimer("EMSTimer", 1);
	elseif GUI.GetPlayerID() <= 4 then
		WT.UpdateWaveTimer("EMSTimer", 2);
	else
		WT.UpdateWaveTimer("EMSTimer", 1);
		WT.UpdateWaveTimer("EMSTimer2", 2);
	end
end

function WT.Interpolate(_v1,_v2,_t)
	return _t*_v1+(1-_t)*_v2;
end

function WT.UpdateWaveTimer(_widget, _teamId)
	if WT.WavesActivated[_teamId] then
		local p = WT.WaveCountdown[_teamId]/WT.MaxWaveCooldown;
		local r, g, b = math.max(50,WT.Interpolate(0, 255, p)), math.max(50,WT.Interpolate(255, 0, p)), 50;
		XGUIEng.SetText(_widget, "@color:"..r..","..g..","..b.." "..WT.CalculateTimeStr(WT.WaveCountdown[_teamId]));
	end
end

function WT.CampsDeadInit()
	WT.NumCamps = 6;
	-- collect all camp entities
	WT.Camps = {};
	local camp;
	for playerId = 1,4 do
		WT.Camps[playerId] = {};
		for campId = 1, WT.NumCamps do
			WT.Camps[playerId][campId] = {};
			for i = 1,5 do
				camp = "b"..playerId..campId..i;
				if IsAlive(camp) then
					table.insert(WT.Camps[playerId][campId], camp);
				end
			end
		end
	end
	StartSimpleJob("WT_CampsDeadController");
end

function WT_CampsDeadController()
	for playerId = 1,2 do
		WT.CampsCheck(playerId, 2);
	end
	for playerId = 3,4 do
		WT.CampsCheck(playerId, 1);
	end
end

function WT.CampsCheck(_playerId, _targetTeamId)
	local campDead;
	for campId = table.getn(WT.Camps[_playerId]), 1, -1 do
		campDead = true;
		for i = 1, table.getn(WT.Camps[_playerId][campId]) do
			if IsAlive(WT.Camps[_playerId][campId][i]) then
				campDead = false;
				break;
			end
		end
		if campDead then
			WT.ReducePeacetime(_targetTeamId);
			table.remove(WT.Camps[_playerId], campId);
		end
	end
end

function WT.ReducePeacetime(_teamId)
	local factor = 0.95; -- -5% zeit pro zerstörtes camp
	WT.Peacetimes[_teamId] = math.floor(WT.Peacetimes[_teamId] * factor);
	WT.TeamMessage(_teamId,
		"@color:255,0,0 Eure Ruhephase wurde verkürzt!",
		"@color:255,0,0 Die Ruhephase der Gegner wurde verkürzt!"
	);
end

function WT.TeamMessage(_teamId, _text, _textOther)
	local playerId = GUI.GetPlayerID();
	if WT.IsLocalPlayerInTeam(_teamId) then
		Message(_text);
	else
		if _textOther then
			Message(_textOther);
		end
	end
end

function WT.InitText()
	local colorize = function(_text)
		return EMS.GV.RuleOverviewColor2 .. " " .._text.. " @color:255,255,255 ";
	end
	WT.TextTable = 
	{
		Costs = "Kosten",
		Gold = "Taler",
		Clay = "Lehm",
		Wood = "Holz",
		Stone = "Stein",
		Iron = "Eisen",
		Sulfur = "Schwefel",
		
		Tooltips = {
			{
				Titel= "Seuche",
				Text = "Schergen werfen Giftpakete an zufällige Orte ins Land eures Gegners, die dort "..colorize("80 Sekunden").." verweilen. "..
						"Sollten Arbeiter in diese Giftpakete laufen, stecken Sie sich an einer Krankheit an.",
			},
			{
				Titel= "Diebesmeute",
				Text = "Eine Meute an Dieben überfällt euren Gegner und verwüstet dessen Siedlung. (Jeder Dieb bringt einen Sprengsatz an einem willkürlich gewählten Gebäude an.)",
			},
			{
				Titel= "Angst",
				Text = "Ein Fluch von Kala verängstigt euren Gegner. Die Motivation aller Arbeiter sinkt einmalig um "..colorize("20%.").."",
			},
			{
				Titel= "Steuerumschreibung",
				Text = "Für die nächsten "..colorize("3 Minuten").." bezahlen die Siedler eures Gegners niedrige Steuern.",
			},
			{
				Titel= "Alkoholismus",
				Text = "Eure Schergen schmuggeln hochprozentigen Alkohol ins Land der Gegner. Die klugen Köpfe sind eine Weile nicht mehr ganz so klug. "..
				"(Verlangsamt jegliche Forschungen des Gegners für "..colorize("1 Minute").." um "..colorize("88%")..".)",
			},
			
			{
				Titel= "Gegenmittel",
				Text = "Schützt eure Arbeiter für "..colorize("5 Minuten").." vor einer eintreffenden Seuche.",
			},
			{
				Titel= "Stadtwache",
				Text = "Erhöht die Wachebereitschaft aller Bewohner um somit Diebe für "..colorize("5 Minuten").." abzuwehren.",
			},
			{
				Titel= "Segen",
				Text = "Kala wirkt einen Segenszauber und schützt euch "..colorize("5 Minuten").." vor dem gegnerischen Fluch.",
			},
			{
				Titel= "Stabile Rechtslage",
				Text = "Für "..colorize("5 Minuten").." sind eure Steuerrechte unantastbar.",
			},
			{
				Titel= "Starker Wille",
				Text = "Ihr ruft euren Männern das gemeinsame Ziel ins Gedächtnis. Sie trotzen dem Wunsch nach Alkoholkonsum für "..colorize(" 5 Minuten."),
			},
		},
		
		Attacks =
		{
			Attack = " greift ",
			-- 1-5
			{
				ReceivedAttackSuccess = "Eure Siedler werden durch eine Seuche vergiftet!",
				ReceivedAttackFail = "Ihr habt eine Seuche abgewehrt!",
				SentAttackSuccess = "Eine Seuche vergifted euren Gegner!",
				SentAttackFail = "Euer Seuchenanschlag wurde abgewehrt!",
				WitnessAttackSuccess = " an. Eine Seuche vergifted wurde ausgebracht!",
				WitnessAttackFail = " an. Die Seuche hatte keine Chance!"
			},
			
			{
				ReceivedAttackSuccess = "Eine Meute an Dieben überfällt Eure Siedlung!",
				ReceivedAttackFail = "Eure Stadtwache hat einen Diebesangriff abgewehrt!",
				SentAttackSuccess = "Eure Diebe verwüsten die gegnerische Siedlung",
				SentAttackFail = "Oh nein! Die Diebe wurden von der gegnerischen Stadtwache aufgehalten!",
				WitnessAttackSuccess = " an. Diebe verwüsten seine Siedlung!",
				WitnessAttackFail = " an. Die Stadtwache hat erfolgreich eine Meute von Dieben abgehalten!"
			},
			
			{
				ReceivedAttackSuccess = "Eure Siedler wirken sehr beunruight und ihre Motivation sinkt!",
				ReceivedAttackFail = "Kalas segen schützt eure Siedler vor einem Fluch!",
				SentAttackSuccess = "Kalas Fluch dezimiert die Motivation der feindlichen Siedler!",
				SentAttackFail = "Kalas Fluch blieb wirkungslos, die Gegner haben vorgesorgt.",
				WitnessAttackSuccess = " an. Kala versetzt die Siedler in Angst und ihre Motivation schwindet!",
				WitnessAttackFail = " an. Der Fluch von Kala bleibt wirkungslos!"
			},
			
			{
				ReceivedAttackSuccess = "Ihr werdet gezwungen niedrige Steuern zu beziehen! Wir erarbeiten so schnell es geht neue Gesetze!",
				ReceivedAttackFail = "Dank eurer stabilen Rechtslage konnte der Gegner eure Steuerlage nicht ändern!",
				SentAttackSuccess = "Ihr habt erfolgreich die Steuern des Gegner gesenkt!",
				SentAttackFail = "Die Steuerumschreibung ist fehlgeschlagen!",
				WitnessAttackSuccess = " an. Die Steuereinnahmen werden auf ein Minimum gedrückt.",
				WitnessAttackFail = " an. Durch eine stabile Rechtslage findet keine Steueränderung statt."
			},
			
			{
				ReceivedAttackSuccess = "Eure Gelehrten feiern das Leben! Ein Hoch auf König Dario. Geforscht wird morgen wieder.",
				ReceivedAttackFail = "Ihr habt eine kostenlose Lieferung Alkohol erhalten! Und dank der Disziplin eurer Männer bleibt alles für euch!",
				SentAttackSuccess = "Der Alkohol ist angekommen! Die Gelehrten des Gegners liegen im Koma!",
				SentAttackFail = "Unmöglich! Niemand interessiert sich für eure Alkohollieferung!",
				WitnessAttackSuccess = " an. Man feiert den plötzlichen Alkoholüberschuss gebürig. Alle Forschungen wurden vertagt.",
				WitnessAttackFail = " an. Dem eisernen Willen seiner Männer zum Dank, betrinkt sich heute niemand!"
			},
			
		},
		
		ProtectionActivated = {
			Self = {
				"Ihr habt den Schutz gegen Seuchen aktiviert!",
				"Ihr habt den Schutz gegen die Diebesmeute aktiviert!",
				"Ihr habt den Schutz gegen Kalas Fluch aktiviert!",
				"Ihr habt den Schutz gegen Steuersenkung aktiviert!",
				"Ihr habt den Schutz gegen Alkoholismus aktiviert!",
			},
			Teammate = {
				"Euer Partner hat den Schutz gegen Seuchen aktiviert!",
				"Euer Partner hat den Schutz gegen die Diebesmeute aktiviert!",
				"Euer Partner hat den Schutz gegen Kalas Fluch aktiviert!",
				"Euer Partner hat den Schutz gegen Steuersenkung aktiviert!",
				"Euer Partner hat den Schutz gegen Alkoholismus aktiviert!",
			},
		},
	}
		
	WT.ResourceNames = {
		[ResourceType.Gold] = WT.TextTable.Gold,
		[ResourceType.Clay] = WT.TextTable.Clay,
		[ResourceType.Wood] = WT.TextTable.Wood,
		[ResourceType.Stone] = WT.TextTable.Stone,
		[ResourceType.Iron] = WT.TextTable.Iron,
		[ResourceType.Sulfur] = WT.TextTable.Sulfur,
	};
end

function WT.UpdateTroopTooltip(_troopType)
	local costs = WT.GetTroopCosts(_troopType, WT.GetPlayersAI(GUI.GetPlayerID()));
	XGUIEng.SetText("EMSMAWTooltip", WT.GetCostString(costs, GUI.GetPlayerID()));
end

function WT.GetCostString(_costs, _playerId)
	local str = WT.TextTable.Costs..": @cr ";
	local color = "";
	local playerRes;
	if table.getn(_costs) == 0 then
		return "";
	end
	for i = 1, table.getn(_costs) do
		playerRes = WT.GetPlayersTotalResources(_playerId, _costs[i][1]);
		if playerRes < _costs[i][2] then
			color = "@color:255,80,80";
		else
			color = "@color:255,255,255";
		end
		str = str .. WT.ResourceNames[_costs[i][1]] .. " : ".. color .. " " .. _costs[i][2] .. " @cr @color:255,255,255 ";
	end
	return str;
end

function WT.GetPlayersTotalResources(_playerId, _resourceType)
	return Logic.GetPlayersGlobalResource( _playerId, _resourceType ) + Logic.GetPlayersGlobalResource( _playerId, _resourceType+1);
end

function WT.Pay(_playerId, _costs)
	for i = 1, table.getn(_costs) do
		Logic.SubFromPlayersGlobalResource(_playerId , _costs[i][1], _costs[i][2]);
	end
end

function WT.HasEnoughResources(_playerId, _costs)
	for i = 1, table.getn(_costs) do
		if WT.GetPlayersTotalResources(_playerId, _costs[i][1]) < _costs[i][2] then
			if GUI.GetPlayerID() == _playerId then
				Message("not enough resources");
			end
			return false;
		end
	end
	return true;
end


function WT.ExtendUnlimitedArmy()

		--[[S5Hook.EntityIterator_O = S5Hook.EntityIterator;
		IteratorCounter = 0;
		S5Hook.EntityIterator = function(...)
			IteratorCounter = IteratorCounter + 1;
			return S5Hook.EntityIterator_O(unpack(arg));
		end]]

	QuickLazyUnlimitedArmy = UnlimitedArmy:CreateSubClass("QuickLazyUnlimitedArmy")

	QuickLazyUnlimitedArmy:AMethod()
	function QuickLazyUnlimitedArmy:Init(data, tickdelta, tickfrequency)
		self:CallBaseMethod("Init", QuickLazyUnlimitedArmy, data)
		self.tickdelta = tickdelta
		self.tickfrequency = tickfrequency
		-- dirty hack to save call base method
		self.TickO = self.Tick
		EndJob(self.Trigger);
		self.Trigger = StartSimpleHiResJob(":Tick", self)
		function self:Tick()
			if math.mod(math.floor(Logic.GetTime()*10+0.5), self.tickfrequency)==self.tickdelta then
				--LuaDebugger.Log(math.mod(math.floor(Logic.GetTime()*10+0.5), self.tickfrequency) .. "/"..self.tickdelta);
				self:TickO()
				--LuaDebugger.Log(IteratorCounter);
				IteratorCounter = 0;
			end
		end
	end
	QuickLazyUnlimitedArmy:FinalizeClass();
	
end 

function WT.GetUnitPoolByPlayerId(_playerId)
	if _playerId > 2 then
		return WT.UnitPoolId2;
	end
	return WT.UnitPoolId1;
end

function WT.ChangeUABehaviour()
	-- all of this pretty bad style, but it just a quick hack
	-- to make ua less cost intensive on this map
	-- might not work anymore as soon as the api changes.
	WT.UnitPoolId1 = 5;
	WT.UnitPoolId2 = 7;
	
	WT.UnitPool =
	{
		-- units of player 1 and 2 are collected in
		[WT.UnitPoolId1] = 
		{
			Leaders = {},
			Buildings = {},
			Others = {},
			Covid = {},
		},
		
		-- units of player 3, 4 are collected in this pool
		[WT.UnitPoolId2] = 
		{
			Leaders = {},
			Buildings = {},
			Others = {},
			Covid = {}, -- for covid
		},
	}
	WT.PoolCategories = {"Leaders","Buildings","Others"};
	
	Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED, "", "WT_UnitPool_EntityCreated", 1);
	Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_DESTROYED, "", "WT_UnitPool_EntityDestroyed", 1);
	
	for eId in S5Hook.EntityIterator(Predicate.OfAnyPlayer(1,2)) do
		WT.AddUnitToPool(WT.UnitPoolId1, eId);
	end
	
	for eId in S5Hook.EntityIterator(Predicate.OfAnyPlayer(1,2)) do
		WT.AddUnitToPool(WT.UnitPoolId2, eId);
	end
	
	function UnlimitedArmy.GetNearestEnemyInArea(p, player, area, leader, building, aiactive, addCond, excludeFleeing)
		if not (leader == true and building == false) then
			-- only support first call to this function
			--LuaDebugger.Log("unecessary call?");
			return;
		end
		
		if p == invalidPosition then
			return nil
		end
		addCond = addCond or function() return true end
		
		local unitPool = WT.UnitPool[player];
		local maxDistSquared = area*area;
		local nearestDistSquared = maxDistSquared+1;
		
		local nearestEntity;
		local category;
		local loops = 0;
		for i = 1,3 do 
			category = WT.PoolCategories[i];
			for eId, v in pairs(unitPool[category]) do
				loops = loops + 1;
				local squaredDistance = WT.GetSquaredDistance(eId, p)
				-- check if entity is in area
				if squaredDistance < nearestDistSquared then
					-- check if target is valid and not fleeing
					--LuaDebugger.Log("possible target");
					if UnlimitedArmy.IsValidTarget(eId, player, aiactive)
					and (not excludeFleeing or not UnlimitedArmy.IsEntityFleeingFrom(eId, p))
					and addCond(eId) then
						nearestDistSquared = squaredDistance;
						nearestEntity = eId;
					end
				end
			end
			if nearestEntity then
				--LuaDebugger.Log("Nearest entity is "..nearestEntity .." of category "..category.." after "..loops.."loops");
				return nearestEntity;
			end
		end
		--LuaDebugger.Log("return nil after " .. loops .. " loops");
		-- return nil, no unit found in range
	end
	
	function UnlimitedArmy.GetFirstEnemyInArea(p, player, area, leader, building, aiactive, addCond, excludeFleeing)
		if p == invalidPosition then
			return nil
		end
		addCond = addCond or function() return true end
		
		local unitPool = WT.UnitPool[player];
		local maxDistSquared = area*area;
		local nearestDistSquared = maxDistSquared+1;
		local loops = 0;
		local category;
		for i = 1,3 do 
			category = WT.PoolCategories[i];
			for eId, v in pairs(unitPool[category]) do
				loops = loops + 1;
				local squaredDistance = WT.GetSquaredDistance(eId, p)
				-- check if entity is in area
				if squaredDistance < nearestDistSquared then
					-- check if target is valid and not fleeing
					if UnlimitedArmy.IsValidTarget(eId, player, aiactive)
					and (not excludeFleeing or not UnlimitedArmy.IsEntityFleeingFrom(eId, p))
					and addCond(eId) then
						--LuaDebugger.Log("GetFirstEnemyInArea "..eId.. "of category "..category.." after "..loops.." loops");
						return eId;
					end
				end
			end
		end
	end
	
	-- this is only used for hero abilites => no hero abilities
	function UnlimitedArmy.GetNumberOfEnemiesInArea(p, player, area, aiactive, addCond, excludeFleeing)
		return 0;
	end
end

function WT.GetSquaredDistance(_entityId, _pos)
	local ePos = GetPosition(_entityId);
	local a = _pos.X - ePos.X;
	local b = _pos.Y - ePos.Y;
	return (a*a)+(b*b);
end

function WT.GetSquaredDistancePP(_pos1, _pos2)
	local a = _pos1.X - _pos2.X;
	local b = _pos1.Y - _pos2.Y;
	return (a*a)+(b*b);
end

function WT_UnitPool_EntityCreated()
	local entityId = Event.GetEntityID();
	local entityPlayer = Logic.EntityGetPlayer(entityId);
	if entityPlayer == 1 or entityPlayer == 2 then
		WT.AddUnitToPool(WT.UnitPoolId1, entityId);
	elseif entityPlayer == 3 or entityPlayer == 4 then
		WT.AddUnitToPool(WT.UnitPoolId2, entityId);
	end
end

function WT_UnitPool_EntityDestroyed()
	local entityId = Event.GetEntityID();
	local entityPlayer = Logic.EntityGetPlayer(entityId);
	if entityPlayer == 1 or entityPlayer == 2 then
		WT.RemoveUnitFromPool(WT.UnitPoolId1, entityId);
	elseif entityPlayer == 3 or entityPlayer == 4 then
		WT.RemoveUnitFromPool(WT.UnitPoolId2, entityId);
	end
end

function WT.GetUnitCategory(_entityId)
	if Logic.IsLeader(_entityId) == 1 
	or Logic.IsHero(_entityId) == 1 then
		return "Leaders";
	elseif Logic.IsBuilding(_entityId) == 1 then
		return "Buildings";
	elseif Logic.IsSerf(_entityId) == 1 then
		-- include heroes, serfs
		return "Others";
	end
	return "";
end

function WT.AddUnitToPool(_poolId, _entityId)
	local cat = WT.GetUnitCategory(_entityId);
	if cat ~= "" then
		WT.UnitPool[_poolId][cat][_entityId] = Logic.GetEntityTypeName(Logic.GetEntityType(_entityId));
	end
	if WT.IsCovidUnit(_entityId) then
		WT.UnitPool[_poolId].Covid[_entityId] = Logic.GetEntityTypeName(Logic.GetEntityType(_entityId));
	end
end

function WT.RemoveUnitFromPool(_poolId, _entityId)
	local cat = WT.GetUnitCategory(_entityId);
	if cat ~= "" then
		WT.UnitPool[_poolId][cat][_entityId] = nil;
	end
	if WT.IsCovidUnit(_entityId) then
		WT.UnitPool[_poolId].Covid[_entityId] = nil;
	end
end

function WT.IsCovidUnit(_entityId)
	return Logic.IsSettler(_entityId) == 1;
end
WT.City =
{
    [1] = {
        [1] = 4,
        [2] = {
            Y = 35000,
            X = 20200,
        },
    },
    [2] = {
        [1] = 49,
        [2] = {
            Y = 25900,
            X = 20300,
        },
    },
    [3] = {
        [1] = 7,
        [2] = {
            Y = 29000,
            X = 21000,
        },
    },
    [4] = {
        [1] = 43,
        [2] = {
            Y = 28100,
            X = 11400,
        },
    },
    [5] = {
        [1] = 61,
        [2] = {
            Y = 23500,
            X = 17500,
        },
    },
    [6] = {
        [1] = 61,
        [2] = {
            Y = 23700,
            X = 19600,
        },
    },
    [7] = {
        [1] = 61,
        [2] = {
            Y = 29200,
            X = 6700,
        },
    },
    [8] = {
        [1] = 61,
        [2] = {
            Y = 27900,
            X = 7800,
        },
    },
    [9] = {
        [1] = 61,
        [2] = {
            Y = 37200,
            X = 30900,
        },
    },
    [10] = {
        [1] = 61,
        [2] = {
            Y = 30400,
            X = 27400,
        },
    },
    [11] = {
        [1] = 61,
        [2] = {
            Y = 29300,
            X = 25800,
        },
    },
    [12] = {
        [1] = 79,
        [2] = {
            Y = 32300,
            X = 27800,
        },
    },
    [13] = {
        [1] = 61,
        [2] = {
            Y = 37000,
            X = 7400,
        },
    },
    [14] = {
        [1] = 31,
        [2] = {
            Y = 31600,
            X = 27300,
        },
    },
    [15] = {
        [1] = 31,
        [2] = {
            Y = 34700,
            X = 27200,
        },
    },
    [16] = {
        [1] = 31,
        [2] = {
            Y = 30200,
            X = 25300,
        },
    },
    [17] = {
        [1] = 31,
        [2] = {
            Y = 33600,
            X = 23700,
        },
    },
    [18] = {
        [1] = 51,
        [2] = {
            Y = 28600,
            X = 18200,
        },
    },
    [19] = {
        [1] = 51,
        [2] = {
            Y = 34100,
            X = 9800,
        },
    },
    [20] = {
        [1] = 651,
        [2] = {
            Y = 30600,
            X = 28300,
        },
    },
    [21] = {
        [1] = 51,
        [2] = {
            Y = 29100,
            X = 14000,
        },
    },
    [22] = {
        [1] = 51,
        [2] = {
            Y = 31800,
            X = 11400,
        },
    },
    [23] = {
        [1] = 51,
        [2] = {
            Y = 32200,
            X = 9800,
        },
    },
    [24] = {
        [1] = 51,
        [2] = {
            Y = 28600,
            X = 17100,
        },
    },
    [25] = {
        [1] = 51,
        [2] = {
            Y = 27400,
            X = 14600,
        },
    },
    [26] = {
        [1] = 51,
        [2] = {
            Y = 30500,
            X = 9700,
        },
    },
    [27] = {
        [1] = 35,
        [2] = {
            Y = 32800,
            X = 7700,
        },
    },
    [28] = {
        [1] = 35,
        [2] = {
            Y = 37000,
            X = 27600,
        },
    },
    [29] = {
        [1] = 51,
        [2] = {
            Y = 29800,
            X = 11200,
        },
    },
    [30] = {
        [1] = 38,
        [2] = {
            Y = 33200,
            X = 21500,
        },
    },
    [31] = {
        [1] = 1,
        [2] = {
            Y = 31700,
            X = 19600,
        },
    },
    [32] = {
        [1] = 31,
        [2] = {
            Y = 36200,
            X = 24500,
        },
    },
    [33] = {
        [1] = 31,
        [2] = {
            Y = 32200,
            X = 24800,
        },
    },
    [34] = {
        [1] = 25,
        [2] = {
            Y = 36700,
            X = 20900,
        },
    },
    [35] = {
        [1] = 7,
        [2] = {
            Y = 31900,
            X = 20400,
        },
    },
    [36] = {
        [1] = 1,
        [2] = {
            Y = 31600,
            X = 21700,
        },
    },
    [37] = {
        [1] = 7,
        [2] = {
            Y = 31100,
            X = 20600,
        },
    },
    [38] = {
        [1] = 23,
        [2] = {
            Y = 35900,
            X = 18800,
        },
    },
    [39] = {
        [1] = 23,
        [2] = {
            Y = 34500,
            X = 18700,
        },
    },
    [40] = {
        [1] = 23,
        [2] = {
            Y = 37300,
            X = 18500,
        },
    },
    [41] = {
        [1] = 40,
        [2] = {
            Y = 34700,
            X = 17200,
        },
    },
    [42] = {
        [1] = 40,
        [2] = {
            Y = 37900,
            X = 25200,
        },
    },
    [43] = {
        [1] = 23,
        [2] = {
            Y = 34800,
            X = 23700,
        },
    },
    [44] = {
        [1] = 23,
        [2] = {
            Y = 33100,
            X = 18700,
        },
    },
    [45] = {
        [1] = 23,
        [2] = {
            Y = 37500,
            X = 19600,
        },
    },
    [46] = {
        [1] = 23,
        [2] = {
            Y = 31600,
            X = 18700,
        },
    },
    [47] = {
        [1] = 40,
        [2] = {
            Y = 32700,
            X = 17200,
        },
    },
    [48] = {
        [1] = 25,
        [2] = {
            Y = 37000,
            X = 17300,
        },
    },
    [49] = {
        [1] = 1,
        [2] = {
            Y = 37400,
            X = 16200,
        },
    },
    [50] = {
        [1] = 31,
        [2] = {
            Y = 35400,
            X = 22400,
        },
    },
    [51] = {
        [1] = 20,
        [2] = {
            Y = 36450,
            X = 22825,
        },
    },
    [52] = {
        [1] = 1,
        [2] = {
            Y = 31900,
            X = 23400,
        },
    },
    [53] = {
        [1] = 7,
        [2] = {
            Y = 34600,
            X = 21400,
        },
    },
    [54] = {
        [1] = 7,
        [2] = {
            Y = 35200,
            X = 16100,
        },
    },
    [55] = {
        [1] = 23,
        [2] = {
            Y = 35000,
            X = 24900,
        },
    },
    [56] = {
        [1] = 1,
        [2] = {
            Y = 36100,
            X = 16200,
        },
    },
    [57] = {
        [1] = 36,
        [2] = {
            Y = 33400,
            X = 25000,
        },
    },
    [58] = {
        [1] = 31,
        [2] = {
            Y = 31200,
            X = 24900,
        },
    },
    [59] = {
        [1] = 31,
        [2] = {
            Y = 32200,
            X = 26000,
        },
    },
    [60] = {
        [1] = 31,
        [2] = {
            Y = 31200,
            X = 26100,
        },
    },
    [61] = {
        [1] = 31,
        [2] = {
            Y = 33500,
            X = 26400,
        },
    },
    [62] = {
        [1] = 31,
        [2] = {
            Y = 34700,
            X = 26000,
        },
    },
    [63] = {
        [1] = 31,
        [2] = {
            Y = 35700,
            X = 26000,
        },
    },
    [64] = {
        [1] = 51,
        [2] = {
            Y = 34000,
            X = 12200,
        },
    },
    [65] = {
        [1] = 51,
        [2] = {
            Y = 33500,
            X = 13700,
        },
    },
    [66] = {
        [1] = 51,
        [2] = {
            Y = 35700,
            X = 12300,
        },
    },
    [67] = {
        [1] = 51,
        [2] = {
            Y = 32300,
            X = 12600,
        },
    },
    [68] = {
        [1] = 51,
        [2] = {
            Y = 37700,
            X = 11400,
        },
    },
    [69] = {
        [1] = 51,
        [2] = {
            Y = 30900,
            X = 14200,
        },
    },
    [70] = {
        [1] = 51,
        [2] = {
            Y = 37400,
            X = 13100,
        },
    },
    [71] = {
        [1] = 51,
        [2] = {
            Y = 30600,
            X = 12500,
        },
    },
    [72] = {
        [1] = 51,
        [2] = {
            Y = 36600,
            X = 9900,
        },
    },
    [73] = {
        [1] = 51,
        [2] = {
            Y = 30300,
            X = 15300,
        },
    },
    [74] = {
        [1] = 51,
        [2] = {
            Y = 28600,
            X = 15800,
        },
    },
    [75] = {
        [1] = 38,
        [2] = {
            Y = 33300,
            X = 19900,
        },
    },
}
