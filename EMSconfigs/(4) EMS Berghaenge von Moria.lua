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
	Version = 1.33,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		TriggerFix_mode = "Xpcall"
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\packer\\devLoad.lua");
		mcbPacker.mainPath="maps\\user\\EMS\\tools\\";
		mcbPacker.require("s5CommunityLib/comfort/other/FrameworkWrapperLight");
		Script.Load("maps\\user\\EMS\\tools\\s5CommunityLib\\lib\\UnlimitedArmySpawnGenerator.lua");
		S5HookLoader.Init()
		EntityIdChangedHelper.Init()
		LuaDebugger.Log = function() end
		AddPeriodicSummer(60);
		Diploeinstellung();
		SetupColorMappingForPlayers();
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
		--Tools.ExploreArea(1,1,900)
		--createArmies();
		XGUIEng.ShowWidget("EMSMAMITLeft", 1);
		
		--debugtools();
		
		CreateUAs()
		
		
		WT.Init();
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
	PunkteCounterJob = StartSimpleJob("PunkteCounter")
		Logic.AddWeatherElement(1,110,1,1,5,10) 
		Logic.AddWeatherElement(2,50,1,2,5,10) 
		Logic.AddWeatherElement(3,140,1,3,5,10)
		Logic.AddWeatherElement(2,70,1,2,5,10) 
		Logic.AddWeatherElement(3,110,1,3,5,10) 
		Logic.AddWeatherElement(1,110,1,1,5,10) 
			if Logic.GetTimeToNextWeatherPeriod() > 15 then
			Logic.SetWeatherOffset(Logic.GetTimeToNextWeatherPeriod()-10)
			end
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
				1000,
				2200,
				2200,
				1200,
				0,
				150,
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
	
	AIPlayers = {5,6,7,8},
	
	TowerLimit = 5,
	
	NumberOfHeroesForAll = 2,
	Drake = 0,
	Erec = 0,
	
	HeavyCavalry = 0,
	LightCavalry = 0,
	Cannon4 = 1,
	Cannon3 = 1,
	Cannon2 = 1,
	Cannon1 = 1,
	
	Sword = 4,
	Bow = 4,
	PoleArm = 4,
	HeavyCavalry = 2,
	LightCavalry = 2,
	Rifle = 2,
	Thief = 1,
	Scout = 1,
	
	Markets = 0,
	TowerLevel = 3,
	WeatherChangeLockTimer = 1,
};

WT = {};

function Diploeinstellung ()
	SetHostile(1,3)
	SetHostile(1,4)
	SetHostile(1,6)

	SetHostile(2,3)
	SetHostile(2,4)
	SetHostile(2,6)

	SetFriendly(1,2)
	SetFriendly(1,5)

	SetFriendly(2,5)

	SetHostile(3,5)
	SetHostile(4,5)

	SetHostile(5,6)

	SetFriendly(3,4)
	SetFriendly(3,6)
	SetFriendly(4,6)

Logic.SetShareExplorationWithPlayerFlag(1, 2, 1)
Logic.SetShareExplorationWithPlayerFlag(1, 5, 1)
Logic.SetShareExplorationWithPlayerFlag(2, 5, 1)

Logic.SetShareExplorationWithPlayerFlag(3, 4, 1)
Logic.SetShareExplorationWithPlayerFlag(3, 6, 1)
Logic.SetShareExplorationWithPlayerFlag(4, 6, 1)
end

function SetupColorMappingForPlayers()
    local ai1Color = XNetwork.GameInformation_GetLogicPlayerColor(5)
    local ai2Color = XNetwork.GameInformation_GetLogicPlayerColor(6)
    local barbarcolor = XNetwork.GameInformation_GetLogicPlayerColor(7)
    local NPCcolor = XNetwork.GameInformation_GetLogicPlayerColor(8)
    if ai1Color == 0 then
        ai1Color = 9
    end
    if ai2Color == 0 then
        ai2Color = 13
    end
    if barbarcolor == 0 then
        barbarcolor = 14
    end
    if NPCcolor == 0 then
        NPCcolor = 11
    end
    
    local colors = {}
    for i = 1,4 do
        colors[XNetwork.GameInformation_GetLogicPlayerColor(i)] = true
    end
    
    -- enemy ai color not used

    -- if default colors green and white are not used by players-> use them
    if not colors[9] then
        ai1Color = 9
        colors[9] = true
    elseif colors[ai1Color] then
        -- set aiColor also used by player
        for i = 1, 16 do
            if not colors[i] then
                ai1Color = i
                colors[i] = true
                break
            end
        end
    end
    if not colors[13] then
        ai2Color = 13
        colors[13] = true
    elseif colors[ai2Color] then
        -- set aiColor also used by player
        for i = 1, 16 do
            if not colors[i] then
                ai2Color = i
                colors[i] = true
                break
            end
        end
    end
    
    if not colors[14] then
        barbarcolor = 14
        colors[barbarcolor] = true
    elseif colors[barbarcolor] then
        for i = 1,16 do
            if not colors[i] then
                barbarcolor = id
                colors[barbarcolor] = true
                break
            end
        end
    end
    
    if not colors[11] then
        NPCcolor = 11
        colors[11] = true
    elseif colors[NPCcolor] then
        for i = 1,16 do
            if not colors[i] then
                NPCcolor = id
                colors[i] = true
                break
            end
        end
    end
    -- set ingame colors
    Display.SetPlayerColorMapping(5, ai1Color)
    Display.SetPlayerColorMapping(6, ai2Color)
    Display.SetPlayerColorMapping(7,barbarcolor)
    Display.SetPlayerColorMapping(8,NPCcolor)
    
    -- stati colors
    local r,g,b = GUI.GetPlayerColor(5)
    Logic.PlayerSetPlayerColor(5, r, g, b)
    r,g,b = GUI.GetPlayerColor(6)
    Logic.PlayerSetPlayerColor(6, r, g, b)
    r,g,b = GUI.GetPlayerColor(7)
    Logic.PlayerSetPlayerColor(7, r, g, b)
