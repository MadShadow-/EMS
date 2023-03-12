-- TODO:
-- fix EMS:
-- GUIUpdate functions should use GetRepresentative() instead of GetValue()
-- MapRuleToGUIWidget should only contain tables
-- AllowNegativeNumbers should not count the - sign as digit
-- stdbool should return bool instead of number
-- self:SetValue should not sheck if > 0 by defaul
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function EMS.GL.GetThresholdDescription(_string)
	return "Legt fest, ab welchem Noise Wert ".._string.." generiert werden. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Werte zwischen -1000 und 1000 sind möglich. Je größer der Abstand zum Wert darüber, desto mehr Fläche wird dieses Biom einnehmen. @cr Die Werte auf der linken Seite der Tabelle sollten nach unten hin größer werden, auf der rechten Seite kleiner. Ansonsten werden entsprechende Biome nicht generiert. @cr Die Optionen Flachland und Hochebenen gehören nicht dazu. Diesen Werten glätten die Terrainhöhe. @cr @cr @color:255,204,51,255 VORSICHT: @color:255,255,255,255 Wahlloses verstellen dieser Werte kann die Karte unspielbar machen."
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.GetAmountDescription(_string)
	return "Legt die Anzahl an ".._string.." je Spieler fest. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Rohstoffhaufen werden gleichmäßig in der Nähe von Schächten des gleichen Rohstofftyps verteilt."
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.GetContentDescription(_string)
	return "Legt die Anzahl an Rohstoffeinheiten in ".._string.." fest."
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function EMS.GL.GUIUpdate_Threshold(_rule)
	local widget = EMS.GL.MapRuleToGUIWidget[_rule];
	local value = EMS.GL.GetRule(_rule):GetRepresentative();
	if math.abs(value) >= 1000 then
		value = "-";
	end
	XGUIEng.SetText(widget[1], "@center "..value);
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function EMS.GL.GUIUpdate_Dummy(_string)
	--ignore
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.DbgShow_PlayerConfig()
	for i = 1,16 do
		XGUIEng.ShowWidget("RMG6Frame"..i, 1)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.GUIUpdate_PlayerConfig(_index, _text)
	
	local nplayers, players, nteams = RandomMapGenerator.UnpackPlayerConfig()
	local widget = "RMG6F".._index.."".._text
	
	if nplayers < _index then
		--XGUIEng.ShowWidget("RMG6Frame".._index, 0)
		if _text == "Name" then
			XGUIEng.SetText(widget, "")
		elseif _text == "Player" then
			XGUIEng.SetMaterialColor(widget, 0, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 1, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 2, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 3, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 4, 0, 0, 0, 0)
		elseif _text == "Team" then
			XGUIEng.SetText(widget, "")
		elseif _text == "Add" then
			XGUIEng.DisableButton(widget, 1)
			XGUIEng.ShowWidget("RMG6F".._index.."Remove", 0)
		elseif _text == "Remove" then
			XGUIEng.ShowWidget(widget, 0)
			XGUIEng.ShowWidget("RMG6F".._index.."Add", 1)
		end
		return
	end
	
	local p = players[_index].id
	local ishuman = players[_index].ishuman == 1
	
	if _text == "Name" then
		if ishuman then
			if XNetwork.Manager_DoesExist() == 1 then
				XGUIEng.SetText(widget, "@center".." "..XNetwork.GameInformation_GetLogicPlayerUserName(p))
			else
				XGUIEng.SetText(widget, "@center".." "..p)
			end
		else
			XGUIEng.SetText(widget, "@center Dummy")
		end
	elseif _text == "Player" then
		if ishuman then
			local r, g, b = EMS.GL.GEN_GetPlayerColor( XNetwork.GameInformation_GetLogicPlayerColor(p) )
			XGUIEng.SetMaterialColor(widget, 0, r, g, b, 255)
			XGUIEng.SetMaterialColor(widget, 1, r, g, b, 255)
			XGUIEng.SetMaterialColor(widget, 2, r, g, b, 255)
			XGUIEng.SetMaterialColor(widget, 3, r, g, b, 255)
			XGUIEng.SetMaterialColor(widget, 4, r, g, b, 255)
		else
			XGUIEng.SetMaterialColor(widget, 0, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 1, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 2, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 3, 0, 0, 0, 0)
			XGUIEng.SetMaterialColor(widget, 4, 0, 0, 0, 0)
		end
	elseif _text == "Team" then
		XGUIEng.SetText(widget, "@center Team"..players[_index].team)
	elseif _text == "Add" then
		if ishuman then
			XGUIEng.DisableButton(widget, 0)
			XGUIEng.ShowWidget(widget, 1)
			XGUIEng.ShowWidget("RMG6F".._index.."Remove", 0)
		else
			XGUIEng.ShowWidget(widget, 0)
			XGUIEng.ShowWidget("RMG6F".._index.."Remove", 1)
		end
	elseif _text == "Remove" then
		if not ishuman then
			XGUIEng.DisableButton(widget, 0)
			XGUIEng.ShowWidget(widget, 1)
			XGUIEng.ShowWidget("RMG6F".._index.."Add", 0)
		else
			XGUIEng.ShowWidget(widget, 0)
			XGUIEng.ShowWidget("RMG6F".._index.."Add", 1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.AddDummyPlayer(_index)
	
	local nplayers, players = RandomMapGenerator.UnpackPlayerConfig()
	if nplayers < 16 then
		nplayers = nplayers + 1

		for i = nplayers, _index + 2, -1 do
			players[i] = players[i - 1]
		end
		players[_index + 1] = {id = 1, team = players[_index].team, ishuman = 0}
		
		RandomMapGenerator.PackPlayerConfig( nplayers, players )
		
		XGUIEng.ShowWidget("RMG6Frame"..nplayers, 1)
	end
	
	EMS.GL.DbgShow_PlayerConfig()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function EMS.GL.RemoveDummyPlayer(_index)
	
	local nplayers, players = RandomMapGenerator.UnpackPlayerConfig()
	nplayers = nplayers - 1
	
	for i = _index, nplayers, 1 do
		players[i] = players[i + 1]
	end
	players[nplayers + 1] = nil
	
	RandomMapGenerator.PackPlayerConfig( nplayers, players )
	
	EMS.GL.DbgShow_PlayerConfig()
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function EMS.GL.SetRandomSeed()
	
	if not EMS.CanChangeRules or EMS.GL.GameStarted then
		return;
	end
	
	-- XGUIEng.GetRandom ist Mist !
	--[[local seed = XGUIEng.GetRandom(31622)
	seed = seed + seed ^ 2
	
	if XGUIEng.GetRandom(1) == 1 then
		seed = -seed
	end]]
	
	EMS.GL.SetValue("RMG_Seed", RandomMapGenerator.GetRandomSeed(EMS.RD.Rules.RMG_Seed:GetValue()))
end

function EMS.GL.GEN_GetPlayerColor( _ColorID )

	if _ColorID == 1 then
		return 15, 64, 255
	elseif _ColorID == 2 then
		return 226, 0, 0
	elseif _ColorID == 3 then
		return 235, 209, 0
	elseif _ColorID == 4 then
		return 0, 235, 209
	elseif _ColorID == 5 then
		return 252, 164, 39
	elseif _ColorID == 6 then
		return 178, 2, 255
	elseif _ColorID == 7 then
		return 178, 176, 154
	elseif _ColorID == 8 then
		return 115, 209, 65
	elseif _ColorID == 9 then
		return 0, 140, 2
	elseif _ColorID == 10 then
		return 184, 184, 184
	elseif _ColorID == 11 then
		return 184, 182, 90
	elseif _ColorID == 12 then
		return 135, 135, 135 
	elseif _ColorID == 13 then
		return 230, 230, 230
	elseif _ColorID == 14 then
		return 57, 57, 57
	elseif _ColorID == 15 then
		return 139, 223, 255
	elseif _ColorID == 16 then
		return 255, 150, 214
	else
		
		if XNetwork.Manager_DoesExist() == 1 then
			return XNetwork.EXTENDED_ColorCodeToRGBA(_ColorID);
		end
		
	end;
	
	return 40, 40, 40
	
end
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
function RandomMapGenerator.GL_Setup()
	-- custom text input
	EMS.GL.CustomTextInputs["RMG_Seed"]					= CTI.New({Widget="RMG1F1Value", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=9, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_TerrainBaseHeight"]	= CTI.New({Widget="RMG2F1Value", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_WaterBaseHeight"]		= CTI.New({Widget="RMG2F2Value", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_NoiseFactorZ"]			= CTI.New({Widget="RMG2F3Value", Before = "@center ", NumbersOnly=true, MaxLength=3, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_NoiseFactorXY"]		= CTI.New({Widget="RMG2F4Value", Before = "@center ", NumbersOnly=true, MaxLength=3, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ForestDensity"]		= CTI.New({Widget="RMG2F5Value", Before = "@center ", NumbersOnly=true, MaxLength=3, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_ThresholdPike"]		= CTI.New({Widget="RMG3F2Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdMountain"]	= CTI.New({Widget="RMG3F4Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdHill"]		= CTI.New({Widget="RMG3F6Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdForest"]		= CTI.New({Widget="RMG3F7Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdMeadow"]		= CTI.New({Widget="RMG3F8Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdFlatland"]	= CTI.New({Widget="RMG3F9Value2", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=false, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdSea"]			= CTI.New({Widget="RMG3F1Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLake"]		= CTI.New({Widget="RMG3F3Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdCoast"]		= CTI.New({Widget="RMG3F5Value",  Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowForest"]	= CTI.New({Widget="RMG3F7Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowMeadow"]	= CTI.New({Widget="RMG3F8Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdLowFlatland"]	= CTI.New({Widget="RMG3F9Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdRoad"]		= CTI.New({Widget="RMG3F10Value", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_ThresholdHighMeadow"]	= CTI.New({Widget="RMG4F2Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdHighForest"]	= CTI.New({Widget="RMG4F3Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ThresholdPlateau"]		= CTI.New({Widget="RMG4F1Value1", Before = "@center ", NumbersOnly=true, AllowNegativeNumbers=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	
	EMS.GL.CustomTextInputs["RMG_AmountClayPit"]		= CTI.New({Widget="RMG5F1Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentClayPit"]		= CTI.New({Widget="RMG5F1Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountClayPile"]		= CTI.New({Widget="RMG5F2Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentClayPile"]		= CTI.New({Widget="RMG5F2Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountStonePit"]		= CTI.New({Widget="RMG5F3Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentStonePit"]		= CTI.New({Widget="RMG5F3Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountStonePile"]		= CTI.New({Widget="RMG5F4Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentStonePile"]		= CTI.New({Widget="RMG5F4Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountIronPit"]		= CTI.New({Widget="RMG5F5Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentIronPit"]		= CTI.New({Widget="RMG5F5Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountIronPile"]		= CTI.New({Widget="RMG5F6Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentIronPile"]		= CTI.New({Widget="RMG5F6Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountSulfurPit"]		= CTI.New({Widget="RMG5F7Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentSulfurPit"]		= CTI.New({Widget="RMG5F7Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountSulfurPile"]		= CTI.New({Widget="RMG5F8Value1", Before = "@center ", NumbersOnly=true, MaxLength=2, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentSulfurPile"]	= CTI.New({Widget="RMG5F8Value2", Before = "@center ", NumbersOnly=true, MaxLength=4, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountWoodPile"]		= CTI.New({Widget="RMG5F9Value1", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_ContentWoodPile"]		= CTI.New({Widget="RMG5F9Value2", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_AmountVC"]				= CTI.New({Widget="RMG2F7Value", Before = "@center ", NumbersOnly=true, MaxLength=1, Callback=EMS.GL.CustomTextInputCallback});

	EMS.GL.CustomTextInputs["RMG_StartResourceGold"]	= CTI.New({Widget="RMG7F1Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_StartResourceClay"]	= CTI.New({Widget="RMG7F2Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_StartResourceWood"]	= CTI.New({Widget="RMG7F3Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_StartResourceStone"]	= CTI.New({Widget="RMG7F4Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_StartResourceIron"]	= CTI.New({Widget="RMG7F5Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	EMS.GL.CustomTextInputs["RMG_StartResourceSulfur"]	= CTI.New({Widget="RMG7F6Value", Before = "@center ", NumbersOnly=true, MaxLength=6, Callback=EMS.GL.CustomTextInputCallback});
	
	-- gui update
	EMS.GL.GUIUpdate["RMG_Seed"]					= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_LandscapeSet"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GenerateRivers"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GateLayout"]				= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GateSize"]				= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_GenerateRoads"]			= EMS.GL.GUIUpdate_TextToggleButton
	EMS.GL.GUIUpdate["RMG_MirrorMap"]				= EMS.GL.GUIUpdate_TextToggleButton
	EMS.GL.GUIUpdate["RMG_RandomPlayerPosition"]	= EMS.GL.GUIUpdate_TextToggleButton
	
	EMS.GL.GUIUpdate["RMG_TerrainBaseHeight"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_WaterBaseHeight"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_NoiseFactorZ"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_NoiseFactorXY"]			= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_ForestDensity"]			= EMS.GL.GUIUpdate_Number
	
	EMS.GL.GUIUpdate["RMG_ThresholdPike"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdMountain"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdHill"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdForest"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdMeadow"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdFlatland"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdSea"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLake"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdCoast"]			= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowForest"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowMeadow"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdLowFlatland"]	= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdRoad"]			= EMS.GL.GUIUpdate_Threshold
	
	EMS.GL.GUIUpdate["RMG_ThresholdHighMeadow"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdHighForest"]		= EMS.GL.GUIUpdate_Threshold
	EMS.GL.GUIUpdate["RMG_ThresholdPlateau"]		= EMS.GL.GUIUpdate_Threshold

	EMS.GL.GUIUpdate["RMG_AmountClayPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentClayPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountClayPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentClayPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountStonePit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentStonePit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountStonePile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentStonePile"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountIronPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentIronPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountIronPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentIronPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountSulfurPit"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentSulfurPit"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountSulfurPile"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentSulfurPile"]		= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_AmountWoodPile"]			= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ContentWoodPile"]			= EMS.GL.GUIUpdate_Text

	EMS.GL.GUIUpdate["RMG_AmountVC"]				= EMS.GL.GUIUpdate_Text
	EMS.GL.GUIUpdate["RMG_ShowResources"]			= EMS.GL.GUIUpdate_TextToggleButton
	EMS.GL.GUIUpdate["RMG_ShowVillageCenters"]		= EMS.GL.GUIUpdate_TextToggleButton

	EMS.GL.GUIUpdate["RMG_StartResourceGold"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_StartResourceClay"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_StartResourceWood"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_StartResourceStone"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_StartResourceIron"]		= EMS.GL.GUIUpdate_Number
	EMS.GL.GUIUpdate["RMG_StartResourceSulfur"]		= EMS.GL.GUIUpdate_Number

	EMS.GL.GUIUpdate["RMG_PlayerConfig"]			= EMS.GL.GUIUpdate_Dummy
	
	-- map rule to gui widget
	EMS.GL.MapRuleToGUIWidget["RMG_Seed"]					= {"RMG1F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_LandscapeSet"]			= {"RMG1F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_GenerateRivers"]			= {"RMG1F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_GateLayout"]				= {"RMG1F3aValue"}
	EMS.GL.MapRuleToGUIWidget["RMG_GateSize"]				= {"RMG1F3bValue"}
	EMS.GL.MapRuleToGUIWidget["RMG_GenerateRoads"]			= "RMG1F4Value"
	EMS.GL.MapRuleToGUIWidget["RMG_MirrorMap"]				= "RMG1F5Value"
	EMS.GL.MapRuleToGUIWidget["RMG_RandomPlayerPosition"]	= "RMG1F6Value"
	
	EMS.GL.MapRuleToGUIWidget["RMG_TerrainBaseHeight"]		= {"RMG2F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_WaterBaseHeight"]		= {"RMG2F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_NoiseFactorZ"]			= {"RMG2F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_NoiseFactorXY"]			= {"RMG2F4Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ForestDensity"]			= {"RMG2F5Value"}
	
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdPike"]			= {"RMG3F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdMountain"]		= {"RMG3F4Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHill"]			= {"RMG3F6Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdForest"]		= {"RMG3F7Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdMeadow"]		= {"RMG3F8Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdFlatland"]		= {"RMG3F9Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdSea"]			= {"RMG3F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLake"]			= {"RMG3F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdCoast"]			= {"RMG3F5Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowForest"]		= {"RMG3F7Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowMeadow"]		= {"RMG3F8Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdLowFlatland"]	= {"RMG3F9Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdRoad"]			= {"RMG3F10Value"}

	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHighMeadow"]	= {"RMG4F2Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdHighForest"]	= {"RMG4F3Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ThresholdPlateau"]		= {"RMG4F1Value1"}

	EMS.GL.MapRuleToGUIWidget["RMG_AmountClayPit"]			= {"RMG5F1Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentClayPit"]			= {"RMG5F1Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountClayPile"]			= {"RMG5F2Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentClayPile"]		= {"RMG5F2Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountStonePit"]			= {"RMG5F3Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentStonePit"]		= {"RMG5F3Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountStonePile"]		= {"RMG5F4Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentStonePile"]		= {"RMG5F4Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountIronPit"]			= {"RMG5F5Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentIronPit"]			= {"RMG5F5Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountIronPile"]			= {"RMG5F6Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentIronPile"]		= {"RMG5F6Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountSulfurPit"]		= {"RMG5F7Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentSulfurPit"]		= {"RMG5F7Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountSulfurPile"]		= {"RMG5F8Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentSulfurPile"]		= {"RMG5F8Value2"}
	EMS.GL.MapRuleToGUIWidget["RMG_AmountWoodPile"]			= {"RMG5F9Value1"}
	EMS.GL.MapRuleToGUIWidget["RMG_ContentWoodPile"]		= {"RMG5F9Value2"}

	EMS.GL.MapRuleToGUIWidget["RMG_AmountVC"]				= {"RMG2F7Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_ShowResources"]			= "RMG2F9Value"
	EMS.GL.MapRuleToGUIWidget["RMG_ShowVillageCenters"]		= "RMG2F6Value"
	--EMS.GL.MapRuleToGUIWidget["RMG_PlayerConfig"]			= "RMG6F1Name"

	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceGold"]		= {"RMG7F1Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceClay"]		= {"RMG7F2Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceWood"]		= {"RMG7F3Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceStone"]		= {"RMG7F4Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceIron"]		= {"RMG7F5Value"}
	EMS.GL.MapRuleToGUIWidget["RMG_StartResourceSulfur"]	= {"RMG7F6Value"}
	
	-- map widget to rule required for CTI
	EMS.GL.MapWidgetToRule["RMG1F1Value"]	= "RMG_Seed"
	--EMS.GL.MapWidgetToRule["RMG1F2Value"]	= "RMG_LandscapeSet"
	--EMS.GL.MapWidgetToRule["RMG1F3Value"]	= "RMG_GenerateRivers"
	--EMS.GL.MapWidgetToRule["RMG1F3aValue"]	= "RMG_GateLayout"
	--EMS.GL.MapWidgetToRule["RMG1F3bValue"]	= "RMG_GateSize"
	--EMS.GL.MapWidgetToRule["RMG1F4Value"]	= "RMG_GenerateRoads"
	--EMS.GL.MapWidgetToRule["RMG1F5Value"]	= "RMG_MirrorMap"
	--EMS.GL.MapWidgetToRule["RMG1F6Value"]	= "RMG_RandomPlayerPosition"
	
	EMS.GL.MapWidgetToRule["RMG2F1Value"]	= "RMG_TerrainBaseHeight"
	EMS.GL.MapWidgetToRule["RMG2F2Value"]	= "RMG_WaterBaseHeight"
	EMS.GL.MapWidgetToRule["RMG2F3Value"]	= "RMG_NoiseFactorZ"
	EMS.GL.MapWidgetToRule["RMG2F4Value"]	= "RMG_NoiseFactorXY"
	EMS.GL.MapWidgetToRule["RMG2F5Value"]	= "RMG_ForestDensity"
	
	EMS.GL.MapWidgetToRule["RMG3F1Value"]	= "RMG_ThresholdSea"
	EMS.GL.MapWidgetToRule["RMG3F2Value"]	= "RMG_ThresholdPike"
	EMS.GL.MapWidgetToRule["RMG3F3Value"]	= "RMG_ThresholdLake"
	EMS.GL.MapWidgetToRule["RMG3F4Value"]	= "RMG_ThresholdMountain"
	EMS.GL.MapWidgetToRule["RMG3F5Value"]	= "RMG_ThresholdCoast"
	EMS.GL.MapWidgetToRule["RMG3F6Value"]	= "RMG_ThresholdHill"
	EMS.GL.MapWidgetToRule["RMG3F7Value1"]	= "RMG_ThresholdLowForest"
	EMS.GL.MapWidgetToRule["RMG3F7Value2"]	= "RMG_ThresholdForest"
	EMS.GL.MapWidgetToRule["RMG3F8Value1"]	= "RMG_ThresholdLowMeadow"
	EMS.GL.MapWidgetToRule["RMG3F8Value2"]	= "RMG_ThresholdMeadow"
	EMS.GL.MapWidgetToRule["RMG3F9Value1"]	= "RMG_ThresholdLowFlatland"
	EMS.GL.MapWidgetToRule["RMG3F9Value2"]	= "RMG_ThresholdFlatland"
	EMS.GL.MapWidgetToRule["RMG3F10Value"]	= "RMG_ThresholdRoad"
	
	EMS.GL.MapWidgetToRule["RMG4F2Value1"]	= "RMG_ThresholdHighMeadow"
	EMS.GL.MapWidgetToRule["RMG4F3Value1"]	= "RMG_ThresholdHighForest"
	EMS.GL.MapWidgetToRule["RMG4F1Value1"]	= "RMG_ThresholdPlateau"

	EMS.GL.MapWidgetToRule["RMG5F1Value1"]	= "RMG_AmountClayPit"
	EMS.GL.MapWidgetToRule["RMG5F1Value2"]	= "RMG_ContentClayPit"
	EMS.GL.MapWidgetToRule["RMG5F2Value1"]	= "RMG_AmountClayPile"
	EMS.GL.MapWidgetToRule["RMG5F2Value2"]	= "RMG_ContentClayPile"
	EMS.GL.MapWidgetToRule["RMG5F3Value1"]	= "RMG_AmountStonePit"
	EMS.GL.MapWidgetToRule["RMG5F3Value2"]	= "RMG_ContentStonePit"
	EMS.GL.MapWidgetToRule["RMG5F4Value1"]	= "RMG_AmountStonePile"
	EMS.GL.MapWidgetToRule["RMG5F4Value2"]	= "RMG_ContentStonePile"
	EMS.GL.MapWidgetToRule["RMG5F5Value1"]	= "RMG_AmountIronPit"
	EMS.GL.MapWidgetToRule["RMG5F5Value2"]	= "RMG_ContentIronPit"
	EMS.GL.MapWidgetToRule["RMG5F6Value1"]	= "RMG_AmountIronPile"
	EMS.GL.MapWidgetToRule["RMG5F6Value2"]	= "RMG_ContentIronPile"
	EMS.GL.MapWidgetToRule["RMG5F7Value1"]	= "RMG_AmountSulfurPit"
	EMS.GL.MapWidgetToRule["RMG5F7Value2"]	= "RMG_ContentSulfurPit"
	EMS.GL.MapWidgetToRule["RMG5F8Value1"]	= "RMG_AmountSulfurPile"
	EMS.GL.MapWidgetToRule["RMG5F8Value2"]	= "RMG_ContentSulfurPile"
	EMS.GL.MapWidgetToRule["RMG5F9Value1"]	= "RMG_AmountWoodPile"
	EMS.GL.MapWidgetToRule["RMG5F9Value2"]	= "RMG_ContentWoodPile"
	
	EMS.GL.MapWidgetToRule["RMG2F7Value"]	= "RMG_AmountVC"
	--EMS.GL.MapWidgetToRule["RMG2F9Value"]	= "RMG_ShowResources"
	--EMS.GL.MapWidgetToRule["RMG2F6Value"]	= "RMG_ShowVillageCenters"

	EMS.GL.MapWidgetToRule["RMG7F1Value"]	= "RMG_StartResourceGold"
	EMS.GL.MapWidgetToRule["RMG7F2Value"]	= "RMG_StartResourceClay"
	EMS.GL.MapWidgetToRule["RMG7F3Value"]	= "RMG_StartResourceWood"
	EMS.GL.MapWidgetToRule["RMG7F4Value"]	= "RMG_StartResourceStone"
	EMS.GL.MapWidgetToRule["RMG7F5Value"]	= "RMG_StartResourceIron"
	EMS.GL.MapWidgetToRule["RMG7F6Value"]	= "RMG_StartResourceSulfur"
		
	-- tooltip text
	EMS.L.RMG_RandomSeed 		= "Setzt einen zufälligen Seed."
	EMS.L.RMG_IncreaseThreshold = "Erhöht alle Gelände-Parameter. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Bei höheren Parametern wird es mehr Gewässer und weniger Berge geben."
	EMS.L.RMG_DecreaseThreshold = "Verringert alle Gelände-Parameter. @cr @cr @color:51,204,255,255 TIPP: @color:255,255,255,255 Bei niedrigeren Parametern wird es mehr Berge und weniger Gewässer geben."
	
	-- add rule pages
	table.insert(EMS.GV.Pages, "EMSPagesRMG")
	table.insert(EMS.GV.Pages, "EMSPagesRMG2")

	-- show rule page arrows
	XGUIEng.ShowWidget("EMSPUSCUp", 1)
	XGUIEng.ShowWidget("EMSPUSCDown", 1)
end	
function RandomMapGenerator.SetRulesToDefault()
	
	EMS.GL.SetValueSynced("RMG_Seed", RandomMapGenerator.GetRandomSeed())

	EMS.GL.SetValueSynced("RMG_GenerateRivers",	2)
	EMS.GL.SetValueSynced("RMG_GateLayout",		1)
	EMS.GL.SetValueSynced("RMG_GateSize",		3)
	EMS.GL.SetValueSynced("RMG_GenerateRoads",	Bool2Num(true))
	EMS.GL.SetValueSynced("RMG_LandscapeSet",	1)
	EMS.GL.SetValueSynced("RMG_MirrorMap",		Bool2Num(true))
	
	EMS.GL.SetValueSynced("RMG_AmountClayPit",        1)
	EMS.GL.SetValueSynced("RMG_ContentClayPit",   30000)
	EMS.GL.SetValueSynced("RMG_AmountClayPile",       4)
	EMS.GL.SetValueSynced("RMG_ContentClayPile",   4000)
	EMS.GL.SetValueSynced("RMG_AmountStonePit",       1)
	EMS.GL.SetValueSynced("RMG_ContentStonePit",  30000)
	EMS.GL.SetValueSynced("RMG_AmountStonePile",      4)
	EMS.GL.SetValueSynced("RMG_ContentStonePile",  4000)
	EMS.GL.SetValueSynced("RMG_AmountIronPit",        2)
	EMS.GL.SetValueSynced("RMG_ContentIronPit",   30000)
	EMS.GL.SetValueSynced("RMG_AmountIronPile",       4)
	EMS.GL.SetValueSynced("RMG_ContentIronPile",   4000)
	EMS.GL.SetValueSynced("RMG_AmountSulfurPit",      2)
	EMS.GL.SetValueSynced("RMG_ContentSulfurPit", 30000)
	EMS.GL.SetValueSynced("RMG_AmountSulfurPile",     4)
	EMS.GL.SetValueSynced("RMG_ContentSulfurPile", 4000)
	EMS.GL.SetValueSynced("RMG_AmountWoodPile",       2)
	EMS.GL.SetValueSynced("RMG_ContentWoodPile",  30000)
	EMS.GL.SetValueSynced("RMG_AmountVC", 3)
	
	RandomMapGenerator.SetupThresholdsNormal()

	--local res = EMS.RD.AdditionalConfig.Ressources.Normal[player]
	EMS.GL.SetValueSynced("RMG_StartResourceGold", 500)
	EMS.GL.SetValueSynced("RMG_StartResourceClay", 2400)
	EMS.GL.SetValueSynced("RMG_StartResourceWood", 1750)
	EMS.GL.SetValueSynced("RMG_StartResourceStone", 700)
	EMS.GL.SetValueSynced("RMG_StartResourceIron", 50)
	EMS.GL.SetValueSynced("RMG_StartResourceSulfur", 50)
end

function RandomMapGenerator.PackPlayerConfig( _nplayers, _players, _nteams, _teams )
	
	local config = ""
	config = AddNumberToString( config, _nplayers, 2 )
	
	for p = 1, _nplayers do
		
		local data = _players[p]
		
		config = AddNumberToString( config, data.id, 2 )
		config = AddNumberToString( config, data.team, 2 )
		config = AddNumberToString( config, data.ishuman, 1 )
	end
	
	EMS.GL.SetValue( "RMG_PlayerConfig", config )
end

function AddNumberToString( _text, _num, _digits )
	
	_digits = _digits or 1
	
	-- the lazy aproach is enough
	if _digits == 2 and _num < 10 then
		_text = _text .. "0"
	end
	_text = _text .. _num
		
	return _text
end

function RandomMapGenerator.UnpackPlayerConfig()
	
	local config = EMS.RD.Rules.RMG_PlayerConfig:GetValue()
	
	local nplayers = 0
	local players = {}
	local nteams = 0
	local teams = {}
	
	config, nplayers = GetNumberFromString( config, 2 )
	
	for p = 1, nplayers do
		
		local id,team, ishuman = 0,0,0
		
		config, id      = GetNumberFromString( config, 2 )
		config, team    = GetNumberFromString( config, 2 )
		config, ishuman = GetNumberFromString( config, 1 )
		
		local isIn = false

		for _,v in pairs(teams) do
			if v == team then
				isIn = true
				break
			end
		end

		if not isIn then
			nteams = nteams + 1
			teams[nteams] = team
		end
		
		players[p] = { id = id, team = team, ishuman = ishuman }
	end
	
	return nplayers, players, nteams, teams
end

function GetNumberFromString( _text, _digits )
	
	_digits = _digits or 1
	
	local num = tonumber( string.sub( _text, 1, _digits ) )
	_text = string.sub( _text, _digits + 1, string.len( _text ) )
	
	return _text, num
end