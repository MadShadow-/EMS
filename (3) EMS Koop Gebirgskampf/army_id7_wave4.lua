function ActivateArmyId7_Wave4()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
-------------------------------------ID7 Barracks1-------------------------------------------------------------------------------------

function ArmyWave4Barracks1_ID7()
    if IsExisting("end_b1_id7") then
    local SpawnPos = GetPosition("spawn_end_b1_id7")
        if IsDestroyed("Truppname370") and IsDestroyed("Truppname371")  and IsDestroyed("Truppname372") then
            if Counter.Tick2("ArmyWave4Barracks1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname37"..i)
                    AddWaypoints("Truppname37"..i, {"id7_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname37"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname373") and IsDestroyed("Truppname374") and IsDestroyed("Truppname375") then
            if Counter.Tick2("ArmyWave4Barracks1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderPoleArm4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname37"..i)
                    AddWaypoints("Truppname37"..i, {"id7_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname37"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("end_b1_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Barracks1_ID7")


-------------------------------------ID7 Archery1-------------------------------------------------------------------------------------

 function ArmyWave4Archery1_ID7()
    if IsExisting("end_a1_id7") then
    local SpawnPos = GetPosition("spawn_end_a1_id7")
        if IsDestroyed("Truppname380") and IsDestroyed("Truppname381")  and IsDestroyed("Truppname382") then
            if Counter.Tick2("ArmyWave4Archery1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname38"..i)
                    AddWaypoints("Truppname38"..i, {"id7_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname38"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname383") and IsDestroyed("Truppname384") and IsDestroyed("Truppname385") then
            if Counter.Tick2("ArmyWave4Archery1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname38"..i)
                    AddWaypoints("Truppname38"..i, {"id7_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname38"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("end_a1_id7") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Archery1_ID7")

            
    
----------------------------------ID7 Tower1 ---------------------------------------------------------------------------------

function ArmyWave4Tower1_ID7()
    if IsExisting("end_t1_id7") then
    local SpawnPos = GetPosition("spawn_end_t1_id7")
	    if IsDestroyed("Truppname390") and IsDestroyed("Truppname391")  and IsDestroyed("Truppname392") then
			if Counter.Tick2("ArmyWave4Tower1_ID7_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname39"..i)
					AddWaypoints("Truppname39"..i, {"id7_attack_target3", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname39"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname393") and IsDestroyed("Truppname394") and IsDestroyed("Truppname395") then
			if Counter.Tick2("ArmyWave4Tower1_ID7_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname39"..i)
					AddWaypoints("Truppname39"..i, {"id7_attack_target3", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname39"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("end_t1_id7") then
		return true
	end
end 

StartSimpleJob("ArmyWave4Tower1_ID7")


----------------------------------ID7 Tower2 ---------------------------------------------------------------------------------

function ArmyWave4Tower2_ID7()
    if IsExisting("t1_id7") then
    local SpawnPos = GetPosition("spawn_t1_id7")
	    if IsDestroyed("Truppname400") and IsDestroyed("Truppname401")  and IsDestroyed("Truppname402") then
			if Counter.Tick2("ArmyWave4Tower2_ID7_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname40"..i)
					AddWaypoints("Truppname40"..i, {"id7_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname40"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname403") and IsDestroyed("Truppname404") and IsDestroyed("Truppname405") then
			if Counter.Tick2("ArmyWave4Tower2_ID7_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_BanditLeaderSword1, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname40"..i)
					AddWaypoints("Truppname40"..i, {"id7_attack_target4", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname40"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("t1_id7") then
		return true
	end
end 

StartSimpleJob("ArmyWave4Tower2_ID7")


----------------------------------ID7 Stable1 ---------------------------------------------------------------------------------

function ArmyWave4Stable1_ID7()
    if IsExisting("end_s1_id7") then
    local SpawnPos = GetPosition("spawn_end_s1_id7")
	    if IsDestroyed("Truppname410") and IsDestroyed("Truppname411")  and IsDestroyed("Truppname412") then
			if Counter.Tick2("ArmyWave4Stable1_ID7_1", RespawnTime) then
				for i = 0, 2 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname41"..i)
					AddWaypoints("Truppname41"..i, {"id7_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname41"..i), math.random(1, 4))
				end
			end
        end
		--
        if IsDestroyed("Truppname413") and IsDestroyed("Truppname414") and IsDestroyed("Truppname415") then
			if Counter.Tick2("ArmyWave4Stable1_ID7_2", RespawnTime) then
				for i = 3, 5 do
					SetEntityName(AI.Entity_CreateFormation(7, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname41"..i)
					AddWaypoints("Truppname41"..i, {"id7_attack_target5", loop=true})
					Logic.LeaderChangeFormationType(GetEntityId("Truppname41"..i), math.random(1, 4))
				end
			end
        end
    end
	if IsDead("end_s1_id7") then
		return true
	end
end 

StartSimpleJob("ArmyWave4Stable1_ID7")

----------------------------------ID7 Castle ---------------------------------------------------------------------------------

function ArmyWave4Castle1_ID7()
    if IsExisting("burg_id7") then
    local SpawnPos = GetPosition("spawn_burg_id7")
        if IsDestroyed("Truppname420") and IsDestroyed("Truppname421")  and IsDestroyed("Truppname422") then
            if Counter.Tick2("ArmyWave4Castle1_ID7_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname42"..i)
                    AddWaypoints("Truppname42"..i, {"id7_attack_target7", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname42"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname423") and IsDestroyed("Truppname424") and IsDestroyed("Truppname425") then
            if Counter.Tick2("ArmyWave4Castle1_ID7_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(7, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname42"..i)
                    AddWaypoints("Truppname42"..i, {"id7_attack_target7", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname42"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("burg_id7") then
        return true
    end
end 

    StartSimpleJob("ArmyWave4Castle1_ID7")

end