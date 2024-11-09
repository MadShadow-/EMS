EMS_CustomMapConfig =
{
	Version = 1,

	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;

		TeamPlayer = {1, 1, 2, 2, [17] = 1}
		PlayerTeam = {{1, 2}, {3, 4}}
		EnemyTeam = {2, 1}
		TeamPoints = {0, 0}
		MaxPoints = 2000

		local resourceTable = {
			{Entities.XD_GoldPit1, 50000},
			{Entities.XD_ClayPit1, 50000},
			{Entities.XD_StonePit1, 50000},
			{Entities.XD_IronPit1, 50000},
			{Entities.XD_SulfurPit1, 50000},
			{Entities.XD_Clay1, 4000},
			{Entities.XD_Stone1, 4000},
			{Entities.XD_Iron1, 4000},
			{Entities.XD_Sulfur1, 4000},
		}
		MapTools.SetMapResource(resourceTable)
		MapTools.WallsToPlayerZero(
			Entities.XD_DarkWallStraightGate,
			Entities.XD_DarkWallStraightGate_Closed,
			Entities.XD_DarkWallCorner,
			Entities.XD_DarkWallStraight,
			Entities.XD_DarkWallDistorted,
			Entities.XD_WallStraightGate,
			Entities.XD_WallStraightGate_Closed,
			Entities.XD_WallCorner,
			Entities.XD_WallStraight,
			Entities.XD_WallDistorted
		)
	end,

	Callback_OnGameStart = function()
	end,

	Callback_OnPeacetimeEnded = function()
		MapTools.OpenWallGates();
		if Callback_OnPeacetimeEnded_KotH then
			Callback_OnPeacetimeEnded_KotH()
		end
	end,

	Peacetime = 30,

	GameMode = 2,
	GameModes = {"Standard", "KingOfTheHill"},
	Callback_GameModeSelected = function(_gamemode)
		if _gamemode == 2 then
			Callback_OnPeacetimeEnded_KotH = function()
				SetupProgressBars()
				Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, nil, "CheckForMilitaryUnitsInMiddleJob", 1)
				--for i = 1, 8 do Tools.CreateGroup(1, Entities.PU_LeaderSword3, 8, 30800, 31000, 0) end
			end
		else
			for id in CEntityIterator.Iterator(CEntityIterator.InRangeFilter(30400, 30400, 2100), CEntityIterator.OfAnyTypeFilter(Entities.XD_Torch, Entities.XD_Rock3, Entities.XD_TemplarAltar)) do
				Logic.DestroyEntity(id)
			end
			Logic.CreateEntity(Entities.XD_VillageCenter, 30400, 30400, 0, 0)
		end
	end,

	ResourceLevel = 1,
	Ressources =
	{
		Normal = {
			[1] = {
				500,
				2400,
				1750,
				700,
				50,
				50,
			},
		},
	},

	Callback_OnFastGame = function()
	end,
};

function ColorGrade(_c1, _c2, _lambda)
	return math.clamp(math.abs(math.floor(_c1*_lambda + _c2*(1-_lambda))),0,255);
end

function math.clamp(_v, _min, _max)
	return math.max(math.min(_v, _max), _min);
end

function GetPlayerColorString(_playerId)
	local r,g,b = GUI.GetPlayerColor(_playerId);
	return " @color:"..r..","..g..","..b.." ";
end

function SetupProgressBars()
	local r,g,b;
	local timeProgress;
	GUIUpdate_VCTechRaceProgress = function()
		for teamId = 1,2 do
			local r1,g1,b1 = GUI.GetPlayerColor(PlayerTeam[teamId][1]);
			local r2,g2,b2 = GUI.GetPlayerColor(PlayerTeam[teamId][2]);
			timeProgress = math.max(math.min(math.sin(0.25*XGUIEng.GetSystemTime()), 0.5), -0.5) + 0.5;
			r = ColorGrade(r1,r2, timeProgress);
			g = ColorGrade(g1,g2, timeProgress);
			b = ColorGrade(b1,b2, timeProgress);

			XGUIEng.SetMaterialColor("VCMP_Team"..teamId.."Progress", 0, r, g, b, 255)
		end
	end
	GUIUpdate_VCTechRaceColor = function()end

	-- napo
	local barLength = 250
	local textBoxSize = 15
	local barHeight = 10
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
	for i = 3, 8 do 
		XGUIEng.ShowWidget("VCMP_Team"..i, 0);
		XGUIEng.ShowWidget("VCMP_Team"..i.."_Shade", 0);
	end
	for teamId = 1,2 do
		r,g,b = GUI.GetPlayerColor(PlayerTeam[teamId][1]);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", "(" .. TeamPoints[teamId] .. "/" .. MaxPoints .. ") " .. UserTool_GetPlayerName(PlayerTeam[teamId][1]) .. " & " .. UserTool_GetPlayerName(PlayerTeam[teamId][2]));
		XGUIEng.SetMaterialColor("VCMP_Team"..teamId.."Progress", 0, r, g, b, 150)
	end
    UpdateProgressBars()
