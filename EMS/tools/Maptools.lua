MapTools = {};

function MapTools.NoResourcePaybackForStartTurrets()
	MapTools.StartTurrets = {};
	local nrOfPlayers = 1;
	if XNetwork then
		nrOfPlayers = XNetwork.GameInformation_GetMapMaximumNumberOfHumanPlayer();
		if nrOfPlayers == 0 then
			nrOfPlayers = 1;
		end
	end
	for playerId = 1, nrOfPlayers do
		local n,eID = Logic.GetPlayerEntities(playerId, Entities.PB_Tower3, 1);
		if (n > 0) then
			local firstEntity = eID;
			repeat
				MapTools.StartTurrets[eID] = true;
				eID = Logic.GetNextEntityOfPlayerOfType(eID);
			until (firstEntity == eID);
		end
	end
	MapTools.GUI_SellBuildingStartTowers = GUI.SellBuilding;
	GUI.SellBuilding = function(_eId)
		if MapTools.StartTurrets[_eId] then
			Sync.Call("MapTools.RemoveTurretCosts", GetPlayer(_eId));
			MapTools.StartTurrets[_eId] = nil;
		end
		MapTools.GUI_SellBuildingStartTowers(_eId);
	end
	MapTools.RemoveTurretCosts = function(_player)
		AddWood(_player, -100);
		AddStone(_player, -100);
	end
	
	if CNetwork then
		CNetwork.SetNetworkHandler("MapTools.RemoveTurretCosts", function(_name, _player)
			if CNetwork.IsAllowedToManipulatePlayer(_name, _player) then
				MapTools.RemoveTurretCosts(_player)
			end
		end);
	end
end

MapTools.NonFastGameTypes =
{
	[Entities.PB_Headquarters1] = true,
	[Entities.PB_Headquarters2] = true,
	[Entities.PB_Headquarters3] = true,
	
	[Entities.PB_VillageCenter1] = true,
	[Entities.PB_VillageCenter2] = true,
	[Entities.PB_VillageCenter3] = true,
	[Entities.XS_Ambient] = true,
	[Entities.XD_StandartePlayerColor] = true,
	[Entities.XD_ScriptEntity] = true,
}

MapTools.FastGameEntities = {};
function MapTools.RemoveFastGameEntities()
	local eType;
	for playerId, playerData in pairs(EMS.PlayerList) do
		for eId in S5Hook.EntityIterator(Predicate.OfPlayer(playerId)) do
			eType = Logic.GetEntityType(eId);
			if not MapTools.NonFastGameTypes[eType] then
				table.insert(MapTools.FastGameEntities, MapTools.GetEntityProps(eId));
				DestroyEntity(eId);
			end
		end
	end
end

function MapTools.RecreateFastGameEntities()
	for i = 1, table.getn(MapTools.FastGameEntities) do
		MapTools.CreateEntityByProps(MapTools.FastGameEntities[i]);
	end
end

function MapTools.GetEntityProps(_eId)
	return
	{
		Logic.GetEntityType(_eId),
		GetPosition(_eId).X,
		GetPosition(_eId).Y,
		Logic.GetEntityOrientation(_eId),
		GetPlayer(_eId),
	}
end

function MapTools.CreateEntityByProps(_props)
	Logic.CreateEntity(unpack(_props));
end

function MapTools.WallsToPlayerZero(...)
	local replace = function(_type)
		local pos, ori, name, newEntity;
		for eId in S5Hook.EntityIterator(Predicate.OfType(_type)) do
			MapTools.ReplaceEntity(eId, _type, 0);
		end
	end
	for i = 1, table.getn(arg) do
		replace(arg[i]);
	end
end

function MapTools.OpenGates(...)
	local gateType = Entities.XD_WallStraightGate;
	for i = 1, table.getn(arg) do
		if arg[i] == Entities.XD_WallStraightGate_Closed then
			gateType = Entities.XD_WallStraightGate;
		elseif arg[i] == Entities.XD_PalisadeGate1 then
			gateType = Entities.XD_PalisadeGate2;
		elseif arg[i] == Entities.XD_DarkWallStraightGate_Closed then
			gateType = Entities.XD_DarkWallStraightGate;
		end
		for eId in S5Hook.EntityIterator(Predicate.OfType(arg[i])) do
			MapTools.ReplaceEntity(eId, gateType);
		end
	end
end

