ReconnectTool = {
	StartedReconnect = false,
	LastActionTimestamp = 0,
	DelayNextAction = 0,
	CurrentActionIndex = 0,
	Text = " Verbindung verloren ",
	Started = false,
	GameNotOpenAnymore = false,
	Actions =
	{
		[1] = function()
			CUtil.SetGameTimeFactor(1);
			XNetworkUbiCom.Manager_Destroy();
			XNetworkUbiCom.Manager_Create();
			ReconnectTool.Started = true;
			ReconnectTool.Text = " Verbinden ";
			XGUIEng.ShowWidget("ReconnectToolState",1);
			XNetworkUbiCom.Manager_LogIn_Connect();
			XNetworkUbiCom.Manager_LogIn_Start();
			return 1;
		end,
		
		[2] = function()
			XNetworkUbiCom.Lobby_Group_Enter(NETWORK_GAME_LOBBY);
			if XNetworkUbiCom.Lobby_Group_GetIndexOfCurrent() == -1 then
				ReconnectTool.GameNotOpenAnymore = true;
				return 1;
			end
			XNetwork.Chat_SendMessageToAll(".join");
			CNetwork.set_ready();
			CNetwork.send_need_ticks(Network_GetLastTickReceived() + 2000);
			CNetwork.receive_async_commands();
			-- reset params
			ReconnectTool.Started = false;
			ReconnectTool.CurrentActionIndex = 0;
			-- update GUI
			ReconnectTool.Text = " @color:0,255,0 Verbunden! ";
			XGUIEng.SetText( "ReconnectToolState", ReconnectTool.Text);
			XGUIEng.ShowWidget("ReconnectToolState",0);
			return 1;
		end,
	},
};

function ReconnectTool.UpdateEveryFrame()
	if not CNetwork then
		return;
	end
	if not ReconnectTool.Started then
		if table.getn(GetIngamePlayers()) > 0 then
			return;
		end
		if table.getn(GetSpectators()) > 0 then
			return;
		end
	end
	if ReconnectTool.GameNotOpenAnymore then
		XGUIEng.SetText( "ReconnectToolState", " @color:255,0,0 Spiel auf Kimichuras Server nicht mehr offen! Kann nicht verbinden! ");
		return;
	end
	-- disconnected => reconnect
	local currentTimestamp = math.floor(XGUIEng.GetSystemTime());
	local delay = currentTimestamp - ReconnectTool.LastActionTimestamp;
	XGUIEng.SetText( "ReconnectToolState", "("..ReconnectTool.CurrentActionIndex.."/"..table.getn(ReconnectTool.Actions).." "..ReconnectTool.Text.." in "..(ReconnectTool.DelayNextAction-delay));
	if delay > ReconnectTool.DelayNextAction then
		-- update timestamp
		ReconnectTool.LastActionTimestamp = currentTimestamp;
		-- next action
		ReconnectTool.CurrentActionIndex = ReconnectTool.CurrentActionIndex + 1;
		-- execute
		local res = ReconnectTool.Actions[ReconnectTool.CurrentActionIndex]();
		if res ~= 1 then
			-- action failed
			ReconnectTool.CurrentActionIndex = 0;
			ReconnectTool.DelayNextAction = 5;
			ReconnectTool.Text = " @color:255,0,0 Fehlgeschlagen! ";
			return;
		end
		ReconnectTool.DelayNextAction = 2;
	end
end
