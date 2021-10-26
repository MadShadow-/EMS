-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                             TOOLS                                            * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
EMS.T = {};

function EMS.T.Setup()
	EMS.MaxPlayers = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer();
	
	-- PlayerList, a list containing all playing player ids
	EMS.PlayerList = {};
	local playerCount = 0;
	if EMS.T.IsMultiplayer() then
		for i = 1, XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer() do
			if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(i) == 1 then
				EMS.PlayerList[i] = EMS.T.GetPlayerInformation(i);
				playerCount = playerCount + 1;
			end
		end
	else
		EMS.PlayerList[1] = EMS.T.GetPlayerInformation(1);
		playerCount = 1;
	end
	
	EMS.TotalPlayerCount = playerCount;
	
	EMS.T.MPGame_ApplicationCallback_PlayerLeftGame = MPGame_ApplicationCallback_PlayerLeftGame;
	MPGame_ApplicationCallback_PlayerLeftGame = function( _PlayerID, _Misc )
		EMS.T.MPGame_ApplicationCallback_PlayerLeftGame(_PlayerID, _Misc);
		EMS.PlayerList[_PlayerID] = nil;
	end
	
	EMS.T.OverwriteBuyHero();
	
	EMS.T.SetupMultiplayerTools();
	EMS.T.AfkTracker.Setup();
end

function EMS.T.OverwriteBuyHero()
	GUIUpdate_BuyHeroButton = function()
		local PlayerID = GUI.GetPlayerID()
		local NumberOfHerosToBuy = Logic.GetNumberOfBuyableHerosForPlayer( PlayerID )
		
		
		if NumberOfHerosToBuy > 0 then
			XGUIEng.ShowWidget("Buy_Hero",1)		
		else
			XGUIEng.ShowWidget("Buy_Hero",0)		
		end
	end
end

function EMS.T.GetPlayerInformation(_playerId)
	local r,g,b = GUI.GetPlayerColor(_playerId);
	local name = UserTool_GetPlayerName(_playerId);
	return {
		Name = name,
		Color = string.format("@color:%d,%d,%d", r, g, b),
		ColorName = string.format("@color:%d,%d,%d %s", r, g, b, name),
	};
end

-- copied from chromix ai script
function EMS.T.CopyTable( _t, _noMetaTable )
 
    assert( _t ~= _G);
    local meta = getmetatable( _t );
    if meta then
        setmetatable( _t, {} );
    end
    
    local tNew = {};
    for k, v in pairs( _t ) do
        if type( v ) == "table" then
            tNew[k] = EMS.T.CopyTable( v );
        else
            tNew[k] = v;
        end
    end
    if meta then
        setmetatable( _t, meta );
		if not _noMetaTable then
			setmetatable( tNew, EMS.T.CopyTable( meta, true ) );
		end
    end
    return tNew;
    
end

function EMS.T.IsMultiplayer()
	if CNetwork then
		-- CNetwork makes XNetwork Manager Does Exist
		if XNetworkUbiCom.Manager_DoesExist() == 0 then
			return false;
		end
	end
	if XNetworkUbiCom.Manager_DoesExist() == 1 then
		return 3;
	elseif XNetwork.Manager_DoesExist() == 1 then
		return 2;
	else
		return false;
	end
end

function EMS.T.GetPlayerEntities(_playerID, _entityType)
	local playerEntities = {};
	if _entityType ~= nil then
		local n,eID = Logic.GetPlayerEntities(_playerID, _entityType, 1);
		if (n > 0) then
			local firstEntity = eID;
			repeat
				table.insert(playerEntities,eID);
				eID = Logic.GetNextEntityOfPlayerOfType(eID);
			until (firstEntity == eID);
		end
		return playerEntities;
	else
		for k,v in pairs(Entities) do
			if not string.find(tostring(k), "XD_", 1, true) and
			not string.find(tostring(k), "XA_", 1, true) and
			not string.find(tostring(k), "XS_", 1, true) then
			local n,eID = Logic.GetPlayerEntities(_playerID, v, 1);
				if (n > 0) then
					local firstEntity = eID;
					repeat
						table.insert(playerEntities,eID);
						eID = Logic.GetNextEntityOfPlayerOfType(eID);
					until (firstEntity == eID);
				end
			end
		end
		return playerEntities;
	end
end