end

function createArmies()
	SetHostile(1,2);
	local spawn = {X=Logic.WorldGetSize()/2,Y=Logic.WorldGetSize()/2}
	Army = UnlimitedArmy:New({Player=2, Area=300000});
	
	Army:CreateLeaderForArmy(Entities.PU_LeaderSword2, 4, spawn, 5);
	Army:CreateLeaderForArmy(Entities.PU_LeaderSword2, 4, spawn, 5);
end


function debugtools()

	Input.KeyBindDown(Keys.Y, "SpawnLocal(1)", 2)
	Input.KeyBindDown(Keys.X, "SpawnLocal(3)", 2)
	
	function SpawnLocal(_id)
		local x,y = GUI.Debug_GetMapPositionUnderMouse();
		--CNetwork.send_command("Debug_SpawnTroop".._id, GUI.GetPlayerID(), x, y);
		Debug_SpawnTroop1(_id,x,y)
	end
	
	function Debug_SpawnTroop1(_playerId,x,y)
		entent = AI.Entity_CreateFormation(
			_playerId,
			Entities.PU_LeaderSword3,
			0,
			8,
			x, y,
			0,0,
			0,
			0
		);
	end
end

function WT.Init()
	WT.InitFlags();
	WT.InitTechnologyCounter();
end


function WT.InitFlags()
	WT.Players = 4;
	
	-- teams
	WT.Teams = 
	{
		{1, 2},
		{3, 4}
	};
	WT.NumTeams = table.getn(WT.Teams);
	
	-- flags
	WT.Flags = {};
	local smallRange = 2500;
	local bigRange = 3500;
	for i = 1, 5 do
		WT.Flags[i] = {
			Position = GetPosition("p"..i),
			Range = smallRange,
			GivePoints = 1,
		}; 
	end
	WT.Flags[1].Range = bigRange;
	WT.Flags[1].GivePoints = 5;
	WT.NumFlags = table.getn(WT.Flags);
	
	WT.Score = {};
	for i = 1,WT.NumTeams do
		WT.Score[i] = 0;
	end
	
	-- points needed
	WT.ScoreLimit = 15000;
	
	-- track all existing units, that is serfs and leaders
	local listOfSerfs = S5Hook.EntityIteratorTableize( Predicate.OfType(Entities.PU_Serf))
	local listOfLeaders = S5Hook.EntityIteratorTableize( Predicate.OfCategory(EntityCategories.Leader))
	WT.ListOfTrackedEntities = {}
	for k,v in pairs(listOfSerfs) do
		table.insert( WT.ListOfTrackedEntities, v)
	end
	for k,v in pairs(listOfLeaders) do
		table.insert( WT.ListOfTrackedEntities, v)
	end
	WT.ListOfIncompleteBuildings = {}
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_CREATED, nil, "WT_OnEntityCreated", 1)
	StartSimpleJob("WT_TrackerWatchDog")
	
	-- Setup nice flags
	-- type of flag: XD_StandardLarge
	-- Central flag does not have standards, maybe add some?
	WT.CreateStandardsForCentralFlag()
	-- replace by XD_StandartePlayerColor?
	WT.ListOfStandardData = {}
	for eId in S5Hook.EntityIterator( Predicate.OfType( Entities.XD_StandardLarge)) do
		local pos = GetPosition( eId)
		local rot = Logic.GetEntityOrientation( eId)
		table.insert( WT.ListOfStandardData, {pos = pos, rot = rot, eId = eId})
	end
	for k,v in pairs(WT.ListOfStandardData) do
		v.flag = WT.GetFlagIDByPosition( v.pos)
		DestroyEntity( v.eId)
		v.eId = Logic.CreateEntity( Entities.XD_Rock1, v.pos.X, v.pos.Y, v.rot, 0)
		Logic.SetModelAndAnimSet( v.eId, Models.XD_StandartePlayerColor)
	end
	for k,v in pairs(WT.Flags) do
		v.OldOwner = 0
	end
	
	StartSimpleJob("WT_FlagController");
	WT.SetupFlagGUI();
end

function WT.CreateStandardsForCentralFlag()
	local pos = GetPosition("p1")
	local range = 3500
	-- create outer flags that indicate range
	--local angles = {15, 79, 194, 252}					-- Range flags are in the middle of entries
	local angles = {185, 205, 241, 263, 4, 27, 69, 85}	-- Range flags are at the borders of entry points
	for k,angle in pairs(angles) do 
		local flagX, flagY = WT.GetPositionByCenterAndAngle( pos, angle, range)
		Logic.CreateEntity( Entities.XD_StandardLarge, flagX, flagY, angle + 90, 1)
	end
	-- create inner flags for eye candy
	range = 2500
	n = 36
	for i = 1, n do
		local angle = 360/n*i
		local flagX, flagY = WT.GetPositionByCenterAndAngle( pos, angle, range)
		Logic.CreateEntity( Entities.XD_StandardLarge, flagX, flagY, angle + 90, 1)
	end
	local x, y, alpha
	for i = 1, 4 do
		for lambda = 0, 1, 0.04 do
			x, y, alpha = WT.GetSpiralPositionAndRot( range, math.pi, i/2*math.pi, 1-math.sqrt(1-lambda))
			Logic.CreateEntity( Entities.XD_StandardLarge, x + pos.X, y + pos.Y, alpha - 90, 1)
		end
	end
