-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                          	 DEBUG                                            * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --
EMS.D = {};

function EMS.D.Setup(_customFunc1, _customFunc2)
	
	if EMS.D.InitDone then
		return;
	end
	EMS.D.InitDone = true;
	
	-- show debug button info window
	XGUIEng.ShowWidget("EMSDebug2", 1);
	
	Message("@color:255,80,80 ----------- ems debug mode is active -----------");
	
	EMS.D.MaxPlayers = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer();
	if EMS.D.MaxPlayers == 0 then EMS.D.MaxPlayers = 1 end
	
	local debugInfo = "Debug keybinds: @cr ";
	local addKeyBind = function(_key, _keyInfo)
		debugInfo = debugInfo .. " @color:255,215,0 " .. _key .. " @color:255,255,255 - " .. _keyInfo .. " @cr ";
	end
	
	addKeyBind("Q", "Speedup the game (Not on Kimichuras server, use his GUI there instead)");
	addKeyBind("R", "Restart the map immediately (only works in Singleplayer)");
	addKeyBind("L", "Global map vision for target1");
	addKeyBind("Alt + 1-8", "Set current target to player id to 1-8. Press one of the buttons to change current target.");
	addKeyBind("A", "Spawn Bow target 1");
	addKeyBind("S", "Spawn Bow target 2");
	addKeyBind("Y", "Spawn Sword target 1");
	addKeyBind("X", "Spawn Sword target 2");
	addKeyBind("W", "Spawn Serf target 1");
	addKeyBind("C", "Delete all spawned troops");
	addKeyBind("U", "Research all university technologies for target 1");
	addKeyBind("E", "Toggle unlimited resources for target1");
	
	addKeyBind("N", "Call custom function 1");
	addKeyBind("M", "Call custom function 2");
	
	if CNetwork then
		addKeyBind("Shift + 1-8", "Set current target to player id to 9-16");
	end
	
	XGUIEng.SetText("EMSD2Info", debugInfo);
	
	
	-- key binds
	-- the id the operations are performed on
	EMS.D.CurrentTargetPlayerIdSet = 1; -- the target player id that is changed
	
	EMS.D.TargetPlayerId = {GUI.GetPlayerID(), 2}; -- the target player ids
	XGUIEng.SetText("EMSD2TargetPlayerId1", "Target1: "..EMS.D.TargetPlayerId[1]);
	XGUIEng.SetText("EMSD2TargetPlayerId2", "Target2: "..EMS.D.TargetPlayerId[2]);
	
	for i = 1, 8 do
		Input.KeyBindDown(Keys.ModifierAlt + Keys["D"..i], "EMS.D.SetTargetPlayer("..i..")");
	end
	if CNetwork then
		for i = 9, 16 do
			Input.KeyBindDown(Keys.ModifierShift + Keys["D"..(i-8)], "EMS.D.SetTargetPlayer("..i..")");
		end
	end
	
	Input.KeyBindDown(Keys.Q, "SpeedUpGame()", 2);
	Input.KeyBindDown(Keys.R, "Framework.RestartMap()", 2);
	
	Input.KeyBindDown(Keys.L, "Sync.Call('EMS.D.ToggleVision', EMS.D.TargetPlayerId[1])", 2);
	
	Input.KeyBindDown(Keys.A, "Sync.Call('EMS.D.SpawnTroop', GUI.GetPlayerID(), EMS.D.TargetPlayerId[1], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2], Entities.PU_LeaderBow4)", 2);
	Input.KeyBindDown(Keys.S, "Sync.Call('EMS.D.SpawnTroop', GUI.GetPlayerID(), EMS.D.TargetPlayerId[2], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2], Entities.PU_LeaderBow4)", 2);
	
	Input.KeyBindDown(Keys.Y, "Sync.Call('EMS.D.SpawnTroop', GUI.GetPlayerID(), EMS.D.TargetPlayerId[1], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2], Entities.PU_LeaderSword4)", 2);
	Input.KeyBindDown(Keys.X, "Sync.Call('EMS.D.SpawnTroop', GUI.GetPlayerID(), EMS.D.TargetPlayerId[2], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2], Entities.PU_LeaderSword4)", 2);
	
	Input.KeyBindDown(Keys.W, "Sync.Call('EMS.D.CreateEntity', Entities.PU_Serf, ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2], 0, EMS.D.TargetPlayerId[1])", 2);

	Input.KeyBindDown(Keys.C, "Sync.Call('EMS.D.ClearTroops', GUI.GetPlayerID())", 2);
	
	Input.KeyBindDown(Keys.E, "Sync.Call('EMS.D.ToggleUnlimitedResources', EMS.D.TargetPlayerId[1])", 2);
	Input.KeyBindDown(Keys.U, "Sync.Call('EMS.D.ResearchAllUniversityTechnologies', EMS.D.TargetPlayerId[1])", 2);
	
	Input.KeyBindDown(Keys.N, "Sync.Call('EMS.D.CustomFunc1', GUI.GetPlayerID(), EMS.D.TargetPlayerId[1], EMS.D.TargetPlayerId[2], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2])", 2);
	Input.KeyBindDown(Keys.M, "Sync.Call('EMS.D.CustomFunc2', GUI.GetPlayerID(), EMS.D.TargetPlayerId[1], EMS.D.TargetPlayerId[2], ({GUI.Debug_GetMapPositionUnderMouse()})[1], ({GUI.Debug_GetMapPositionUnderMouse()})[2])", 2);
	
	-- overwrite custom funcs
	EMS.D.CustomFunc1 = _customFunc1 or function()end;
	EMS.D.CustomFunc2 = _customFunc2 or function()end;
	
	EMS.D.InitCNetworkHandler();
	return true;
end