function EMS.T.RemoveVillageCenters()
	EMS.T.StartVillageCenters = {{},{},{}};
	local vcId;
	local entities;
	for i = 1,3 do
		for playerId, data in pairs(EMS.PlayerList) do
			entities = EMS.T.GetPlayerEntities(playerId, Entities["PB_VillageCenter"..i]);
			for x = 1, table.getn(entities) do
				table.insert(EMS.T.StartVillageCenters[i], entities[x]);
			end
		end
		for j = 1, table.getn(EMS.T.StartVillageCenters[i]) do
			vcId = EMS.T.StartVillageCenters[i][j];
			EMS.T.StartVillageCenters[i][j] = {
				EntityType = Logic.GetEntityType(vcId),
				Position = GetPosition(vcId),
				PlayerId = GetPlayer(vcId),
				Rotation = Logic.GetEntityOrientation(vcId),
				Name = Logic.GetEntityName(vcId),
			};
			DestroyEntity(vcId);
		end
	end
end

function EMS.T.RecreateVillageCenters()
	local vcdata, eId;
	for i = 1,3 do
		for j = 1, table.getn(EMS.T.StartVillageCenters[i]) do
			vcdata = EMS.T.StartVillageCenters[i][j];
			SetEntityName(Logic.CreateEntity(vcdata.EntityType, vcdata.Position.X, vcdata.Position.Y, vcdata.Rotation, vcdata.PlayerId), vcdata.Name);
		end
	end
end

function EMS.T.SetPlayerEntitiesNonSelectable()
	EMS.T.StartAllPlayerEntities = {};
	local eId;
	local IsHeadquarter = function(_eId)
		local eType = Logic.GetEntityType(_eId);
		return eType == Entities.PB_Headquarters1 or
			   eType == Entities.PB_Headquarters2 or
			   eType == Entities.PB_Headquarters3;
	end
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.T.StartAllPlayerEntities[playerId] = EMS.T.GetPlayerEntities(playerId);
		for i = 1, table.getn(EMS.T.StartAllPlayerEntities[playerId]) do
			eId = EMS.T.StartAllPlayerEntities[playerId][i];
			if not IsHeadquarter(eId) then
				Logic.SetEntitySelectableFlag(EMS.T.StartAllPlayerEntities[playerId][i], 0);
			end
		end
	end
end

function EMS.T.SetPlayerEntitiesSelectable()
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.T.StartAllPlayerEntities[playerId] = EMS.T.GetPlayerEntities(playerId);
		for i = 1, table.getn(EMS.T.StartAllPlayerEntities[playerId]) do
			Logic.SetEntitySelectableFlag(EMS.T.StartAllPlayerEntities[playerId][i], 1);
		end
	end
end

function EMS.T.IsErbe()
	return Entities.PU_Hero10 == nil;
end