end
function WT.GetSpiralPositionAndRot( _r, _omega, _phiOff, _lambda)
	local angle = _omega*_lambda + _phiOff
	local cos = math.cos(angle)
	local sin = math.sin(angle)
	local x = (1-_lambda)*_r*cos
	local y = (1-_lambda)*_r*sin
	local dx = -(1-_lambda)*_r*sin*_omega - _r*cos
	local dy = (1-_lambda)*_r*cos*_omega - _r*sin
	return x, y, WT.GetAngleByDXDY( dx, dy)+90
end
function WT.GetAngleByDXDY( _dx, _dy)
	if _dx < 0 then 
		return 180 + math.deg(math.atan( _dy / _dx))
	else
		return math.deg(math.atan( _dy / _dx))
	end
end
function WT.GetPositionByCenterAndAngle( _center, _angle, _range)
	local x = _center.X + _range*math.cos(math.rad(_angle))
	local y = _center.Y + _range*math.sin(math.rad(_angle))
	return x,y
end
function WT.DEBUG_GetAngleToCenterFlag()
	local eId = GUI.GetSelectedEntity()
	local p1 = GetPosition("p1")
	local p2 = GetPosition(eId)
	local dX = p2.X - p1.X
	local dY = p2.Y - p1.Y
	LuaDebugger.Log(dX)
	LuaDebugger.Log(dY)
	if dX < 0 then 
		LuaDebugger.Log(180 + math.deg(math.atan(dY / dX)))
	else
		LuaDebugger.Log(math.deg(math.atan(dY / dX)))
	end
end
-- Is called by the OnEntityCreated-Trigger, fills the list of tracked entities and list of incomplete buildings
function WT_OnEntityCreated()
	local created = Event.GetEntityID()
	local pId = Logic.EntityGetPlayer( created)
	-- throw out bad player ids
	if pId == 0 or pId > 4 then
		return
	end
	-- track serfs
	if Logic.GetEntityType( created) == Entities.PU_Serf then
		table.insert( WT.ListOfTrackedEntities, created)
		return
	end
	-- and leaders
	if Logic.IsEntityInCategory( created, EntityCategories.Leader) == 1 then
		table.insert( WT.ListOfTrackedEntities, created)
		return
	end
	-- and building, but wait for completion
	if Logic.IsBuilding( created) == 1 then
		-- check if "building" is actually a construction site
		local typeName = Logic.GetEntityTypeName(Logic.GetEntityType( created))
		if string.find( typeName, "ConstructionSite") then
			return
		end
		table.insert( WT.ListOfIncompleteBuildings, created)
	end
	-- and heroes
	if Logic.IsHero( created) == 1 then
		table.insert( WT.ListOfTrackedEntities, created)
		return
	end
end
-- Cleans the list of tracked entities and incomplete buildings
function WT_TrackerWatchDog()
	-- clear the tracker list
	for i = table.getn(WT.ListOfTrackedEntities), 1, -1 do
		if IsDead(WT.ListOfTrackedEntities[i]) and Logic.IsHero(WT.ListOfTrackedEntities[i]) == 0 then
			table.remove( WT.ListOfTrackedEntities, i)
		end
	end
	-- clear the list of incomplete buildings
	for i = table.getn(WT.ListOfIncompleteBuildings), 1, -1 do
		if IsDead(WT.ListOfIncompleteBuildings[i]) then
			table.remove( WT.ListOfIncompleteBuildings, i)
		end
	end
	-- transfer ids to main list if building is complete
	for i = table.getn(WT.ListOfIncompleteBuildings), 1, -1 do
		if Logic.IsConstructionComplete(WT.ListOfIncompleteBuildings[i]) == 1 then
			local bId = WT.ListOfIncompleteBuildings[i]
			table.insert( WT.ListOfTrackedEntities, bId)
			table.remove( WT.ListOfIncompleteBuildings, i)
		end
	end
end
-- Actual getter function, returns 1 if team 1,2 has the flag, 2 if team 3,4 has the flag and 0 if none of the above holds
function WT.GetOwnerOfFlag( _x, _y, _range)
	local isNearby = {}
	for i = 1, 4 do
		isNearby[i] = false
	end
	for k,v in pairs(WT.ListOfTrackedEntities) do
		local pId = Logic.EntityGetPlayer( v)
		if pId < 5 then
			if WT.GetDistance( _x, _y, GetPosition(v)) < _range and IsAlive(v) then
				isNearby[pId] = true
			end
		end
	end	
	-- compute from the isNearby table the state of the flag
	local team1Nearby = isNearby[1] or isNearby[2]
	local team2Nearby = isNearby[3] or isNearby[4]
	if team1Nearby and not team2Nearby then
		return 1
	elseif team2Nearby and not team1Nearby then
		return 2
	else
		return 0
	end
end
function WT.GetDistance( _x, _y, _pos)
	local dX = _x - _pos.X
	local dY = _y - _pos.Y
	return( math.sqrt(dX*dX + dY*dY))
end

-- Code for changing flags when position gets conquered
function WT.GetFlagIDByPosition( _pos)
	local tol = 5000
	for k,v in pairs(WT.Flags) do
		local dX = math.abs( v.Position.X - _pos.X)
		local dY = math.abs( v.Position.Y - _pos.Y)
		-- use \ell^1 norm, im too lazy to code \ell^2 norm
		if dX + dY < tol then
			return k
		end
	end
	return 0
