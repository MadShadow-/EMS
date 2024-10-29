EMS_CustomMapConfig =
{
	Version = 2,

	Callback_OnMapStart = function()
		Main_MapStart()
	end,

	Callback_OnGameStart = function()
		Main_GameStart()
	end,

	Callback_OnPeacetimeEnded = function()

	end,

	Peacetime = 0,

	GameMode = 1,
	GameModes = {"Standard"},
	Callback_GameModeSelected = function(_gamemode)
	end,

	ResourceLevel = 1,

	Ressources =
	{
		Normal = {
			[1] = {
				700,
				2300,
				1750,
				700,
				150,
				150,
			},
		},
	},

	Callback_OnFastGame = function()
	end,

	AIPlayers = {},

	TowerLevel = 3,
	TowerLimit = 4,

	NumberOfHeroesForAll = 2,
	
	HeavyCavalry = 2,
	LightCavalry = 2,
};

function FreeMine(_Player, _Type)
    local pos = GetPosition("HQ" .. _Player)
    for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(_Type), CEntityIterator.InRangeFilter(pos.X, pos.Y, 20000)) do
        local x, y = Logic.GetEntityPosition(id)
        Logic.CreateEntity(Entities.XD_Bomb1, x - 500, y - 500, 0, 8)
        return
    end
end
function FreeClayMine(_Tribute)
    local player = _Tribute.pId
    Logic.RemoveTribute(player, PlayerTributes[player][2])
    FreeMine(player, Entities.XD_ClosedClayPit1)
end
function FreeStoneMine(_Tribute)
    local player = _Tribute.pId
    Logic.RemoveTribute(player, PlayerTributes[player][1])
    FreeMine(player, Entities.XD_ClosedStonePit1)
end

function IsResourcePit(_Id)
    _Id = _Id or Event.GetEntityID()
    return Logic.IsEntityInCategory(_Id, EntityCategories.ResourcePit) == 1
end
function InitResourcePit(_Id)
    _Id = _Id or Event.GetEntityID()
    Logic.SetResourceDoodadGoodAmount(_Id, 50000)
end

function StopBanditRespawn(_Index)
    if IsDead("bandittower" .. _Index) then
        DefensiveArmy.StopRespawn(Bandits[_Index])
        return true
    end
end

function SetupSwampWeatherGfxSet()
    SetupSwampSummer(1, 0, 0, 0) -- summer
    SetupSwampRain(2, 1, 0, 0) -- rain
    SetupSwampWinter(3, 0, 1, 1) -- winter
    SetupSwampSummer(4, 1, 0, 0) -- summer > rain
    SetupSwampSummer(5, 0, 1, 0) -- summer > winter
    SetupSwampRain(6, 0, 0, 0) -- rain > summer
    SetupSwampRain(7, 1, 1, 0) -- rain > winter
    SetupSwampWinter(8, 0, 0, 1) -- winter > summer
    SetupSwampWinter(9, 1, 1, 1) -- winter > rain
end
function SetupSwampSummer(_Id, _Rain, _Snow, _Ice)
    Display.GfxSetSetRainEffectStatus(_Id, 0.0, 1.0, _Rain)
    Display.GfxSetSetSnowEffectStatus(_Id, 0.0, 1.0, _Snow)
    Display.GfxSetSetSnowStatus(_Id, 0.0, 1.0, _Ice)
    Display.GfxSetSetSkyBox(_Id, 0.0, 1.0, "YSkyBox02")
    Display.GfxSetSetFogParams(_Id, 0.0, 1.0, 1, 147, 141, 136, 9000, 36000)
    Display.GfxSetSetLightParams(_Id, 0.0, 1.0, 40, -15, -36, 147, 136, 124, 147, 124, 100)