function EMS.T.SetupMPLogic()
	local playerId;
	if EMS.T.IsMultiplayer() then
		for playerId = 1, XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer() do
			if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(playerId) == 1 then
				Logic.SetPlayerRawName( playerId, XNetwork.GameInformation_GetLogicPlayerUserName( playerId ) );
				Logic.PlayerSetGameStateToPlaying(playerId);
				Logic.PlayerSetIsHumanFlag(playerId, 1);
				
				local r,g,b = GUI.GetPlayerColor( playerId );
				Logic.PlayerSetPlayerColor( playerId, r, g, b);
			else
				if not EMS.RD.AdditionalConfig.AIPlayers[playerId] then
					MultiplayerTools.RemoveAllPlayerEntities( playerId );
				end
			end
		end
		XGUIEng.ShowWidget(gvGUI_WidgetID.NetworkWindowInfoCustomWidget, 1);
	else
		playerId = 1;
		Logic.SetPlayerRawName(playerId, UserTool_GetPlayerName(playerId));
		Logic.PlayerSetGameStateToPlaying(playerId);	
		Logic.PlayerSetIsHumanFlag(playerId, 1);
		
		local r,g,b = GUI.GetPlayerColor( playerId );
		Logic.PlayerSetPlayerColor( playerId, r, g, b);
	end
	EMS.T.UpdateDiplomacy(Diplomacy.Friendly, Diplomacy.Neutral);
	
	--Extra keybings only in MP 
	Input.KeyBindDown(Keys.NumPad0, "KeyBindings_MPTaunt(1,1)", 2)  --Yes
	Input.KeyBindDown(Keys.NumPad1, "KeyBindings_MPTaunt(2,1)", 2)  --No
	Input.KeyBindDown(Keys.NumPad2, "KeyBindings_MPTaunt(3,1)", 2)  --Now	
	Input.KeyBindDown(Keys.NumPad3, "KeyBindings_MPTaunt(7,1)", 2)  --help
	Input.KeyBindDown(Keys.NumPad4, "KeyBindings_MPTaunt(8,1)", 2)  --clay
	Input.KeyBindDown(Keys.NumPad5, "KeyBindings_MPTaunt(9,1)", 2)  --gold
	Input.KeyBindDown(Keys.NumPad6, "KeyBindings_MPTaunt(10,1)", 2) --iron	
	Input.KeyBindDown(Keys.NumPad7, "KeyBindings_MPTaunt(11,1)", 2) --stone
	Input.KeyBindDown(Keys.NumPad8, "KeyBindings_MPTaunt(12,1)", 2) --sulfur
	Input.KeyBindDown(Keys.NumPad9, "KeyBindings_MPTaunt(13,1)", 2) --wood
	
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad0, "KeyBindings_MPTaunt(5,1)", 2)  --attack here
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad1, "KeyBindings_MPTaunt(6,1)", 2)  --defend here
	
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad2, "KeyBindings_MPTaunt(4,0)", 2)  --attack you
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad3, "KeyBindings_MPTaunt(14,0)", 2) --VeryGood
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad4, "KeyBindings_MPTaunt(15,0)", 2) --Lame
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad5, "KeyBindings_MPTaunt(16,0)", 2) --funny comments 
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad6, "KeyBindings_MPTaunt(17,0)", 2) --funny comments 
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad7, "KeyBindings_MPTaunt(18,0)", 2) --funny comments 
	Input.KeyBindDown(Keys.ModifierControl + Keys.NumPad8, "KeyBindings_MPTaunt(19,0)", 2) --funny comments 
	
	-- No nil-error on game call VC_Deathmatch()
	function VC_Deathmatch()
	end
end

function EMS.T.SetupBugfixes()
	-- allow to create player 0 entities
	Score.Player[0] = {
		battle = 0,
		buildings = 0,
		settlers = 2,
		all = 2,
		resources = 0,
		technology = 0,
	};
end


function EMS.T.UpdateDiplomacy(_friends, _enemies)
	local team = XNetwork.GameInformation_GetLogicPlayerTeam;
	for player1, data in pairs(EMS.PlayerList) do
		for player2, data in pairs(EMS.PlayerList) do
			if player1 ~= player2 then
				if team(player1) == team(player2) then
					Logic.SetShareExplorationWithPlayerFlag( player1, player2, 1 );
					Logic.SetShareExplorationWithPlayerFlag( player2, player1, 1 );
					Logic.SetDiplomacyState( player1, player2, _friends );
				else
					Logic.SetDiplomacyState( player1, player2, _enemies );
				end
			end
		end
	end
	-- restore fixed diplomacy
	for i = 1, table.getn(EMS.RD.AdditionalConfig.Diplomacies) do
		Logic.SetDiplomacyState( unpack(EMS.RD.AdditionalConfig.Diplomacies[i]) );
	end
end


function EMS.T.SetPeacetime( _seconds )
	EMS.T.StartCountdown( _seconds, EMS.EndPeacetime, true );
end

function EMS.T.StartCountdown(_Limit, _Callback, _Show)
	assert(type(_Limit) == "number")

	Counter.Index = (Counter.Index or 0) + 1

	if _Show and EMS.T.CountdownIsVisisble() then
		assert(false, "StartCountdown: A countdown is already visible")
	end

	Counter["counter" .. Counter.Index] = {Limit = _Limit, TickCount = 0, Callback = _Callback, Show = _Show, Finished = false}

	if _Show then
		MapLocal_StartCountDown(_Limit)
	end

	if Counter.JobId == nil then
		Counter.JobId = StartSimpleJob("EMS_T_CountdownTick")
	end

	return Counter.Index
end

function EMS.T.StopCountdown(_Id)
	if Counter.Index == nil then
		return
	end
	if _Id == nil then
		for i = 1, Counter.Index do
			if Counter.IsValid("counter" .. i) then
				if Counter["counter" .. i].Show then
					MapLocal_StopCountDown()
				end
				Counter["counter" .. i] = nil
			end
		end
	else
		if Counter.IsValid("counter" .. _Id) then
			if Counter["counter" .. _Id].Show then
				MapLocal_StopCountDown()
			end
			Counter["counter" .. _Id] = nil
		end
	end