function EMS.D.CustomFunc1(_fromPlayer, _target1, _target2, _x, _y)
end

function EMS.D.CustomFunc2(_fromPlayer, _target1, _target2, _x, _y)
end

function EMS.D.CreateEntity(_entity, _x, _y, _rot, _playerId)
	Logic.CreateEntity(_entity, _x, _y, _rot, _playerId);
end

function EMS.D.InitCNetworkHandler()
	if not CNetwork then
		return;
	end
	
	CNetwork.SetNetworkHandler("EMS.D.ToggleVision", function (_name, _player)
		EMS.D.ToggleVision(_player)
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.SpawnTroop", function (_name, _fromPlayer, _forPlayer, _x, _y, _leaderType)
		EMS.D.SpawnTroop(_fromPlayer, _forPlayer, _x, _y, _leaderType);
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.CreateEntity", function (_name, _entity, _x, _y, _rot, _playerId)
		EMS.D.CreateEntity(_entity, _x, _y, _rot, _playerId);
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.ClearTroops", function (_name, _fromPlayer)
		EMS.D.SpawnTroop(_fromPlayer);
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.ToggleUnlimitedResources", function (_name, _forPlayer)
		EMS.D.ToggleUnlimitedResources(_forPlayer)
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.ResearchAllUniversityTechnologies", function (_name, _forPlayer)
		EMS.D.ResearchAllUniversityTechnologies(_forPlayer)
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.CustomFunc1", function (_name, _fromPlayer, _target1, _target2, _x, _y)
		EMS.D.CustomFunc1(_fromPlayer, _target1, _target2, _x, _y);
	end)
	
	CNetwork.SetNetworkHandler("EMS.D.CustomFunc2", function (_name, _fromPlayer, _target1, _target2, _x, _y)
		EMS.D.CustomFunc2(_fromPlayer, _target1, _target2, _x, _y);
	end)
	
end

function EMS.D.ButtonCallback_SetChangeTarget(_id)
	EMS.D.CurrentTargetPlayerIdSet = _id;
end

function EMS.D.SetTargetPlayer(_playerId)
	EMS.D.DbgMsg("Set target " .. EMS.D.CurrentTargetPlayerIdSet .." to player id " .. _playerId);
	EMS.D.TargetPlayerId[EMS.D.CurrentTargetPlayerIdSet] = _playerId;
	XGUIEng.SetText("EMSD2TargetPlayerId1", "Target1: "..EMS.D.TargetPlayerId[1]);
	XGUIEng.SetText("EMSD2TargetPlayerId2", "Target2: "..EMS.D.TargetPlayerId[2]);
end

function EMS.D.ToggleVision(_player)
	EMS.D.VisionEntities = EMS.D.VisionEntities or {};
	EMS.D.VisionActive = EMS.D.VisionActive or {};
	if not EMS.D.VisionActive[_player] then
		EMS.D.VisionActive[_player] = true;
		local p = Logic.WorldGetSize()/2;
		EMS.D.VisionEntities[_player] = Logic.CreateEntity(Entities.XD_ScriptEntity,  p+_player, p+_player, 0, _player)
		Logic.SetEntityExplorationRange(EMS.D.VisionEntities[_player], 384);
		EMS.D.DbgMsg("Activate global vision for " .. UserTool_GetPlayerName(_player));
	else
		EMS.D.VisionActive[_player] = false;
		DestroyEntity(EMS.D.VisionEntities[_player]);
		EMS.D.DbgMsg("Deactivate global vision for ".. UserTool_GetPlayerName(_player));
	end
end

function EMS.D.ResearchAllUniversityTechnologies(_forPlayer)
	-- todo: make toggable
	EMS.D.DbgMsg("Research all university technologies for ".. UserTool_GetPlayerName(_forPlayer));
	ResearchAllUniversityTechnologies(_forPlayer);
end

function EMS.D.ToggleUnlimitedResources(_forPlayer)
	EMS.D.UnlimitedResources = EMS.D.UnlimitedResources or {};
	local g = 10000000;
	if not EMS.D.UnlimitedResources[_forPlayer] then
		EMS.D.DbgMsg("Activate unlimited resources for  ".. UserTool_GetPlayerName(_forPlayer));
		EMS.D.UnlimitedResources[_forPlayer] = true;
		Tools.GiveResouces(_forPlayer, g,g,g,g,g,g);
	else
		EMS.D.DbgMsg("Deactivate unlimited resources for  ".. UserTool_GetPlayerName(_forPlayer));
		EMS.D.UnlimitedResources[_forPlayer] = false;
		g = -g;
		Tools.GiveResouces(_forPlayer, g,g,g,g,g,g);
	end
end

EMS.D.Troops = {};
function EMS.D.SpawnTroop(_fromPlayer, _forPlayer, _x, _y, _leaderType)
	EMS.D.Troops[_fromPlayer] = EMS.D.Troops[_fromPlayer] or {};
	local entity = AI.Entity_CreateFormation(
			_forPlayer,
			_leaderType,
			0,
			8,
			_x, _y,
			0,0,
			0,
			0
		);
	table.insert(EMS.D.Troops[_fromPlayer], entity);
end

function EMS.D.ClearTroops(_fromPlayer)
	EMS.D.Troops[_fromPlayer] = EMS.D.Troops[_fromPlayer] or {};
	for i = 1, table.getn(EMS.D.Troops[_fromPlayer]) do
		DestroyEntity(EMS.D.Troops[_fromPlayer][i]);
	end
end

function EMS.D.DbgMsg(_text)
	Message("@color:255,80,80 (dbg) " .. _text);
end

function EMS.D.ButtonCallback_ToggleInfo()
	XGUIEng.ShowWidget("EMSD2Info", XGUIEng.IsWidgetShown("EMSD2Info") - 1);
end