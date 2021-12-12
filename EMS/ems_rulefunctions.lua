-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                        RULE FUNCTIONS                                        * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
EMS.RF = {};

function EMS.RF.Setup()
	-- testing
	--EMS.RF.ActivateHQRushProtection();
	--EMS.RF.ActivateTowerLimit(5);
	--EMS.RF.ActivateMarketLimit(3);
	--EMS.RF.ActivateWeatherLockTimer(0.5)
	--EMS.RF.ActivateBlessLimit()
	EMS.RF.TradeLimit = 10000000;
	EMS.RF.GUIAction_MarketToggleResource = GUIAction_MarketToggleResource;
	GUIAction_MarketToggleResource = function( _Amount, _Resource)
		if XGUIEng.IsModifierPressed(Keys.ModifierControl) == 1 then
			_Amount = _Amount * 20;
		elseif XGUIEng.IsModifierPressed(Keys.ModifierAlt) == 1 then
			_Amount = EMS.RF.TradeLimit or (_Amount * 20);
		end
		_Resource = math.max( (_Resource + _Amount), 0);
		_Resource = math.min( _Resource, EMS.RF.TradeLimit);
		return _Resource;
	end
	

	GameCallback_OnTransactionComplete = function(_BuildingID, _empty )
		
		if GetPlayer(_BuildingID) ~= GUI.GetPlayerID() then
			return;
		end
		
		local BuildingID = GUI.GetSelectedEntity()
		
		if _BuildingID == BuildingID then
			XGUIEng.ShowWidget(gvGUI_WidgetID.TradeInProgress,0)							
		end
		GUIAction_MarketClearDeals()
	--	Sound.PlayFeedbackSound( Sounds.Speech_INFO_Deal_rnd_01, 0 )
		
	end
	
end

function EMS.RF.GiveResources(_level)
	for playerId, data in pairs(EMS.PlayerList) do
		if _level == 1 then
			Tools.GiveResouces(playerId, unpack(EMS.RD.AdditionalConfig.Ressources.Normal[playerId]));
		elseif _level == 2 then
			Tools.GiveResouces(playerId, unpack(EMS.RD.AdditionalConfig.Ressources.FastGame[playerId]));
		else
			Tools.GiveResouces(playerId, unpack(EMS.RD.AdditionalConfig.Ressources.SpeedGame[playerId]));
		end
	end
end