end
function SetupSwampRain(_Id, _Rain, _Snow, _Ice)
    Display.GfxSetSetRainEffectStatus(_Id, 0.0, 1.0, _Rain)
    Display.GfxSetSetSnowEffectStatus(_Id, 0.0, 1.0, _Snow)
    Display.GfxSetSetSnowStatus(_Id, 0.0, 1.0, _Ice)
    Display.GfxSetSetSkyBox(_Id, 0.0, 1.0, "YSkyBox04")
    Display.GfxSetSetFogParams(_Id, 0.0, 1.0, 1, 147, 141, 136, 5000, 20000)
    Display.GfxSetSetLightParams(_Id, 0.0, 1.0, 40, -15, -50, 132, 136, 139, 116, 124, 131)
end
function SetupSwampWinter(_Id, _Rain, _Snow, _Ice)
    Display.GfxSetSetRainEffectStatus(_Id, 0.0, 1.0, _Rain)
    Display.GfxSetSetSnowEffectStatus(_Id, 0.0, 1.0, _Snow)
    Display.GfxSetSetSnowStatus(_Id, 0.0, 1.0, _Ice)
    Display.GfxSetSetSkyBox(_Id, 0.0, 1.0, "YSkyBox01")
    Display.GfxSetSetFogParams(_Id, 0.0, 1.0, 1, 147, 141, 136, 7000, 28000)
    Display.GfxSetSetLightParams(_Id, 0.0, 1.0, 40, -15, -75, 139, 136, 132, 131, 124, 116)
end

function AddPeriodicSummerToRain(_Duration)
    Logic.AddWeatherElement(1, _Duration, 1, 4, 5, 10)
end
function AddPeriodicSummerToWinter(_Duration)
    Logic.AddWeatherElement(1, _Duration, 1, 5, 5, 10)
end
function AddPeriodicRainToSummer(_Duration)
    Logic.AddWeatherElement(2, _Duration, 1, 6, 5, 10)
end
function AddPeriodicRainToWinter(_Duration)
    Logic.AddWeatherElement(2, _Duration, 1, 7, 5, 10)
end
function AddPeriodicWinterToSummer(_Duration)
    Logic.AddWeatherElement(3, _Duration, 1, 8, 5, 10)
end
function AddPeriodicWinterToRain(_Duration)
    Logic.AddWeatherElement(3, _Duration, 1, 9, 5, 10)
end

function UpdateScores()
    GUI.ClearNotes()
    local team = TeamPlayer[GUI.GetPlayerID()]
    local enemy = EnemyTeam[team]

    local text = string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "Punkte" or "Score"
    GUI.AddStaticNote(text .. ": @cr @color:155,230,112,255 " .. math.floor(TeamPoints[team]) .. " / " .. MaxPoints .. " @cr @color:220,64,16,255 " .. math.floor(TeamPoints[enemy]) .. " / " .. MaxPoints)

    if TeamPoints[team] >= MaxPoints and TeamPoints[team] > TeamPoints[enemy] then
        GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:155,230,112,255 Ihr habt das Spiel gewonnen." or "@color:155,230,112,255 You have won the game.")
        Sound.PlayGUISound(Sounds.OnKlick_Select_dario)
        return true
    elseif TeamPoints[enemy] >= MaxPoints and TeamPoints[team] < TeamPoints[enemy] then
        GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:220,64,16,255 Ihr habt das Spiel verloren." or "@color:220,64,16,255 You have lost the game.")
        Sound.PlayGUISound(Sounds.OnKlick_Select_kerberos)
        return true
    end
end

function IsCheckPoint(_Id)
    _Id = _Id or Event.GetEntityID()
    local typename = Logic.GetEntityTypeName(Logic.GetEntityType(_Id))
    if string.find(typename, "Mine") and string.find(typename, "PB_") and not string.find(typename, "Generic") then
        local x, y = Logic.GetEntityPosition(_Id)
        local index, dist = GetIndexByPosition(x, y)
        if dist < 1000 then
            return true, index
        end
    end
    return false, 0
