-- ************************************************************************************************ 
-- *                                                                                              * 
-- *                                                                                              * 
-- *                                             EMS                                              * 
-- *                                  Enhanced Multiplayer Script                                 * 
-- *                                                                                              * 
-- *                                                                                              * 
-- ************************************************************************************************ 
EMS = {};
EMS.Version = 0.70;

-- compability with MCS
MCS = EMS;

initEMS = function()return true end;

LuaDebugger = LuaDebugger or {};
LuaDebugger.Log = LuaDebugger.Log or function(_txt) Message("Log " .. tostring(_txt)) end;

function GameCallback_OnGameStart()
	if XNetwork.Manager_DoesExist() == 0 then		
		for i=1,1,1 do
			--MultiplayerTools.DeleteFastGameStuff(i)
		end
		local PlayerID = GUI.GetPlayerID()
		Logic.PlayerSetIsHumanFlag( PlayerID, 1 )
		Logic.PlayerSetGameStateToPlaying( PlayerID )
	end
	EMS.Setup()
end

function EMS.Setup()
	if EMS.SetupDone then
		return;
	end
	EMS.SetupDone = true;
	
	if CNetwork then
		EMS.UseCNetwork = true;
	end
	
	--Include global tool script functions
	local files = {
		"Ai\\Support",
		"extra2comfort",
		"Comfort",
		"Tools",
		"WeatherSets",
		"GlobalMissionScripts",
		"Quests",
		"Information",
		"NPC",
	};
	table.foreach(files,function(_,_value)Script.Load("Data\\Script\\MapTools\\".._value..".lua")end);

	Script.Load("maps\\user\\EMSconfigs\\"..Framework.GetCurrentMapName()..".lua");
	
	-- language
	Script.Load("maps\\user\\EMS\\ems_language.lua");
	-- global values
	Script.Load("maps\\user\\EMS\\ems_globalvalues.lua");
	-- tools
	Script.Load("maps\\user\\EMS\\ems_tools.lua");
	-- anti cheat
	Script.Load("maps\\user\\EMS\\ems_anticheat.lua");
	-- rule data
	Script.Load("maps\\user\\EMS\\ems_ruledata.lua");
	-- rule functions
	Script.Load("maps\\user\\EMS\\ems_rulefunctions.lua");
	-- GUI Legenden
	Script.Load("maps\\user\\EMS\\ems_guil.lua");
	-- GUI Changes
	Script.Load("maps\\user\\EMS\\ems_gc.lua");
	-- QoL
	Script.Load("maps\\user\\EMS\\ems_qol.lua");
	-- Debug
	Script.Load("maps\\user\\EMS\\ems_debug.lua");
	-- CNetwork
	Script.Load("maps\\user\\EMS\\ems_cnetwork.lua");
	
	if CNetwork and not EMS.T.IsMultiplayer() then
		GUI.AddStaticNote("@color:255,0,0 Do not start EMS on Kimichuras server in single player!");
		return;
	end

	EMS.LoadToolFolder();
	
	InstallS5Hook();
	
	if not EMS.UseCNetwork then
		ChatCallbackKey = function(_key)
			if not EMS.T.IsMultiplayer() then
				return;
			end
			if _key == 99 then
				if not EMS.GL.CustomChatInputObj.IsOpen then
					EMS.GL.CustomChatInputObj:Open();
				end
			end
		end
		CTH.RegisterCT(ChatCallbackKey)
	end
	
	-- first, load new gui.
	EMS.GL.LoadGUI();
	
	
	
	-- cnetwork
	-- dependeny: CNetwork before GL
	EMS.CN.Setup();
	-- tools
	EMS.T.Setup();
	-- language
	EMS.L.Setup()
	-- global values
	EMS.GV.Setup();
	-- anti cheat
	EMS.AC.Setup();
	-- rule data
	EMS.RD.Setup(EMS_CustomMapConfig);
	-- rule functions
	EMS.RF.Setup();
	-- GUI Legenden
	EMS.GL.Setup();
	-- GUI Changes
	EMS.GC.Setup();
	-- Quality of Life
	EMS.QoL.Setup();
	-- Debug
	if ems_debug then
		EMS.D.Setup();
	end
	
	EMS.T.SetupBugfixes();
	
	EMS.MapStarted()

	-- call this after map started callback to intervene
	EMS.T.SetupMPLogic();
	
	-- Dependency: Call Sync.Init after Gui because GUI redefines Message Callback
	Sync.Init();
	
	StartSimpleJob("EMS_Delayed");
end

function EMS.LoadToolFolder()
	local files = {
		"CharTriggerHandle",
		"CommonComforts",
		"CustomTextInput",
		"Maptools",
		"OSIHandle",
		"S5Hook",
		"Sync",
		"WeatherSets",
	};
	table.foreach(files,function(_,_value)Script.Load("maps\\user\\EMS\\tools\\".._value..".lua")end);
end

function EMS.MapStarted()
	-- prevent direct start
	EMS.T.RemoveVillageCenters();
	EMS.T.SetPlayerEntitiesNonSelectable();
	for playerId, data in pairs(EMS.PlayerList) do
		Logic.SetPlayerPaysLeaderFlag(playerId, 0);
	end
	EMS.RD.AdditionalConfig.Callback_OnMapStart();
end

