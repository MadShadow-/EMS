function ActivateArmyId6_Wave3()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
-------------------------------------ID6 Barracks1-------------------------------------------------------------------------------------
    
function ArmyWave3Barracks1_ID6()
    if IsExisting("b1_id6") then
    local SpawnPos = GetPosition("spawn_b1_id6")
	    if IsDestroyed("Truppname60") and IsDestroyed("Truppname61")  and IsDestroyed("Truppname62") then
			if Counter.Tick2("ArmyWave3Barracks1_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname6"..i)
					AddWaypoints("Truppname6"..i, {"id6_attack_target1", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname6"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname63") and IsDestroyed("Truppname64") and IsDestroyed("Truppname65") then
			if Counter.Tick2("ArmyWave3Barracks1_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname6"..i)
					AddWaypoints("Truppname6"..i, {"id6_attack_target1", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname6"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("b1_id6") then
		return true
	end
end 

StartSimpleJob("ArmyWave3Barracks1_ID6")


     

 -------------------------------------ID6 Archery1-------------------------------------------------------------------------------------
 function ArmyWave3Archery1_ID6()
    if IsExisting("a1_id6") then
    local SpawnPos = GetPosition("spawn_a1_id6")
	    if IsDestroyed("Truppname70") and IsDestroyed("Truppname71")  and IsDestroyed("Truppname72") then
			if Counter.Tick2("ArmyWave3Archery1_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname7"..i)
					AddWaypoints("Truppname7"..i, {"id6_attack_target2", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname7"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname73") and IsDestroyed("Truppname74") and IsDestroyed("Truppname75") then
			if Counter.Tick2("ArmyWave3Archery1_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname7"..i)
					AddWaypoints("Truppname7"..i, {"id6_attack_target2", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname7"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("a1_id6") then
		return true
	end
end 

StartSimpleJob("ArmyWave3Archery1_ID6")
            
    
----------------------------------ID6 Foundry1 ---------------------------------------------------------------------------------

function ArmyWave3Foundry1_ID6()
    if IsExisting("f1_id6") then
    local SpawnPos = GetPosition("spawn_f1_id6")
	    if IsDestroyed("Truppname80") and IsDestroyed("Truppname81")  and IsDestroyed("Truppname82") then
			if Counter.Tick2("ArmyWave3Foundry1_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname8"..i)
					AddWaypoints("Truppname8"..i, {"id6_attack_target2", loop=true})
				end
			end
        end
		--
        if IsDestroyed("Truppname83") and IsDestroyed("Truppname84") and IsDestroyed("Truppname85") then
			if Counter.Tick2("ArmyWave3Foundry1_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname8"..i)
					AddWaypoints("Truppname8"..i, {"id6_attack_target2", loop=true})
				end
			end
        end
    end
	if IsDead("f1_id6") then
		return true
	end
end 

StartSimpleJob("ArmyWave3Foundry1_ID6")
        
     
----------------------------------ID6 Tower1 ---------------------------------------------------------------------------------

function ArmyWave3Tower1_ID6()
    if IsExisting("t1_id6") then
    local SpawnPos = GetPosition("spawn_t1_id6")
	    if IsDestroyed("Truppname90") and IsDestroyed("Truppname91")  and IsDestroyed("Truppname92") then
			if Counter.Tick2("ArmyWave3Tower1_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname9"..i)
					AddWaypoints("Truppname9"..i, {"id6_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname9"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname93") and IsDestroyed("Truppname94") and IsDestroyed("Truppname95") then
			if Counter.Tick2("ArmyWave3Tower1_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname9"..i)
					AddWaypoints("Truppname9"..i, {"id6_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname9"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("t1_id6") then
		return true
	end
end 

StartSimpleJob("ArmyWave3Tower1_ID6")



----------------------------------ID6 Tower2 ---------------------------------------------------------------------------------
function ArmyWave3Tower2_ID6()
    if IsExisting("t2_id6") then
    local SpawnPos = GetPosition("spawn_t2_id6")
	    if IsDestroyed("Truppname100") and IsDestroyed("Truppname101")  and IsDestroyed("Truppname102") then
			if Counter.Tick2("ArmyWave3Tower2_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname10"..i)
					AddWaypoints("Truppname10"..i, {"id6_attack_target6", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname10"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname103") and IsDestroyed("Truppname104") and IsDestroyed("Truppname105") then
			if Counter.Tick2("ArmyWave3Tower2_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname10"..i)
					AddWaypoints("Truppname10"..i, {"id6_attack_target6", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname10"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("t2_id6") then
		return true
	end
end 

StartSimpleJob("ArmyWave3Tower2_ID6")



----------------------------------ID6 Castle ---------------------------------------------------------------------------------

function ArmyWave3Castle1_ID6()
    if IsExisting("c1_id6") then
    local SpawnPos = GetPosition("spawn_c1_id6")
	    if IsDestroyed("Truppname110") and IsDestroyed("Truppname111")  and IsDestroyed("Truppname112") then
			if Counter.Tick2("ArmyWave3Castle1_ID6_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname11"..i)
					AddWaypoints("Truppname11"..i, {"id6_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname11"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname113") and IsDestroyed("Truppname114") and IsDestroyed("Truppname115") then
			if Counter.Tick2("ArmyWave3Castle1_ID6_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(6, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname11"..i)
					AddWaypoints("Truppname11"..i, {"id6_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname11"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("c1_id6") then
		return true
	end
end 

    StartSimpleJob("ArmyWave3Castle1_ID6")


    
    end