end

function ActivateSpawner(_Id)
    _Id = _Id or Event.GetEntityID()
    local x, y = Logic.GetEntityPosition(_Id)
    local index = GetIndexByPosition(x, y)
    local team = TeamPlayer[Logic.EntityGetPlayer(_Id)]

    -- break on upgrade
    if CheckPointTeam[index] == 0 then
        CheckPointTeam[index] = team
        CheckPointBuildings[index] = _Id
        NextSpawn[index] = GetSpawnTime(CheckPointTeam[index])
    end
end

function DeactivateSpawner()
    local id = Event.GetEntityID()
    local x, y = Logic.GetEntityPosition(id)
    local index = GetIndexByPosition(x, y)

    local upgradelevel = Logic.GetUpgradeLevelForBuilding(id)
    if upgradelevel < 2 then
        local name = Logic.GetEntityTypeName(Logic.GetEntityType(id))
        name = string.gsub(name, upgradelevel + 1, upgradelevel + 2)
        -- break on upgrade
        for id in CEntityIterator.Iterator(CEntityIterator.InRangeFilter(x, y, 1), CEntityIterator.OfTypeFilter(Entities[name])) do
            return
        end
    end
    CheckPointTeam[index] = 0
    NextSpawn[index] = nil
end

function GetSpawnTime(_Team)
    local pointspersecond = 0
    for i = 1, 5 do
        if CheckPointTeam[i] == _Team then
            pointspersecond = pointspersecond + KAI.RM.GetBuildingAverageProductionRate(CheckPointBuildings[i])
        end
    end
    -- 120s - 150s
    return 30 * (1 - pointspersecond / MaxPointsPerSecond) + 120
end

function SpawnWave(_Index)
    local team = CheckPointTeam[_Index]
    -- 2 * (1 - 4) troops
    local amount = TeamPoints[team] / MaxPoints * 3 + 1

    local x, y = GetRandomPositionInSpawnArea(_Index)
    local types = {Entities.CU_Evil_LeaderBearman1, Entities.CU_Evil_LeaderSkirmisher1}
    if x then
        for i = 1, amount do
            for j = 1, 2 do
                AddWaypoints(
                    AI.Entity_CreateFormation(6, types[j], nil, 16, x, y, 0, 1, 0, 0),
                    {{X = CheckPoints[_Index].X, Y = CheckPoints[_Index].Y}, loop = false}
                )
            end
        end
    end
end

function CheckPointControllerJob()
    for i = 1, 5 do
        if CheckPointTeam[i] ~= 0 then
            TeamPoints[CheckPointTeam[i]] = TeamPoints[CheckPointTeam[i]] + KAI.RM.GetBuildingAverageProductionRate(CheckPointBuildings[i])
            if UpdateProgressBars() then
                return true
            end
        end
        if NextSpawn[i] then
            if NextSpawn[i] <= 0 then
                SpawnWave(i)
                NextSpawn[i] = GetSpawnTime(CheckPointTeam[i])
            else
                NextSpawn[i] = NextSpawn[i] - 1
            end
        end
    end
end

function GetIndexByPosition(_X, _Y)
    local dis = {}
    for i = 1, 5 do
        dis[i] = {I = i, D = (_X - CheckPoints[i].X) ^ 2 + (_Y - CheckPoints[i].Y) ^ 2}
    end
    table.sort(dis, function(_a, _b) return _a.D < _b.D end)
    return dis[1].I, math.sqrt(dis[1].D)
end

function AreHumanMilitaryUnitsInArea( _X, _Y, _Range, _Amount )
    _Amount = _Amount or 1
    local amount = 0
    for id in CEntityIterator.Iterator(CEntityIterator.InRangeFilter(_X, _Y, _Range), CEntityIterator.OfAnyPlayerFilter(1, 2, 3, 4), CEntityIterator.OfAnyCategoryFilter(EntityCategories.Leader, EntityCategories.Hero, EntityCategories.Cannon)) do
        if Logic.IsEntityAlive(id) then
            amount = amount + 1
            if amount >= _Amount then
                return true
            end
        end
    end
    return false