function EMS.RF.ActivateHQRushProtection()
	EMS.RF.HQRP = {Headquarters = {}, VillageCenters={}, InvulnerabilityFlag={}};

	EMS.RF.HQRP.GameCallback_OnBuildingUpgradeComplete = GameCallback_OnBuildingUpgradeComplete;
	GameCallback_OnBuildingUpgradeComplete = function(_oldId, _newId)
		EMS.RF.HQRP.GameCallback_OnBuildingUpgradeComplete(_oldId, _newId);
		local eType = Logic.GetEntityType(_newId);
		if Logic.GetUpgradeCategoryByBuildingType(eType) == UpgradeCategories.Headquarters then
			local pId = Logic.EntityGetPlayer(_newId);
			if EMS.RF.HQRP.Headquarters[pId][_oldId] then
				EMS.RF.HQRP.Headquarters[pId][_oldId] = nil;
				EMS.RF.HQRP.Headquarters[pId][_newId] = true;
			end
		end
	end
	
	EMS.RF.HQRP.SetInvulnerabilityStatusForPlayer = function(_playerId, _flag)
		for hqId,v in pairs(EMS.RF.HQRP.Headquarters[_playerId]) do
			Logic.SetEntityInvulnerabilityFlag(hqId, _flag);
		end
	end
	
	EMS.RF.HQRP.HasStateChanged = function(_playerId)
		if not EMS.PlayerList[_playerId] then
			return;
		end
		if EMS.RF.HQRP.GetNumberOfVillageCenters(_playerId) > 0 then
			-- check player is vulernerable
			return EMS.RF.HQRP.InvulnerabilityFlag[_playerId] == 0;
		end
		-- check player is invulnerable
		return EMS.RF.HQRP.InvulnerabilityFlag[_playerId] == 1;
	end
	
	EMS.RF.HQRP.GetNumberOfVillageCenters = function(_playerId)
		local numberOfVillageCenters = 0;
		for villageCenterId, _ in pairs(EMS.RF.HQRP.VillageCenters[_playerId]) do
			numberOfVillageCenters = numberOfVillageCenters + 1;
		end
		return numberOfVillageCenters;
	end
	
	EMS.RF.HQRP.Update = function(_playerId)
		if not EMS.PlayerList[_playerId] then
			return;
		end
		if EMS.RF.HQRP.HasStateChanged(_playerId) then
			EMS.RF.HQRP.UpdateInvulnerabilityStatus(_playerId);
			EMS.RF.HQRP.CreateUpdateMessage(_playerId);
		end
	end
	
	EMS.RF.HQRP.UpdateInvulnerabilityStatus = function(_playerId)
		EMS.RF.HQRP.InvulnerabilityFlag[_playerId] = math.min(EMS.RF.HQRP.GetNumberOfVillageCenters(_playerId), 1);
		EMS.RF.HQRP.SetInvulnerabilityStatusForPlayer(_playerId, EMS.RF.HQRP.InvulnerabilityFlag[_playerId]);
	end
	
	EMS.RF.HQRP.CreateUpdateMessage = function(_playerId)
		if not EMS.GV.GameStarted then
			-- prevent message spam at game start
			return;
		end
		if Logic.PlayerGetGameState(_playerId) ~= 1 then
			-- player already lost or left
			return;
		end
		local msg = EMS.L.HQRush1 .. " ".. EMS.PlayerList[_playerId].ColorName .. " @color:255,255,255 ".. EMS.L.HQRush2;
		if EMS.RF.HQRP.InvulnerabilityFlag[_playerId] == 0 then
			msg = msg .. " @color:255,0,0 " .. EMS.L.Vulnerable .. "!";
		else
			msg = msg .. " @color:0,255,0 " .. EMS.L.Invulnerable .. "!";
		end
		Message(msg);
	end
	
	EMS.RF.HQRP.IsVillageCenter = function(_entityId)
		local type = Logic.GetEntityType(_entityId);
		return (type == Entities.PB_VillageCenter1 or type == Entities.PB_VillageCenter2 or type == Entities.PB_VillageCenter3);
	end
	
	EMS.RF.HQRP.GameCallback_OnBuildingConstructionComplete = GameCallback_OnBuildingConstructionComplete;
	GameCallback_OnBuildingConstructionComplete = function(_buildingId, _playerId)
		EMS.RF.HQRP.GameCallback_OnBuildingConstructionComplete(_buildingId, _playerId);
		if _playerId == 0 and not EMS.PlayerList[_playerId] then
			return;
		end
		if EMS.RF.HQRP.IsVillageCenter(_buildingId) then
			EMS.RF.HQRP.VillageCenters[_playerId][_buildingId] = true;
			EMS.RF.HQRP.Update(_playerId);
		end
	end
	
	EMS_RF_HQRP_EntityCreated = function()
		local entityId = Event.GetEntityID();
		if EMS.RF.HQRP.IsVillageCenter(entityId) and Logic.IsConstructionComplete(entityId) == 1 then
			local playerId = Logic.EntityGetPlayer(entityId);
			if not EMS.PlayerList[playerId] then
				return;
			end
			EMS.RF.HQRP.VillageCenters[playerId][buildingId] = true;
			EMS.RF.HQRP.Update(playerId);
		end
	end

	EMS_RF_HQRP_EntityDestroyed = function()
		local entityId = Event.GetEntityID();
		if EMS.RF.HQRP.IsVillageCenter(entityId) then
			local playerId = Logic.EntityGetPlayer(entityId);
			if not EMS.PlayerList[playerId] then
				return;
			end
			-- only completely builded village centers will be inside of the table
			-- fixed prior bug that uncompleted village centers decreased the nr of total vcs
			if EMS.RF.HQRP.VillageCenters[playerId][entityId] then
				EMS.RF.HQRP.VillageCenters[playerId][entityId] = nil;
			end
			EMS.RF.HQRP.Update(playerId);
		end
	end
	
	if not EMS.RD.AdditionalConfig.InvulnerableHQs then
		-- create triggers only when hqs can be vulnerable
		Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_CREATED, "", "EMS_RF_HQRP_EntityCreated", 1);
		Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_DESTROYED, "", "EMS_RF_HQRP_EntityDestroyed", 1);
	end
	
	local hqs;
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.RF.HQRP.Headquarters[playerId] = {};
		EMS.RF.HQRP.VillageCenters[playerId] = {};
		if EMS.RD.AdditionalConfig.InvulnerableHQs then	
			EMS.RF.HQRP.InvulnerabilityFlag[playerId] = 1;
		else
			EMS.RF.HQRP.InvulnerabilityFlag[playerId] = 0;
		end
		for j = 1,3 do
			hqs = {Logic.GetPlayerEntities(playerId, Entities["PB_Headquarters"..j], 10)};
			if hqs[1] > 0 then
				for hqi = 2, table.getn(hqs) do
					EMS.RF.HQRP.Headquarters[playerId][hqs[hqi]] = true;
				end
			end
		end
		
		for j = 1,3 do
			vcs = {Logic.GetPlayerEntities(playerId, Entities["PB_VillageCenter"..j], 10)};
			for vci = 1, vcs[1] do
				EMS.RF.HQRP.VillageCenters[playerId][vcs[vci+1]] = true;
			end
		end
		EMS.RF.HQRP.UpdateInvulnerabilityStatus(playerId);
	end
	
