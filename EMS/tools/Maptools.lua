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
		CNetwork.SetNetworkHandler("MapTools.RemoveTurretCosts", function(name, _player)
			MapTools.RemoveTurretCosts(_player)
		end);
	end
end

MapTools.NonFastGameTypes =
{
	[Entities.PB_Headquarters1] = true,
	[Entities.PB_Headquarters2] = true,
	[Entities.PB_Headquarters1] = true,
	
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
	for playerId, playerData in pairs(MCS.PlayerList) do
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