end

-- 4000 : 55, 3000 : 65, 0 : 120
CheckPoints = {
    [1] = {X = 58000, Y = 58000},
    [2] = {X = 18000, Y = 18000},
    [3] = {X = 18000, Y = 58000},
    [4] = {X = 58000, Y = 18000},
    [5] = {X = 38400, Y = 38400},
}
SpawnAreas = {
    -- north
    [1] = {
        {X = 60900, Y = 60900, R = 5500},
        {X = 55900, Y = 55900, R = 6500},
    },
    -- south
    [2] = {
        {X = 15900, Y = 15900, R = 5500},
        {X = 20900, Y = 20900, R = 6500},
    },
    -- west
    [3] = {
        {X = 15900, Y = 60900, R = 5500},
        {X = 20900, Y = 55900, R = 6500},
    },
    -- east
    [4] = {
        {X = 60900, Y = 15900, R = 5500},
        {X = 55900, Y = 20900, R = 6500},
    },
    -- center
    [5] = {X = 38400, Y = 38400, R = 12000},
}

function GetRandomPositionInSpawnArea(_Index)

    local spawnarea = SpawnAreas[_Index]
    if _Index < 5 then
        spawnarea = spawnarea[math.random(1,2)]
    end

    local ntries = 250
    while ntries > 0 do
        local x, y = GetRandomPositionInDistance(spawnarea.X, spawnarea.Y, spawnarea.R)
        if CUtil.GetBlocking100(x, y) == 0 and not AreHumanMilitaryUnitsInArea(x, y, 2000, 10) then
            return x, y
        end
    end
end

function GetRandomPositionInDistance(_X, _Y, _Min, _Max)
    if not _Max then
        _Max = _Min
        _Min = 0
    end
    local a = math.random(-_Max, _Max)
    local bMin = 0
    if math.abs(a) < _Min then
        bMin = math.sqrt(_Min^2 - a^2)
    end
    local bMax = math.sqrt(_Max^2 - a^2)
    local b = math.floor(math.random(bMin, bMax) + 0.5)
    if math.sin(a) < 0 then
        b = -b
    end
    return _X + a, _Y + b
end

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

function UpdateProgressBars()
	for teamId = 1,2 do
		XGUIEng.SetProgressBarValues("VCMP_Team"..teamId.."Progress", math.floor(TeamPoints[teamId]), MaxPoints);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", "(" .. math.floor(TeamPoints[teamId]) .. "/" .. MaxPoints .. ") " ..
			GetPlayerColorString(PlayerTeam[teamId][1]) .. " " .. UserTool_GetPlayerName(PlayerTeam[teamId][1]) .. " @color:255,255,255,255 & "
			.. GetPlayerColorString(PlayerTeam[teamId][2]) .. " " .. UserTool_GetPlayerName(PlayerTeam[teamId][2]));
	end

    local team = TeamPlayer[GUI.GetPlayerID()]
    local enemy = EnemyTeam[team]
    if TeamPoints[team] >= MaxPoints and TeamPoints[team] > TeamPoints[enemy] then
        GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:155,230,112,255 Ihr habt das Spiel gewonnen." or "@color:155,230,112,255 You have won the game.")
        Sound.PlayGUISound(Sounds.OnKlick_Select_dario)
        return true
    elseif TeamPoints[enemy] >= MaxPoints and TeamPoints[team] < TeamPoints[enemy] then
        GUI.AddStaticNote(string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and "@color:220,64,16,255 Ihr habt das Spiel verloren." or "@color:220,64,16,255 You have lost the game.")
        Sound.PlayGUISound(Sounds.OnKlick_Select_kerberos)
        return true
    end