end

function EMS_T_CountdownTick()
	local empty = true
	for i = 1, Counter.Index do
		if Counter.IsValid("counter" .. i) then
			if Counter.Tick("counter" .. i) then
				Counter["counter" .. i].Finished = true
			end

			if Counter["counter" .. i].Finished and not IsBriefingActive() then
				if Counter["counter" .. i].Show then
					MapLocal_StopCountDown()
				end

				-- callback function
				if type(Counter["counter" .. i].Callback) == "function" then
					Counter["counter" .. i].Callback()
				end

				Counter["counter" .. i] = nil
			end

			empty = false
		end
	end

	if empty then
		Counter.JobId = nil
		Counter.Index = nil
		return true
	end
end

function EMS.T.CountdownIsVisisble()
	for i = 1, Counter.Index do
		if Counter.IsValid("counter" .. i) and Counter["counter" .. i].Show then
			return true
		end
	end
	return false
end


function EMS.T.SetupMultiplayerTools()
	MultiplayerTools = MultiplayerTools or {};
	
	MultiplayerTools.InitCameraPositionsForPlayers = function()
		local PlayerID = GUI.GetPlayerID()	
		local CameraPositionName = "P" .. PlayerID .. "_StartPos"
		local Start;
		if IsExisting(CameraPositionName) then
			Start = Logic.GetEntityIDByName(CameraPositionName)
		else
			local UpgradeTypeTable = {Logic.GetBuildingTypesInUpgradeCategory(UpgradeCategories.Headquarters)}
			local AmountOfUpgradeTypes = UpgradeTypeTable[1]	
			for i=1,AmountOfUpgradeTypes,1 
			do
				-- Get ID of upgradecategory of player
				local TempTable = {Logic.GetPlayerEntities( GUI.GetPlayerID(), UpgradeTypeTable[i+1], 48 )	}
				local number = TempTable[1]		
				for j=1,number,1 
				do
					if TempTable[j+1] ~= nil then
						Start = TempTable[j+1]
						break
					end
				end		
			end
		end	
		Camera.ScrollGameTimeSynced(Logic.EntityGetPos(Start));
	end


	MultiplayerTools.RemoveAllPlayerEntities = function( _PlayerID )
		
		if S5Hook then
			for eId in S5Hook.EntityIterator(Predicate.OfPlayer(_PlayerID)) do
				if Logic.GetEntityType(eId) ~= Entities.XD_ScriptEntity then
					DestroyEntity(eId);
				end
			end
			return;
		end
		-- As long as there are entities	
		while true do
			-- Get next x entities
			local Table = { Logic.GetAllPlayerEntities( _PlayerID, 20 ) }
			local Number = Table[ 1 ]
			-- Break when done
			if Number == 0 then
				break
			end
			-- Delete them
			for i=2, Number, 1 do
				local EntityID = Table[i]
				Logic.DestroyEntity( EntityID )
			end
		end
	end

	MultiplayerTools.PlayerLeftGame = function( _PlayerID )
		-- Player valid?
		if _PlayerID == 0 then
			return;
		end
		-- Distribute resources to allied player AND remove players resources
		do
			-- Get number of humen player
			local HumenPlayer = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer()
			-- Is leaving player a humen?
			if _PlayerID <= HumenPlayer then
				-- Count allied player
				local Allies = 0
				
				-- Do count
				do
					for TempPlayerID=1, HumenPlayer, 1 do
						if TempPlayerID ~= _PlayerID then
							if Logic.GetDiplomacyState( TempPlayerID, _PlayerID ) == Diplomacy.Friendly and
							   Logic.PlayerGetGameState( TempPlayerID ) == 1 then
								Allies = Allies + 1
							end
						end
					end
				end
				
				-- Get player resources
				local PlayerClay   = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Clay ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.ClayRaw )	
				local PlayerGold   = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Gold ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.GoldRaw )
				local PlayerWood   = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Wood ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.WoodRaw )
				local PlayerIron   = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Iron ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.IronRaw )
				local PlayerStone  = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Stone ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.StoneRaw )
				local PlayerSulfur = Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.Sulfur ) + Logic.GetPlayersGlobalResource( _PlayerID, ResourceType.SulfurRaw )
				
				-- Any allies?
				if Allies ~= 0 then
					-- Distribute resources
					for TempPlayerID=1, HumenPlayer, 1 do
						if TempPlayerID ~= _PlayerID then
							if Logic.GetDiplomacyState( TempPlayerID, _PlayerID ) == Diplomacy.Friendly and
							   Logic.PlayerGetGameState( TempPlayerID ) == 1 then
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Clay,   PlayerClay / Allies )
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Gold,   PlayerGold / Allies )
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Wood,   PlayerWood / Allies )
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Iron,   PlayerIron / Allies )
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Stone,  PlayerStone / Allies )
								Logic.AddToPlayersGlobalResource( TempPlayerID, ResourceType.Sulfur, PlayerSulfur / Allies )
							end
						end
					end
				end
				
				-- Remove player resources
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Clay, PlayerClay )
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Gold, PlayerGold )
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Wood, PlayerWood )
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Iron, PlayerIron )
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Stone, PlayerStone )
				Logic.SubFromPlayersGlobalResource( _PlayerID, ResourceType.Sulfur, PlayerSulfur )
			end
		end
		-- Remove player entities
		MultiplayerTools.RemoveAllPlayerEntities( _PlayerID )
		--say logic, player has lost
		Logic.PlayerSetGameStateToLeft( _PlayerID )
	end

	MultiplayerTools.GiveBuyableHerosToHumanPlayer = function( _NumberOfHeros )
		-- Get number of humen player
		local HumenPlayer = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer()
		-- For all humen player
		for PlayerID=1, HumenPlayer, 1 do
			-- Give heros to buy
			Logic.SetNumberOfBuyableHerosForPlayer( PlayerID, _NumberOfHeros )
		end
	end