end

function EMS.RF.ActivateBlessLimit()
	EMS.RF.BlessLimit = {}
	for i = 1,5 do
		EMS.RF.BlessLimit[i] = 0
	end
	EMS.RF.BlessLimit.GUIAction_BlessSettlers = GUIAction_BlessSettlers;
	GUIAction_BlessSettlers = function(_blessCategory)
		local CurrentFaith = Logic.GetPlayersGlobalResource( GUI.GetPlayerID() , ResourceType.Faith )	
		local BlessCosts = Logic.GetBlessCostByBlessCategory(_blessCategory)
		if CurrentFaith < BlessCosts then
			EMS.RF.BlessLimit.GUIAction_BlessSettlers(_blessCategory);
			return;
		end
		if EMS.RF.BlessLimit[_blessCategory] == 0 then
			EMS.RF.BlessLimit.GUIAction_BlessSettlers(_blessCategory);
			if _blessCategory == 5 then
				for i = 1,5 do
					EMS.RF.BlessLimit[i] = 90;
					XGUIEng.DisableButton("BlessSettlers"..i, 1);
				end	
			else
				EMS.RF.BlessLimit[_blessCategory] = 90;
				XGUIEng.DisableButton("BlessSettlers".._blessCategory, 1);
			end
		end
	end
	
	GUIUpdate_BuildingButtons("BlessSettlers2", Technologies.T_BlessSettlers2)
	GUIUpdate_GlobalTechnologiesButtons("BlessSettlers4", Technologies.T_BlessSettlers4,Entities.PB_Monastery2)
	
	EMS.RF.BlessLimit.GUIUpdate_GlobalTechnologiesButtons = GUIUpdate_GlobalTechnologiesButtons;
	function GUIUpdate_GlobalTechnologiesButtons(_Button, _Technology, _BuildingType)
		EMS.RF.BlessLimit.GUIUpdate_GlobalTechnologiesButtons(_Button, _Technology, _BuildingType);
		if not string.find(_Button, "BlessSettlers") then
			return;
		end
		local i = tonumber(string.sub(_Button, 14, 14));
		if EMS.RF.BlessLimit[i] > 0 then
			XGUIEng.DisableButton(_Button, 1);
		end
	end

	EMS.RF.BlessLimit.GUIUpdate_BuildingButtons = GUIUpdate_BuildingButtons;
	GUIUpdate_BuildingButtons = function(_Button, _Technology)
		EMS.RF.BlessLimit.GUIUpdate_BuildingButtons(_Button, _Technology);
		if not string.find(_Button, "BlessSettlers") then
			return;
		end
		local i = tonumber(string.sub(_Button, 14, 14));
		if EMS.RF.BlessLimit[i] > 0 then
			XGUIEng.DisableButton(_Button, 1);
		end
	end
	
	EMS.RF.BlessLimit.GUITooltip_BlessSettlers = GUITooltip_BlessSettlers;
	function GUITooltip_BlessSettlers(_DisabledTooltip,_NormalTooltip,_NotUsed, _ShortCut)
		EMS.RF.BlessLimit.GUITooltip_BlessSettlers(_DisabledTooltip,_NormalTooltip,_NotUsed, _ShortCut);
		local i = tonumber(string.sub(_NormalTooltip,30,30));
		if EMS.RF.BlessLimit[i] == 0 then
			return;
		end
		local oldToolTip = XGUIEng.GetStringTableText(_NormalTooltip);
		local start, ende = string.find(oldToolTip, "@cr");
		start = start or 0;
		ende = ende or 0;
		local newToolTip = string.sub(oldToolTip, 1, start-1) .. " @color:255,0,0 ("..EMS.RF.BlessLimit[i]..") @cr "
							.. string.sub(oldToolTip, ende+1);
		XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomText, newToolTip)
	end
	--GUITooltip_BlessSettlers("MenuMonastery/BlessSettlers_disabled","AOMenuMonastery/BlessSettlers1_normal","AOMenuMonastery/BlessSettlers1_researched","KeyBindings/BlessSettlers1")
	
	EMS_RF_BlessLimitCounter = function()
		for i = 1,5 do
			if EMS.RF.BlessLimit[i] > 0 then
				EMS.RF.BlessLimit[i] = EMS.RF.BlessLimit[i] - 1
			elseif EMS.RF.BlessLimit[i] == 0 then
				XGUIEng.DisableButton("BlessSettlers"..i, 0);
			end
		end
	end
	
	if CNetwork then
		local Network_BlessSettlers = {};
		CNetwork.SetNetworkHandler("BlessSettlers", 
			function(name, _playerID, _level)
				if CNetwork.IsAllowedToManipulatePlayer(name, _playerID) then
					if (_level == 1 and Logic.GetTechnologyState(_playerID, Technologies.T_BlessSettlers1) == 2)
					or (_level == 2 and Logic.GetTechnologyState(_playerID, Technologies.T_BlessSettlers2) == 2)
					or (_level == 3 and Logic.GetTechnologyState(_playerID, Technologies.T_BlessSettlers3) == 2)
					or (_level == 4 and Logic.GetTechnologyState(_playerID, Technologies.T_BlessSettlers4) == 2)
					or (_level == 5 and Logic.GetTechnologyState(_playerID, Technologies.T_BlessSettlers5) == 2) then
						
						Network_BlessSettlers[_playerID] = Network_BlessSettlers[_playerID] or {-90, -90, -90, -90, -90};
						local timepassed = Logic.GetTime() - Network_BlessSettlers[_playerID][_level];
						
						if timepassed >= 90 then
							SendEvent.BlessSettlers(_playerID, _level);
							Network_BlessSettlers[_playerID][_level] = Logic.GetTime();
							
							if GUI.GetPlayerID() == _playerID then
								EMS.RF.BlessLimit[_level] = 90;
							end;
						end;
					end;
				end;
			end
		);
	end;
	
	StartSimpleJob("EMS_RF_BlessLimitCounter")
