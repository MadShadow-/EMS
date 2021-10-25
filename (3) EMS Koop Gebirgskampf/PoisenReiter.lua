gvTypesToTrack = {}
PlayerUnits = {}
PoisonPos = {}
giftreiter = {}
PoisonCounter = 1

function GetAllEntitiesOfPlayerOfType(_player, _type)
    local units = {};
    local n, first = Logic.GetPlayerEntities(_player, _type, 1);
    if n > 0 then
        local entity = first;
        repeat
            table.insert(units, entity)
            entity = Logic.GetNextEntityOfPlayerOfType(entity);
        until entity == first;
    end;
    
    return units;
end;

for k,v in pairs(Entities) do
        if (string.find(k, "CU_", 1, true) or string.find(k, "PU_", 1, true) or string.find(k, "PV_",1,true)) and not string.find(k, "Soldier", 1, true) and not string.find(k, "Hawk",1,true) and not string.find(k,"Hero2_",1,true)  then
            gvTypesToTrack[v] = true;
        end;
end;
	
for type, _ in pairs(gvTypesToTrack) do
	local units = GetAllEntitiesOfPlayerOfType(1, type);
	for i = 1,table.getn(units) do
		PlayerUnits[units[i]] = true;
	end;
	local units = GetAllEntitiesOfPlayerOfType(2, type);
	for i = 1,table.getn(units) do
		PlayerUnits[units[i]] = true;
	end;
	local units = GetAllEntitiesOfPlayerOfType(3, type);
	for i = 1,table.getn(units) do
		PlayerUnits[units[i]] = true;
	end;
end;

function P1EntityCreated()
	local id = Event.GetEntityID();
	local type = Logic.GetEntityType(id);
	if Logic.EntityGetPlayer(id) == 1 or Logic.EntityGetPlayer(id) == 2 or Logic.EntityGetPlayer(id) == 3 then
		if gvTypesToTrack[type] then
		   -- füge in liste ein
		PlayerUnits[id] = true;
		end;
	end
end

function P1EntityDestroied()
    local id = Event.GetEntityID();
    if Logic.EntityGetPlayer(id) == 1 or Logic.EntityGetPlayer(id) == 2 or Logic.EntityGetPlayer(id) == 3 then
        if PlayerUnits[id] then
            PlayerUnits[id] = nil;
        end;
    end
end

EntityCreatedTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_CREATED,nil,"P1EntityCreated",1,nil,nil)
EntityDestroiedTrigger = Trigger.RequestTrigger(Events.LOGIC_EVENT_ENTITY_DESTROYED,nil,"P1EntityDestroied",1,nil,nil)

function PoisenThrower()
	for j = table.getn(PoisonPos),1,-1 do
		local giftspot = PoisonPos[j]
		if giftspot.Dauer > 0 then
			for id,_ in pairs(PlayerUnits) do
				if GetSimpleDistanceSquared(giftspot,GetPosition(id)) < 360000 then
					if Logic.IsLeader(id) == 1 then
						local soldiers = {Logic.GetSoldiersAttachedToLeader(id)}
						local dmg = (soldiers[1])*(Logic.GetEntityMaxHealth(soldiers[2])*0.33)+Logic.GetEntityMaxHealth(id)*0.33
						if soldiers[1] > 0 then
							local changedDmg
							for i = soldiers[1]+1,2,-1 do
								local currentHP = Logic.GetEntityHealth(soldiers[i])
								changedDmg = math.min(currentHP,dmg)
								Logic.HurtEntity(soldiers[i],changedDmg)
								dmg = dmg - changedDmg
								if dmg <= 0 then
									break;
								end
							end
						end
						Logic.HurtEntity(id,dmg)
					else
						Logic.HurtEntity(id,Logic.GetEntityMaxHealth(id)*0.33)
					end
				end
			end
			giftspot.Dauer = giftspot.Dauer - 1
		else
			table.remove(PoisonPos,j)
		end
	end
	for j = table.getn(giftreiter),1,-1 do
		if IsAlive(giftreiter[j].ID) then
			if giftreiter[j].PoisonCounter <= 0 then
				local _x,_y = Logic.GetEntityPosition(giftreiter[j].ID)
				table.insert(PoisonPos, {X=_x;Y=_y;Dauer=20})
				Logic.CreateEffect(GGL_Effects.FXKalaPoison,_x,_y,0)

				giftreiter[j].PoisonCounter = 2
				return false
			else
				giftreiter[j].PoisonCounter = PoisonCounter - 1
			end
		else
			table.remove(giftreiter,j)
		end
	end
	return false
end

function GetSimpleDistanceSquared(_pos1,_pos2)
	return (_pos1.X - _pos2.X)^2 + (_pos1.Y - _pos2.Y)^2
end

PoisenReiterTriggerID = Trigger.RequestTrigger(Events.LOGIC_EVENT_EVERY_SECOND,nil,"PoisenThrower",1,nil,nil)
