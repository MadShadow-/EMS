
 function ActivateArmyId6_Wave2()
  
	if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
-------------------------------------ID6 Barracks2-------------------------------------------------------------------------------------


function ArmyBarracks2_ID6()
    if IsExisting("barracks2_id6") then
    local SpawnPos = GetPosition("spawn_barracks2_id6")
	    if IsDestroyed("Truppname10") and IsDestroyed("Truppname11")  and IsDestroyed("Truppname12") then
			if Counter.Tick2("ArmyBarracks2_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname1"..i)
					AddWaypoints("Truppname1"..i, {"id6_attack_target1", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname1"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname13") and IsDestroyed("Truppname14") and IsDestroyed("Truppname15") then
			if Counter.Tick2("ArmyBarracks2_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword3, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname1"..i)
					AddWaypoints("Truppname1"..i, {"id6_attack_target1", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname1"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("barracks2_id6") then
		return true
	end
end 

StartSimpleJob("ArmyBarracks2_ID6")



        





----------------------------------ID6 Archery2 ---------------------------------------------------------------------------------
function ArmyArchery2_ID6()
    if IsExisting("archery2_id6") then
    local SpawnPos = GetPosition("spawn_archery2_id6")
	    if IsDestroyed("Truppname20") and IsDestroyed("Truppname21")  and IsDestroyed("Truppname22") then
			if Counter.Tick2("ArmyArchery2_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname2"..i)
					AddWaypoints("Truppname2"..i, {"id6_attack_target2", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname2"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname23") and IsDestroyed("Truppname24") and IsDestroyed("Truppname25") then
			if Counter.Tick2("ArmyArchery2_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname2"..i)
					AddWaypoints("Truppname2"..i, {"id6_attack_target2", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname2"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("archery2_id6") then
		return true
	end
end 

StartSimpleJob("ArmyArchery2_ID6")



    


----------------------------------ID6 Stable2 ---------------------------------------------------------------------------------


function ArmyStable2_ID6()
    if IsExisting("stable2_id6") then
    local SpawnPos = GetPosition("spawn_stable2_id6")
	    if IsDestroyed("Truppname30") and IsDestroyed("Truppname31")  and IsDestroyed("Truppname32") then
			if Counter.Tick2("ArmyStable2_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname3"..i)
					AddWaypoints("Truppname3"..i, {"id6_attack_target3", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname3"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname33") and IsDestroyed("Truppname34") and IsDestroyed("Truppname35") then
			if Counter.Tick2("ArmyStable2_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname3"..i)
					AddWaypoints("Truppname3"..i, {"id6_attack_target3", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname3"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("stable2_id6") then
		return true
	end
end 

StartSimpleJob("ArmyStable2_ID6")






----------------------------------ID6 Stable3 ---------------------------------------------------------------------------------
function ArmyStable3_ID6()
    if IsExisting("stable3_id6") then
    local SpawnPos = GetPosition("spawn_stable3_id6")
	    if IsDestroyed("Truppname40") and IsDestroyed("Truppname41")  and IsDestroyed("Truppname42") then
			if Counter.Tick2("ArmyStable3_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname4"..i)
					AddWaypoints("Truppname4"..i, {"id6_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname4"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname43") and IsDestroyed("Truppname44") and IsDestroyed("Truppname45") then
			if Counter.Tick2("ArmyStable3_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname4"..i)
					AddWaypoints("Truppname4"..i, {"id6_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname4"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("stable3_id6") then
		return true
	end
end 

StartSimpleJob("ArmyStable3_ID6")




 ----------------------------------ID6 Stable4 ---------------------------------------------------------------------------------
 function ArmyStable4_ID6()
    if IsExisting("stable4_id6") then
    local SpawnPos = GetPosition("spawn_stable4_id6")
	    if IsDestroyed("Truppname50") and IsDestroyed("Truppname51")  and IsDestroyed("Truppname52") then
			if Counter.Tick2("ArmyStable4_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname5"..i)
					AddWaypoints("Truppname5"..i, {"id6_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname5"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname53") and IsDestroyed("Truppname54") and IsDestroyed("Truppname55") then
			if Counter.Tick2("ArmyStable4_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname5"..i)
					AddWaypoints("Truppname5"..i, {"id6_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname5"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("stable4_id6") then
		return true
	end
end 

StartSimpleJob("ArmyStable4_ID6")




end