end

function EMS.RF.ActivateMarketLimit(_limit)
	EMS.RF.MarketLimit = _limit;
	EMS.RF.MarketLimit_LastCreated = {};
	EMS.RF.MarketLimit_InUpgradeProgress = 0;
	EMS.RF.MarketLimitJob = 0;
	EMS.RF.MarketLimit_BuildingsInUpgradeProgress = {};

	EMS.RF.MarketLimitCount = {};
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.RF.MarketLimitCount[playerId] = table.getn(EMS.T.GetPlayerEntities(playerId, Entities["PB_Market2"]));
	end
	
	EMS.RF.IsMarket = function(_Id)
		return Logic.GetEntityType(_Id) == Entities.PB_Market2;
	end
	
	EMS_RF_MarketLimit_EntityCreated = function()
		local Id = Event.GetEntityID();
		local pId = Logic.EntityGetPlayer(Id);
		if not EMS.RF.IsMarket(Id) or not EMS.PlayerList[pId] then
			return;
		end
		if EMS.RF.MarketLimitCount[pId] >= EMS.RF.MarketLimit then
			table.insert(EMS.RF.MarketLimit_LastCreated, Id);
			if EMS.RF.MarketLimitJob == 0 then
				EMS.RF.MarketLimitJob = StartSimpleHiResJob("EMS_RF_MarketLimit_DestroyEntity");
			end
		else
			EMS.RF.MarketLimitCount[pId] = EMS.RF.MarketLimitCount[pId] + 1;
		end
	end
	
	EMS_RF_MarketLimit_EntityDestroyed = function()
		local Id = Event.GetEntityID();
		local pId = Logic.EntityGetPlayer(Id);
		if not EMS.RF.IsMarket(Id) or not EMS.PlayerList[pId] then
			return;
		end
		if EMS.RF.MarketLimitCount[pId] > 0 then
			EMS.RF.MarketLimitCount[pId] = EMS.RF.MarketLimitCount[pId] - 1;
		end
	end
	
	EMS_RF_MarketLimit_DestroyEntity = function()
		for i = 1, table.getn(EMS.RF.MarketLimit_LastCreated) do
			DestroyEntity(EMS.RF.MarketLimit_LastCreated[i]);
		end
		EMS.RF.MarketLimitJob = 0;
		return true;
	end
	
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_CREATED, "", "EMS_RF_MarketLimit_EntityCreated", 1);
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_DESTROYED, "", "EMS_RF_MarketLimit_EntityDestroyed", 1);
	
	EMS.RF.GameCallback_OnBuildingUpgradeComplete_ML = GameCallback_OnBuildingUpgradeComplete;
	GameCallback_OnBuildingUpgradeComplete = function(_oId, _nId)
		if Logic.GetEntityType(_nId) == Entities.PB_Market2 then
			if EMS.RF.MarketLimit_InUpgradeProgress > 0 then
				EMS.RF.MarketLimit_InUpgradeProgress = EMS.RF.MarketLimit_InUpgradeProgress - 1;
			else
				EMS.RF.MarketLimit_InUpgradeProgress = 0;
			end
		end
		if EMS.RF.MarketLimit_BuildingsInUpgradeProgress[_oId] then
				EMS.RF.MarketLimit_BuildingsInUpgradeProgress[_oId] = nil;
			end
		EMS.RF.GameCallback_OnBuildingUpgradeComplete_ML(_oId, _nId);
	end
	
	EMS.RF.GUIAction_CancelUpgrade_ML = GUIAction_CancelUpgrade;
	GUIAction_CancelUpgrade = function()
		local seltype = Logic.GetEntityType(GUI.GetSelectedEntity());
		if seltype == Entities.PB_Market1 then
			if EMS.RF.MarketLimit_InUpgradeProgress > 0 then
				EMS.RF.MarketLimit_InUpgradeProgress = EMS.RF.MarketLimit_InUpgradeProgress - 1;
			else
				EMS.RF.MarketLimit_InUpgradeProgress = 0;
			end
			if EMS.RF.MarketLimit_BuildingsInUpgradeProgress[GUI.GetSelectedEntity()] then
				EMS.RF.MarketLimit_BuildingsInUpgradeProgress[GUI.GetSelectedEntity()] = nil;
			end
		end
		EMS.RF.GUIAction_CancelUpgrade_ML();
	end
	
	EMS.RF.GUIAction_UpgradeSelectedBuilding_ML = GUIAction_UpgradeSelectedBuilding;
	GUIAction_UpgradeSelectedBuilding = function()
		local sel = GUI.GetSelectedEntity();
		if Logic.GetEntityType(sel) ~= Entities.PB_Market1 then
			EMS.RF.GUIAction_UpgradeSelectedBuilding_ML();
			return;
		end
		if (EMS.RF.MarketLimitCount[GUI.GetPlayerID()]+EMS.RF.MarketLimit_InUpgradeProgress) < EMS.RF.MarketLimit then
			EMS.RF.GUIAction_UpgradeSelectedBuilding_ML();
		end
	end
	
	EMS.RF.UpgradeSingleBuilding_ML = GUI.UpgradeSingleBuilding;
	GUI.UpgradeSingleBuilding = function(_entity)
		local sel = _entity;
		if not EMS.PlayerList[GetPlayer(sel)] then
			return EMS.RF.UpgradeSingleBuilding_ML(sel);
		end
		if Logic.GetEntityType(sel) == Entities.PB_Market1 then
			if not EMS.RF.MarketLimit_BuildingsInUpgradeProgress[sel] then
				EMS.RF.MarketLimit_BuildingsInUpgradeProgress[sel] = true;
			else
				return;
			end
			if (EMS.RF.MarketLimitCount[GUI.GetPlayerID()]+EMS.RF.MarketLimit_InUpgradeProgress) < EMS.RF.MarketLimit then
				EMS.RF.MarketLimit_InUpgradeProgress = EMS.RF.MarketLimit_InUpgradeProgress + 1;
				EMS.RF.UpgradeSingleBuilding_ML(sel);
			end
			return;
		end
		EMS.RF.UpgradeSingleBuilding_ML(sel);
	end
	
	EMS.RF.GUITooltip_UpgradeBuilding_ML = GUITooltip_UpgradeBuilding;
	GUITooltip_UpgradeBuilding = function(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType)
		EMS.RF.GUITooltip_UpgradeBuilding_ML(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType);
		if _BuildingType == Entities.PB_Market1 then
			if _TechnologyType ~= nil then
				local TechState = Logic.GetTechnologyState(GUI.GetPlayerID(), _TechnologyType)			
				if TechState == 0 then
					return;
				end
			end
			if Logic.GetTechnologyState(GUI.GetPlayerID(), Technologies.GT_Trading) ~= 4 then
				return;
			end
			local currentBuildings = EMS.RF.MarketLimitCount[GUI.GetPlayerID()] + EMS.RF.MarketLimit_InUpgradeProgress;
			local color;
			if currentBuildings < EMS.RF.MarketLimit then
				color = " @color:0,255,0 ";
			else
				color = " @color:255,0,0 ";
			end
			local oldToolTip = XGUIEng.GetStringTableText("MenuMarket/UpgradeMarket1_normal");
			local start, ende = string.find(oldToolTip, "@cr");
			start = start or 0;
			ende = ende or 0;
			local newToolTip = string.sub(oldToolTip, 1, start-1) .. color .. "("..currentBuildings.."/"..EMS.RF.MarketLimit..") @cr "
								.. string.sub(oldToolTip, ende+1);
			XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomText, newToolTip);
		end
	end
	