function EMS.StartGame()
	-- called after start countdown
	EMS.GV.GameStarted = true;
	Sound.PlayGUISound(Sounds.fanfare, 50);
	-- revert start preventions
	EMS.T.SetPlayerEntitiesSelectable();
	EMS.T.RecreateVillageCenters();
	for playerId, data in pairs(EMS.PlayerList) do
		Logic.SetPlayerPaysLeaderFlag(playerId, 1);
	end
	EMS.RD.AdditionalConfig.Callback_OnGameStart();
	for k, v in pairs(EMS.RD.Rules) do
        if type(v) == "table" and v.Evaluate then
            v:Evaluate();
        end
    end
	-- show hero button
	GUIUpdate_BuyHeroButton();
end

function EMS.EndPeacetime(_noFeedback)
	EMS.T.UpdateDiplomacy(Diplomacy.Friendly, Diplomacy.Hostile);
	EMS.RD.AdditionalConfig.Callback_OnPeacetimeEnded();
	if _noFeedback then
		return;
	end
	Sound.PlayGUISound(Sounds.OnKlick_Select_kerberos, 50);
	Sound.PlayGUISound(Sounds.VoicesMentor_MP_PeaceTimeOver_rnd_01, 50);
	Message("@color:255,255,0 " .. EMS.L.PeacetimeEnded);
end

function EMS_Delayed()
	-- to overwrite simis stuff
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
	
	-- reset colors in loaded games
	for playerId, data in pairs(EMS.PlayerList) do
		Display.SetPlayerColorMapping( playerId, XNetwork.GameInformation_GetLogicPlayerColor(playerId));
	end
	
	if EMS.T.IsMultiplayer() then
		for playerId = 1, XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer() do
			if XNetwork.GameInformation_IsHumanPlayerAttachedToPlayerID(playerId) == 1 then
				Logic.SetPlayerRawName( playerId, XNetwork.GameInformation_GetLogicPlayerUserName( playerId ) );
				Logic.PlayerSetGameStateToPlaying(playerId);
				Logic.PlayerSetIsHumanFlag(playerId, 1);
				
				local r,g,b = GUI.GetPlayerColor( playerId );
				Logic.PlayerSetPlayerColor( playerId, r, g, b);

				-- reset player color
				EMS.PlayerList[playerId] = EMS.T.GetPlayerInformation(playerId);
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
	
	-- update gui, for some reason thats necessary on simis server
	EMS.GL.UpdatePlayerNames();
	EMS.GL.UpdateGameDate();
	EMS.VersionCheck.Setup();
	return true;
end

EMS.VersionCheck = {};
function EMS.VersionCheck.Setup()
	EMS.VersionCheck.Players = {};
	EMS.VersionCheck.MyEMSVersion = EMS.Version;
	EMS.VersionCheck.MyConfigVersion = EMS.RD.AdditionalConfig.ConfigVersion;
	
	EMS.VersionCheck.GetNetworkAdress = function()
		if EMS.T.IsMultiplayer() then
			return XNetwork.UserInSession_GetUserNameByNetworkAddress(XNetwork.Manager_GetLocalMachineNetworkAddress());
		else
			return UserTool_GetPlayerName(1);
		end
	end
	
	EMS.VersionCheck.SetVersionForPlayer = function(_playerName, _emsVersion, _configVersion)
		EMS.VersionCheck.Players[_playerName] =
		{
			EMSVersion = _emsVersion,
			ConfigVersion = _configVersion,
		};
		EMS.VersionCheck.CheckVersion();
	end
	
	EMS.VersionCheck.VersionOutdated = function(_playerName, _version1, _version2)
		return  " @color:255,255,255 " .. _playerName .. " - @color:255,72,53 " .. tostring(_version1) .. " / " .. tostring(_version2) .. " @cr ";
	end
	
	EMS.VersionCheck.CheckVersion = function()
		local versionDifference = false;
		local breakMe = false;
		for PlayerIndex, VersionInfo in pairs(EMS.VersionCheck.Players) do
			breakMe = false;
			for PlayerIndex2, VersionInfo2 in pairs(EMS.VersionCheck.Players) do
				if VersionInfo.EMSVersion ~= VersionInfo2.EMSVersion
				or VersionInfo.ConfigVersion ~= VersionInfo2.ConfigVersion then
					versionDifference = true;
					breakMe = true;
					break;
				end
			end
			if breakMe then break; end
		end
		
		if not versionDifference then
			EMS.GL.RuleOverviewShowRules();
			return;
		end

		local versions = "";
		for PlayerIndex, VersionInfo in pairs(EMS.VersionCheck.Players) do
			versions = versions .. EMS.VersionCheck.VersionOutdated(PlayerIndex, VersionInfo.EMSVersion, VersionInfo.ConfigVersion);
		end

		EMS.GL.RuleOverviewSetCustom("@color:255,72,53 @center " .. EMS.L.VersionsDifferent, versions);
		EMS.GL.RuleOverviewShowCustom();
	end
	
	local delay = 5;
	EMS_VersionCheck_Delay = function()
		if delay > 0 then
			delay = delay - 1;
			return;
		end
		Sync.CallNoSync("EMS.VersionCheck.RequestVersions");
		return true;
	end
	StartSimpleJob("EMS_VersionCheck_Delay");
	
	EMS.VersionCheck.RequestVersions = function()
		local playerIndex = EMS.VersionCheck.GetNetworkAdress();
		local emsVersion = EMS.VersionCheck.MyEMSVersion;
		local configVersion = EMS.VersionCheck.MyConfigVersion;
		
		if EMS.T.IsLocalPlayerSpectator() then
			-- spectators will only set their own version for them else - no one else cares about their version
			EMS.VersionCheck.SetVersionForPlayer(playerIndex, emsVersion, configVersion);
			return;
		end
		-- players will share their version with the others
		Sync.CallNoSync("EMS.VersionCheck.SetVersionForPlayer", playerIndex, emsVersion, configVersion);
	end
end