end
function WT.OnFlagOwnershipChange( _flagId, _newOwner)
	-- remove old flags if necessary
	for k,v in pairs(WT.ListOfStandardData) do
		if v.flag ==_flagId and v.eId ~= nil then
			DestroyEntity( v.eId)
			v.eId = nil
		end
	end
	-- create new flags if necessary
	-- dummy flags for neutral
	if _newOwner == 0 then
		for k,v in pairs(WT.ListOfStandardData) do
			if v.flag ==_flagId then
				v.eId = Logic.CreateEntity( Entities.XD_Rock1, v.pos.X, v.pos.Y, v.rot, 0)
				Logic.SetModelAndAnimSet( v.eId, Models.XD_StandartePlayerColor)
			end
		end
		return
	end
	-- get the correct player id
	-- for the flags we will use pId = offset + alt where alt is alternating from 0 to 1 and back
	local offset = 1
	local alt = 0
	if _newOwner == 2 then
		offset = 3
	end
	for k,v in pairs(WT.ListOfStandardData) do
		if v.flag ==_flagId then
			local eId = Logic.CreateEntity( Entities.XD_StandartePlayerColor, v.pos.X, v.pos.Y, v.rot, offset + alt)
			alt = 1 - alt
			v.eId = eId
		end
	end
end
function WT_FlagController()
	for i = 1, WT.NumFlags do
		WT.CheckTeamsInArea(i);
	end
	WT.UpdateScoreBars();
	if (WT.Score[1] >= WT.ScoreLimit) or (WT.Score[2] >= WT.ScoreLimit) then
		return true;
	end
end
function WT.CheckTeamsInArea(_flagIndex)
	local owner = WT.GetOwnerOfFlag( WT.Flags[_flagIndex].Position.X, WT.Flags[_flagIndex].Position.Y, WT.Flags[_flagIndex].Range)
	
	-- update if there is some change
	if owner ~= WT.Flags[_flagIndex].OldOwner then
		WT.OnFlagOwnershipChange( _flagIndex, owner)
		WT.Flags[_flagIndex].OldOwner = owner
	end
	
	if owner == 1 then
		WT.Score[1] = WT.Score[1] + WT.Flags[_flagIndex].GivePoints;
	elseif owner == 2 then
		WT.Score[2] = WT.Score[2] + WT.Flags[_flagIndex].GivePoints;
	end
end


function WT.ColorGrade(_c1, _c2, _lambda)
	return math.clamp(math.abs(math.floor(_c1*_lambda + _c2*(1-_lambda))),0,255);
end

function math.clamp(_v, _min, _max)
	return math.max(math.min(_v, _max), _min);
end

function WT.UpdateScoreBars()
	for teamId = 1,2 do
		XGUIEng.SetProgressBarValues("VCMP_Team"..teamId.."Progress", WT.Score[teamId], WT.ScoreLimit);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", "(" .. WT.Score[teamId] .. "/" .. WT.ScoreLimit .. ") " ..
			WT.GetPlayerColorString(WT.Teams[teamId][1]) .. " " .. UserTool_GetPlayerName(WT.Teams[teamId][1]) .. " @color:255,255,255,255 & "
			.. WT.GetPlayerColorString(WT.Teams[teamId][2]) .. " " .. UserTool_GetPlayerName(WT.Teams[teamId][2]));
	end
end

function WT.SetupFlagGUI()
	-- gradient 30, 150 to 255,242 to 255,0
	local r,g,b;
	local timeProgress;
	GUIUpdate_VCTechRaceProgress = function()
		for teamId = 1,2 do
			local r1,g1,b1 = GUI.GetPlayerColor(WT.Teams[teamId][1]);
			local r2,g2,b2 = GUI.GetPlayerColor(WT.Teams[teamId][2]);
			timeProgress = math.max(math.min(math.sin(0.25*XGUIEng.GetSystemTime()), 0.5), -0.5) + 0.5;
			r = WT.ColorGrade(r1,r2, timeProgress);
			g = WT.ColorGrade(g1,g2, timeProgress);
			b = WT.ColorGrade(b1,b2, timeProgress);
		
			XGUIEng.SetMaterialColor("VCMP_Team"..teamId.."Progress", 0, r, g, b, 255)
		end
	end
	GUIUpdate_VCTechRaceColor = function()end
	
	-- napo
	local barLength = 250
	local textBoxSize = 15
	--local barHeight = 4
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
	local r,g,b;
	for teamId = 1,2 do
		r,g,b = GUI.GetPlayerColor(WT.Teams[teamId][1]);
		XGUIEng.SetText("VCMP_Team"..teamId.."Name", "(" .. WT.Score[teamId] .. "/" .. WT.ScoreLimit .. ") " .. UserTool_GetPlayerName(WT.Teams[teamId][1]) .. " & " .. UserTool_GetPlayerName(WT.Teams[teamId][2]));
		XGUIEng.SetMaterialColor("VCMP_Team"..teamId.."Progress", 0, r, g, b, 150)
	end
end

-- ********************************************************************************************
-- ********************************************************************************************
-- ********************************************************************************************
-- ********************************************************************************************
-- ********************************************************************************************