function MapTools.OpenWallGates()
	MapTools.OpenGates(Entities.XD_DarkWallStraightGate_Closed);
	MapTools.OpenGates(Entities.XD_WallStraightGate_Closed);
end

function MapTools.OpenPalisadeGates()
	MapTools.OpenGates(Entities.XD_PalisadeGate1);
end

function MapTools.ReplaceEntity(_eId, _replaceType, _playerId)
	local pos, ori, name, newEntity, player;
	pos = GetPosition(_eId);
	ori = Logic.GetEntityOrientation(_eId);
	name = Logic.GetEntityName(_eId);
	playerId = Logic.EntityGetPlayer(_eId);
	DestroyEntity(_eId);
	newEntity = Logic.CreateEntity(_replaceType, pos.X, pos.Y, ori, _playerId or playerId);
	if name then
		SetEntityName(newEntity, name);
	end
end

-- replaces all entities of type _entityType with woodpiles
function MapTools.CreateWoodPiles(_amountOfWood, _entityType)
	if not _entityType then
		_entityType = Entities.XD_SingnalFireOff;
	end
	local pos;
	for eId in S5Hook.EntityIterator(Predicate.OfType(_entityType)) do
		pos = GetPosition(eId);
		DestroyEntity(eId);
		MapTools.CreateWoodPile( pos.X, pos.Y, _amountOfWood);
	end
end

--[[
function MapTools.CreateWoodPile( _entityId, _amountOfWood )
	LuaDebugger.Break();
    assert( type( _entityId ) == "number" );
    assert( type( _amountOfWood ) == "number" );
    MapTools.WoodPiles = MapTools.WoodPiles or {
        JobId = StartSimpleJob("MapTools_ControlWoodPiles"),
	--	UniqueNumber = 0,
    };
	
	--MapTools.WoodPiles.UniqueNumber = MapTools.WoodPiles.UniqueNumber + 1;
    local pos = GetPosition( _entityId );
    local woodPileId = Logic.CreateEntity( Entities.XD_ResourceTree, pos.X, pos.Y, 0, 0 );
    --SetEntityName( woodPileId, "WoodPile"..MapTools.WoodPiles.UniqueNumber );
	
	Logic.SetModelAndAnimSet(woodPileId, Models.XD_SignalFire1);
    Logic.SetResourceDoodadGoodAmount(woodPileId, _amountOfWood*10);
	local woodPileEffectId = Logic.CreateEntity(Entities.XD_Rock03, pos.X, pos.Y, 0, 0);
	Logic.SetModelAndAnimSet(woodPileEffectId, Models.Effects_XF_ChopTree);
    table.insert( MapTools.WoodPiles, { WoodPileId = woodPileId, EffectId = woodPileEffectId, ResourceLimit = _resources*9 } );
end

function MapTools_ControlWoodPiles()
    for i = table.getn( MapTools.WoodPiles ),1,-1 do
        if Logic.GetResourceDoodadGoodAmount( MapTools.WoodPiles[i].WoodPileId ) <= MapTools.WoodPiles[i].ResourceLimit then
            MapTools.DestroyWoodPile(MapTools.WoodPiles[i], i);
        end
    end
end

function MapTools.DestroyWoodPile( _piletable, _index )
    local pos = GetPosition(_piletable.WoodPileId);
    DestroyEntity(_piletable.WoodPileId);
    DestroyEntity(_piletable.EffectId);
    Logic.CreateEffect(GGL_Effects.FXCrushBuilding, pos.X, pos.Y, 0);
    table.remove(MapTools.WoodPiles, _index)
end]]

