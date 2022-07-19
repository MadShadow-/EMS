function ActivateArmyId8_Wave4()
  
    if CheckMode == 1 then
        RespawnTime = 40
     elseif CheckMode == 2 then
        RespawnTime = 20
     elseif CheckMode == 3 then
        RespawnTime = 10
     end
-------------------------------------ID8 Barracks1-------------------------------------------------------------------------------------

function ArmyWave4Barracks1_ID8()
    if IsExisting("end_b1_id8") then
    local SpawnPos = GetPosition("spawn_end_b1_id8")
        if IsDestroyed("Truppname600") and IsDestroyed("Truppname601")  and IsDestroyed("Truppname602") then
            if Counter.Tick2("ArmyWave4Barracks1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname60"..i)
                    AddWaypoints("Truppname60"..i, {"id8_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname60"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname603") and IsDestroyed("Truppname604") and IsDestroyed("Truppname605") then
            if Counter.Tick2("ArmyWave4Barracks1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderSword4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname60"..i)
                    AddWaypoints("Truppname60"..i, {"id8_attack_target3", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname60"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("end_b1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Barracks1_ID8")

    

 -------------------------------------ID8 Archery1-------------------------------------------------------------------------------------

 function ArmyWave4Archery1_ID8()
    if IsExisting("end_a1_id8") then
    local SpawnPos = GetPosition("spawn_end_a1_id8")
        if IsDestroyed("Truppname610") and IsDestroyed("Truppname611")  and IsDestroyed("Truppname612") then
            if Counter.Tick2("ArmyWave4Archery1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname61"..i)
                    AddWaypoints("Truppname61"..i, {"id8_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname61"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname613") and IsDestroyed("Truppname614") and IsDestroyed("Truppname615") then
            if Counter.Tick2("ArmyWave4Archery1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PU_LeaderBow4, nil, 8, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname61"..i)
                    AddWaypoints("Truppname61"..i, {"id8_attack_target4", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname61"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("end_a1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Archery1_ID8")

    
----------------------------------ID8 Tower1 ---------------------------------------------------------------------------------

function ArmyWave4Tower1_ID8()
    if IsExisting("end_t1_id8") then
    local SpawnPos = GetPosition("spawn_end_t1_id8")
        if IsDestroyed("Truppname620") and IsDestroyed("Truppname621")  and IsDestroyed("Truppname622") then
            if Counter.Tick2("ArmyWave4Tower1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.PV_Cannon4, nil, 0, SpawnPos.X, SpawnPos.Y, 0, 1, 0, 0),"Truppname62"..i)
                    AddWaypoints("Truppname62"..i, {"id8_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname62"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname623") and IsDestroyed("Truppname624") and IsDestroyed("Truppname625") then
            if Counter.Tick2("ArmyWave4Tower1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname62"..i)
                    AddWaypoints("Truppname62"..i, {"id8_attack_target5", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname62"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("end_t1_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Tower1_ID8")   

        
----------------------------------ID8 Castle ---------------------------------------------------------------------------------

function ArmyWave4Castle1_ID8()
    if IsExisting("burg_id8") then
    local SpawnPos = GetPosition("spawn_burg_id8")
        if IsDestroyed("Truppname630") and IsDestroyed("Truppname631")  and IsDestroyed("Truppname632") then
            if Counter.Tick2("ArmyWave4Castle1_ID8_1", RespawnTime) then
                for i = 0, 2 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranMajor, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname63"..i)
                    AddWaypoints("Truppname63"..i, {"id8_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname63"..i), math.random(1, 4))
                end
            end
        end
        --
        if IsDestroyed("Truppname633") and IsDestroyed("Truppname634") and IsDestroyed("Truppname635") then
            if Counter.Tick2("ArmyWave4Castle1_ID8_2", RespawnTime) then
                for i = 3, 5 do
                    SetEntityName(AI.Entity_CreateFormation(8, Entities.CU_VeteranLieutenant, nil, 4, SpawnPos.X, SpawnPos.Y, 0, 1, 3, 0),"Truppname63"..i)
                    AddWaypoints("Truppname63"..i, {"id8_attack_target6", loop=true})
                    Logic.LeaderChangeFormationType(GetEntityId("Truppname63"..i), math.random(1, 4))
                end
            end
        end
    end
    if IsDead("burg_id8") then
        return true
    end
end 

StartSimpleJob("ArmyWave4Castle1_ID8")
     
    
end