end

function UpdateProgressBars()
    local team = TeamPlayer[GUI.GetPlayerID()]
    local enemy = EnemyTeam[team]

	for teamId = 1,2 do
		XGUIEng.SetProgressBarValues("VCMP_Team"..teamId.."Progress", math.floor(TeamPoints[teamId]), MaxPoints);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", "(" .. math.floor(TeamPoints[teamId]) .. "/" .. MaxPoints .. ") " ..
			GetPlayerColorString(PlayerTeam[teamId][1]) .. " " .. UserTool_GetPlayerName(PlayerTeam[teamId][1]) .. " @color:255,255,255,255 & "
			.. GetPlayerColorString(PlayerTeam[teamId][2]) .. " " .. UserTool_GetPlayerName(PlayerTeam[teamId][2]));

        if Logic.PlayerGetGameState(PlayerTeam[teamId][1]) == 3 and Logic.PlayerGetGameState(PlayerTeam[teamId][1]) == 3 then
            ConcludeGame(enemy)
            return true
        end
    end

    if TeamPoints[team] >= MaxPoints and TeamPoints[team] > TeamPoints[enemy] then
        ConcludeGame(team)
        return true
    elseif TeamPoints[enemy] >= MaxPoints and TeamPoints[team] < TeamPoints[enemy] then
        ConcludeGame(enemy)
        return true
    end
end

function ConcludeGame(_Team)
    Logic.PlayerSetGameStateToWon(PlayerTeam[_Team][1])
    Logic.PlayerSetGameStateToWon(PlayerTeam[_Team][2])
    Logic.PlayerSetGameStateToLost(PlayerTeam[EnemyTeam[_Team]][1])
    Logic.PlayerSetGameStateToLost(PlayerTeam[EnemyTeam[_Team]][2])

    if GUI.GetPlayerID() <= 4 then
        XGUIEng.ShowWidget("GameEndScreen", 1)

        if _Team == TeamPlayer[GUI.GetPlayerID()] then
            GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:155,230,112,255 Ihr habt das Spiel gewonnen." or "@color:155,230,112,255 You have won the game.")
            Sound.PlayGUISound(Sounds.OnKlick_Select_dario)
        else
            GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:220,64,16,255 Ihr habt das Spiel verloren." or "@color:220,64,16,255 You have lost the game.")
            Sound.PlayGUISound(Sounds.OnKlick_Select_kerberos)
        end
    end
end

function CheckForMilitaryUnitsInMiddleJob()
	local maphalf = Logic.WorldGetSize() / 2
	local unitsperteam = {0, 0}
    for id in CEntityIterator.Iterator(
        CEntityIterator.InRangeFilter(30400, 30400, 2000),
        CEntityIterator.OfAnyPlayerFilter(1, 2, 3, 4),
        CEntityIterator.OfAnyCategoryFilter(EntityCategories.Soldier, EntityCategories.Leader, EntityCategories.Hero, EntityCategories.Cannon, EntityCategories.Sword) -- Sword to catch battle serfs
    ) do
        if Logic.IsEntityAlive(id) then
            local entitytype = Logic.GetEntityType(id)
            if entitytype ~= Entities.PU_Scout and entitytype ~= Entities.PU_Thief then
				local team = TeamPlayer[Logic.EntityGetPlayer(id)]
                unitsperteam[team] = unitsperteam[team] + 1
            end
        end
    end
	local minunitsneeded = 50
	if unitsperteam[1] >= minunitsneeded and unitsperteam[2] <= 0 then
		TeamPoints[1] = TeamPoints[1] + 1
		UpdateProgressBars()
	elseif unitsperteam[2] >= minunitsneeded and unitsperteam[1] <= 0 then
		TeamPoints[2] = TeamPoints[2] + 1
		UpdateProgressBars()
	end
end