--[[
function MapTools.CreateWoodPile( _posEntity, _resources )
    assert( type( _resources ) == "number" );
    MapTools.gvWoodPiles = MapTools.gvWoodPiles or {
        JobID = StartSimpleJob("MapTools_ControlWoodPiles"),
    };
    local pos = GetPosition( _posEntity );
    local pile_id = Logic.CreateEntity( Entities.XD_Rock3, pos.X, pos.Y, 0, 0 );
	
    SetEntityName( pile_id, _posEntity.."_WoodPile" );
	
    local newE = ReplaceEntity( _posEntity, Entities.XD_ResourceTree );
	Logic.SetModelAndAnimSet(newE, Models.XD_SignalFire1);
    Logic.SetResourceDoodadGoodAmount( GetEntityId( _posEntity ), _resources*10 );
	Logic.SetModelAndAnimSet(pile_id, Models.Effects_XF_ChopTree);
    table.insert( MapTools.gvWoodPiles, { ResourceEntity = _posEntity, PileEntity = _posEntity.."_WoodPile", ResourceLimit = _resources*9 } );
end

function MapTools_ControlWoodPiles()
    for i = table.getn( MapTools.gvWoodPiles ),1,-1 do
        if Logic.GetResourceDoodadGoodAmount( GetEntityId( MapTools.gvWoodPiles[i].ResourceEntity ) ) <= MapTools.gvWoodPiles[i].ResourceLimit then
            MapTools.DestroyWoodPile( MapTools.gvWoodPiles[i], i );
        end
    end
end
 
function MapTools.DestroyWoodPile( _piletable, _index )
    local pos = GetPosition( _piletable.ResourceEntity );
    DestroyEntity( _piletable.ResourceEntity );
    DestroyEntity( _piletable.PileEntity );
    Logic.CreateEffect( GGL_Effects.FXCrushBuilding, pos.X, pos.Y, 0 );
    table.remove( MapTools.gvWoodPiles, _index )
end]]

function MapTools.CreateWoodPile(_x, _y, _resources)
	local eId = Logic.CreateEntity(Entities.XD_ResourceTree, _x, _y, 0, 0);
	Logic.SetResourceDoodadGoodAmount(eId, _resources * 10);
	Logic.SetModelAndAnimSet(eId, Models.XD_SignalFire1);
	MapTools.WoodPiles = MapTools.WoodPiles or {};
	MapTools.WoodPiles[eId] = {ResourceLimit=_resources * 9, X=_x, Y=_y};
	if not MapTools.WoodPileControlJob then
		MapTools.WoodPileControlJob = StartSimpleJob("MapTools_ControlWoodPiles");
	end
end

function MapTools_ControlWoodPiles()
	for eId, t in pairs(MapTools.WoodPiles) do
		if Logic.GetResourceDoodadGoodAmount(eId) <= t.ResourceLimit then
            MapTools.DestroyWoodPile(eId, t.X, t.Y);
			MapTools.WoodPiles[eId] = nil;
        end
	end
end

function MapTools.DestroyWoodPile(_eId, _x, _y)
	DestroyEntity(_eId);
    Logic.CreateEffect( GGL_Effects.FXCrushBuilding, _x, _y, 0 );
end

function MapTools.SetMapResourceDefault()
	local resourceTable = {
		{Entities.XD_StonePit1, 100000},
		{Entities.XD_IronPit1, 100000},
		{Entities.XD_ClayPit1, 100000},
		{Entities.XD_SulfurPit1, 100000},
		{Entities.XD_Stone1, 4000},
		{Entities.XD_Iron1, 4000},
		{Entities.XD_Clay1, 4000},
		{Entities.XD_Sulfur1, 4000}
	}
	MapTools.SetMapResource(resourceTable);
end

function MapTools.SetMapResource(_resourceTable)
	for i = 1,table.getn(_resourceTable) do
		for eId in S5Hook.EntityIterator(Predicate.OfAnyType(_resourceTable[i][1])) do
			Logic.SetResourceDoodadGoodAmount(eId, _resourceTable[i][2]);
		end
	end
end

function MapTools.DestroyEntities(_type)
	for eId in S5Hook.EntityIterator(Predicate.OfAnyType(_type)) do
		DestroyEntity(eId);
	end
end

function MapTools.SetVillageCenterPlacesProvided(_buildingEntityType, _amountOfPlaces)
	S5Hook.GetRawMem(9002416)[0][16][_buildingEntityType*8+2][44]:SetInt(_amountOfPlaces);
end