end

function EMS.T.InitStandardVictoryCondition()
	EMS.T.VictoryCondition = {};
	EMS.T.VictoryCondition.NumberOfPlayersPlaying = 0;
	EMS.T.VictoryCondition.Playing = {};
	local hqs, hqi;
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.T.VictoryCondition.NumberOfPlayersPlaying = EMS.T.VictoryCondition.NumberOfPlayersPlaying + 1;
		EMS.T.VictoryCondition[playerId] = {};
		EMS.T.VictoryCondition.Playing[playerId] = true;
		for j = 1,3 do
			hqs = {Logic.GetPlayerEntities(playerId, Entities["PB_Headquarters"..j], 10)};
			if hqs[1] > 0 then
				for hqi = 2, table.getn(hqs) do
					table.insert(EMS.T.VictoryCondition[playerId], hqs[hqi]);
				end
			end
		end
	end
end

function EMS_T_StandardVictoryConditionJob()
	-- started from file ruledata
	-- if config doesn't disable it
	if not EMS.GV.GameStarted then
		return;
	end
	local HasLost;
	for playerId, data in pairs(EMS.PlayerList) do
		if EMS.T.VictoryCondition.Playing[playerId] then
			HasLost = true;
			for HQIndex = table.getn(EMS.T.VictoryCondition[playerId]), 1, -1 do
				if IsAlive(EMS.T.VictoryCondition[playerId][HQIndex]) then
					HasLost = false;
					break;
				else
					table.remove(EMS.T.VictoryCondition[playerId], HQIndex);
				end
			end
			if HasLost then
				if not EMS.T.ScanForPlayerHQ(playerId) then
					EMS.T.PlayerLost(playerId);
					EMS.T.VictoryCondition.Playing[playerId] = false;
					EMS.T.VictoryCondition.NumberOfPlayersPlaying = EMS.T.VictoryCondition.NumberOfPlayersPlaying - 1;
					if EMS.T.VictoryCondition.NumberOfPlayersPlaying <= 0 then
						return true;
					end
				end
			end
		end
	end
end

function EMS.T.ScanForPlayerHQ(_playerId)
	local foundHQs = false;
	local hqs;
	for j = 1,3 do
		hqs = {Logic.GetPlayerEntities(_playerId, Entities["PB_Headquarters"..j], 10)};
		if hqs[1] > 0 then
			for hqi = 2, table.getn(hqs) do
				table.insert(EMS.T.VictoryCondition[_playerId], hqs[hqi]);
				foundHQs = true;
			end
		end
	end
	return foundHQs;