end

function SetupProgressBars()
	-- gradient 30, 150 to 255,242 to 255,0
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

function Main_MapStart()
    --local path = "maps\\user\\(4) EMS King of the Swamp\\maps\\externalmap\\script\\"
    local path = "maps\\externalmap\\script\\"

    Script.Load(path .. "DefensiveArmy.lua")
    Script.Load(path .. "Filter.lua")
    Script.Load(path .. "SpawnArmy.lua")
    Script.Load(path .. "Memory.lua")
    Script.Load(path .. "Navigation.lua")
    Script.Load(path .. "ResourceManager.lua")
    
    if string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" then
        CUtil.SetStringTableText("names/PB_GoldMine1", "Goldgrube")
        CUtil.SetStringTableText("names/PB_GoldMine2", "Goldstollen")
        CUtil.SetStringTableText("names/PB_GoldMine3", "Goldbergwerk")
        CUtil.SetStringTableText("names/XD_GoldPit1", "Goldschacht")
        Logic.AddQuest(GUI.GetPlayerID(), 1, MAINQUEST_OPEN, "Erschließt den Sumpf", "Tief in den Sümpfen befinden sich weitere Rohstoffvorkommen. Besetzt diese und haltet die Stellungen um jeden Preis. @cr Doch seid vorsichtig! Düstere Kreaturen treiben in den Sümpfen ihr Unwesen.", 1)
        --Logic.AddQuest(GUI.GetPlayerID(), 2, SUBQUEST_OPEN, "Verschüttete Rohstoffe", "Weiter außerhalb eurer Siedlung haben eure Späher weitere Rohstoffvorkommen entdeckt. Leider sind sie von Geröll bedeckt. @cr Für ein paar Taler und etwas Pulver könnt ihr euch eine Bombe anfertigen lassen, die genug Sprengkraft hätte um einen der Schächte freizulegen.", 1)
    else
        CUtil.SetStringTableText("names/PB_GoldMine1", "Gold Pit")
        CUtil.SetStringTableText("names/PB_GoldMine2", "Gold Galley")
        CUtil.SetStringTableText("names/PB_GoldMine3", "Gold Mine")
        CUtil.SetStringTableText("names/XD_GoldPit1", "Gold Shaft")
        Logic.AddQuest(GUI.GetPlayerID(), 1, MAINQUEST_OPEN, "open up the swamp", "There are further resource deposits deep in the swamps. Occupy these and hold the positions at all costs. @cr But be careful! Dark creatures are wreaking havoc in the swamps.", 1)
        --Logic.AddQuest(GUI.GetPlayerID(), 2, SUBQUEST_OPEN, "buried resources", "Your scouts have discovered more resource deposits further outside your settlement. Unfortunately, they are covered by rubble. @cr For a few thalers and some powder you can have a bomb made that would have enough explosive power to uncover one of the shafts.", 1)
    end

    -- summer 4
    -- rain 1
    -- winter 1
    -- sumer 2
    -- winter 2
    -- rain 2
    AddPeriodicSummer(6 * 60 - 5)
    AddPeriodicSummerToRain(25)
    AddPeriodicRain(90 - 5)
    AddPeriodicRainToWinter(25)
    AddPeriodicWinter(90 - 5)
    AddPeriodicWinterToSummer(25)
    AddPeriodicSummer(3 * 60 - 5)
    AddPeriodicSummerToWinter(25)
    AddPeriodicWinter(3 * 60 - 5)
    AddPeriodicWinterToRain(25)
    AddPeriodicRain(3 * 60 - 5)
    AddPeriodicRainToSummer(25)

    LocalMusic.UseSet = DARKMOORMUSIC

    for p = 1, 4 do
        SetHostile(p, 5)
        SetHostile(p, 6)
    end

    ResearchTechnology(Technologies.T_SoftArcherArmor, 5)
    ResearchTechnology(Technologies.T_LeatherArcherArmor, 5)
    ResearchTechnology(Technologies.T_PaddedArcherArmor, 5)
    ResearchTechnology(Technologies.T_Fletching, 5)
    ResearchTechnology(Technologies.T_BodkinArrow, 5)

    TeamPlayer = {1, 1, 2, 2, [17] = 1}
    PlayerTeam = {{1, 2}, {3, 4}}
    EnemyTeam = {2, 1}
    TeamPoints = {0, 0}
    MaxPoints = 5000
    MaxPointsPerSecond = 2.5 * 4 + 4.2
    CheckPointBuildings = {}
    CheckPointTeam = {0, 0, 0, 0, 0}
    NextSpawn = {}

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
    MapTools.CreateWoodPiles(25000)

    GameCallback_OnBuildingConstructionComplete_Orig = GameCallback_OnBuildingConstructionComplete
    function GameCallback_OnBuildingConstructionComplete(_BuildingId, _PlayerId)
        GameCallback_OnBuildingConstructionComplete_Orig(_BuildingId, _PlayerId)

        if IsCheckPoint(_BuildingId) then
            ActivateSpawner(_BuildingId)
        end
    end

    GameCallback_OnBuildingUpgradeComplete_Orig = GameCallback_OnBuildingUpgradeComplete
    function GameCallback_OnBuildingUpgradeComplete(_OldId, _NewId)
        GameCallback_OnBuildingUpgradeComplete_Orig(_OldId, _NewId)

        local ischeckpoint, index = IsCheckPoint(_NewId)
        if ischeckpoint then
            CheckPointBuildings[index] = _NewId
        end
    end

    SetupProgressBars()

    Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED, "IsResourcePit", "InitResourcePit", 1)
    Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_DESTROYED, "IsCheckPoint", "DeactivateSpawner", 1)
    Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, "", "CheckPointControllerJob", 1)
    Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, "", "WaypointsFunc", 1)
    Logic.CreateEntity(Entities.XD_GoldPit1, 38325, 38350, 0, 0)

    GameCallback_GUI_SelectionChanged_Orig = GameCallback_GUI_SelectionChanged_Orig or GameCallback_GUI_SelectionChanged
    function GameCallback_GUI_SelectionChanged()
        GameCallback_GUI_SelectionChanged_Orig()

        local selectedentity = GUI.GetSelectedEntity()
        local entitytype = Logic.GetEntityType(selectedentity)
        local upgradecategory = Logic.GetUpgradeCategoryByBuildingType(entitytype)

        if upgradecategory == UpgradeCategories.GoldMine and Logic.IsConstructionComplete(selectedentity) == 1 then
            XGUIEng.ShowWidget(gvGUI_WidgetID.Ironmine,1)
            InterfaceTool_UpdateUpgradeButtons(entitytype, upgradecategory, "Upgrade_Ironmine")
        end
    end

    GUITooltip_UpgradeBuilding_Orig = GUITooltip_UpgradeBuilding_Orig or GUITooltip_UpgradeBuilding
    function GUITooltip_UpgradeBuilding(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType)

        local selectedentity = GUI.GetSelectedEntity()
        local entitytype = Logic.GetEntityType(selectedentity)
        local upgradecategory = Logic.GetUpgradeCategoryByBuildingType(entitytype)

        if upgradecategory == UpgradeCategories.GoldMine then
            _DisabledTooltip = string.gsub(_DisabledTooltip, "Iron", "Gold")
            _NormalTooltip = string.gsub(_NormalTooltip, "Iron", "Gold")
        end

        GUITooltip_UpgradeBuilding_Orig(_BuildingType, _DisabledTooltip, _NormalTooltip, _TechnologyType)
    end

    for id in CEntityIterator.Iterator(CEntityIterator.OfTypeFilter(Entities.PB_Headquarters1)) do
        Logic.SetEntityName(id, "HQ" .. Logic.EntityGetPlayer(id))
    end

    if not CNetwork then
        Camera.ZoomSetFactorMax(3)
        Camera.ZoomSetFactor(3)
    end

    Main_GameLoaded()