--[[function ex()
	local buildingInfo =
	{
		SpawnInfo =
		{
			Type = Entities.PB_Tower3,
			X = 50000,
			Y = 60000,
			Rotation = 0,
			OwnerPlayer = 5, -- who owns the building on start
		},
		NeutralPlayer = 5,
		Entity = 0, -- [optional] if entity is already on map. else its spawned.
		RespawnCallback = function(_prevOwner, _newOwner)
			Message("New owner player is " .. _newOwner);
		end,
		ConquerConditionCallback = function(_buildingInfo) -- returns the playerId that has the building conquered or false if neutral
			local numEntities = 1;
			local range = 3000;
			local entities;
			local entitiesInArea = {};
			for playerId = 1,4 do
				entities = {Logic.GetPlayerEntitiesInArea(playerId, 0, _buildingInfo.SpawnInfo.X, _buildingInfo.SpawnInfo.Y, range, numEntities)}
				if entities[1] > 0 then
					entitiesInArea[playerId] = true;
				end
			end
			local t1 = entitiesInArea[1] and entitiesInArea[2];
			local t2 = entitiesInArea[3] and entitiesInArea[4];
			if t1 and t2 then
				if entitiesInArea[1] then return 1 else return 2 end;
			elseif t1 then
				if entitiesInArea[3] then return 3 else return 4 end;
			elseif t2 then
				return 3;
			end
			return false;
		end,
		HealthThresholdPercentage = 10, -- health at which building can be conquered
		RespawnHurtPercentage = 100, -- hp to hurt building in % of entity max health after (re)spawn
	};
	MapTools.AddConquerBuilding(buildingInfo);
end]]

MapTools.CB = {};
function MapTools.AddConquerBuilding(_buildingInfo)
	if not MapTools.ConquerBuildingSetupDone then
		MapTools.ConquerBuildingSetup();
	end
	if not _buildingInfo.MaxHealth then
		if _buildingInfo.Entity then
			_buildingInfo.MaxHealth = Logic.GetEntityMaxHealth(_buildingInfo.Entity);
		else
			_buildingInfo.MaxHealth = 0;
		end
	end
	if not IsAlive(_buildingInfo.Entity) then
		MapTools.CB.Spawn(_buildingInfo);
	end
	table.insert(MapTools.CB.BuildingInfos, _buildingInfo); 
end

function MapTools.ConquerBuildingSetup()
	if MapTools.ConquerBuildingSetupDone then return; end
	MapTools.ConquerBuildingSetupDone = true;
	MapTools.CB.BuildingInfos = {};

	StartSimpleJob("MapTools_ConquerBuildingController");
end

function MapTools_ConquerBuildingController()
	local building;
	local buildingInfo;
	for i = 1, table.getn(MapTools.CB.BuildingInfos) do
		buildingInfo = MapTools.CB.BuildingInfos[i];
		building = buildingInfo.Entity;
		if not IsAlive(building) or Logic.GetEntityHealth(building) < (buildingInfo.HealthThresholdPercentage * buildingInfo.MaxHealth) then
			if IsAlive(buildingInfo.Entity) then
				DestroyEntity(buildingInfo.Entity);
			end

			local newOwner = buildingInfo.ConquerConditionCallback(buildingInfo)
			if newOwner then
				MapTools.CB.NewOwner(buildingInfo, newOwner);
			else
				MapTools.CB.NewOwner(buildingInfo,  buildingInfo.NeutralPlayer);
			end
			MapTools.CB.RespawnBuilding(buildingInfo);
		end
	end
end

function MapTools.CB.NewOwner(_buildingInfo, _newOwner)
	_buildingInfo.PreviousOwner = _buildingInfo.SpawnInfo.Owner;
	_buildingInfo.SpawnInfo.Owner = _newOwner;
end

-- building has been conquered -> destroy and respawn
function MapTools.CB.RespawnBuilding(_buildingInfo)
	MapTools.CB.Spawn(_buildingInfo);

	-- reduce health
	_buildingInfo.MaxHealth = Logic.GetEntityMaxHealth(_buildingInfo.Entity) or 0;
	local hurtValue = _buildingInfo.MaxHealth * _buildingInfo.RespawnHurtPercentage;
	
	if _buildingInfo.SpawnInfo.Owner == _buildingInfo.NeutralPlayer then
		-- neutral respawn with low hp
		Logic.HurtEntity(_buildingInfo.Entity, _buildingInfo.MaxHealth - _buildingInfo.MaxHealth * _buildingInfo.HealthThresholdPercentage);
	else
		Logic.HurtEntity(_buildingInfo.Entity, hurtValue);
	end


	_buildingInfo.RespawnCallback(_buildingInfo.PreviousOwner, _buildingInfo.SpawnInfo.Owner);
end

function MapTools.CB.Spawn(_buildingInfo)
	local spawnInfo = _buildingInfo.SpawnInfo;
	_buildingInfo.Entity = Logic.CreateEntity(spawnInfo.Type, spawnInfo.X, spawnInfo.Y, spawnInfo.Rotation, spawnInfo.Owner);
end