end

function EMS.RF.ActivateTradeLimit(_limit)
	EMS.RF.TradeLimit = _limit;
end

function EMS.RF.ActivateTowerLimit(_limit)
	EMS.RF.TowerLimit = _limit;
	EMS.RF.TowerLimit_LastCreated = {};
	EMS.RF.TowerLimit_InUpgradeProgress = {};
	EMS.RF.TowerLimitJob = 0;
	EMS.RF.TowerLimit_BuildingsInUpgradeProgress = {}
	
	local towers = {};
	EMS.RF.TowerLimitCount = {};
	for playerId, data in pairs(EMS.PlayerList) do
		EMS.RF.TowerLimitCount[playerId] = 0;
		for i = 2,5 do
			if i < 4 then
				towers = EMS.T.GetPlayerEntities(playerId, Entities["PB_Tower"..i]);
			else
				towers = EMS.T.GetPlayerEntities(playerId, Entities["PB_DarkTower"..(i-2)]);
			end
			EMS.RF.TowerLimitCount[playerId] = EMS.RF.TowerLimitCount[playerId] + table.getn(towers);
		end
	end
	
	EMS.RF.IsTower = function(_Id)
		local type = Logic.GetEntityType(_Id)
		if type == Entities.PB_Tower2
		or type == Entities.PB_Tower3
		or type == Entities.PB_DarkTower2
		or type == Entities.PB_DarkTower3 then
			return true;
		end
		return false;
	end
	
	EMS.RF.IsLvl1Tower = function(_Id)
		local type = Logic.GetEntityType(_Id)
		if type == Entities.PB_Tower1
		or type == Entities.PB_DarkTower1 then
			return true;
		end
		return false;
	end
	
	EMS.RF.IsLvl2Tower = function(_Id)
		local type = Logic.GetEntityType(_Id)
		if type == Entities.PB_Tower2
		or type == Entities.PB_DarkTower2 then
			return true;
		end
		return false;
	end
	
	EMS_RF_TowerLimit_EntityCreated = function()
		local Id = Event.GetEntityID();
		local pId = Logic.EntityGetPlayer(Id);
		if not EMS.PlayerList[pId] or not EMS.RF.IsTower(Id) then
			return;
		end
		if EMS.RF.TowerLimitCount[pId] > EMS.RF.TowerLimit then
			table.insert(EMS.RF.TowerLimit_LastCreated,Id);
			if EMS.RF.TowerLimitJob == 0 then
				EMS.RF.TowerLimitJob = StartSimpleHiResJob("EMS_RF_TowerLimit_DestroyEntity");
			end
		else
			EMS.RF.TowerLimitCount[pId] = EMS.RF.TowerLimitCount[pId] + 1;
		end
	end
	
	EMS_RF_TowerLimit_EntityDestroyed = function()
		local Id = Event.GetEntityID();
		if EMS.RF.TowerLimit_InUpgradeProgress[Id] then
			EMS.RF.TowerLimit_InUpgradeProgress[Id] = nil;
		end
		local pId = Logic.EntityGetPlayer(Id);
		if not EMS.RF.IsTower(Id) or not EMS.PlayerList[pId] then
			return;
		end
		if EMS.RF.TowerLimitCount[pId] > 0 then
			EMS.RF.TowerLimitCount[pId] = EMS.RF.TowerLimitCount[pId] - 1;
		end
	end
	
	EMS_RF_TowerLimit_DestroyEntity = function()
		for i = 1, table.getn(EMS.RF.TowerLimit_LastCreated) do
			DestroyEntity(EMS.RF.TowerLimit_LastCreated[i]);
		end
		EMS.RF.TowerLimitJob = 0;
		return true;
	end
	
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_CREATED, "", "EMS_RF_TowerLimit_EntityCreated", 1);
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_DESTROYED, "", "EMS_RF_TowerLimit_EntityDestroyed", 1);
	
	EMS.RF.GameCallback_OnBuildingUpgradeComplete_TL = GameCallback_OnBuildingUpgradeComplete;
	GameCallback_OnBuildingUpgradeComplete = function(_oId, _nId)
		if EMS.RF.TowerLimit_InUpgradeProgress[_oId] then
			EMS.RF.TowerLimit_InUpgradeProgress[_oId] = nil;
		end
		if EMS.RF.TowerLimit_BuildingsInUpgradeProgress[_oId] then
			EMS.RF.TowerLimit_BuildingsInUpgradeProgress[_oId] = nil;
		end
		EMS.RF.GameCallback_OnBuildingUpgradeComplete_TL(_oId, _nId);
	end
	
	EMS.RF.GUIAction_CancelUpgrade_TL = GUIAction_CancelUpgrade;
	GUIAction_CancelUpgrade = function()
		local sel = GUI.GetSelectedEntity();
		if EMS.RF.TowerLimit_InUpgradeProgress[sel] then
			EMS.RF.TowerLimit_InUpgradeProgress[sel] = nil;
		end
		if EMS.RF.TowerLimit_BuildingsInUpgradeProgress[sel] then
			EMS.RF.TowerLimit_BuildingsInUpgradeProgress[sel] = nil;
		end
		EMS.RF.GUIAction_CancelUpgrade_TL();
	end
	
	EMS.RF.GUIAction_UpgradeSelectedBuilding_TL = GUIAction_UpgradeSelectedBuilding;
	GUIAction_UpgradeSelectedBuilding = function()
		local sel = GUI.GetSelectedEntity();
		if not EMS.RF.IsLvl1Tower(sel) then
			EMS.RF.GUIAction_UpgradeSelectedBuilding_TL();
			return;
		end
		local inUpgradeCount = 0;
		for k,v in pairs(EMS.RF.TowerLimit_InUpgradeProgress) do
			inUpgradeCount = inUpgradeCount + 1;
		end
		if (EMS.RF.TowerLimitCount[GUI.GetPlayerID()]+inUpgradeCount) < EMS.RF.TowerLimit then
			EMS.RF.GUIAction_UpgradeSelectedBuilding_TL();
		end
	end
	
	EMS.RF.UpgradeSingleBuilding_TL = GUI.UpgradeSingleBuilding;
	GUI.UpgradeSingleBuilding = function(_entity)
		local sel = _entity;
		if not EMS.PlayerList[GetPlayer(sel)] then
			return EMS.RF.UpgradeSingleBuilding_TL(sel);
		end
		if EMS.RF.IsLvl1Tower(sel) then
			if not EMS.RF.TowerLimit_BuildingsInUpgradeProgress[sel] then
				EMS.RF.TowerLimit_BuildingsInUpgradeProgress[sel] = true;
			else
				return;
			end
			local inUpgradeCount = 0;
			for k,v in pairs(EMS.RF.TowerLimit_InUpgradeProgress) do
				inUpgradeCount = inUpgradeCount + 1;
			end
			if (EMS.RF.TowerLimitCount[GUI.GetPlayerID()]+inUpgradeCount) < EMS.RF.TowerLimit then
				EMS.RF.TowerLimit_InUpgradeProgress[sel] = true;
				EMS.RF.UpgradeSingleBuilding_TL(sel);
			end
			return;
		end
		EMS.RF.UpgradeSingleBuilding_TL(sel);
	end
	
	EMS.RF.GUITooltip_UpgradeBuilding_TL = GUITooltip_UpgradeBuilding;
	GUITooltip_UpgradeBuilding = function(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType)
		EMS.RF.GUITooltip_UpgradeBuilding_TL(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType);
		local towerLvl = 1;
		if _BuildingType == Entities.PB_Tower1 or _BuildingType == Entities.PB_DarkTower1 then
			if _TechnologyType ~= nil then
				local TechState = Logic.GetTechnologyState(GUI.GetPlayerID(), _TechnologyType)			
				if TechState == 0 then
					return;
				end
			end
			if Logic.GetTechnologyState(GUI.GetPlayerID(), Technologies.GT_GearWheel) ~= 4 then
				return;
			end
		elseif _BuildingType == Entities.PB_Tower2 or _BuildingType == Entities.PB_DarkTower2 then
			if _TechnologyType ~= nil then
				local TechState = Logic.GetTechnologyState(GUI.GetPlayerID(), _TechnologyType)			
				if TechState == 0 then
					return;
				end
			end
			if Logic.GetTechnologyState(GUI.GetPlayerID(), Technologies.GT_Metallurgy) ~= 4 then
				return;
			end
			towerLvl = 2;
		else
			return;
		end
		local inUpgradeCount = 0;
		for k,v in pairs(EMS.RF.TowerLimit_InUpgradeProgress) do
			inUpgradeCount = inUpgradeCount + 1;
		end
		local currentBuildings = EMS.RF.TowerLimitCount[GUI.GetPlayerID()] + inUpgradeCount;
		local color;
		if currentBuildings < EMS.RF.TowerLimit or towerLvl == 2 then
			color = " @color:0,255,0 ";
		else
			color = " @color:255,0,0 ";
		end
		local oldToolTip = XGUIEng.GetStringTableText("MenuTower/UpgradeTower"..towerLvl.."_normal");
		local start, ende = string.find(oldToolTip, "@cr");
		start = start or 0;
		ende = ende or 0;
		local newToolTip = string.sub(oldToolTip, 1, start-1) .. color .. "("..currentBuildings.."/"..EMS.RF.TowerLimit..") @cr "
							.. string.sub(oldToolTip, ende+1);
		XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomText, newToolTip);
	end