function WT.InitTechnologyCounter()
	
	WT.TechnologyList =
	{
	
		{
			Technology = Technologies.GT_Alloying,
			ScoreGoal = 1500,
			Name = "Legierung",
		},
		
		{
			Technology = Technologies.GT_StandingArmy,
			ScoreGoal = 2000,
			Name = "Stehendes Heer"
		},
				{
			Technology = Technologies.GT_Trading,
			ScoreGoal = 2500,
			Name = "Handelswesen"
		},
		
		{
			Technology = Technologies.GT_Binocular,
			ScoreGoal = 3000,
			Name = "Fernglas"
		},
		
		{
			Technology = Technologies.UP1_University,
			ScoreGoal = 5000,
			Name = "Universität"
		},
		
		{
			Technology = Technologies.GT_Metallurgy,
			ScoreGoal = 6000,
			Name = "Metallurgie"
		},
		
		{
			Technology = Technologies.GT_Tactics,
			ScoreGoal = 7000,
			Name = "Taktiken"
		},
		
		{
			Technology = Technologies.GT_Matchlock,
			ScoreGoal = 7500,
			Name = "Luntenschloss"
		},
		
		{
			Technology = Technologies.UP2_Headquarter,
			ScoreGoal = 9000,
			Name = "Zitadelle"
		},
		
		{
			Technology = Technologies.GT_Strategies,
			ScoreGoal = 10000,
			Name = "Pferdezucht"
		},
		
		{
			Technology = Technologies.GT_Chemistry,
			ScoreGoal = 10000,
			Name = "Chemie"
		},
		
		{
			Technology = Technologies.MU_LeaderRifle,
			ScoreGoal = 12000,
			Name = "Scharfschützen"
		},
		
		{
			Technology = Technologies.T_UpgradeRifle1,
			ScoreGoal = 13000,
			Name = "Scharfschützen Stufe 2"
		},
		
	};
	
	-- a copy of technology list for each team
	-- to be emptied by point progress
	WT.TeamTechnologyList = {};
	for teamId = 1, WT.NumTeams do
		WT.TeamTechnologyList[teamId] = CopyTable(WT.TechnologyList);
	end
	
	WT.ForbidAllTechnologies();
	for teamId = 1, WT.NumTeams do
		WT.UpdateTechnologyGUI(teamId);
	end
	StartSimpleJob("WT_ControlTechnologyPoints");
end

function WT.ForbidAllTechnologies()
	for teamId = 1, WT.NumTeams do
		for playerIndex = 1, table.getn(WT.Teams[teamId]) do
			local playerId = WT.Teams[teamId][playerIndex];
			for i = 1, table.getn(WT.TechnologyList) do
				ForbidTechnology(WT.TechnologyList[i].Technology, playerId);
			end
		end
	end
end

function WT_ControlTechnologyPoints()
	local currentSCORE;
	for teamId = 1, WT.NumTeams do
		currentTeamScore = WT.Score[teamId];
		if WT.TeamTechnologyList[teamId][1] then	
			if currentTeamScore >= WT.TeamTechnologyList[teamId][1].ScoreGoal then
				for playerIndex = 1, table.getn(WT.Teams[teamId]) do
					AllowTechnology(WT.TeamTechnologyList[teamId][1].Technology, WT.Teams[teamId][playerIndex]);
				end
				table.remove(WT.TeamTechnologyList[teamId], 1);
				WT.UpdateTechnologyGUI(teamId);
			end
		end
		if currentTeamScore >= WT.ScoreLimit then
			WT.Win(teamId);
			return true;
		end
	end
end

function WT.UpdateTechnologyGUI(_teamId)
	local text = "@cr @cr @cr @cr @cr @cr @cr @cr @cr @cr @cr ";
	text = text .. " @color:30,144,255 Nächte Technologien: @cr @color:255,125,0 ";
	local myTeam = false;
	for playerIndex = 1, table.getn(WT.Teams[_teamId]) do
		if GUI.GetPlayerID() == WT.Teams[_teamId][playerIndex] then
			myTeam = true;
			break;
		end
	end
	if not myTeam then return end;
	
	for i = 1, 2 do
		if WT.TeamTechnologyList[_teamId][i] then
			text = text .. WT.TeamTechnologyList[_teamId][i].Name .. " (Punkte: " .. WT.TeamTechnologyList[_teamId][i].ScoreGoal .. ") @cr ";
		end
	end
	XGUIEng.SetText("EMSMAMITLeft", Umlaute(text));
end

function Umlaute( _text )
	local texttype = type( _text );
	if texttype == "string" then
		_text = string.gsub( _text, "ä", "\195\164" );
		_text = string.gsub( _text, "ö", "\195\182" );
		_text = string.gsub( _text, "ü", "\195\188" );
		_text = string.gsub( _text, "ß", "\195\159" );
		_text = string.gsub( _text, "Ä", "\195\132" );
		_text = string.gsub( _text, "Ö", "\195\150" );
		_text = string.gsub( _text, "Ü", "\195\156" );
		return _text;
	elseif texttype == "table" then
		for k,v in _text do
			_text[k] = Umlaute( v );
		end
		return _text;
	else
		return _text;
	end 
end

function WT.Win(_teamId)
	SetNeutral(1,3);
	SetNeutral(1,4);
	SetNeutral(2,3);
	SetNeutral(2,4);
	local p1,p2 = WT.Teams[_teamId][1], WT.Teams[_teamId][2];
	-- sieges nachricht 
	Message(WT.GetPlayerColorString(p1) .. UserTool_GetPlayerName(p1) .. " @color:255,125,0 "
		.. " und " .. WT.GetPlayerColorString(p2) .. UserTool_GetPlayerName(p2) .. " @color:255,125,0 haben gewonnen!");
		
	local ViewCenter;
	for i = 1,4 do
		ViewCenter = Logic.CreateEntity(Entities.XD_ScriptEntity,  Logic.WorldGetSize()/2, Logic.WorldGetSize()/2+i, 0, i)
		Logic.SetEntityExplorationRange(ViewCenter, Logic.WorldGetSize())
	end
end

function WT.GetPlayerColorString(_playerId)
	local r,g,b = GUI.GetPlayerColor(_playerId);
	return " @color:"..r..","..g..","..b.." ";
