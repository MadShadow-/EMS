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
	Version = 1,
 
	-- ********************************************************************************************
	-- * Callback_OnMapStart
	-- * Called directly after the loading screen vanishes and works as your entry point.
	-- * Similar use to FirstMapAction/GameCallback_OnGameSart
	-- ********************************************************************************************
 
	Callback_OnMapStart = function()
		AddPeriodicSummer(60);
		SetupHighlandWeatherGfxSet();
		LocalMusic.UseSet = HIGHLANDMUSIC;
	end,
 
 
	-- ********************************************************************************************
	-- * Callback_OnGameStart
	-- * Called at the end of the 10 seconds delay, after the host chose the rules and started
	-- ********************************************************************************************
	Callback_OnGameStart = function()
		Comfort_TrackEntitysIni()	
		
		Comfort_TrackEntityIni(0,Entities.XD_DrawBridgeOpen1)
		for i = 1, table.getn( Track_Entity_Table[0][Entities.XD_DrawBridgeOpen1] ) do
			MakeInvulnerable(ReplaceEntity(Logic.GetEntityName(Track_Entity_Table[0][Entities.XD_DrawBridgeOpen1][i]),Entities.PB_DrawBridgeClosed1))
		end
		-- Söldnerquartiere			
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 30700, 31900, 0, 8 ), "merc_1" )
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 27100, 31800, 180, 8 ), "merc_2" )
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 27100, 25900, 180, 8 ), "merc_3" )
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 30600, 25800, 0, 8 ), "merc_4" )
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 29000, 24600, 90, 8 ), "merc_5" )
		Logic.SetEntityName ( Logic.CreateEntity( Entities.CB_Mercenary, 29000, 33300, 270, 8 ), "merc_6" )
					
		Logic.AddMercenaryOffer( GetEntityId( "merc_5" ), Entities.CU_Barbarian_LeaderClub2, 20, ResourceType.Gold, 1000, ResourceType.Iron, 500 )
		Logic.AddMercenaryOffer( GetEntityId( "merc_5" ), Entities.CU_BlackKnight_LeaderMace2, 100, ResourceType.Gold, 1000, ResourceType.Iron, 500 )
		Logic.AddMercenaryOffer( GetEntityId( "merc_6" ), Entities.CU_Barbarian_LeaderClub2, 20, ResourceType.Gold, 1000, ResourceType.Iron, 500 )
		Logic.AddMercenaryOffer( GetEntityId( "merc_6" ), Entities.CU_BlackKnight_LeaderMace2, 100, ResourceType.Gold, 1000, ResourceType.Iron, 500 )
		for i = 1,4 do
			Logic.AddMercenaryOffer( GetEntityId( "merc_"..i ), Entities.PU_Scout, 50, ResourceType.Gold, 200, ResourceType.Iron, 100 )
			Logic.AddMercenaryOffer( GetEntityId( "merc_"..i ), Entities.PU_Serf, 100, ResourceType.Gold, 75)
		end
	end,
 
	-- ********************************************************************************************
	-- * Callback_OnPeacetimeEnded
	-- * Called when the peacetime counter reaches zero
	-- ********************************************************************************************
	Callback_OnPeacetimeEnded = function()
		for i = 1,21 do
			ReplaceEntity("Door_"..i,Entities.XD_WallStraightGate);	
		end
	end,
 
 
	-- ********************************************************************************************
	-- * Peacetime
	-- * Number of minutes the players will be unable to attack each other
	-- ********************************************************************************************
	Peacetime = 30,
 
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
	-- * You could give different ressources or change the map environment accordingly
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
				500,
				2200,
				1600,
				800,
				50,
				50,
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
};