end

function Main_GameStart()
    Bandits = {}
    for i = 1, 8 do
        local pos = GetPosition("banditspawn" .. i)
        Bandits[i] = DefensiveArmy.new(5, pos.X, pos.Y, 3000, PlayerChunk_GetPlayerEnemyChunk(5), 600, true)
        local respawntime = 30 * 10
        for j = 1, 3 do
            DefensiveArmy.AddTroopSpawn(Bandits[i], respawntime, Entities.CU_BanditLeaderSword1, 8, pos.X, pos.Y, 0)
        end
        for j = 1, 4 do
            DefensiveArmy.AddTroopSpawn(Bandits[i], respawntime, Entities.PU_LeaderBow2, 4, pos.X, pos.Y, 0)
        end
        Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND, "", "StopBanditRespawn", 1, nil, {i})
    end

    for i = 1, 5 do
        AI.Entity_CreateFormation(6, Entities.CU_Evil_LeaderBearman1, nil, 16, CheckPoints[i].X, CheckPoints[i].Y, 0, 1, 0, 0)
        AI.Entity_CreateFormation(6, Entities.CU_Evil_LeaderSkirmisher1, nil, 16, CheckPoints[i].X, CheckPoints[i].Y, 0, 1, 0, 0)
    end

    -- removed for balancing
    -- Pilgrim needed to be more rewarded
    --[[local text = string.lower(XNetworkUbiCom.Tool_GetCurrentLanguageShortName() or "") == "de" and
    "Legt eine Bombe am verschütteten REPLACE, um diesen frei zu legen. @cr Bedenkt, ihr könnt nur eine Bombe kaufen! @cr Taler 500, Eisen 100, Schwefel 100" or
    "Place a bomb at the hidden REPLACE, to uncover it. @cr Beware, you can only buy on bomb! @cr Gold 500, Iron 100, Sulfur 100"

    PlayerTributes = {}
    for p = 1, 4 do
        PlayerTributes[p] = {}
        PlayerTributes[p][1] = AddTribute(
            {
                Callback = FreeClayMine,
                pId = p,
                text = string.gsub(text, "REPLACE", XGUIEng.GetStringTableText("names/XD_ClayPit1")),
                cost = {Gold = 500, Iron = 100, Sulfur = 100},
            }
        )
        PlayerTributes[p][2] = AddTribute(
            {
                Callback = FreeStoneMine,
                pId = p,
                text = string.gsub(text, "REPLACE", XGUIEng.GetStringTableText("names/XD_StonePit1")),
                cost = {Gold = 500, Iron = 100, Sulfur = 100},
            }
        )
    end]]
end

function Main_GameLoaded()
    SetupSwampWeatherGfxSet()
    Display.SetPlayerColorMapping(5, 14)
    Display.SetPlayerColorMapping(6, 11)

    -- Debug
    --Display.SetRenderFogOfWar(0)
    --Tools.CreateGroup(1, Entities.PU_LeaderSword1, 4, 23000, 67200)
    --Tools.CreateGroup(1, Entities.PU_LeaderSword1, 4, 23000, 67400)
    --Tools.CreateGroup(1, Entities.PU_LeaderSword1, 4, 23000, 67600)
    --Logic.CreateEntity(Entities.PU_Hero4, 22800, 67500, 0, 1)
    --Logic.CreateEntity(Entities.PU_Hero10, 22800, 67400, 0, 1)
    --for k, v in pairs(Technologies) do ResearchTechnology(v) end
    --KAI.RM.GetBuildingAverageProductionRate(GUI.GetSelectedEntity())
end

--function MultiplayerTools.OnSaveGameLoaded()
    --Main_GameLoaded()
--end