end

--[[
--- author: Noigi?		current maintainer: mcb		v2.0
--  kopiert ein table.
-- referenzerhaltend/metatablekopierend
function CopyTable(_t, ref)
	ref = ref or {}
	if type(_t) == "table" then
		if ref[_t] then
			return ref[_t]
		end
		local r = {}
		ref[_t] = r
		for k,v in pairs(_t) do
			r[k] = CopyTable(v, ref)
		end
		local mt = getmetatable(_t)
		if mt then
			if metatable then
				mt = CopyTable(mt, ref)
				mt.keySave = nil
				metatable.set(r, mt)
			else
				setmetatable(r, CopyTable(mt, ref))
			end
		end
		return r
	else
		return _t
	end
end ]]

function CreateUAs()
	BanditTower1UA = UnlimitedArmy:New({
						Player = 5,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditTower1UA.SpawnerActive = false
	BanditTower1UA:AddCommandSetSpawnerStatus(false,false)
	BanditTower1UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditTower1UA,{
						Position = GetPosition("BanditTower1"),
						ArmySize = 9,
						SpawnCounter = 120,
						SpawnLeaders = 9,
						LeaderDesc = {
								{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderRifle1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3}
								}
							})
	BanditTower2UA = UnlimitedArmy:New({
						Player = 5,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditTower2UA.SpawnerActive = false
	BanditTower2UA:AddCommandSetSpawnerStatus(false,false)
	BanditTower2UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditTower2UA,{
						Position = GetPosition("BanditTower2"),
						ArmySize = 9,
						SpawnCounter = 120,
						SpawnLeaders = 9,
						LeaderDesc = {
								{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderRifle1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3}
								}
							})
	BanditTower3UA = UnlimitedArmy:New({
						Player = 6,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditTower3UA.SpawnerActive = false
	BanditTower3UA:AddCommandSetSpawnerStatus(false,false)
	BanditTower3UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditTower3UA,{
						Position = GetPosition("BanditTower3"),
						ArmySize = 9,
						SpawnCounter = 120,
						SpawnLeaders = 9,
						LeaderDesc = {
								{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderRifle1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3}
								}
							})
	BanditTower4UA = UnlimitedArmy:New({
						Player = 6,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditTower4UA.SpawnerActive = false
	BanditTower4UA:AddCommandSetSpawnerStatus(false,false)
	BanditTower4UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditTower4UA,{
						Position = GetPosition("BanditTower4"),
						ArmySize = 9,
						SpawnCounter = 120,
						SpawnLeaders = 9,
						LeaderDesc = {
								{LeaderType = Entities.PU_LeaderHeavyCavalry2, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderPoleArm4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderBow4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PV_Cannon4, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderRifle1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3},
								{LeaderType = Entities.PU_LeaderSword4, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 3}
								}
							})
	BanditMid11UA = UnlimitedArmy:New({
						Player = 5,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditMid11UA.SpawnerActive = false
	BanditMid11UA:AddCommandSetSpawnerStatus(false,false)
	BanditMid11UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditMid11UA,{
							Position = GetPosition("BanditMid1"),
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderBow3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon2, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderPoleArm3, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderHeavyCavalry1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2}
									},
									})
	BanditMid12UA = UnlimitedArmy:New({
						Player = 5,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditMid12UA.SpawnerActive = false
	BanditMid12UA:AddCommandSetSpawnerStatus(false,false)
	BanditMid12UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditMid12UA,{
							Position = GetPosition("BanditMid1"),
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderBow3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon2, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderPoleArm3, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderHeavyCavalry1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2}
									},
									})
	BanditMid21UA = UnlimitedArmy:New({
						Player = 6,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditMid21UA.SpawnerActive = false
	BanditMid21UA:AddCommandSetSpawnerStatus(false,false)
	BanditMid21UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditMid21UA,{
							Position = GetPosition("BanditMid2"),
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderBow3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon2, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderPoleArm3, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderHeavyCavalry1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2}
									}
									})
	BanditMid22UA = UnlimitedArmy:New({
						Player = 6,
						Area = 4000,
						AutoDestroyIfEmpty = false,
						TransitAttackMove = true,
						Formation = UnlimitedArmy.Formations.Chaotic,
						LeaderFormation = FormationFunktion,
						AutoRotateRange = true,
						DoNotNormalizeSpeed = false,
						IgnoreFleeing = false
						})
	BanditMid22UA.SpawnerActive = false
	BanditMid22UA:AddCommandSetSpawnerStatus(false,false)
	BanditMid22UASpawnGenerator = UnlimitedArmySpawnGenerator:New(BanditMid22UA,{
							Position = GetPosition("BanditMid2"),
							ArmySize = 10,
							SpawnCounter = 60,
							SpawnLeaders = 10,
							LeaderDesc = {
									{LeaderType = Entities.PU_LeaderSword3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderBow3, SoldierNum = 8, SpawnNum = 3, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon2, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderCavalry2, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderPoleArm3, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2},
									{LeaderType = Entities.PV_Cannon3, SoldierNum = 8, SpawnNum = 1, Looped = true, Experience = 2},
									{LeaderType = Entities.PU_LeaderHeavyCavalry1, SoldierNum = 8, SpawnNum = 2, Looped = true, Experience = 2}
									},
									})
end

FormationFunktion = function(self, truppid)
	if Logic.IsEntityInCategory(truppid, EntityCategories.Cannon)==1 then
		return 1
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Hero)==1 then
		return 1
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.CavalryHeavy)==1 then
		return 7
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.CavalryLight)==1 then
		return 2
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Bow)==1 or Logic.IsEntityInCategory(truppid, EntityCategories.Rifle)==1 then
		return 2
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Spear)==1 then
		return 6
	end
	if Logic.IsEntityInCategory(truppid, EntityCategories.Sword)==1 then
		return 4
	end
	return 1