function Comfort_TrackEntitysIni()	
	-- Trackt alle initialisierten Entitys
	Track_Entity_Table = {}
	for _pId = 0,8 do
		Track_Entity_Table[_pId] = {}
	end
	Comfort_TrackEntityIni = function(_pId,_eType)
		Track_Entity_Table[_pId][_eType] = {}
		Track_Entity_Table[_pId][_eType].tracked = true
		if not(_pId == 0) then
			local temp = {Logic.GetPlayerEntities(_pId, _eType,1)}
			if temp[1] > 0 then
				local latestEntity = temp[2]
				for u = 1, Logic.GetNumberOfEntitiesOfTypeOfPlayer(_pId, _eType) do
					if latestEntity ~= 0 then
						table.insert(Track_Entity_Table[_pId][_eType], latestEntity)
					end		
					latestEntity = Logic.GetNextEntityOfPlayerOfType(latestEntity);
				end
			end			
		else
			Track_Entity_Table[_pId][_eType] = SucheAufDerWelt(_pId,_eType)
		end
	end
	
	Comfort_TrackEntity_Created = function(_eId,_pId)
		if _eId == nil then
			_eId = Event.GetEntityID()
			_pId = GetPlayer(_eId)
		end
		local _eType = Logic.GetEntityType(_eId)
		--if Logic.IsBuilding(_eId) == 1 then
		if Comfort_TrackEntity_IsTracked(_pId,_eType) then
			if Track_Entity_Table[_pId][_eType].tracked then
				local _drin = false
				for i = 1, table.getn(Track_Entity_Table[_pId][_eType]) do
					if _eId == Track_Entity_Table[_pId][_eType][i] then
						_drin = true
						break
					end
				end
				if not _drin then
					table.insert(Track_Entity_Table[_pId][_eType], _eId)
				end
			end
		end
	end
	
	Comfort_TrackEntity_Destroyed = function()
		local _eId = Event.GetEntityID()
		local _pId = GetPlayer(_eId)
		local _eType = Logic.GetEntityType(_eId)
		if Comfort_TrackEntity_IsTracked(_pId,_eType) then					
			for i = 1, table.getn(Track_Entity_Table[_pId][_eType]) do
				if _eId == Track_Entity_Table[_pId][_eType][i] then
					table.remove(Track_Entity_Table[_pId][_eType], i)
					break
				end
			end
		end	
	end	
	
	Comfort_TrackEntity_IsTracked = function(_pId, _eType, _TypeOrId)
		if _TypeOrId == false then _eType = Logic.GetEntityType(_eTypeOrId) end
		if type(Track_Entity_Table[_pId]) == "table" then
			if type(Track_Entity_Table[_pId][_eType]) == "table" then
			else return false
			end
		else return false
		end
		return Track_Entity_Table[_pId][_eType].tracked	
	end		
	Comfort_TrackEntity_RemoveTracking = function(_pId, _eType)
		Track_Entity_Table[_pId][_eType] = {}
		Track_Entity_Table[_pId][_eType].tracked = false
	end
	Comfort_TrackEntity_GetCount = function(_pId,_eType,_onlyConstructed)
		assert( type(_pId) == "number", "Spieler ID muss Zahl sein!" )
		assert( type(_eType) == "number", "Entity Typ muss Zahl sein!" )
		assert( Comfort_TrackEntity_IsTracked(_pId,_eType), "Entity Typ wird nicht getrackt!" )
		_onlyConstructed = _onlyConstructed or false
		if not(_onlyConstructed) then
			return table.getn(Track_Entity_Table[_pId][_eType])
		else
			local _count = 0	
			for i = 1, table.getn(Track_Entity_Table[_pId][_eType]) do
				_count = _count + Logic.IsConstructionComplete(Track_Entity_Table[_pId][_eType][i]) 
			end
			return _count
		end
	end
	
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_CREATED, "", "Comfort_TrackEntity_Created", 1)
	Trigger.RequestTrigger( Events.LOGIC_EVENT_ENTITY_DESTROYED, "", "Comfort_TrackEntity_Destroyed", 1)
end

function SucheAufDerWelt(_player, _entity, _groesse, _punkt)
	local punktX1, punktX2, punktY1, punktY2, data
	local gefunden = {}
	local rueck
	if not _groesse then
		_groesse = Logic.WorldGetSize() 
	end
	if not _punkt then
		_punkt = {X = _groesse/2, Y = _groesse/2}
	end
	if _player == 0 then
		data ={Logic.GetEntitiesInArea(_entity, _punkt.X, _punkt.Y, math.floor(_groesse * 0.71), 16)}
	else
		data ={Logic.GetPlayerEntitiesInArea(_player,_entity, _punkt.X, _punkt.Y, math.floor(_groesse * 0.71), 16)}
	end
	if data[1] >= 16 then -- Aufteilen angesagt
		local _klgroesse = _groesse / 2 
		-- Ausgangspunkt ist _punkt
		-- _punkt verteilen
		local punktX1 = _punkt.X - _groesse / 4
		local punktX2 = _punkt.X + _groesse / 4
		local punktY1 = _punkt.Y - _groesse / 4
		local punktY2 = _punkt.Y + _groesse / 4
		rueck = SucheAufDerWelt(_player, _entity, _klgroesse, {X=punktX1,Y=punktY1})
		for i = 1, table.getn(rueck) do
			if not IstDrin(rueck[i], gefunden) then
				table.insert(gefunden, rueck[i])
			end
		end
		rueck = SucheAufDerWelt(_player, _entity, _klgroesse, {X=punktX1,Y=punktY2})
		for i = 1, table.getn(rueck) do
			if not IstDrin(rueck[i], gefunden) then
				table.insert(gefunden, rueck[i])
			end
		end
		rueck = SucheAufDerWelt(_player, _entity, _klgroesse, {X=punktX2,Y=punktY1})
		for i = 1, table.getn(rueck) do
			if not IstDrin(rueck[i], gefunden) then
				table.insert(gefunden, rueck[i])
			end
		end
		rueck = SucheAufDerWelt(_player, _entity, _klgroesse, {X=punktX2,Y=punktY2})
		for i = 1, table.getn(rueck) do
			if not IstDrin(rueck[i], gefunden) then
				table.insert(gefunden, rueck[i])
			end
		end
	else
		table.remove(data,1)
		for i = 1, table.getn(data) do
			if not IstDrin(data[i], gefunden) then
				table.insert(gefunden, data[i])
			end
		end
	end
	return gefunden
end
function IstDrin(_wert, _table)
  for i = 1, table.getn(_table) do
    if _table[i] == _wert then 
        return true 
    end 
  end
  return false
end