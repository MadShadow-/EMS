-- ************************************************************************************************ --
-- *                                                                                              * --
-- *                                                                                              * --
-- *                                              EMS                                             * --
-- *                                           CNETWORK                                           * --
-- *                                                                                              * --
-- *                                                                                              * --
-- ************************************************************************************************ --

EMS = EMS or {};

EMS.CN = {};

function EMS.CN.Setup()

	if not CNetwork then
		return;
	end
	
	InputCallback_Char_Orig = InputCallback_Char;
	InputCallback_Char = function(_key)
		if IsWidgetReallyShown("EMSMenu") and _key ~= Keys.F1 and _key < 255 then
			CTH.CharTrigger(_key);
			if _key == Keys.C then
				if not EMS.GL.CustomChatInputObj.IsOpen then
					EMS.GL.CustomChatInputObj:Open();
				end
			end
			return;
		end;
		if InputCallback_Char_Orig then
			InputCallback_Char_Orig(_key);
		end
	end
	
	InputCallback_ConvertChar = function(_key, _shift)
		--LuaDebugger.Break();
		if _key >= string.byte("A") and _key <= string.byte("Z") then
			if _shift then
				return _key;
			else
				-- add offset for small letters
				return _key+32;
			end
		elseif _key == 219 then
			if _shift then
				return string.byte("?");
			else
				return string.byte("?");
			end
		elseif _key == 192 then
			if _shift then
				return string.byte("?");
			else
				return string.byte("?");
			end
		elseif _key == 222 then
			if _shift then
				return string.byte("?");
			else
				return string.byte("?");
			end
		elseif _key == 186 then
			if _shift then
				return string.byte("?");
			else
				return string.byte("?");
			end
		elseif _key >= 49 and _key <= 57 then
			if _shift then
				return _key - 16;
			else
				return _key;
			end
		elseif _key == 48 then
			if _shift then
				return string.byte("=");
			else
				return string.byte("0");
			end
		end
		return _key;
	end
	
	local InputCallback_KeyDown_O = InputCallback_KeyDown;
	function InputCallback_KeyDown(_ctrl, _shift, _alt, _key)
		if IsWidgetReallyShown("EMSMenu") and _key ~= Keys.F1 and _key < 255 then
			if _key == Keys.Up or _key == Keys.Down or _key == Keys.Left or _key == Keys.Right then
				if InputCallback_KeyDown_O then
					return InputCallback_KeyDown_O( _ctrl,_shift, _alt, _key);
				else
					return;
				end
			end
			CTH.CharTrigger(InputCallback_ConvertChar(_key, _shift));
			if _key == Keys.C then
				if not EMS.GL.CustomChatInputObj.IsOpen then
					EMS.GL.CustomChatInputObj:Open();
				end
			end
			return true;
		end;
		if InputCallback_KeyDown_O then
			return InputCallback_KeyDown_O( _ctrl,_shift, _alt, _key);
		end;
	end
	
	EMS.CN.SetEMSHandler();
	EMS.CN.SetMCSHandler();
	
	Sync.Call = function(_func, ...) CNetwork.SendCommand(_func, unpack(arg)) end
end

function EMS.CN.GetHost()
	return XNetwork.EXTENDED_GameInformation_GetHost();
end

function EMS.CN.SetValueSynced(_name, _rule, _value)
	if EMS.GV.GameStarted then
		return;
	end
	
	if _name == EMS.CN.GetHost() then
		EMS.GL.SetValueSynced(_rule, _value);
	end
end

function EMS.CN.ToggleSynced(_name, _rule)
	if EMS.GV.GameStarted then
		return;
	end
	
	if _name == EMS.CN.GetHost() then
		EMS.GL.ToggleSynced(_rule);
	end;
end

function EMS.CN.InitiateStart(_name)
	if EMS.GL.GameStarted then
		return;
	end
	
	if _name == EMS.CN.GetHost() then
		EMS.GL.InitiateStart();
	end
end

function EMS.CN.SetShareExploration(_name, _player, _player2, _flag)
	if CNetwork.IsAllowedToManipulatePlayer(_name, _player2) then
		EMS.T.SetShareExploration(_player, _player2, _flag);
	end
end

function EMS.CN.SetRulesByConfig(_name, _configTableString)
	if _name == EMS.CN.GetHost() then
		local config = Sync.StringToTable(_configTableString);
		EMS.GL.SetRulesByConfig(config);
	end
end

function EMS.CN.SetMCSHandler()
	-- compatibility of loading games with mcs namespace
	CNetwork.SetNetworkHandler("MCS.GL.SetValueSynced", function (_name, _rule, _value)
		EMS.CN.SetValueSynced(_name, _rule, _value);
	end)
	
	CNetwork.SetNetworkHandler("MCS.GL.ToggleSynced", function(_name, _rule)
		EMS.CN.ToggleSynced(_name, _rule);
	end)
	
	CNetwork.SetNetworkHandler("MCS.GL.InitiateStart", function(_name)
		EMS.CN.InitiateStart(_name);
	end)
	
	CNetwork.SetNetworkHandler("MCS_T_SetShareExploration", function(_name, _player, _player2, _flag)
		EMS.CN.SetShareExploration(_name, _player, _player2, _flag)
	end)
	
	CNetwork.SetNetworkHandler("MCS.GL.SetRulesByConfig", function(_name, _configTableString)			
		EMS.CN.SetRulesByConfig(_name, _configTableString)
	end)
end

function EMS.CN.SetEMSHandler()
	CNetwork.SetNetworkHandler("EMS.GL.SetValueSynced", function (_name, _rule, _value)
		EMS.CN.SetValueSynced(_name, _rule, _value);
	end)
	
	CNetwork.SetNetworkHandler("EMS.GL.ToggleSynced", function(_name, _rule)
		EMS.CN.ToggleSynced(_name, _rule);
	end)
	
	CNetwork.SetNetworkHandler("EMS.GL.InitiateStart", function(_name)
		EMS.CN.InitiateStart(_name);
	end)
	
	CNetwork.SetNetworkHandler("EMS_T_SetShareExploration", function(_name, _player, _player2, _flag)
		EMS.CN.SetShareExploration(_name, _player, _player2, _flag)
	end)
	
	CNetwork.SetNetworkHandler("EMS.GL.SetRulesByConfig", function(_name, _configTableString)			
		EMS.CN.SetRulesByConfig(_name, _configTableString)
	end)
end