end

function PunkteCounter()
	--UA richtung mitte
	if (WT.Score[2] >= math.floor(WT.ScoreLimit * 0.4)) and not Team1MidArmy then
		Team1MidArmy = true
		BanditMid11UA:AddCommandSetSpawnerStatus(true,false)
		BanditMid11UA:AddCommandWaitForSpawnerFull(true)
		BanditMid11UA:AddCommandSetSpawnerStatus(false,true)
		BanditMid11UA:AddCommandWaitForIdle(true)
		BanditMid11UA:AddCommandMove(GetPosition("BanditMid1"),true)
		BanditMid11UA:AddCommandWaitForIdle(true)
		BanditMid11UA:AddCommandMove(GetPosition("BanditMid1left"),true)
		BanditMid11UA:AddCommandWaitForIdle(true)
		BanditMid11UA:AddCommandMove(GetPosition("p1"),true)
		BanditMid11UA:AddCommandWaitForIdle(true)
		BanditMid11UA:AddCommandDefend(GetPosition("p1"), 6500, true)
		BanditMid11UA:AddCommandSetSpawnerStatus(true,true)	

		BanditMid12UA:AddCommandSetSpawnerStatus(true,false)
		BanditMid12UA:AddCommandWaitForSpawnerFull(true)
		BanditMid12UA:AddCommandSetSpawnerStatus(false,true)
		BanditMid12UA:AddCommandWaitForIdle(true)
		BanditMid12UA:AddCommandMove(GetPosition("BanditMid1"),true)
		BanditMid12UA:AddCommandWaitForIdle(true)
		BanditMid12UA:AddCommandMove(GetPosition("BanditMid1right"),true)
		BanditMid12UA:AddCommandWaitForIdle(true)
		BanditMid12UA:AddCommandMove(GetPosition("p1"),true)
		BanditMid12UA:AddCommandWaitForIdle(true)
		BanditMid12UA:AddCommandDefend(GetPosition("p1"), 6500, true)
		BanditMid12UA:AddCommandSetSpawnerStatus(true,true)			
	elseif (WT.Score[1] >= math.floor(WT.ScoreLimit * 0.4)) and not Team2MidArmy then
		Team2MidArmy = true
		BanditMid21UA:AddCommandSetSpawnerStatus(true,false)
		BanditMid21UA:AddCommandWaitForSpawnerFull(true)
		BanditMid21UA:AddCommandSetSpawnerStatus(false,true)
		BanditMid21UA:AddCommandWaitForIdle(true)
		BanditMid21UA:AddCommandMove(GetPosition("BanditMid2"),true)
		BanditMid21UA:AddCommandWaitForIdle(true)
		BanditMid21UA:AddCommandMove(GetPosition("BanditMid2left"),true)
		BanditMid21UA:AddCommandWaitForIdle(true)
		BanditMid21UA:AddCommandMove(GetPosition("p1"),true)
		BanditMid21UA:AddCommandWaitForIdle(true)
		BanditMid21UA:AddCommandDefend(GetPosition("p1"), 6500, true)
		BanditMid21UA:AddCommandSetSpawnerStatus(true,true)	

		BanditMid22UA:AddCommandSetSpawnerStatus(true,false)
		BanditMid22UA:AddCommandWaitForSpawnerFull(true)
		BanditMid22UA:AddCommandSetSpawnerStatus(false,true)
		BanditMid22UA:AddCommandWaitForIdle(true)
		BanditMid22UA:AddCommandMove(GetPosition("BanditMid2"),true)
		BanditMid22UA:AddCommandWaitForIdle(true)
		BanditMid22UA:AddCommandMove(GetPosition("BanditMid2right"),true)
		BanditMid22UA:AddCommandWaitForIdle(true)
		BanditMid22UA:AddCommandMove(GetPosition("p1"),true)
		BanditMid22UA:AddCommandWaitForIdle(true)
		BanditMid22UA:AddCommandDefend(GetPosition("p1"), 6500, true)
		BanditMid22UA:AddCommandSetSpawnerStatus(true,true)
	end
	--UA richtung außenpunkte
	if (WT.Score[1] >= math.floor(WT.ScoreLimit * 0.6)) and not Team2SideArmy then
		Team2SideArmy = true
		BanditTower3UA:AddCommandSetSpawnerStatus(true,false)
		BanditTower3UA:AddCommandWaitForSpawnerFull(true)
		BanditTower3UA:AddCommandSetSpawnerStatus(false,true)
		BanditTower3UA:AddCommandWaitForIdle(true)
		BanditTower3UA:AddCommandMove(GetPosition("BanditTower3"),true)
		BanditTower3UA:AddCommandWaitForIdle(true)
		BanditTower3UA:AddCommandMove(GetPosition("p2"),true)
		BanditTower3UA:AddCommandWaitForIdle(true)
		BanditTower3UA:AddCommandMove(GetPosition("p3"),true)
		BanditTower3UA:AddCommandWaitForIdle(true)
		BanditTower3UA:AddCommandDefend(GetPosition("p3"), 4500, true)
		BanditTower3UA:AddCommandSetSpawnerStatus(true,true)
		
		BanditTower4UA:AddCommandSetSpawnerStatus(true,false)
		BanditTower4UA:AddCommandWaitForSpawnerFull(true)
		BanditTower4UA:AddCommandSetSpawnerStatus(false,true)
		BanditTower4UA:AddCommandWaitForIdle(true)
		BanditTower4UA:AddCommandMove(GetPosition("BanditTower4"),true)
		BanditTower4UA:AddCommandWaitForIdle(true)
		BanditTower4UA:AddCommandMove(GetPosition("p5"),true)
		BanditTower4UA:AddCommandWaitForIdle(true)
		BanditTower4UA:AddCommandMove(GetPosition("p4"),true)
		BanditTower4UA:AddCommandWaitForIdle(true)
		BanditTower4UA:AddCommandDefend(GetPosition("p4"), 4500, true)
		BanditTower4UA:AddCommandSetSpawnerStatus(true,true)
		
		
		BanditMid21UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderSword3)
		BanditMid21UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderBow3)
		BanditMid21UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderPoleArm3)
		BanditMid21UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderHeavyCavalry1)
		BanditMid21UASpawnGenerator:RemoveLeaderType(Entities.PV_Cannon2)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PU_LeaderSword4, 8, 3, 3, true)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PU_LeaderBow4, 8, 3, 3, true)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PV_Cannon4, 8, 2, 3, true)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PV_Cannon3, 8, 1, 3, true)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PU_LeaderHeavyCavalry2, 8, 2, 3, true)
		BanditMid21UASpawnGenerator:AddLeaderType(Entities.PU_LeaderPoleArm4, 8, 2, 3, true)
		
		BanditMid22UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderSword3)
		BanditMid22UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderBow3)
		BanditMid22UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderPoleArm3)
		BanditMid22UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderHeavyCavalry1)
		BanditMid22UASpawnGenerator:RemoveLeaderType(Entities.PV_Cannon2)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PU_LeaderSword4, 8, 3, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PU_LeaderBow4, 8, 3, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PV_Cannon4, 8, 2, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PV_Cannon3, 8, 1, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PU_LeaderHeavyCavalry2, 8, 2, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PU_LeaderPoleArm4, 8, 2, 3, true)
		BanditMid22UASpawnGenerator:AddLeaderType(Entities.PU_LeaderRifle2, 8, 2, 3, true)
	elseif (WT.Score[2] >= math.floor(WT.ScoreLimit * 0.6)) and not Team1SideArmy then
		Team1SideArmy = true
		BanditTower1UA:AddCommandSetSpawnerStatus(true,false)
		BanditTower1UA:AddCommandWaitForSpawnerFull(true)
		BanditTower1UA:AddCommandSetSpawnerStatus(false,true)
		BanditTower1UA:AddCommandWaitForIdle(true)
		BanditTower1UA:AddCommandMove(GetPosition("BanditTower1"),true)
		BanditTower1UA:AddCommandWaitForIdle(true)
		BanditTower1UA:AddCommandMove(GetPosition("p4"),true)
		BanditTower1UA:AddCommandWaitForIdle(true)
		BanditTower1UA:AddCommandMove(GetPosition("p5"),true)
		BanditTower1UA:AddCommandWaitForIdle(true)
		BanditTower1UA:AddCommandDefend(GetPosition("p5"), 4500, true)
		BanditTower1UA:AddCommandSetSpawnerStatus(true,true)
		
		BanditMid11UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderSword3)
		BanditMid11UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderBow3)
		BanditMid11UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderPoleArm3)
		BanditMid11UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderHeavyCavalry1)
		BanditMid11UASpawnGenerator:RemoveLeaderType(Entities.PV_Cannon2)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PU_LeaderSword4, 8, 3, 3, true)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PU_LeaderBow4, 8, 3, 3, true)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PV_Cannon4, 8, 2, 3, true)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PV_Cannon3, 8, 1, 3, true)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PU_LeaderHeavyCavalry2, 8, 2, 3, true)
		BanditMid11UASpawnGenerator:AddLeaderType(Entities.PU_LeaderPoleArm4, 8, 2, 3, true)
		
		BanditMid12UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderSword3)
		BanditMid12UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderBow3)
		BanditMid12UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderPoleArm3)
		BanditMid12UASpawnGenerator:RemoveLeaderType(Entities.PU_LeaderHeavyCavalry1)
		BanditMid12UASpawnGenerator:RemoveLeaderType(Entities.PV_Cannon2)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PU_LeaderSword4, 8, 3, 3, true)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PU_LeaderBow4, 8, 3, 3, true)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PV_Cannon4, 8, 2, 3, true)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PV_Cannon3, 8, 1, 3, true)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PU_LeaderHeavyCavalry2, 8, 2, 3, true)
		BanditMid12UASpawnGenerator:AddLeaderType(Entities.PU_LeaderPoleArm4, 8, 2, 3, true)
		
		BanditTower2UA:AddCommandSetSpawnerStatus(true,false)
		BanditTower2UA:AddCommandWaitForSpawnerFull(true)
		BanditTower2UA:AddCommandSetSpawnerStatus(false,true)
		BanditTower2UA:AddCommandWaitForIdle(true)
		BanditTower2UA:AddCommandMove(GetPosition("BanditTower2"),true)
		BanditTower2UA:AddCommandWaitForIdle(true)
		BanditTower2UA:AddCommandMove(GetPosition("p3"),true)
		BanditTower2UA:AddCommandWaitForIdle(true)
		BanditTower2UA:AddCommandMove(GetPosition("p2"),true)
		BanditTower2UA:AddCommandWaitForIdle(true)
		BanditTower2UA:AddCommandDefend(GetPosition("p2"), 4500, true)
		BanditTower2UA:AddCommandSetSpawnerStatus(true,true)
	end
	return false
end