end

function EMS.T.PlayerLost(_playerId)
	if GUI.GetPlayerID() == _playerId then
		GUI.AddNote( "@color:255,0,0 " .. XGUIEng.GetStringTableText( "InGameMessages/Note_PlayerLostGame" ) );
	else
		if EMS.PlayerList[_playerId] then
			GUI.AddNote(  EMS.PlayerList[_playerId].ColorName .. " @color:255,255,255 " .. XGUIEng.GetStringTableText( "InGameMessages/Note_PlayerXLostGame" ) );
		end
	end
	Logic.PlayerSetGameStateToLost(_playerId);
	MultiplayerTools.RemoveAllPlayerEntities(_playerId);
	XGUIEng.ShowWidget("GameEndScreen",0);
end

function EMS.T.ShareExploration(_p1, _p2)
	EMS.T.SetShareExploration(_p1, _p2, 1);
	EMS.T.SetShareExploration(_p2, _p1, 1);
end

function EMS.T.SetShareExploration(_p1, _p2, _flag)
	Logic.SetShareExplorationWithPlayerFlag( _p1, _p2, _flag );
end

function EMS.T.IsLocalPlayerSpectator()
	return GUI.GetPlayerID() == 17;
end

EMS.T.AfkTracker = {X=0,Y=0, LastMove=0, AfkTimeout=45, Afk=false, AfkPlayers={}, OrigNames={}};
function EMS.T.AfkTracker.Setup()
	if EMS.T.IsLocalPlayerSpectator() then
		return;
	end
	StartSimpleJob("EMS_T_AfkTracker_Job");
end

function EMS_T_AfkTracker_Job()
	local x,y = GUI.Debug_GetMapPositionUnderMouse();
	if Game.GameTimeGetFactor() > 3 then
		-- probably reloading game
		EMS.T.AfkTracker.LastMove = XGUIEng.GetSystemTime();
	end
	if EMS.T.AfkTracker.X ~= x and EMS.T.AfkTracker.Y ~= y then
		EMS.T.AfkTracker.X, EMS.T.AfkTracker.Y = x,y;
		EMS.T.AfkTracker.LastMove = XGUIEng.GetSystemTime();
		if EMS.T.AfkTracker.Afk then
			EMS.T.AfkTracker.Afk = false;
			Sync.CallNoSync("EMS.T.AfkTracker.SetAfkState", GUI.GetPlayerID(), false);
		end
	elseif not EMS.T.AfkTracker.Afk then
		local timeDiff = XGUIEng.GetSystemTime() - EMS.T.AfkTracker.LastMove;
		if timeDiff > EMS.T.AfkTracker.AfkTimeout then
			EMS.T.AfkTracker.Afk = true;
			Sync.CallNoSync("EMS.T.AfkTracker.SetAfkState", GUI.GetPlayerID(), true);
		end
	end
end

function EMS.T.AfkTracker.SetAfkState(_playerId, _isAfk)
	if EMS.PlayerList[_playerId] == nil then
		return;
	end
	EMS.T.AfkTracker.AppendAfkToName(_playerId, _isAfk);
	if _isAfk then
		EMS.T.AfkTracker.AfkPlayers[_playerId] = true;
		Message(EMS.PlayerList[_playerId].ColorName .. EMS.GV.AttentionColor .. EMS.L.PlayerIsAfkNow);
	else
		EMS.T.AfkTracker.AfkPlayers[_playerId] = nil;
		Message(EMS.PlayerList[_playerId].ColorName .. EMS.GV.AttentionColor .. EMS.L.PlayerNotAfkAnymore);
	end
end

function EMS.T.AfkTracker.AppendAfkToName(_playerId, _afk)
	if EMS.T.AfkTracker.OrigNames[_playerId] == nil then
		EMS.T.AfkTracker.OrigNames[_playerId] = UserTool_GetPlayerName(_playerId);
	end
	local name = EMS.T.AfkTracker.OrigNames[_playerId];
	if _afk then
		name = name .. " @color:255,0,0 (AFK)";
	end
	SetPlayerName(_playerId, name);
end


function EMS.T.CreatePlayers9To16()
	local buildingId;
	local entity
	for playerId = 9,16 do
		buildingId = 0;
		entity = GetEntity("ems_"..playerId.."_"..buildingId)
		while(true) do
			Logic.GetEntityType(entity);
		end
	end
end





