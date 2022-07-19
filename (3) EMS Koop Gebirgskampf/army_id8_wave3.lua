function ActivateArmyId8_Wave3()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
-------------------------------------ID8 Barracks1-------------------------------------------------------------------------------------
function ArmyWave3Barracks1_ID8()
    if IsExisting("b1_id8") then
    local SpawnPos = GetPosition("spawn_b1_id8")
        if IsDestroyed("Truppname540") and IsDestroyed("Truppname541")  and IsDestroyed("Truppname542") then
            if Counter.Tick2("ArmyWave3Barracks1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname54"..i)
                    AddWaypoints("Truppname54"..i, {"id8_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname54"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname543") and IsDestroyed("Truppname544") and IsDestroyed("Truppname545") then
            if Counter.Tick2("ArmyWave3Barracks1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderPoleArm4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname54"..i)
                    AddWaypoints("Truppname54"..i, {"id8_attack_target1", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname54"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("b1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Barracks1_ID8")

        
 -------------------------------------ID8 Archery1-------------------------------------------------------------------------------------
 function ArmyWave3Archery1_ID8()
    if IsExisting("a1_id8") then
    local SpawnPos = GetPosition("spawn_a1_id8")
        if IsDestroyed("Truppname550") and IsDestroyed("Truppname551")  and IsDestroyed("Truppname552") then
            if Counter.Tick2("ArmyWave3Archery1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname55"..i)
                    AddWaypoints("Truppname55"..i, {"id8_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname55"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname553") and IsDestroyed("Truppname554") and IsDestroyed("Truppname555") then
            if Counter.Tick2("ArmyWave3Archery1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderRifle2, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname55"..i)
                    AddWaypoints("Truppname55"..i, {"id8_attack_target2", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname55"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("a1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Archery1_ID8")

----------------------------------ID8 Foundry1 ---------------------------------------------------------------------------------
function ArmyWave3Foundry1_ID8()
    if IsExisting("f1_id8") then
    local SpawnPos = GetPosition("spawn_f1_id8")
        if IsDestroyed("Truppname560") and IsDestroyed("Truppname561")  and IsDestroyed("Truppname562") then
            if Counter.Tick2("ArmyWave3Foundry1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname56"..i)
                    AddWaypoints("Truppname56"..i, {"id8_attack_target3", loop=true})
                end
            end
        end
        --
        if IsDestroyed("Truppname563") and IsDestroyed("Truppname564") and IsDestroyed("Truppname565") then
            if Counter.Tick2("ArmyWave3Foundry1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon3, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname56"..i)
                    AddWaypoints("Truppname56"..i, {"id8_attack_target3", loop=true})
                end
            end
        end
    end
    if IsDead("f1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Foundry1_ID8")

    
 ----------------------------------ID8 Stable1 ---------------------------------------------------------------------------------

 function ArmyWave3Stable1_ID8()
    if IsExisting("s1_id8") then
    local SpawnPos = GetPosition("spawn_s1_id8")
        if IsDestroyed("Truppname570") and IsDestroyed("Truppname571")  and IsDestroyed("Truppname572") then
            if Counter.Tick2("ArmyWave3Stable1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname57"..i)
                    AddWaypoints("Truppname57"..i, {"id8_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname57"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname573") and IsDestroyed("Truppname574") and IsDestroyed("Truppname575") then
            if Counter.Tick2("ArmyWave3Stable1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname57"..i)
                    AddWaypoints("Truppname57"..i, {"id8_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname57"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("s1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Stable1_ID8")

 


----------------------------------ID8 Stable2 ---------------------------------------------------------------------------------

function ArmyWave3Stable2_ID8()
    if IsExisting("s2_id8") then
    local SpawnPos = GetPosition("spawn_s2_id8")
        if IsDestroyed("Truppname580") and IsDestroyed("Truppname581")  and IsDestroyed("Truppname582") then
            if Counter.Tick2("ArmyWave3Stable2_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderHeavyCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname58"..i)
                    AddWaypoints("Truppname58"..i, {"id8_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname58"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname583") and IsDestroyed("Truppname584") and IsDestroyed("Truppname585") then
            if Counter.Tick2("ArmyWave3Stable2_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderCavalry2, nil, 3, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname58"..i)
                    AddWaypoints("Truppname58"..i, {"id8_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname58"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("s2_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Stable2_ID8")



----------------------------------ID8 Castle ---------------------------------------------------------------------------------

function ArmyWave3Castle1_ID8()
    if IsExisting("c1_id8") then
    local SpawnPos = GetPosition("spawn_c1_id8")
        if IsDestroyed("Truppname590") and IsDestroyed("Truppname591")  and IsDestroyed("Truppname592") then
            if Counter.Tick2("ArmyWave3Castle1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname59"..i)
                    AddWaypoints("Truppname59"..i, {"id8_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname59"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname593") and IsDestroyed("Truppname594") and IsDestroyed("Truppname595") then
            if Counter.Tick2("ArmyWave3Castle1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname59"..i)
                    AddWaypoints("Truppname59"..i, {"id8_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname59"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("c1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave3Castle1_ID8")


end