end

function EMS.RF.ActivateWeatherLockTimer(_time)
	EMS.RF.WLT = {};
	EMS.RF.WLT.CooldownMax = _time*60;
	EMS.RF.WLT.Cooldown = 0;
	
	EMS.RF.WLT.GameCallback_SetWeather = GameCallback_SetWeather;
	GameCallback_SetWeather = function(_weather)
		EMS.RF.WLT.LockWeatherChange();
		EMS.RF.WLT.GameCallback_SetWeather(_weather);
	end
	
	EMS.RF.WLT.LockWeatherChange = function()
		if not EMS.RF.WLT.IsAlreadyActive then
			EMS.RF.WLT.Cooldown = EMS.RF.WLT.CooldownMax;
			StartSimpleJob("EMS_RF_WLT_Counter");
			EMS.RF.WLT.IsAlreadyActive = true
		end
	end
	EMS_RF_WLT_Counter = function()
		if EMS.RF.WLT.Cooldown > 0 then
			EMS.RF.WLT.Cooldown = EMS.RF.WLT.Cooldown - 1;
			return;
		end
		EMS.RF.WLT.IsAlreadyActive = false
		return true;                
	end
	
	EMS.RF.WLT.GUIUpdate_ChangeWeatherButtons = GUIUpdate_ChangeWeatherButtons;
	GUIUpdate_ChangeWeatherButtons = function(_Button, _Technology,_WeatherState)
		EMS.RF.WLT.GUIUpdate_ChangeWeatherButtons(_Button, _Technology,_WeatherState);
		if EMS.RF.WLT.Cooldown > 0 then
			XGUIEng.DisableButton(_Button, 1);
		end
	end
	
	EMS.RF.WLT.GUITooltip_ResearchTechnologies = GUITooltip_ResearchTechnologies;
	GUITooltip_ResearchTechnologies = function(_TechnologyType,_Tooltip, _ShortCut)
		EMS.RF.WLT.GUITooltip_ResearchTechnologies(_TechnologyType,_Tooltip, _ShortCut);
		if EMS.RF.WLT.Cooldown == 0 then
			return;
		end
		if not string.find(_Tooltip, "MenuWeathermachine/") then
			return;
		end
		local TechState = Logic.GetTechnologyState(GUI.GetPlayerID(), _TechnologyType)	
		if not (TechState == 2 or TechState == 3) then 	
			return;
		end
		local oldToolTip = XGUIEng.GetStringTableText(_Tooltip.."_normal");
		local start, ende = string.find(oldToolTip, "@cr");
		start = start or 0;
		ende = ende or 0;
		local newToolTip = string.sub(oldToolTip, 1, start-1) .. " @color:255,0,0 ("..EMS.RF.WLT.Cooldown..") @cr "
							.. string.sub(oldToolTip, ende+1);
		XGUIEng.SetText(gvGUI_WidgetID.TooltipBottomText, newToolTip)
	end
	
	if CNetwork then
		local Network_WeatherChange = {};
		CNetwork.SetNetworkHandler("SetWeather", 
			function(name, _playerID, _weatherType)
				if CNetwork.IsAllowedToManipulatePlayer(name, _playerID) then
					-- TODO check technology
					local time = Logic.GetTime();
					
					Network_WeatherChange[_playerID] = Network_WeatherChange[_playerID] or (- EMS.RF.WLT.CooldownMax - 1);
					
					local timepassed = time - Network_WeatherChange[_playerID];
						
					if timepassed >= EMS.RF.WLT.CooldownMax then
						SendEvent.SetWeather(_playerID, _weatherType);
						Network_WeatherChange[_playerID] = time;
						
						if GUI.GetPlayerID() == _playerID then
							EMS.RF.WLT.Cooldown = EMS.RF.WLT.CooldownMax;
						end;
					end;
				end;
			end
		);
	end;
end

function EMS.RF.ActivateGameMode(_gameModeIndex)
	EMS.RD.AdditionalConfig.Callback_GameModeSelected(_gameModeIndex);
end